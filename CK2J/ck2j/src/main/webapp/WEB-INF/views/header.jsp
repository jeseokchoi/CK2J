<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서평랭</title>
<script>const cpath = '${cpath}'</script>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/header.css">

</head>
<body>
<div class="homeWindow"></div>
<aside id="right">
	<button id="rightAsideX">X</button>
	<ul class="asideRight" style="margin-left:10%;">
		<c:if test="${empty user && empty nonuserLoginDTO}">
			<li><a href="${cpath }/user/login">LOGIN</a></li>
			<li><a href="${cpath}/product/cart">CART</a></li>
			<li><a href="${cpath }/user/mypage">MYPAGE</a></li>
		</c:if>
		
			<!-- 회원 로그인 / 로그아웃 -->
		<c:if test="${not empty user }">
			<li><h3>${user.user_name }님 환영합니다.</h3></li>
			<li><a href="${cpath }/user/logout">LOGOUT</a></li>
			<li><a href="${cpath}/product/cart/${user.user_id}">CART</a></li>
			<li><a href="${cpath }/user/mypage">MYPAGE</a></li>
		</c:if>
		
		<c:if test="${not empty nonuserLoginDTO}">
			<li><h3>${nonuserLoginDTO.receiver_name }님 환영합니다.</h3></li>
			<li><a href="${cpath }/nonuser/logout">NONUSER_LOGOUT</a></li>
			<li><a href="${cpath }/nonuser/orderList">NONUSER_ORDERLIST</a></li>
		</c:if>
		<c:if test="${user.user_role == 'admin'}">
			<li><a href="${cpath }/admin/index">ADMIN_PAGE</a></li> 
		</c:if>
			<!-- 비회원 로그인 / 로그아웃 -->
	</ul>
</aside>

<!-- 요기 변경 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 3/1 새봄 -->
<aside id="menuBtn">
<!-- 	<button id="reading_glasses">◎돋보기</button> -->
	
	<img id="reading_glasses" src="${cpath }/resources/img/reading_glasses.png">
	<a href="${cpath }/product/cart/${user.user_id}"><img id="shopping_bag" src="${cpath }/resources/img/shopping_bag.png"></a>
	<img id="ham" src="${cpath }/resources/img/hamburger.png">
<!-- 	<button id="ham">햄버거</button> -->

</aside>


<aside id="left">
	<h1><a href="${cpath }/">CK2J</a></h1>
	<ul>
		<li>
			WOMAN
			<ol class="dropDown w">
				<li><a href="${cpath }/product/productList/w_">All</a></li>
				<li><a href="${cpath }/product/productList/w_outer">Outer</a></li>
				<li><a href="${cpath }/product/productList/w_shirts">Shirts</a></li>
				<li><a href="${cpath }/product/productList/w_top">Top</a></li>
				<li><a href="${cpath }/product/productList/w_bottom">Bottom</a></li>
				<li><a href="${cpath }/product/productList/w_knit">Knit</a></li>
			</ol>
		</li>
		<li>
			MAN
			<ol class="dropDown m">
				<li><a href="${cpath }/product/productList/m_">All</a></li>
				<li><a href="${cpath }/product/productList/m_suit">Suit</a></li>
				<li><a href="${cpath }/product/productList/m_outer">Outer</a></li>
				<li><a href="${cpath }/product/productList/m_top">Top</a></li>
				<li><a href="${cpath }/product/productList/m_knit">Knit</a></li>
				<li><a href="${cpath }/product/productList/m_shirts">Shirts</a></li>
				<li><a href="${cpath }/product/productList/m_pants">Pants</a></li>
				<li><a href="${cpath }/product/productList/m_shoes">Shoes</a></li>
			</ol>
		</li>
		<li>
			BOARD
			<ol class="dropDown b">
				<li><a href="${cpath }/board/notice">Notice</a></li>
				<li><a href="${cpath }/board/qna">Q & A</a></li>
			</ol>
		</li>
		<li> 
			ABOUT
			<ol class="dropDown a">
			
				<li><a href="${cpath}/map">Map</a></li>
				<li><a href="${cpath}/aboutUs">About Us</a></li>
					
			</ol>
		
		</li>
	</ul>
</aside>

<div class="SNS">
	
<a href="https://www.facebook.com/Showpin2/"><img id="facebook" style="height:25px; width:25px; margin-left: 0px;"  src="${cpath }/resources/img/facebook.gif"></a>
<a href="https://www.instagram.com/showpin_official/"><img id="instagram" style="height:25px; width:25px; margin-left: 10px;" src="${cpath }/resources/img/instagram.png"></a>
<a href="https://pf.kakao.com/_xiGULM"><img id="kakao" style="height:25px; width:25px; margin-left: 13px;" src="${cpath }/resources/img/kakao.png"></a>
	

</div>

<!-- 새봄 써치 모달 -->
<div class="modalWindow"></div>

<div id="modal" class="hidden">
   

   <div class="X">X</div>
<!--    <button id="modalX">X</button> -->
   
   <div class="searchInput">
      <fieldset>
      <form method="GET" action="${cpath}/search/searchList">
         
         <div class="searchInput2">
            <input type="text" name="keyword" value="${param.keyword }"  placeholder="SEARCH">
            <div class="searchInfo">검색어 입력후에 엔터를 누르세요.</div>         
          </div>
          
      </form>   
      </fieldset>
   
   </div>
   <div id="modal_overlay"></div>
</div>

<!-- <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script> -->
<script src="${cpath }/resources/js/ch/headerFunction.js"></script>
<script>
	const leftTitleArray = Array.from(document.querySelectorAll('ul > li'))
	const olList = document.querySelectorAll('ol')
	const ham = document.querySelector('img#ham')
	const rightAsideX = document.querySelector('button#rightAsideX')
	const homeWindow = document.querySelector('div.homeWindow')
	const test1 = document.querySelector('button#test')
	const reading_glasses = document.querySelector('img#reading_glasses') 
	const X = document.querySelector('div.X')
	const modalWindow = document.querySelector('div.modalWindow')
	
	
	leftTitleArray.forEach(t => t.onclick = clickHandler)
	ham.onclick = menuOpen
	rightAsideX.onclick = menuClose
	homeWindow.onclick = menuClose
	reading_glasses.onclick = openModal
	X.onclick = closeModal
</script>


