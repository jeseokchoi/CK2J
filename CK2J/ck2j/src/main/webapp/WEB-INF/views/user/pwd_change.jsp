<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/pwd_change.css">
<script src="${cpath }/resources/js/JH/pwd_change.js"></script>
<main>
	<section>
	
	<div id="pwd_change">
	<div class="pwd_change_head">
		<h1>PASSWORD CHANGE</h1>
		<h4>고객님의 계정 비밀번호를 새로 설정 합니다.</h4>
	</div>
	<div class="pwd_change_body">
		<form method="POST">
		<div class="pwd_result_input">
			<div class="pwd_change">비밀번호</div><div class="pwd_change_input"><input type="password" name="user_pwd" required></div>
			<div class="pwd_span"><span class="pw1Check"></span></div>
			
			</div>
			
			<div class="pwd_result_input">
				<div class="pwd_change">비밀번호 확인</div><div class="pwd_change_input"><input type="password" name="pwCheck"></div>
				<div class="pwd_span"><span class="pw2Check"></span></div>
			
				</div>
				
				<div class="pwd_result_submit"><div><input type="submit" value="변경하기" required></div></div>
		</form>
		</div>
	</div>
	</section>
</main>

<script>
	const user_pwd = document.querySelector('input[name="user_pwd"]')
	const pw1Check = document.querySelector('span.pw1Check')
	
	const pwCheck = document.querySelector('input[name="pwCheck"]')
	const pw2Check = document.querySelector('span.pw2Check')
			
 	user_pwd.onkeyup = passwordCheck

 	pwCheck.onkeyup = passwordCheck2
 	
 	const btnSubmit = document.querySelector('input[type="submit"]')
 	btnSubmit.onclick = modifyProgress

</script>

</body>
</html>