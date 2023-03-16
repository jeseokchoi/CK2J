<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/qnaWriteStyle.css">
<!-- Write 텍스트 폼 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script src="${cpath }/resources/js/cj/qnaWrite.js"></script>
<script src="summernote-custom.js"></script>

<main>
	<section>
		<div class="wrap">
		<div id="qna_title">
			<h2>Q&A</h2>
		</div>
			<form method="POST">
			<div class="write_form1">
				<div class="write_title">제목</div>
					<div class="write_select">
						<select name="qna_title">
								<option>상품 문의</option>
								<option>사이즈 문의</option>
								<option>배송 문의</option>
								<option>배송전 취소 문의</option>
								<option>교환/반품 문의</option>
								<option>기타 문의</option>		
						</select>
					</div>
			</div>
				<div class="write_form2">
					<div class="writer_title">작성자</div>
						<div class="writer">
							<input type="text" name="user_id" value="${user.user_id }" readonly>
						</div>		
				</div>
				<div class="content">
					<textarea id="summernote" name="qna_content" required></textarea>
				</div>
				<div class="write_form3">
					<div class="secret_title">비밀글 설정</div>
					<div class="secret">
						<label><input type="radio" name="qna_secret" value="N" checked>공개글</label>
						<label><input type="radio" name="qna_secret" value="Y">비밀글</label>
						<div id="passwordCheck" class="hidden">
							비밀번호 : <input type="password" name="qna_password" placeholder="비밀번호  입력">
						</div>
					</div>
				</div>
				<div class="write_submit">
					<p>
						<a href="${cpath }/board/qna"><button>목록</button></a>
						<input type="submit" value="작성">
					</p>
				</div>		
			</form>
		</div>
	</section>
</main>


<script>
	document.querySelectorAll('input[name="qna_secret"]').forEach(e => e.onchange = radioBtn)
	document.querySelector('div.write_submit button').onclick = qnaReturnBtn
	
	$(document).ready(function() {
	  $('#summernote').summernote();
	});
</script>

</body>
</html>