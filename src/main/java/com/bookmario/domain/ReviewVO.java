package com.bookmario.domain;

import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class ReviewVO {
	
	private Long rno;
	
	@NotNull(message = "책 정보가 필요합니다")
	private Long bookID;
	
	@NotBlank(message = "작성자 정보가 필요합니다")
	@Size(max = 500, message = "리뷰는 500자 이내로 작성해주세요")
	private String review;
	
	@NotBlank(message = "작성자 정보가 필요합니다")
	private String reviewer;
	private Timestamp reviewDate;
	private Timestamp updateDate;
	
}
