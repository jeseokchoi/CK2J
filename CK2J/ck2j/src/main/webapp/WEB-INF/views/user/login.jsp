<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="${cpath }/resources/css/newSpring/user/login.css" type="text/css"/>



<div class="keepgrowLogin">

<h1 class="shopName">
	<a href="${cpath}/">CK2J</a>
</h1>

<div class="userLogoin">
<ul class="tabMenu">
	<li class="uHover"><a href="${cpath}/user/login">기존 회원이세요 ?</a></li>
	<li><a href="${cpath}/nonuser/login">비회원 배송조회</a></li>
</ul>

<div class="userLogoinBox">
	<form method="POST">
		<p><input class="user" type="text" name="user_id" placeholder="아이디"></p>
		<p><input class="user" type="password" name="user_pwd" placeholder="비밀번호"></p>
		<p><input class="userBtn" type="submit" value="기존 회원 로그인"></p>
		
	</form>
	
<!-- 3/2 스타일 전부 변경 가입하기 추가 .               !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->	
	<div class="find">
			<p><a href="${cpath }/user/find_Id" style="margin-right: 10px;">아이디 찾기</a> |
	 		<a href="${cpath }/user/find_Pwd" style="margin-left: 10px;">비밀번호 찾기</a></p>
	 		<p><a href="${cpath }/user/join" style="margin-left: 50px;">가입하기</a></p>
	</div>
		
	</div>
	

	
</div>	


</div>





