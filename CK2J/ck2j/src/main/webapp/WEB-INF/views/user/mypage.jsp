<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/mypage.css">

<main>
<section>
	<div id="mypage_root">
		<div class="mypage_head"><h1>MY PAGE</h1></div>
		<div class="info">
			<div class="profile1"><img src="${cpath }/resources/img/member.png"></div>
			<div class="profile2"><h3>${user.user_name }님의 마이페이지입니다.<br>
				회원님의 등급은 ${user.user_grade }입니다.</h3>
			</div>
		</div>
		<div class="menu">
			<div class="menu_detail"><img  src="${cpath }/resources/img/bill.png"></div>
			<div class="menu_detail"><h3><a href="${cpath }/user/userOrder">ORDER</a></h3></div>
			<div class="menu_detail"><p><a href="${cpath }/user/userOrder">고객님께서 주문 하신 상품의<br>
			주문 내역을 확인 하실수 있습니다.</a></p></div>
		</div>
		<div class="menu">
			<div class="menu_detail"><img src="${cpath }/resources/img/truck.png"></div>
			<div class="menu_detail"><h3><a href="${cpath }/user/deliverAddress/${user.user_id}">배송지관리</a></h3></div>
			<div class="menu_detail"><p><a href="${cpath }/user/deliverAddress/${user.user_id}">자주 사용하는 배송지를 등록하고<br>관리하실 수 있습니다.</a></p></div>
		</div>
		<div class="menu">
			<div class="menu_detail"><img src="${cpath }/resources/img/user.png"></div>
			<div class="menu_detail"><h3><a href="${cpath }/user/mypageModify">회원정보 관리</a></h3></div>
			<div class="menu_detail"><p><a href="${cpath }/user/mypageModify">회원이신 고객님의 개인정보를<br>
			관리하는 공간 입니다</a></p></div>
		</div>
	</div>
	</section>
	</main>
</body>
</html>