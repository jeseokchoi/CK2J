<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="${cpath }/resources/css/newSpring/orderList.css" type="text/css"/>



<section class="orderList">

	<div class="titleArea">
		<h2>NONUSER ORDER LIST</h2>
	</div>

 	<table id="purchaseProductList">
		<thead>
			<tr>
<!-- 변경 -->			
				<th>
				<br>
				주문일자<br>
				[주문번호]
				<br>
				<br>
<!-- 2/28새봄 수정   테스트 ok-->	
	
   <c:choose>
		<c:when test="${list[0].order_detail_status == '주문확인중' }">
			<a href="${cpath }/nonuser/orderListDelete/${list[0].nonuser_order_idx}"><button>취소</button></a>
		</c:when>
		
		<c:otherwise>
			<h1></h1>
		</c:otherwise>
	
	</c:choose>
	
				</th>
			<!-- 주문상품은 발송 전 이라도 주문번호를 기준으로 전체 취소만 가능 .테이블에 저정된 주문 데이터를 아예 삭제함. 
			주문서는 결제 전이므로 각 상품별 선택 취소 가능, 장바구니에 담긴 데이터를 아예 삭제함.    -->
				<th>이미지</th>
				<th>상품정보</th> <!-- detail -->
				<th>우편번호</th>
				<th>주소</th>
				<th>상세주소</th>
				<th>주문개수</th>
				<th>주문금액</th>
				<th>주문현황</th>  <!-- detail -->
<!-- 2/28 새봄 수정 !!!!!!!!!!!!!!!!! -->	

				<th style ="border-bottom: 1px solid #dadada;">상품 교환/반품</th>				
			
			</tr>
					
		</thead>
		<tbody>

<!-- 변경 !!!!!!  -->	
	<c:if test="${empty list }">

					<td class="errorBlack"><h2>주문내역이 없습니다.<br>
					(주문취소 성공)</h2></td>
	</c:if>
	
	<c:forEach var="dto" items="${list}">
	 	
	
		<tr>
			<td>${dto.order_date }<br>
				[${dto.nonuser_order_idx }]
<!--product_idx--><input type="hidden" name="product_idx" value="${dto.product_idx}">
				  <input type="hidden" name="product_opt_idx" value="${dto.product_opt_idx}">
<!--nonuserOrder_detail_idx--><input type="hidden" name="nonuserOrder_detail_idx" value="${dto.nonuserOrder_detail_idx}">
				</td>
<!-- 2/26 비회원 리스트 이미지 스타일 & 디테일 경로 수정 -->		
			<td><a href="${cpath }/product/view/${dto.product_idx}"><img class="productImgA" src="${cpath }/itemImg/${dto.product_t_img }"></a></td>
			<!-- 수정 -->
			<td>${dto.product_name }
			${dto.product_opt_idx }
			[옵션 : ${dto.product_color } /${dto.product_size} ]
			</td>
			
			<td>${dto.address1 }</td>
			<td>${dto.address2 }</td>
			<td>${dto.address3 }</td>
			<td>${dto.product_count }</td>
			<td><fmt:formatNumber>${dto.product_price }</fmt:formatNumber></td>
			
			<!-- 주문 띄우기  nonuser_order_status-->
			
			<td>${dto.order_detail_status }</td>
			
			
			
		
			
			<td>
			<c:if test="${dto.order_detail_status =='배송완료'}">
				<a href="${cpath }/nonuser/nonuser_return/${dto.product_opt_idx}/${dto.product_idx}/${dto.nonuserOrder_detail_idx}"><button>교환/환불</button></a>
			</c:if>	
			</td>
			<c:if test="${dto.order_detail_status !='배송완료'}"> 
						<h1></h1>
			</c:if>
		
<%-- 	<td><a href="${cpath }/nonuser/nonuser_return/${dto.product_opt_idx}/${dto.product_idx}/${dto.nonuserOrder_detail_idx}"><button>교환/환불</button></a></td> --%>
		
			</tr>

			</c:forEach>	
	</tbody>	
</table>
</section>


</body>
</html>