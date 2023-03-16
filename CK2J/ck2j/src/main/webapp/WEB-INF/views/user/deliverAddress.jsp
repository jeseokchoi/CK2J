<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/deliverAddress.css">

<main>
<section>


	<div id="deliverAddress">
		<div class="deliverAddress_title">
			<h1>DELIVER ADDRESS</h1>
			<h4>고객님의 배송지 주소를 등록하고 수정 하실 수 있습니다.</h4>
		</div>
		<div class="deliverAddress_table">
		<table>
			<thead>
				<tr>
					<th>우편번호</th>
					<th>주소</th>
					<th>상세주소</th>
	
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${address.user_address1}</td>
					<td>${address.user_address2}</td>
					<td>${address.user_address3}</td>
				</tr>
			</tbody>
		</table>
		</div>
		
		<c:if test="${empty address }"><div class="address_button"><a href="${cpath }/user/addressRegist/"><button >배송지등록</button></a></div></c:if>
		<c:if test="${not empty address }"><div class="address_button"><a href="${cpath }/user/addressModify/"><button>배송지수정</button></a></div></c:if>
		<div class="address_cause">
		<table>
			<thead>
				<tr>
					<th>배송주소록 유의사항</th>
				</tr>
			</thead>
			<tbody>
			
				<tr>
					<td>별도로 등록하지 않을 경우 최근 배송 주소록 기준으로 자동 업데이트 됩니다.</td>
				</tr>
				<tr>
					<td>자동 업데이트를 원하지 않을 경우 주소록 고정 선택을 선택하시면 선택된 주소록은 업데이트 대상에서 제외됩니다.</td>
				</tr>
				<tr>
					<td>기본 배송지는 1개만 저장됩니다. 다른 배송지를 기본 배송지로 설정하시면 기본 배송지가 변경됩니다.</td>
				</tr>
			</tbody>
		</table>
			
			
		</div>
		</div>
	</section>
</main>

</body>
</html>