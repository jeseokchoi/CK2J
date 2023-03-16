<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" /> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/adHeader.css">
<body>
<script>
	const cpath = '${cpath}'
</script>
<header>
	<a href="${cpath }/admin/index">관리자페이지</a><a href="${cpath }" style="margin-left: 40px; font-size: 15px;">홈페이지가기</a>
</header>
<main>
<aside>
	<ul class="up">
		<li class="dropMenu">
			상품관리&#5121;
			<ul>
				<li><a href="${cpath }/admin/product/productList">▶ 상품조회</a></li>
				<li><a href="${cpath }/admin/product/uploadFile">▶ 상품등록</a></li>
			</ul>
		</li>
		<li><a href="${cpath }/admin/userManage">회원관리</a></li>
		<li class="dropMenu">
			주문관리&#5121;
			<ul>
				<li><a href="${cpath }/admin/order/userOrderList">▶ 회원주문내역</a></li>
				<li><a href="${cpath }/admin/order/nonuserOrderList">▶ 비회원주문내역</a></li>
			</ul>
		</li>
		<li class="dropMenu">
			통계&#5121;
			<ul>
				<li><a href="${cpath }/admin/accounting/sales">▶ 매출 통계</a></li>
				<li><a href="${cpath }/admin/statistics/gender">▶ 성별 통계</a></li>
				<li><a href="${cpath }/admin/statistics/age">▶ 연령대 통계</a></li>
			</ul>
		</li>
		
		<li class="dropMenu">
			고객관리&#5121;
			<ul>
				<li><a href="${cpath }/admin/board/adNotice">▶ 공지사항 관리</a></li>
				<li><a href="${cpath }/admin/board/qnaReply">▶ Q&A 관리</a></li>
				<li><a href="${cpath }/admin/board/reviewManage">▶ 리뷰 관리</a></li>
			</ul>
		</li>
	</ul>
</aside>




<script>
	const dropMenu = document.querySelectorAll('li.dropMenu')
	
	function dropDownkHandler(event) {
    	const dropDown = event.target.querySelector('ul')
    	const dropList = document.querySelectorAll('li.dropMenu > ul')
    	if(dropDown.classList.contains('selected')){
    		dropDown.classList.remove('selected')
    		return
    	}
    	dropList.forEach(e => e.classList.remove('selected'))
    	dropDown.classList.add('selected')
     }

	dropMenu.forEach(e => e.onclick = dropDownkHandler)
</script>


