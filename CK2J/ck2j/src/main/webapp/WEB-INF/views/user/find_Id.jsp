<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="${cpath }/resources/css/JH/find_id.css">

<main>
<section>
	<div id="find_id">
	<div class="find_id_head">
		<h1>FIND ID</h1>
		
		<h4>가입하신 방법에 따라 아이디 찾기가 가능합니다.<br>
			법인사업자 회원 또는 외국인 회원의 경우 법인명과 법인번호 또는 이름과 등록번호를 입력해 주세요.</h4>
	</div>
	<div class="findForm">
		<form method="POST">
			<p class="find_id_form"><strong>이름</strong><input type="text" name="user_name"></p>
			<p class="find_id_form"><strong>이메일</strong><input type="email" name="user_email"></p>
			<p class="find_id_form"><strong>전화번호</strong><input type="text" name="user_phone"></p>
			<p class="find_id_submit"><input type="submit" value="확인"></p>
		</form>
	</div>
	
	</div>
	
</section>
</main>
</body>
</html>