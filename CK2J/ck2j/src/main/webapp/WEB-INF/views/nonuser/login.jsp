<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="${cpath }/resources/css/newSpring/login.css" type="text/css"/>



<div class="keepgrowLogin">

<h1 class="shopName">
	<a href="${cpath}/">SPN</a>
</h1>

<div class="nonuserLogoin">

<ul class="tabMenu">
	<li><a href="${cpath}/user/login">기존 회원이세요 ?</a></li>
	<li  class="nHover"><a href="${cpath}/nonuser/login">비회원 배송조회</a></li>
</ul>

<div class="nonuserLogoinBox">
	<form method="POST">
		<p><input class="nonuser" type="text" name="receiver_name" placeholder="주문자명"></p>
		<p><input class="nonuser" type="number" name="nonuser_order_idx" placeholder="주문번호"></p>
		<p><input class="nonuser" type="password" name="nonuser_pwd" placeholder="비회원 주문 비밀번호"></p>
		<p><input class="nonuserBtn" type="submit" value="비회원 로그인"></p>
		
<%-- 		<p><a class="nonuserBtn" href="${cpath}/nonuser/orderList"><button>비회원 로그인</button></a></p> --%>
	</form>
	
</div>	

</div>

</div>

</body>
</html>