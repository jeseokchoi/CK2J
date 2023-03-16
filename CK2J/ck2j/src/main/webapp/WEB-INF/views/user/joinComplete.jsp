<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/joinComplete.css">
<main>
<section>
<div id="welcome_root">
	<div class="title"><h1>JOIN US</h1></div>
	<div class="subtitle"><h3>회원가입이 완료 되었습니다.</h3></div>
	<div class="box">
		<div class="box_title">저희 쇼핑몰을 이용해 주셔서 감사합니다.</div>
		<div class="sub_box">
			<div class="pic"><img src="${cpath }/resources/img/join.png"></div>
			<div class="user_detail">
				<table class="welcome_table">
					<tr>
						<th>아이디</th>
						<td>${dto.user_id }</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${dto.user_name }</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${dto.user_email }</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="welcome_message">
		<h4>${dto.user_name }님의 가입을 진심으로 환영합니다.</h4>
		<h4>현재 ${dto.user_name }님은 등급은 [Bronze]입니다.</h4>		
	</div>
	<div class="location_button">
		<a href="${cpath }/">메인으로 이동</a>
	</div>
</div>

</section>
</main>
</body>
</html>