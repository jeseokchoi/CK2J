<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/pwd_result.css">
<script>
	const user_email='${ob.user_email}'
	const user_id = '${ob.user_id}'
</script>
<script src="${cpath }/resources/js/JH/pwd_result.js"></script>
<main>
<section>


<div id="pwd_result">
<c:if test="${msg != null }">
	<script>
	alert('${msg}')
	location.href="${cpath}/user/login"
	</script>
</c:if>

<c:if test="${msg == null }">
		<script>
			alert('${msg2}')
		</script>
			<div class="pwd_result_head">
				<h1>FIND PASSWORD</h1>
				<h4>가입시 등록된 이메일 주소로 인증번호가 전송 되었습니다.<br> 인증 번호를 확인하시고 입력 부탁 드립니다.</h4>
			</div>
			
			<div class="pwd_result_body">
			<form id="form1">
				<p class="pwd_result_input"><strong>인증번호 입력 :</strong><input type="text" name="verification"></p>
				<p class="pwd_result_submit"><input type="submit" value="인증하기"></p>
			</form>
			</div>
	</c:if>
</div>

</section>
</main>

<script>
	console.log('${ob.user_email}')
	console.log('${ob.user_id}')
	
	const checkForm = document.getElementById('form1')	
	checkForm.onsubmit = ownerCheck
	
</script>


</body>
</html>