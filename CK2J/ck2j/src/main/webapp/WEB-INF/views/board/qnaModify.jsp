<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/qnaModiStyle.css">
<!-- Write 텍스트 폼 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script src="${cpath }/resources/js/cj/qnaModify.js"></script>
<script src="summernote-custom.js"></script>

<c:if test="${dto.user_id != user.user_id }">
	<script>
		alert('본인의 글만 수정/삭제 할 수 있습니다')
		location.href = '${cpath}/board/qna'
	</script>
</c:if>

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
							<option ${dto.qna_title == '상품 문의' ? 'selected' : '' } >상품 문의</option>
							<option ${dto.qna_title == '사이즈 문의' ? 'selected' : '' }>사이즈 문의</option>
							<option ${dto.qna_title == '배송 문의' ? 'selected' : '' }>배송 문의</option>
							<option ${dto.qna_title == '배송전 취소 문의' ? 'selected' : '' }>배송전 취소 문의</option>
							<option ${dto.qna_title == '교환/반품 문의' ? 'selected' : '' }>교환/반품 문의</option>
							<option ${dto.qna_title == '기타 문의' ? 'selected' : '' }>기타 문의</option>		
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
					<textarea id="summernote" name="qna_content" required>${dto.qna_content }</textarea>
				</div>
				<div class="write_form3">
					<div class="secret_title">비밀글 설정</div>
					<div class="secret">
						<label><input type="radio" idx="1" name="qna_secret" ${dto.qna_secret == 'Y' ? 'checked' : '' } value="Y">Y</label>
						<label><input type="radio" idx="0" name="qna_secret" ${dto.qna_secret == 'N' ? 'checked' : '' } value="N">N</label>
						<p id="passwordCheck" class="hidden" >
							비밀번호 : <input type="password" value="${dto.qna_password }" name="qna_password" placeholder="비밀번호  입력">
						</p>
					</div>
				</div>
				<div class="write_submit">
					<p>
						<a href="${cpath }/board/qnaView/${dto.qna_idx}"><button>돌아가기</button></a>
						<input type="submit" value="수정">
					</p>
				</div>
			</form>
		</div>
	</section>
</main>
	
	

<script>
	$(document).ready(function() {
	  $('#summernote').summernote();
	});
	if(document.querySelector('input[idx="1"]').checked == true){
		document.querySelector('p#passwordCheck').classList.remove('hidden')
	}
	document.querySelectorAll('input[name="qna_secret"]').forEach(e => e.onchange = redioChange)
	document.querySelector('div.write_submit button').onclick = qnaReturnBtn
</script>

</body>
</html>