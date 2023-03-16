<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>

<section>
	<div class="box">
		<form method="POST">
			<div class="onlyFlex" style="text-align: center;">
				<div style="width: 100px;">색상</div>
				<div style="width: 100px;">사이즈</div>
				<div style="width: 100px;">재고</div>
			</div>
			<c:forEach var="dto" items="${list }">
			<p>
				<input type="text" value="${dto.product_color }" readonly style="width: 90px;">
				<input type="text" value="${dto.product_size }" readonly style="width: 90px;">			
				<input type="number" name="${dto.product_color}/${dto.product_size}" value="${dto.product_stock }" style="width: 90px;">
			</p>
			</c:forEach>
			<p>
				<input type="submit" value="수정">
			</p> 
		</form>
	</div>
</section>
</main>

</body>
</html>