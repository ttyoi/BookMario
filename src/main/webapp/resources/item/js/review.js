console.log("Review Module.....");

var reviewService = (function() {
	
	// 리뷰 추가
	function add(review, callback, error) {
	    console.log("add review.....");

	    $.ajax({
	        type: 'post',
	        url: '/review/new',
	        data: JSON.stringify(review),
	        contentType: "application/json; charset=utf-8",
	        success: function(response) {
	            if (callback) {
	            	callback(response);
	                alert("리뷰가 성공적으로 추가되었습니다!");
	            }
	        },
	        error: function(xhr, status, errorMessage) {
	            var errorResponse = {
	                success: false,
	                message: "리뷰 등록에 실패했습니다."
	            };
	            
	            if (xhr.responseJSON && xhr.responseJSON.message) {
	                errorResponse.message = xhr.responseJSON.message;
	            }
	            
	            if (callback) {
	                callback(errorResponse);
	            }
	        }
	    });
	}

	
	// 리뷰 조회
	function getList(param, callback, errorMessage){
		var bookID = param.bookID;
		var page = param.page || 1;
		
		$.getJSON("/review/pages/"+ bookID + "/" + page + ".json",
			function(data) {
				if(callback) {
					callback(data.reviewCnt, data.list); // 댓글의 숫자와 목록을 가져옴
				}
			}).fail(function(chr, status, errorMessage) {
				if(errorMessage) {
					errorMessage();
				} else {
	                console.error("ErrorMessage is not a function");
	            }
			});
	}
	
	// 리뷰 삭제
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/review/' + rno,
			success : function(response, status, xhr) {
				if (callback) {
					callback(response);
				}
			},
			error : function(xhr, status, er) {
				var errorResponse = {
	                success: false,
	                message: "리뷰 삭제에 실패했습니다."
	            };
	            
	            if (xhr.responseJSON && xhr.responseJSON.message) {
	                errorResponse.message = xhr.responseJSON.message;
	            }
	            
	            if (callback) {
	                callback(errorResponse);
	            }
			}
		});
	}
	
	// 리뷰 수정
	function update(review, callback, error) {
		$.ajax({
			type : 'put',
			url : '/review/' + review.rno,
			data : JSON.stringify(review),
			contentType : "application/json; charset=utf-8",
			success : function(response, status, xhr) {
				if (callback) {
					callback(response);
				}
			},
			error : function(xhr, status, er) {
				var errorResponse = {
	                success: false,
	                message: "리뷰 수정에 실패했습니다."
	            };
	            
	            if (xhr.responseJSON && xhr.responseJSON.message) {
	                errorResponse.message = xhr.responseJSON.message;
	            }
	            
	            if (callback) {
	                callback(errorResponse);
	            }
			}
		});
	}
	
	// 리뷰 단건 조회 처리
	function get(rno, callback, error) {
		$.get("/review/" + rno + ".json", function(result) {
            if (callback) {
                callback(result);
            }
        }).fail(function(xhr, status, err) {
            if (error) {
                error(err);
            }
        });
    }
	
	// 시간에 대한 처리
	function displayTime(timeValue) {
	    var dateObj = new Date(timeValue); // UTC 시간으로 생성됨

	    // 현재 시간과의 차이를 계산
	    var today = new Date();
	    var gap = today.getTime() - dateObj.getTime();
	    
	    // 오늘 작성된 리뷰일 경우 시간만 표시
	    if (gap < (1000 * 60 * 60 * 24)) {
	        var hh = dateObj.getHours(); // UTC 시간을 그대로 가져옴
	        var mi = dateObj.getMinutes();
	        var ss = dateObj.getSeconds();
	        
	        return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, ':', (ss > 9 ? '' : '0') + ss].join('');
	    } else { // 하루 이상 차이가 나면 날짜를 표시
	        var yy = dateObj.getFullYear();
	        var mm = dateObj.getMonth() + 1; // 월은 0부터 시작하므로 +1 필요
	        var dd = dateObj.getDate();
	        
	        return [yy, '/', (mm > 9 ? '' : '0') + mm, '/', (dd > 9 ? '' : '0') + dd].join('');
	    }
	}

	return {
		add : add,
		get : get,
		getList : getList,
		remove : remove,
		update : update,
		displayTime : displayTime
	};
})();