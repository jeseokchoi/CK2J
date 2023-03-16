<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="${cpath }/resources/css/JH/find_Pwd.css">
<!-- 0220 -->

<main>
	<section>
		
			<div id="find_pwd">
				<div class="find_pwd_head">
					<h1>FIND PASSWORD</h1>
				</div>
				
				<div class="findForm">
			
				<form name="form1" method="POST">
					<p class="find_pwd_form"><strong>아이디:</strong> <input type="text" name="user_id"></p>
					<p class="find_pwd_form"><strong>이름 : </strong><input type="text" name="user_name"></p>
					<p class="find_pwd_form"><strong>email : </strong><input type="text" name="user_email"></p>
					<p class="find_pwd_submit"><input type="submit" value="확인"></p>
				</form>
			</div>		
		</div>
	</section>
</main>
</body>
</html>