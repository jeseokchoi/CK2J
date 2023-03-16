<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/qnaPassword.css">
<script src="${cpath }/resources/js/cj/qnaPassword.js"></script>
<main>
	<section>
		<div class="wrap">
			<div id="qna_title">
				<h2>Q&A</h2>
			</div>
			<div id="root">
			<div class="qnaPassword_text">
				<p>이 글은 비밀글입니다. <span>비밀번호를 입력하여 주세요.</span></p>
			</div>
			<div class="qnaView_password">
				<form method="POST">
					<div class="qna_password">비밀번호
						<input type="password" name="qna_password">
					</div>
					<div class="qnaPassword_return">
						<a href="${cpath }/board/qna"><button>목록</button></a>
						<input type="submit" value="확인">
					</div>
				</form>
			</div>
			</div>
		</div>
	</section>
</main>
<script>
	const error = '${error}'
	if(error != '') {
		alert(error)
	}
	
	document.querySelector('div.qnaPassword_return > a > button').onclick = qnaReturnBtn
</script>

</body>
</html>