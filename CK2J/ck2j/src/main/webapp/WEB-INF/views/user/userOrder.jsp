<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<link rel="stylesheet" href="${cpath }/resources/css/newSpring/user/userOrder.css" type="text/css"/>


<!-- 2/28 통일 수정 -->
<section class="orderList">

	<div class="titleArea">
		<h2>ORDER LIST</h2>
	</div>

	<table id="purchaseProductList" style="width: 100%;">
	
		<thead>
			<tr>
			
			<th>
			<br>
			주문일자<br>
				[주문번호]
				<br>
				<br>
				
<!-- 2/28새봄 수정   테스트 ok-->	

<%-- <c:if test="${orderList[0].order_detail_status == '주문확인중' }">  --%>
<%-- 			<a href="${cpath }/user/orderListDelete/${orderList[0].user_order_idx}"><button>취소</button></a> --%>
<%-- 		</c:if> --%>

	<c:choose>
		<c:when test="${orderList[0].order_detail_status == '주문확인중' }">
			<a href="${cpath }/user/orderListDelete/${orderList[0].user_order_idx}"><button>취소</button></a>
		</c:when>
		
		<c:otherwise>
			<h1></h1>
		</c:otherwise>
	
	</c:choose>

				<th>이미지</th>
				<th>상품정보</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>상세주소</th>
				<th>주문 개수</th>
				<th>주문 금액</th>
				<th>주문 현황</th>
				<th>리뷰작성</th>
<!-- 2/28 새봄 수정 !!!!!!!!!!!!!!!!! -->	

				<th style ="border-bottom: 1px solid #dadada;">상품 교환/반품</th>
		
			</tr>
		</thead>
		<tbody>
<!--3/2 수정 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 변경 !!!!!!  -->	


	<c:if test="${empty orderList }">

					<td class="errorBlack"><h2>주문내역이 없습니다.<br>
					(주문취소 성공)</h2></td>
	</c:if>
		<c:forEach var="dto" items="${orderList }"  >


		
			
			<tr>

				
				<td>${dto.order_date }<br>[${dto.user_order_idx }]
<!--product_idx--><input type="hidden" name="product_idx" value="${dto.product_idx}">
				<input type="hidden" name="product_opt_idx" value="${dto.product_opt_idx}">
<!--nonuserOrder_detail_idx--><input type="hidden" name="userOrder_detail_idx" value="${dto.userOrder_detail_idx}">
				<!--nonuserOrder_detail_idx--><input type="hidden" name="user_name" value="${dto.user_name}">
				</td>
				 <!-- 이미지 border color 수정 -->
				<td><a style ="border-right: 1px solid white;" href="${cpath }/product/view/${dto.product_idx}"><img class="productImgA" src="${cpath}/itemImg/${dto.product_t_img}"></a></td>
				<!-- 수정 -->	
				<td style ="border-left: 1px solid white;">${dto.product_name }
				${dto.product_opt_idx }
			[옵션 : ${dto.product_color } /${dto.product_size} ]
				</td>
				
				<td>${dto.address1 }</td>
				<td>${dto.address2 }</td>
				<td>${dto.address3 }</td>
				<td>${dto.product_count }</td>	
				<td><fmt:formatNumber>${dto.product_price }</fmt:formatNumber></td>		

	<!-- 2/28 새봄 수정 !!!!!!!!!!!!!!!!! -->						
				<td>${dto.order_detail_status }</td>
						

		<c:if test="${dto.order_detail_status =='배송완료'}">
			<td><a href="${cpath }/product/review_write?product_idx=${dto.product_idx }&product_opt_idx=${dto.product_opt_idx}">리뷰작성하기</a></td>				
		</c:if>
	<!-- -------------------------------------------------- -->			
			
		<c:if test="${dto.order_detail_status =='배송완료'}">
			<td><a href="${cpath }/user/user_return/${dto.product_opt_idx}/${dto.product_idx}/${dto.userOrder_detail_idx}"><button>교환/환불</button></a></td>			
		</c:if>	
		
		<c:if test="${dto.order_detail_status !='배송완료'}"> 
					<h1></h1>
		</c:if>
		
<!--  테스트 때문에 잠깐 뺴둠. -->		
<%-- 		<td><a href="${cpath }/user/user_return/${dto.product_opt_idx}/${dto.product_idx}/${dto.userOrder_detail_idx}"><button>교환/환불</button></a></td>			 --%>
	

			</tr>
			
			</c:forEach>
		</tbody>
	</table>
</section>

</body>
</html>