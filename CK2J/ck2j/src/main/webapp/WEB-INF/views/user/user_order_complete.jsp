<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="${cpath }/resources/css/newSpring/user/user_order_complete.css" type="text/css"/>

<script src="${cpath }/resources/js/newSpring/user/user_order_complete.js"></script>

<main>
<section id="list">
	<div id="categoryName"><h1>주문 완료</h1></div>
		
		<div class="checkInfo">
		    <div class="checkImg1"><img class="checkImg" style="height:70px; width:70px;"  src="${cpath }/resources/img/check.png"></div>
			
			<div class="checkText0">
				<div class="checkText1">고객님의 주문이 완료 되었습니다.</div> <br>
				<div class="checkText2">주문내역 및 배송에 관한 안내는 주문조회 를 통하여 확인 가능합니다.</div>
			</div>
		</div>

<!-- 결제 정보 -->
<!-- 		<div class="userOrderInfo"><h2>결제정보</h2></div> -->
<!-- 			<div class="userPurchaseInfo"> -->
<!-- 					<div class="userPurchaseText1">최종결제금액</div> -->
<%-- 					<div class="userPurchaseText2" style="font-size : 15px; color : blue;"><fmt:formatNumber pattern="###,###,###" value="${sum }"/>원</div> --%>
<!-- 			</div> -->
<!-- 			<div class="userPurchaseInfo"> -->
<!-- 					<div class="userPurchaseText1">결제수단</div> -->
<!-- 					<div class="userPurchaseText2">------원</div> -->
<!-- 			</div> -->
					
		

<!-- 주문상품 정보  -->		
		<div class="userOrderInfo"><h2>주문상품 정보</h2></div>
			<table id="purchaseProductList">
			<thead>
				<tr>
<!-- 					<th><input type="checkbox" name="multi" value=""></th> -->
					<th>이미지</th>
					<th>상품정보</th>
					<th>판매가</th>
					<th>수량</th>
					<th>배송구분</th>
					<th>배송비</th>
					<th>합계</th>
				</tr>	
			</thead>
			
			<tbody>
			
		<c:set var="sum" value="0"/>
			
			<c:forEach var="dto" items="${list }">
				<tr>
					<td style="display: none;">
						<div class="items">
							<input type="hidden" name="itemIdx" value="${dto.itemIdx }">
							<input type="hidden" name="itemOpt" value="${dto.itemOpt }">
							<input type="hidden" name="itemName" value="${dto.itemName }"> 
							<input type="hidden" name="itemPrice" value="${dto.itemPrice }"> 
							<input type="hidden" name="itemEachPrice" value="${dto.itemEachPrice }"> 
							<input type="hidden" name="itemAmount" value="${dto.itemAmount }">
						</div>
					</td>
				
				
<%-- 					<td><input type="checkbox" each="each" name="${dto.itemIdx}_${dto.itemOpt }" value="${dto.itemIdx }_${dto.itemOpt }"></td> --%>
					<td><img border="1px solid black" width="100px" height="100px" src="${cpath}/itemImg/${dto.product_t_img}"></td>
					<td>
						<strong>${dto.itemName }</strong><br>
						[${dto.itemOpt }]
					</td>
					<td><fmt:formatNumber>${dto.itemEachPrice }</fmt:formatNumber></td>
					<td>${dto.itemAmount }</td>
					<td>기본배송</td>
					<td>무료</td>
					<td class="itemPrice">￦ <fmt:formatNumber> ${dto.itemPrice }</fmt:formatNumber></td>
				</tr>
						<c:set var="sum" value="${sum + dto.itemEachPrice }"/>
				</c:forEach>
				<tr>
			
	<td class="userOrder_totalSum" colspan="8" style=" height: 20px; font-size: 15px; font-weight: bold;text-align: right; padding-right: 20px; border-top: 1px solid #dadada">
		총 합계: <fmt:formatNumber pattern="###,###,###" value="${sum }"/>원
	</td>
					
				</tr>
			</tbody>
		</table>
		
		

<!-- 배송지 정보 -->
		
	<div class="userOrderInfo"><h2>배송지 정보</h2></div>
			<div class="userPurchaseInfo">
					<div class="userPurchaseText1">받으시는분</div>
					<div class="userPurchaseText2">${dto.receiver_name }</div>
			</div>
			
			<div class="userPurchaseInfo">
					<div class="userPurchaseText1">우편번호</div>
					<div class="userPurchaseText2">${dto.address1 }</div>
			</div>		
			
			<div class="userPurchaseInfo">
					<div class="userPurchaseText1">주소</div>
					<div class="userPurchaseText2">${dto.address2 } ${dto.address3 }</div>
			</div>	
			
			<div class="userPurchaseInfo">
					<div class="userPurchaseText1">휴대전화</div>
					<div class="userPurchaseText2">${dto.receiver_phone }</div>
			</div>	
			
			<div class="userPurchaseBtn">
				<div class="shoppingAgainBtn"><a href="${cpath }/">쇼핑계속하기</a></div>
				<c:if test="${empty user}">
					<div class="orderCheckBtn"><a href="${cpath }/nonuser/login">주문확인하기</a></div>
				</c:if>
				<c:if test="${not empty user}">
					<div class="orderCheckBtn"><a href="${cpath }/user/userOrder">주문확인하기</a></div>
				</c:if>
			</div>
	


<div class="Information_Use">
	<div class="Information_titel">이용안내</div>	
		<div class="Information_content">
		① 비회원 주문의 경우, 주문번호를 꼭 기억하세요. 주문번호로 주문조회가 가능합니다.
		② 배송은 결제완료 후 지역에 따라 3일 ~ 5일 가량이 소요됩니다.<br>
		③ 상품별 자세한 배송과정은 주문조회를 통하여 조회하실 수 있습니다.<br>
		④ 주문의 취소 및 환불, 교환에 관한 사항은 이용안내의 내용을 참고하십시오.<br>
		<br>
		세금 계산서 발행 안내
		<br>
		① 부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.<br>
		② 세금계산서는 사업자만 신청하실 수 있습니다.<br>
		③ 배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.<br>
		④ [세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.<br>
		⑤ [세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.<br>
		<br>
		부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내
		<br>
		① 변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며<br>
		② 신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)<br>
		③상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.<br>
		<br>
		현금영수증 이용안내
		<br>
		① 현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.<br>
		② 현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.<br>
		③ 발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.<br>
		④ 현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)<br>
		⑤ 현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.<br>
		
		</div>	
</div>

</main>


<script>
document.onkeydown = noEvent;
</script>


<!--  3/3 새로고침시 데이터가 날라가서 경고창 추가.  -->

</body>
</html>