<div align="center"><img width="300" height="300" alt="BookMario logo" src="https://github.com/user-attachments/assets/8a5478c3-c5e3-4197-888b-ca7a3049814a" /></div>

# Spring을 활용한 인터넷 서점 개발
> Spring Framework, JSP, JQuery등의 정부 표준 프레임워크를 적극 활용한 전통적인 MVC패턴의 Spring Web app입니다.

<br>

## 🗨 프로젝트 소개

### 프로젝트를 간단하게 소개한다면?
CRUD 구현과 웹 애플리케이션 전 과정을 학습하기 위해 진행한 개인 프로젝트입니다.<br>

### 개발기간
2025/09/27 ~ 2025/10/16

### 프로젝트 시연 영상 링크
[![유튜브](https://noticon-static.tammolo.com/dgggcrkxq/image/upload/v1567002882/noticon/ctn6kpoyyaawcggjqmfj.png)](https://youtu.be/xfJiXpY6TEE)

### 핵심 기능은?
#### User
+ Spring Security(세션 기반 로그인/권한 관리)를 이용한 회원가입과 로그인
+ 비밀번호는 bcrypt를 통해 암호화하였습니다. <!-- 이메일 인증 -->

#### Store
+ 도서 등록, 수정, 삭제 (CRUD)
+ 리뷰 등록, 수정, 삭제 (CRUD)
+ 도서 조회 / 도서 분류 / 검색 기능
+ 장바구니 / 주문
+ 주문 정보 확인 / 주문 취소
+ 페이징 처리

<br>

## ⚙ 사용기술
+	Frontend: JSP, Jquery, JavaScript
+	Backend: Spring Framework, MyBatis
+	Database: PostgreSQL
+	Server: Apache Tomcat 9.0

<br>

## ERD

<details>
  <summary>클릭하면 내용이 보여집니다</summary>
<div align="center"><img width="1089" height="601" alt="bookmario ERD" src="https://github.com/user-attachments/assets/47541ccc-e94f-4b13-a7fc-2a6f10c8acc9" /></div>

</details>

<hr/>

### [ 회원 관리 ]
<details>
  <summary>클릭하면 내용이 보여집니다</summary>

<img width="300" height="600" alt="회원가입" src="https://github.com/user-attachments/assets/481c9869-83b5-4221-9cc6-fd6f20da330f" />
<img width="500" height="300" alt="로그인" src="https://github.com/user-attachments/assets/c9fa1231-ca5b-49aa-a182-bb9fb8be32a2" />

- [X] **회원 가입**

    **[ 기능 설명 ]**  
      : 회원 가입을 할 수 있습니다.

    **[ 상세 구조 ]**  
     + **[MemberController](./src/main/java/com/bookmario/controller/MemberController.java)**

     + **MemberService**  
       : [MemberService.java](./src/main/java/com/bookmario/service/MemberService.java) - [MemberServiceImpl.java](./src/main/java/com/bookmario/service/MemberServiceImpl.java)의 구조를 가집니다.

     + **MemberMapper**  
       : [MemberMapper.java](./src/main/java/com/bookmario/mapper/MemberMapper.java) - [MemberMapper.xml](./src/main/resources/com/bookmario/mapper/MemberMapper.xml)의 구조를 가집니다.

- [X] **로그인**  

    **[ 기능 설명 ]**  
      : Spring Security를 사용하여 로그인을 할 수 있습니다.  
      : Spring Security Handler를 이용하여 로그인 성공, 실패, 접근제한을 처리합니다.

    **[ 상세 구조 ]**  
     + **AuthenticaionProvider**    
       : 실제 인증 작업을 진행합니다. 사용자가 인증 요청한 정보와 DB의 사용자 정보가 일치하는지를 확인합니다.  
      
     + **PasswordEncoder**   
       : 패스워드를 암호화합니다.   
       : 암호화되지 않은 실제 패스워드를 저장하는 일은 위험하기 때문에 암호화된 패스워드로 저장하고, 사용자가 패스워드를 입력하면 이를 암호화해서 저장된 패스워드와 비교합니다.

     + **BCyptPasswordEncoder**   
       : PasswordEncoder구현한 클래스중 하나입니다. 해시 함수로 특정 문자열을 암호화하기 때문에 암호화를 한 후에, 다시 원문으로 돌리지 못합니다.

     + **CustomUserDetailsService**    
       : [CustomUserDetailsService](./src/main/java/com/bookmario/security/CustomUserDetailsService.java)은 UserDetailsService를 구현하여 DB의 사용자 정보를 조회합니다.    
       : 유일한 메소드인 loadUserByUsername()는 UserDetails를 상속받아 만든 CustomUser를 반환합니다.   

     + **CustomUser**   
       : [CustomUser](./src/main/java/com/bookmario/security/domain/CustomUser.java)는 조회한 사용자 정보를 담고있습니다.   
       : Spring Security에서 제공하고 있는 UserDetails를 구현한 여러 클래스 중에서 User클래스를 상속받았습니다.

     + **security-context.xml**   
      : [security-context.xml](./src/main/webapp/WEB-INF/spring/security-context.xml)은 Spring Security와 관련된 설정을 담고 있습니다.   
      : AuthenticationSuccessHandler를 상속받아 [로그인 성공 로직](./src/main/java/com/bookmario/security/CustomLoginSuccessHandler.java)을 처리합니다.   
      <!-- : AuthenticationFailureHandler를 상속받아 [로그인 실패 로직]()을 처리합니다. 로그인의 실패 원인을 알려줍니다. -->
      : AccessDeniedHandler를 상속받아 권한이 없는 페이지에 대하여 [접근 제한 로직](./src/main/java/com/bookmario/security/CustomAccessDeniedHandler.java)을 처리합니다.    
     + **MemberMapper**   
      : [MemberMapper.java](./src/main/java/com/bookmario/mapper/MemberMapper.java) - [MemberMapper.xml](./src/main/resources/com/bookmario/mapper/MemberMapper.xml)의 구조를 가집니다.
</details>

<hr/>

### [ 상품 관리 ]
<details>
  <summary>클릭하면 내용이 보여집니다</summary>

<img width="400" height="800" alt="도서 등록" src="https://github.com/user-attachments/assets/a54b942d-acf1-4741-a4fe-37af68bebb2c" />
<img width="400" height="800" alt="도서 수정" src="https://github.com/user-attachments/assets/de5aa02a-4237-4301-b013-b774462d639b" />
<img width="800" height="400" alt="리뷰" src="https://github.com/user-attachments/assets/b007591b-96e1-4ffa-84bf-6d8e56bca7dd" />


- [X] **상품의 CRUD**

   **[ 기능 설명 ]**   
     : 관리자만이 게시물을 등록, 수정, 삭제할 수 있으며, 누구나 조회할 수 있습니다.   
     : 상품은 도서 분류 **카테고리**를 지정하거나 **검색**을 통하여 조회할 수 있습니다.

   **[ 상세 구조 ]**
    + **[BookController](./src/main/java/com/bookmario/controller/BookController.java)**   
      : 이미지는 C:\Bookmario\resources\img 경로에 저장합니다.   
   
    + **BookService**   
       : [BookService](./src/main/java/com/bookmario/service/BookService.java) - [BookServiceImpl](./src/main/java/com/bookmario/service/BookServiceImpl.java)의 구조를 가집니다.

    + **BookMapper**   
       : [BookMapper.java](./src/main/java/com/bookmario/mapper/BookMapper.java) - [BookMapper.xml](./src/main/resources/com/bookmario/mapper/BookMapper.xml)의 구조를 가집니다.

- [X] **리뷰 CRUD**

   **[ 기능 설명 ]**   
    : 회원은 리뷰를 등록, 수정, 삭제할 수 있습니다.<br>
    : 리뷰에 대한 조회는 제품의 리뷰 탭 에서 누구나 가능합니다.

   **[ 상세 구조 ]**   
    + **[ReviewController](./src/main/java/com/bookmario/controller/ReviewController.java)**   
       : json를 반환하는 RestController를 사용하였고, View단에서 JQuery의 AJAX로 데이터를 주고 받습니다.

    + **[ReviewMapper]**   
       :[ReviewMapper.java](./src/main/java/com/bookmario/mapper/ReviewMapper.java) - [ReviewMapper.xml](./src/main/resources/com/bookmario/mapper/ReviewMapper.xml)의 구조를 가집니다.
</details>

<hr/>

### [ 구매 절차 ]
<details>
  <summary>클릭하면 내용이 보여집니다</summary>

<img width="800" height="500" alt="장바구니" src="https://github.com/user-attachments/assets/ed98185f-eba4-47d0-b28b-d781fa405389" />
<img width="800" height="500" alt="주문 내역" src="https://github.com/user-attachments/assets/95d6e924-240d-4e27-ba9f-a770b02093a3" />

- [X] **장바구니**

   **[ 기능 설명 ]**
    : 회원은 원하는 상품의 수량을 지정하여 장바구니에 저장할 수 있습니다.   
    : 장바구니에서 담았던 상품을 삭제할 수도 있습니다.

   **[ 상세 구조 ]**
    + **[CartsController](./src/main/java/com/bookmario/controller/CartsController.java)**
      
    + **CartService**   
       : [CartService.java](./src/main/java/com/bookmario/service/CartService.java) - [CartService.xml](./src/main/java/com/bookmario/service/CartServiceImpl.java)의 구조를 가집니다.

    + **CartMapper**   
       : [CartMapper.java](./src/main/java/com/bookmario/mapper/CartMapper.java) - [CartMapper.xml](./src/main/resources/com/bookmario/mapper/CartMapper.xml)의 구조를 가집니다.

- [X] **구매**

   **[ 기능 설명 ]**
    : 장바구니에 있는 여러 상품들을 함께 주문할 수 있습니다.

   **[ 상세 구조 ]**
    + **[OrdersController](./src/main/java/com/bookmario/controller/OrdersController.java)**

    + **OrderService**   
       : [OrderService](./src/main/java/com/bookmario/service/OrderService.java) - [OrderServiceImpl](./src/main/java/com/bookmario/service/OrderServiceImpl.java)의 구조를 가집니다.

    + **OrderMapper**   
       : [OrderMapper.java](./src/main/java/com/bookmario/mapper/OrderMapper.java) - [OrderMapper.xml](./src/main/resources/com/bookmario/mapper/OrderMapper.xml)의 구조를 가집니다.
</details>

## UI
<details>
  <summary>클릭하면 내용이 보여집니다</summary>

### [메인페이지]
<img width="600" height="1000" alt="메인 페이지" src="https://github.com/user-attachments/assets/c6357c3d-2260-432d-afa2-6c45d0d90a9e" />
<hr/>

### [도서 리스트]
<img width="600" height="600" alt="도서 리스트" src="https://github.com/user-attachments/assets/cdef4a1b-691e-4b81-a5dc-cf8336e71683" />
<hr/>

### [상품 상세보기]
<img width="600" height="600" alt="상품 상세보기" src="https://github.com/user-attachments/assets/59d9240c-3a5c-4ab6-bc66-7592b86abf8c" /><br>
<hr/>

<!-- ### 회원 수정 -->


<!-- ### 관리자 페이지 -->
</details>

## 트러블 슈팅
<details>
  <summary>도서 수정시 이미지 null 문제</summary>
  
+ 배경<br>
  : 기존 도서 수정 화면에서 파일 첨부 없이 저장하면, 이미지 값(book.image)이 null로 저장되어 기존 이미지가 사라지는 현상이 발생했습니다.

+ 원인<br>
  : 컨트롤러에서 MultipartFile file이 비어있을 때 기존 이미지 값을 유지하지 않고, bookVO.image가 null로 덮어써지는 로직 때문이었습니다.

+ 해결<br>
  : 파일 첨부가 없을 경우 기존 도서 정보를 조회하여 이미지 URL을 유지하도록 수정했습니다.

```
if (file != null && !file.isEmpty()) {
    String uploadPath = "/img";
    String fileUrl = FileHelper.upload(uploadPath, file, request);
    bookVO.setImage(fileUrl);
} else {
    bookVO.setImage(existingBookVO.getImage()); // 기존 이미지 유지
}
```
+ 결과<br>
  : 도서 수정 시 이미지 첨부 여부와 관계없이 기존 이미지를 유지해서 해결했습니다.
</details>

<details>
  <summary>리뷰 기능 API 응답 구조 개선</summary>
  
  + 배경<br>
    : 프로젝트 초기에는 빠른 구현을 위해 단순히 "success" 문자열을 반환하는 방식으로 API를 설계했습니다. 그러나 실제 사용 중 다음과 같은 문제를 발견했습니다:
      - **문자열 의존**: `result !== "success"` 같은 하드코딩된 문자열 비교
      - **입력값 검증 부재**: 입력값 검증이 서버 측에 없어 잘못된 데이터 저장 위험 또한 빈 리뷰, 500자 초과 등 잘못된 데이터가 DB에 저장될 위험 
      - **디버깅 어려움**: 디버깅 시 문제 원인 파악이 어려움

  + 개선 내용 (예시)<br>
  
  #### Before
  ```java
  // Controller
  @PostMapping(value = "/new")
    public ResponseEntity create(@RequestBody ReviewVO vo) {
      int insertCount = service.register(vo);
      return insertCount == 1 
        ? new ResponseEntity<>("success", HttpStatus.OK)
        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
  ```

  #### After
  ```java
  // DTO 정의
  @Data
  @AllArgsConstructor
  public class ReviewResponseDTO {
    private boolean success;
    private String message;
    private Long rno;
  }

  // Controller
  @PostMapping(value = "/new", produces = MediaType.APPLICATION_JSON_VALUE)
  public ResponseEntity create(@Valid @RequestBody ReviewVO vo, BindingResult bindingResult) {
    
    if (bindingResult.hasErrors()) {
    String errorMsg = bindingResult.getAllErrors().get(0).getDefaultMessage();
    return ResponseEntity.badRequest().body(new ReviewResponseDTO(false, errorMsg, null));
    }
    
    try {
      int insertCount = service.register(vo);
      if (insertCount == 1) {
        return ResponseEntity.ok(
        new ReviewResponseDTO(true, "리뷰가 등록되었습니다.", vo.getRno()));
      }
    } catch (Exception e) {
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).
      body(new ReviewResponseDTO(false, "서버 오류가 발생했습니다.", null));
    }
  ```

  ```
  // VO에 Validation 추가
  @Data
  public class ReviewVO {
      @NotBlank(message = "리뷰 내용을 입력해주세요")
      @Size(max = 500, message = "리뷰는 500자 이내로 작성해주세요")
      private String review;
    
      @NotBlank(message = "작성자 정보가 필요합니다")
      private String reviewer;
    
      @NotNull(message = "책 정보가 필요합니다")
      private Long bookID;
  }
```

  #### 클라이언트 코드 개선
  ```javascript
  // Before
  reviewService.add(review, function(result){
      if (result !== "success") {
          alert(result);
      }
      modal.modal("hide");
      showList(-1);
  });

  // After
  reviewService.add(review, function(response){
      if (response.success) {
          alert(response.message);
          modal.modal("hide");
          showList(-1);
      } else {
          alert(response.message);
      }
  });
  ```

  **주요 변경 사항**
  - **응답 DTO 도입**: 성공 여부, 메시지, 데이터를 포함한 구조화된 응답
  - **입력값 검증**: `@NotBlank`, `@Size` 등 Bean Validation 적용
  - **에러 핸들링**: try-catch로 예외 상황 처리 및 적절한 HTTP 상태 코드 반환
  - **프론트엔드 개선**: "success" 문자열 비교 → response.success 객체 활용
   
  ### 추가한 기술 스택
  - Spring Validation (Bean Validation)
  - Jackson (JSON 직렬화)

  ### 배운 점
  - **클라이언트-서버 책임 분리**: 에러 메시지는 서버에서 생성하고 클라이언트는 표시만
  - **API 설계의 중요성**: 초기 설계 단계에서 확장성을 고려하지 않으면 나중에 큰 리팩토링 필요
</details>

<!-- ## 아쉬운 점 및 추가하고 싶은 기능 -->
