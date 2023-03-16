<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/review_look.css">

<script src="${cpath }/resources/js/JH/reviewLook.js"></script>

	
	<main>
		<section>	
		<div id="review_look">
		<div class="review_look_head">
			<h1>REVIEW REPLY</h1>
		</div>
		<div class="review_look_body1">
	
	    <div class="review_body"><div class="review_thead">리뷰 번호 </div>     <div class="review_tbody"> ${dto.product_review_idx }</div></div>
	    <div class="review_body"><div class="review_thead">옵션 번호</div>      <div class="review_tbody"> ${dto.product_opt_idx }</div></div>
	    <div class="review_body"><div class="review_thead">유저 아이디</div>    <div class="review_tbody"> ${dto.user_id }</div></div>
	    <div class="review_body"><div class="review_thead">별점</div>           <div class="review_tbody"> ${dto.rate }</div></div>
	    <div class="review_body"><div class="review_thead">작성일 </div>        <div class="review_tbody"> ${dto.writing_date }</div></div>
	    <div class="review_body"><div class="review_thead">삭제 여부 </div>     <div class="review_tbody"> ${dto.delete_check == "n" ? "정상" : "삭제됨" }</div></div>
	    <div class="review_body"><div class="review_thead">내용 </div>          <div class="review_tbody"> ${dto.content }</div></div>
	    
	</div>
		<hr>
		<c:if test="${dto2 != null }">
		<div class="review_reply">
			<div class="review_body"><div class="review_thead">답글 번호 </div> 			    <div class="review_tbody">${dto2.review_reply_idx }</div></div>
			<div class="review_body"><div class="review_thead">내용</div> 				<div class="review_tbody">${dto2.content }</div></div>
			<div class="review_body"><div class="review_thead">답글작성일</div> 			<div class="review_tbody">${dto2.writing_date }</div></div>
			<div class="review_body_button">
				<a href="${cpath }/admin/board/reviewReplyModify/${dto.product_review_idx}"><button>수정하기</button></a>
				<a href="${cpath }/admin/board/reviewReplyDelete/${dto2.review_reply_idx}"><button id="delete">삭제하기</button></a>
			</div>
		</div>
				</c:if>
				
				<c:if test="${dto2 == null }">
				<div class="review_reply">
					<form method="POST">
						<p><input type="hidden" name="product_review_idx" value="${dto.product_review_idx }"></p>
						<p><textarea placeholder="리뷰에 답글을  입력해보세요😊" name="content" rows="10" cols="60"></textarea></p>
						<p><input class="review_reply_button" type="submit" value="리뷰 답글 달기"></p>
					</form>
				</div>
				</c:if>
				</div>	
				</section>
			</main>

<script>
	const deletBtn = document.getElementById('delete')
	deletBtn.onclick = deleteReview
</script>

</body>
</html>