package com.bookmario.controller;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookmario.domain.Criteria;
import com.bookmario.domain.ReviewPageDTO;
import com.bookmario.domain.ReviewResponseDTO;
import com.bookmario.domain.ReviewVO;
import com.bookmario.service.MemberService;
import com.bookmario.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/review/")
@RestController
@Log4j
@RequiredArgsConstructor
public class ReviewController {

	private final ReviewService service;
	
	// 댓글 등록
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReviewResponseDTO> create(@Valid @RequestBody ReviewVO vo, BindingResult bindingResult){
		log.info("ReviewVO: " + vo);
		
		//Validation 에러 체크
		if (bindingResult.hasErrors()) {
			String errorMsg = bindingResult.getAllErrors().get(0).getDefaultMessage();
			return ResponseEntity.badRequest().body(new ReviewResponseDTO(false, errorMsg, null));
		}
		
		try {
			int insertCount = service.register(vo);
			log.info("Review INSERT COUNT: " + insertCount);

			if (insertCount == 1) {
				return ResponseEntity.ok(new ReviewResponseDTO(true, "리뷰가 등록되었습니다.", vo.getRno()));
				} else {
					return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ReviewResponseDTO(false, "리뷰 등록에 실패했습니다.", null));
				}
			} catch (Exception e) {
				log.error("리뷰 등록 오류", e);
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ReviewResponseDTO(false, "서버 오류가 발생했습니다.", null));
			}
		}
	
	// 특정 게시물의 댓글 목록 확인 페이징
	@GetMapping(value = "/pages/{bookID}/{page}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReviewPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bookID") Long bookID) {
		Criteria cri = new Criteria(page,10);
		log.info("getList......");
		log.info("get Review List bookID: " + bookID);
		log.info("cri: " + cri);
		return new ResponseEntity<>(service.getListPage(cri, bookID), HttpStatus.OK);
		}
	
	// 댓글 조회
	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReviewVO> get(@PathVariable("rno") Long rno){
		log.info("get: " + rno);
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	// 댓글 삭제
	@DeleteMapping(value = "/{rno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReviewResponseDTO> remove(@PathVariable("rno") Long rno) {
		log.info("remove: " + rno);
		
		try {
			int deleteCount = service.remove(rno);
			
			if (deleteCount == 1) {
				return ResponseEntity.ok(
					new ReviewResponseDTO(true, "리뷰가 삭제되었습니다.", rno)
				);
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ReviewResponseDTO(false, "리뷰 삭제에 실패했습니다.", null));
			}
		} catch (Exception e) {
			log.error("리뷰 삭제 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
				.body(new ReviewResponseDTO(false, "서버 오류가 발생했습니다.", null));
		}
	}

	//댓글 수정
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
			value = "/{rno}", consumes = "application/json", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReviewResponseDTO> modify(
			@Valid @RequestBody ReviewVO vo,
			@PathVariable("rno") Long rno,
			BindingResult bindingResult) {
		
		vo.setRno(rno);
		log.info("rno: " + rno);
		log.info("modify: " + vo);
		
		// Validation 에러 체크
		if (bindingResult.hasErrors()) {
			String errorMsg = bindingResult.getAllErrors().get(0).getDefaultMessage();
			return ResponseEntity.badRequest()
					.body(new ReviewResponseDTO(false, errorMsg, null));
		}
		
		try {
			int updateCount = service.modify(vo);
			
			if (updateCount == 1) {
				return ResponseEntity.ok(
					new ReviewResponseDTO(true, "리뷰가 수정되었습니다.", rno)
				);
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ReviewResponseDTO(false, "리뷰 수정에 실패했습니다.", null));
			}
		} catch (Exception e) {
			log.error("리뷰 수정 오류", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
				.body(new ReviewResponseDTO(false, "서버 오류가 발생했습니다.", null));
		}
	}
}
