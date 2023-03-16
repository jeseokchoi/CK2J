<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/review_reply_modify.css">

<div id="review_reply_modify">
		<div class="review_modify_head">
			<h1>REVIEW MODIFY</h1>
		</div>
		
		<div class="review_modify_body">
		<form method="POST">
		<div><input type="hidden" name="product_review_idx" value="${dto.product_review_idx }"></div>
		<div><input type="hidden" name="review_reply_idx" value="${dto.review_reply_idx }"></div>
		<div>	
			<div><textarea name="content" rows="10" cols="70">${dto.content }</textarea></div>
		</div>
		<div><input class="reviewReply_modify_button" type="submit" value="리뷰 답글 수정"></div>
	</form>
	</div>
</div>

</body>
</html>