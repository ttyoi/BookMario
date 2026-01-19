<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<head>
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="<c:url value='/resources/img/favicon/favicon.ico'/>"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<title>Book Shop</title>
	<link href="/resources/item/css/item.css" rel="stylesheet" />
</head>
		<div id="root" class="d-flex flex-column min-vh-100">
			<nav id="nav">
				<div id="nav_box">
					<%@ include file="../../include/nav.jsp" %>
				</div>
			</nav>
			
			<header id="header">
				<div id="header_box">
					<%@ include file="../../include/header.jsp" %>
				</div>
			</header>
			
			<!-- Product section -->
			<section class="py-5">
			    <div class="container px-4 px-lg-5 my-5">
			        <div class="row gx-4 gx-lg-5 align-items-center">
			            <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="${ book.image }" onerror="this.onerror=null; this.src='/resources/img/none.png';" alt="NONE IMG" /></div>
			            <!-- 서지 정보 시작 -->
			            <div class="col-md-6">
			            	<!-- 상품 정보 -->
			            	<div class="info">
			            		<div class="info_list">
					                <div class="small mb-1">${ book.bookISBN }</div>
					                <h1 class="display-5 fw-bolder">${ book.title }</h1>
					            </div>
					            <hr>
					            <div class="info_list">
					                <div class="fs-5 mb-3">
					                	<ul>
					                		<li>
						                    	<div class="Litem">판매가</div>
						                    	<div class="Ritem">
						                    		<span id="priceDisplay" style="font-size:24px"></span>원
						                    	</div>
						                    </li>
					                	</ul>
					                </div>
					           	</div>
					           	<hr>
					           	<div class="info_list">
					           		<h4>책 소개</h4>
					                <p class="lead">${ book.content }</p>
					                <hr>
					                <form action="<c:url value='/carts/add' />" method="post">
						                <div class="d-flex">
						                    <input name="amount" class="form-control text-center me-3" id="inputQuantity" type="number" value="1" style="max-width: 4rem" />
						                    <input name="bookID" type="hidden" value="${ book.bookID }">
						                    <button class="btn btn-outline-dark flex-shrink-0" type="submit">
						                        <i class="bi-cart-fill me-1"></i>
						                        Add to cart
						                    </button>
						                </div>
						                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						        	</form>
						        	<hr>
						        	<div class="mt-2">
						        		<sec:authorize access="hasRole('ROLE_ADMIN')">
			                    			<a class="btn btn-outline-dark mt-auto" href="<c:url value='/books/edit/${ book.bookID }' />">수정</a>
			                    			<!-- 삭제 확인 모달 -->
			                    			<button type="button" class="btn btn-deleteAsk btn-danger" data-toggle="modal" data-target="#deleteConfirmationModal">삭제</button>
			                    		</sec:authorize>
			                    		<button data-oper="list" class="btn btn-outline-dark mt-auto" onclick="location.href='/books/products'">목록</button>
			                    		<!-- 삭제 모달 -->
						           		<div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog"  aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
											<div class="modal-dialog" role="document">
							        			<div class="modal-content">
							            			<div class="modal-header">
							                			<h5 class="modal-title" id="deleteConfirmationModalLabel">삭제 확인</h5>
							                			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							            			</div>
							            			<div class="modal-body">
							                			<p>정말 삭제하시겠습니까? 삭제하면 복구되지 않아요.</p>
							            			</div>
							            			<div class="modal-footer">
							                			<a class="btn btn-outline-dark mt-auto" href="<c:url value='/books/delete/${ book.bookID }' />">네</a>
							                			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
							            			</div>
							        			</div>
							    			</div>
										</div>
										<!-- /Delete modal -->
						        	</div>
					        	</div>
				        	</div>
			            </div>
			            <div class="container my-5">
			            	<div class='row'>
			            		<div class ="col-lg-12">
			            			<!-- Panel Header -->
			            			<div class="p-3 mb-3 bg-light rounded shadow-sm">
			            				<i class="bi bi-wechat fs-5"></i> REVIEWS
			            			</div>
			            			<button id="addReviewBtn" class="btn btn-light border border-primary rounded-pill px-4 py-2 shadow-sm">
			            				<i class="bi bi-pencil"></i> Add New Review
			            			</button>
			            			<!-- add New Review Modal -->
			            			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			            				<div class="modal-dialog">
			            					<div class="modal-content">
			            						<div class="modal-header">
			            							<h4 class="modal-title" id="myModalLabel">REVIEW</h4>
			            							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            						</div>
			            						<div class="modal-body">
			            							<div class="form-group">
			            								<label>Review</label>
			            								<input class="form-control" name='review' value='New Review !!'>
			            							</div>
			            							<div class="form-group" style="display:none;">
			            								<label>Review Date</label>
			            								<input class="form-control" name='reviewDate' value=''>
			            							</div>
			            						</div>
			            						<div class="modal-footer">
			            							<button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
			            							<button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
			            							<button id='modalRegisterBtn' type="button" class="btn btn-default" data-bs-dismiss='modal'>등록</button>
			            							<button id='modalCloseBtn' type='button' class='btn btn-default' data-bs-dismiss='modal'>닫기</button>
			            						</div>
			            					</div>
			            				</div>
			            			</div>
			            			
			            			<!-- Panel Body -->
			            			<div class="panel-body p-3 bg-white rounded shadow-sm">
			            				<ul class="chat list-unstyled">
			            					<!-- Start review -->
			            					<li class="media mb-3 border-bottom pb-2">
			            						<div class="media-body">
			            							<h5 class="mt-0 mb-1">user00 <small class="text-muted float-end">yyyy-mm-dd 10:00</small></h5>
			            							<p>Good job!</p>
			            						</div>
			            					</li> <!-- End review -->
			            				</ul>
			            			</div>
			            		</div> <!-- end Body -->
			            		
			            		<!-- panel footer -->
			            		<div class="panel-footer text-center">
								    <ul class="pagination justify-content-center"></ul>
								</div>
			            	</div>
			            </div>
			        </div>
			    </div>
			    
			    <!-- 천 단위로 콤마를 추가하여 출력 -->
			    <script type="text/javascript">
			    	const rawPrice = ${ book.price };
			    	document.getElementById("priceDisplay").textContent = rawPrice.toLocaleString();
				</script>
			    
			    <!-- Delete script -->
			    <script type="text/javascript">
		            $(document).ready(function () {
					    // 삭제 버튼 클릭 시 모달 창 표시
					    $(".btn-deleteAsk").click(function () {
					        $("#deleteConfirmationModal").modal("show");
					    });	
					});
	            </script>
	            
				<c:choose>
				    <c:when test="${pageContext.request.userPrincipal != null}">
				        <script type="text/javascript">
				            var currentUser = '<sec:authentication property="principal.username" />';
				            var currentUserName = '<sec:authentication property="principal.member.username" />';
				            console.log("로그인 사용자 ID:", currentUser);
				            console.log("로그인 사용자 이름:", currentUserName);
				        </script>
				    </c:when>
				    <c:otherwise>
				        <script type="text/javascript">
				            var currentUser = null;
				            var currentUserName = null;
				            console.log("비로그인 사용자");
				        </script>
				    </c:otherwise>
				</c:choose>

			    <!-- review script -->
			    <script type="text/javascript">
				    $(document).ready(function(){
				        var bookIDValue = '<c:out value="${book.bookID}"/>';
				        var reviewUL = $(".chat");
		
				        console.log(bookIDValue);  // bookIDValue 값 확인
				        
				        showList(1);
		
				        function showList(page) {
				        	console.log("show list " + page);
				            reviewService.getList({bookID: bookIDValue, page: page || 1 }, function(reviewCnt, list) {
				            	console.log("reviewCnt: " + reviewCnt);
				            	console.log("Received list:", list); // 서버로부터 받은 리스트 확인
				            	
				            	if(page == -1){
				            		pageNum = Math.ceil(reviewCnt/10.0);
				            		showList(pageNum);
				            		return
				            	}
				            	
				                var str = "";
				                
				                if (list == null || list.length == 0) {
				                	reviewUL.html("<p class='text-muted'>아직 리뷰가 없습니다.</p>");
				                    return;
				                }
				                
				                for (var i = 0, len = list.length || 0; i < len; i++) {         
				                    str += "<li class='left clearfix border-bottom mb-4' data-rno='" + list[i].rno + "'>";
				                    str += "<div><div class='header'><strong class='primary-font'>" + list[i].reviewer + "</strong>";
				                    str += "<small class='pull-right text-muted ms-2'>" + reviewService.displayTime(list[i].reviewDate) + "</small></div>";
				                    str += "<p>" + list[i].review + "</p></div></li>";
				                }
				            	reviewUL.html(str);
				                
				                // 페이징 출력
				            	showReviewPage(reviewCnt);
				            }); //end function
				        } //end showList
		
				        
				        var modal = $(".modal");
				        var modalInputReview = modal.find("input[name='review']");
				        var modalInputReviewer = modal.find("input[name='reviewer']");
				        var modalInputReviewDate = modal.find("input[name='reviewDate']");
				        
				        var modalModBtn = $("#modalModBtn");
				        var modalRemoveBtn = $("#modalRemoveBtn");
				        var modalRegisterBtn = $("#modalRegisterBtn");
				        
				     	// 리뷰 추가 버튼 클릭 시 모달 초기화
						$("#addReviewBtn").on("click", function(e) {
						    // 로그인 여부 확인
						    if (!currentUser) {
						        alert("로그인 후 리뷰를 작성할 수 있습니다.");
						        return;
						    }
						
						    // 모달 초기화 및 표시
						    modal.find("input").val("");
						    modal.find("button[id !='modalCloseBtn']").hide();
						    modalRegisterBtn.show();
						    $("#myModal").modal("show");
						});

				     	// 리뷰 등록 버튼 클릭 시 처리
				        modalRegisterBtn.on("click", function(e) {
				        	var review = {
				        		review: modalInputReview.val(),
				        		reviewer: currentUser,
				        		bookID:bookIDValue
				        	};
				        	
				        	reviewService.add(review, function(response){
				        		if (response.success) {
				                    alert(response.message);
				                    modal.find("input").val("");
					        		modal.modal("hide");	
					        		showList(-1);
				                } else {
				                	alert(response.message);
				                }
				        	});
				        });
				     	// 등록된 리뷰 수정 및 삭제 모달
				        $(".chat").on("click", "li", function(e){
				            var rno = $(this).data("rno");
				            
				            reviewService.get(rno, function(review){
				                // 로그인 사용자와 리뷰 작성자가 다르면 모달 안띄움
				                if(currentUser !== review.reviewer){
				                    alert("본인이 작성한 리뷰만 수정할 수 있습니다.");
				                    return;
				                }

				                // 리뷰어가 본인일 경우에만 모달 표시
				                modalInputReview.val(review.review);
				                modalInputReviewer.val(currentUser); // 리뷰어 로그인 사용자로 고정
				                modalInputReviewDate.val(reviewService.displayTime(review.reviewDate)).attr("readonly","readonly");
				                modal.data("rno", review.rno);
				                
				                modal.find("button:not(#modalCloseBtn)").hide();
				                modalModBtn.show();
				                modalRemoveBtn.show();
				                
				                console.log(rno);
				                console.log(review);
				                $("#myModal").modal("show");
				            });
				        });
				     	
				     	// 수정 버튼 클릭
				     	modalModBtn.on("click", function(e){
				     		// ReviewVO에 @NotNull, @NotBlank를 붙였기 때문에 모든 필드를 검증함 따로 DTO를 분리하는게 좋음
				     		var review = {rno:modal.data("rno"), review: modalInputReview.val(), bookID: bookIDValue, reviewer: currentUser};
				     		reviewService.update(review, function(response){
				     			if (response.success) {
				     	            alert(response.message);
				     	            modal.modal("hide");
				     	            showList(pageNum);
				     	        } else {
				     	            alert(response.message);
				     	        }
				     		});
				     	});
				     	
				     	// 삭제 버튼 클릭
				     	modalRemoveBtn.on("click", function(e){
				     		var rno = modal.data("rno");
				     		reviewService.remove(rno, function(response){
				     			if (response.success) {
				     	            alert(response.message);
				     	            modal.modal("hide");
				     	            showList(pageNum);
				     	        } else {
				     	            alert(response.message);
				     	        }
				     		});
				     	});
				     	
				     	// 리뷰 페이징
				     	var pageNum = 1;
				     	var reviewPageFooter = $(".panel-footer");
		
				     	function showReviewPage(reviewCnt) {
				     		// 리뷰가 없을 경우 페이징 숨김
				     	    if (reviewCnt === 0) {
				     	        reviewPageFooter.html(""); // footer 비우기
				     	        return;
				     	    }
				     		
				     	    var endNum = Math.ceil(pageNum / 10.0) * 10;
				     	    var startNum = endNum - 9;
		
				     	    var prev = startNum != 1; // 이전 버튼 표시 여부
				     	    var next = false;
		
				     	    if (endNum * 10 >= reviewCnt) {
				     	        endNum = Math.ceil(reviewCnt / 10.0);
				     	    }
		
				     	    if (endNum * 10 < reviewCnt) {
				     	        next = true;
				     	    }
		
				     	    var str = "<ul class='pagination justify-content-center'>";
		
				     	    if (prev) {
				     	        str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
				     	    }
		
				     	    for (var i = startNum; i <= endNum; i++) {
				     	        var active = pageNum == i ? "active" : "";
				     	        str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
				     	    }
		
				     	    if (next) {
				     	        str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
				     	    }
		
				     	    str += "</ul></div>";
		
				     	    console.log(str);
		
				     	    reviewPageFooter.html(str);
				     	}
				     	
				     	// 페이지 번호를 클릭했을 때 새로운 덧글을 가져오도록 하는 부분
				     	reviewPageFooter.on("click", "li a", function(e){
				     		e.preventDefault();
				     		console.log("page click");
				     		
				     		var targetPageNum = $(this).attr("href");
				     		console.log("targetPageNum: " + targetPageNum);
				     		pageNum = targetPageNum;
				     		showList(pageNum);
				     	});
				    });
			    </script>
			    
			    <script src="/resources/item/js/review.js"></script>
			    	    
			</section>
		</div>
	<footer id="footer" class="mt-auto">
		<div id="nav_box">
			<%@ include file="../../include/footer.jsp" %>
		</div>
	</footer>