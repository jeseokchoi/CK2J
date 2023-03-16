<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>

<section>
<div class="box">
	<div class="title">
		회원 교환/환불내역
	</div>
</div>
<div class="box">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>구분</th>
				<th>사유</th>
				<th>환불계좌명</th>
				<th>환불은행</th>
				<th>예금주</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${userReturnList }">
			<tr>
				<td>${dto.userOrder_refund_idx }</td>
				<td>${dto.returnType }</td>
				<td>${dto.return_reason }</td>
				<td>${dto.bankAccountName }</td>
				<td>${dto.bankName }</td>
				<td>${dto.bankAccountNumber }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="box">
	<div class="title">
		비회원 교환/환불내역
	</div>
</div>
<div class="box">
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>구분</th>
				<th>사유</th>
				<th>환불계좌명</th>
				<th>환불은행</th>
				<th>예금주</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${nonuserReturnList }">
			<tr>
				<td>${dto.nonuserOrder_refund_idx }</td>
				<td>${dto.returnType }</td>
				<td>${dto.return_reason }</td>
				<td>${dto.bankAccountName }</td>
				<td>${dto.bankName }</td>
				<td>${dto.bankAccountNumber }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</section>
</main>
</body>
</html>