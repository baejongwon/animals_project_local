<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:import url="/header" />
<link rel="stylesheet" href="infoBoard.css">
<script src="infoBoard.js"></script>

<div class="banner" style="background-image: url('img/7001287-sweet-cat.jpg');background-position: 0 57%;">
	<div>
		<h1>Information</h1>
		<p>반려동물 지식 나눔</p>
	</div>
</div>

<div class="sub-contents" id="contents" tabindex="0">
	<div class="container">
		<div class="board-view">
			<h4 class="blind">정보공개 내용</h4>
			<div class="head">
				<strong class="subject">${board.title}</strong>
				<ul class="info">
					<li class="first"><strong>작성일</strong>${board.createdDate }</li>
					<li class="last"><strong>조회수</strong>${board.viewCount }</li>
					<li class="last"><strong>좋아요</strong>
						<img id="likeImg" src="img/like.png" alt="like button" style="width: 15px;margin-top: 5px;cursor: pointer;">
					</li>
				</ul>
			</div>
			<div class="content" id="viewer">
				<c:out value="${board.content}" escapeXml="false" />
			</div>

		</div>

		<!-- 댓글 작성 폼 -->
		<form action="addComment" method="POST">
			<input type="hidden" name="postNo" value="${board.postNo}" /> 
			<input type="hidden" name="parentNo" value="0" />
			<input type="hidden" name="type" value="info" />
			<div class="form-group" style="margin-top: 20px;">
				<textarea name="content" class="form-control"
					placeholder="댓글을 입력하세요" required onclick="showButton()"
					style="height:100px;"></textarea>
			</div>
			<button type="button" class="btn-n" id="cancelButton"
				style="display: none; background: #fff; border: none; color: #000"
				onclick="hideButton()">취소</button>
			<button type="submit" class="btn-n" id="submitButton"
				style="display: none;">작성</button>
		</form>
		<div class="comment-section">
			<h4>댓글 ${commentCount } 개</h4>

			<!-- 기존 댓글 목록 -->
			<div class="comments-list">
				<c:forEach var="comment" items="${comments}">
					<c:if test="${comment.parentNo == 0}">
						<!-- 부모 댓글 -->
						<div class="comment-item" style="margin-top: 12px;">
							<p style="margin-bottom: 3px;">
								<strong>${comment.author}</strong> <small>${comment.createdDate}</small>
								<button type="button" class="btn-s"
									onclick="showReplyForm(${comment.commentNo})">답글</button>
								<c:if test="${sessionScope.id eq comment.author }">
									<button type="button" class="btn-s " id="modifyButton-${comment.commentNo}"
										onclick="modifyComment(${comment.commentNo},'${comment.content}','${type}')">수정</button>
									<button type="button" class="btn-s "
										onclick="deleteComment(${comment.commentNo},${board.postNo},'${type}')">삭제</button>
								</c:if>
							</p>
							<p id="commentText-${comment.commentNo}" class="light-text">${comment.content}</p>
						</div>
						<!-- 대댓글 목록 -->
						<c:forEach var="reply" items="${comments}">
							<c:if test="${reply.parentNo == comment.commentNo}">
								<div class="comment-item reply-item"
									style="margin-left: 20px; margin-top: 10px;">
									<p style="margin-bottom: 3px;">
										<strong>${reply.author}</strong> <small>${reply.createdDate}</small>
										<c:if test="${sessionScope.id eq reply.author }">
											<button type="button" class="btn-s" id="modifyButton-${reply.commentNo}"
												onclick="modifyComment(${reply.commentNo},'${reply.content}','${type}')">수정</button>
											<button type="button" class="btn-s"
												onclick="deleteComment(${reply.commentNo},${board.postNo},'${type}')">삭제</button>
										</c:if>
									</p>
									<p id="commentText-${reply.commentNo}" class="light-text">${reply.content}</p>
								</div>
							</c:if>
						</c:forEach>
						<!-- 대댓글 작성 폼 -->
						<div id="replyForm-${comment.commentNo}" class="reply-form"
							style="display: none; margin-left: 20px; margin-top: 20px;">
							<form action="addComment" method="POST">
								<input type="hidden" name="postNo" value="${comment.postNo}" />
								<input type="hidden" name="parentNo" value="${comment.commentNo}" />
								<input type="hidden" name="type" value="info" />
								<div class="form-group">
									<textarea name="content" class="form-control"
										placeholder="답글을 입력하세요" required></textarea>
								</div>
								<button type="submit" class="btn-n">작성</button>
							</form>
						</div>
					</c:if>
				</c:forEach>
			</div>

		</div>
		<!-- 댓글 작성 끝 -->

		<div class="action-btn-group" style="clear: both;">
			<input type="hidden" id="postNo" value="${board.postNo}" />
			<div class="center">
				<button type="button" class="btn btn-light btn-lg w-sm"
					onclick="location.href='infoBoard?page=${paging}'">목록</button>
				<c:if test="${sessionScope.id eq board.author }">
					<button type="button" class="btn btn-light btn-lg w-sm"
						onclick="location.href='infoBoardModify?postNo=${board.postNo}'">수정</button>
					<button type="button" class="btn btn-light btn-lg w-sm"
						onclick="deleteCheck()">삭제</button>
				</c:if>
			</div>
		</div>

	</div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
	const likeImg = document.getElementById("likeImg");
	let isLike = false;
	const postNo = ${board.postNo};
	const like_check = ${like_check != null ? like_check : 0}; 
	
	if (like_check > 0) {
	      likeImg.src = "img/Like_active.png";
	      isLike = true; 
	  } else {
	      likeImg.src = "img/like.png";
	      isLike = false; 
	  }
	  
	function likePoint() {
		 $.ajax({
		        url: "like/active",
		        type: "POST",
		        data: JSON.stringify({
		            postNo: postNo,
		            post_type : 'info'
		        }),
		        dataType: "json",
		        contentType: "application/json",
		        success: function(data) {
		        	console.log("data : ?", data);	
		        	if (data.status === "로그인이 필요합니다.") {
		                alert(data.status);  
		                window.location.href = 'login';
		            } else{
		        		console.log("좋아요 활성화 성공:", data);	
		        	}
		        },
		        error: function(errorThrown) {
		            console.error("좋아요 활성화 실패:", errorThrown);
		        }
		    });
	}

	function unlikePoint() {
		 $.ajax({
		        url: "like/Inactive",
		        type: "POST",
		        data: JSON.stringify({
		            postNo: postNo,
		           post_type : 'info'
		        }),
		        dataType: "json",
		        contentType: "application/json",
		        success: function(data) {
		        	if (data === "로그인이 필요합니다.") {
		                alert(data);  
		                window.location.href = 'login';
		            } else{
		        		console.log("좋아요 활성화 성공:", data);	
		        	}
		        },
		        error: function(errorThrown) {
		            console.error("좋아요 활성화 실패:", errorThrown);
		        }
		    });
		console.log("좋아요 비활성화");
	}

	likeImg.addEventListener("click", function() {
		if (!isLike) {
			likeImg.src = "img/Like_active.png";
			likePoint();
		} else {
			likeImg.src = "img/like.png";
			unlikePoint();
		}
		isLike = !isLike;
	});
});
</script>
<c:import url="/footer" />
