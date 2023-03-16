<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<link rel="stylesheet" href="${cpath }/resources/css/newSpring/nonuser_return.css" type="text/css"/>
<script src="${cpath }/resources/js/newSpring/nonuser_return.js"></script>

<section class="orderList">

	<div class="titleArea">
		<h2>교환 환불 신청 </h2>
	</div>

	
<table id="purchaseProductList">
<!-- class="orderDetailB"> --> 
		<thead>
<!-- 		 class="orderDetailC"> -->
			<tr>
				<th>주문일자<br>
				[주문번호]</th>
				<th>이미지</th>
				<th>상품번호</th> <!-- detail -->
				<th>금액</th>
				<th>컬러</th>
				<th>사이즈</th>
			</tr>
					
		</thead>


		
		<tbody>
			<tr>
				<td>${list.order_date } <br>
				<br>
					[${list.nonuser_order_idx }]

				</td>
		<td><a href="${cpath }/product/view/${list.product_idx}">
				<img style=" width: 100px; height: 100px;  border: 2px solid #848484;" src="${cpath }/itemImg/${list.product_t_img }"></a></td>
			
			<td>${list.product_opt_idx }
				${list.product_name }
			</td>
			
			<td>${list.product_price }</td>
			<td>${list.product_color }</td>
			<td>${list.product_size }</td>
	
		</tr>
	</tbody>
</table>		
		

<div class="userBtn_R_E">
		<div><button class="search_button1" type="submit">상품교환 신청</button></div>
		<div><button class="search_button3" type="submit">상품환불 신청</button></div>
	</div>
</section>

<div class="searchDetail">

<div id="search_Modal1" class="displaynoneSearch">

<div class="orderDetailAa">

		<div class="titleArea">
			<h2>상품 교환</h2>
		</div>


	
	<form class="searchForm" method="POST" action="${cpath }/nonuser/exchange/${list.product_opt_idx}/${list.product_idx}/${list.nonuserOrder_detail_idx}">
	
		<p>
		<p class="product_size">사이즈 교환</p>
		<input type="hidden" name="product_idx" value="${list.product_idx}">
		<input type="hidden" name="nonuserOrder_detail_idx" value="${list.nonuserOrder_detail_idx}">
<%-- 		<input type="hidden" name="nonuserOrder_detail_idx" value="${list.product_opt_idx}"> --%>
		
		<select name="product_size">
			<option value="">== 카테고리를 선택하세요 ==</option>
			<option value="M">M</option>
			<option value="L">L</option>
			<option value="XL">XL</option>
		</select>
		</p>
		
		<p>
		<p class="product_color">컬러 교환</p>
		<select name="product_color">
			<option value="">== 카테고리를 선택하세요 ==</option>
			<option value="아이보리">아이보리</option>
			<option value="블랙">블랙</option>
			<option value="소라">소라</option>
		</select>
		</p>
		
<!-- 		<span class="return_reason"></span> -->
<!-- 2/26 새봄 교환사유 추가!!!!!!!!!!!!!!!!!!!!!!!! -->	
	<p>	
		<p>교환 사유 선택</p>
		<select name="return_reason" style="width : 200px; text-align: center;">
			
			<option value="">== 카테고리를 선택하세요 ==</option>
			<option value="단순변심">단순 변심</option>
			<option value="상품파손">상품 파손</option>
			<option value="그외사유">그외 사유</option>
			<option value="다른상품배송">다른 상품 배송됨</option>
			<option value="상품과설명이다름">상품이 설명과 다름</option>
			
		</select>
	</p>
		
	<div><button class="search_button2" type="submit">교환 신청</button></div>	
<!-- 		<p><input type="submit" value="교환신청"> -->
	</form>
	
	</div>

	</div><!-- searchModal div  -->
	
</div> 
<!-- ------------------------------------------------------------------------- -->



<div class="searchDetail">

<div id="search_Modal2" class="displaynoneSearch">

<div class="orderDetailAb">

	<div class="titleArea">
			<h2>상품 환불</h2>
	</div>
	
	<form method="POST" action="${cpath }/nonuser/refund/${list.product_opt_idx}/${list.product_idx}/${list.nonuserOrder_detail_idx}">
		
		<input type="hidden" name="product_idx" value="${list.product_idx}">
		<input type="hidden" name="nonuserOrder_detail_idx" value="${list.nonuserOrder_detail_idx}">
		<p>
<!-- 		<span class="return_reason"></span> -->
		<p>환불 사유 선택</p>
		<select name="return_reason" required="required" style="width : 200px; text-align: center;">
			<option value="">== 카테고리를 선택하세요 ==</option>
			<option value="단순변심">단순 변심</option>
			<option value="상품파손">상품 파손</option>
			<option value="그외사유">그외 사유</option>
			<option value="다른상품배송">다른 상품 배송됨</option>
			<option value="상품과설명이다름">상품이 설명과 다름</option>
			
		</select>
		</p>
		
		<p>환불 계좌 성명</p>
		<p><input type="text" style="width : 195px; text-align: center;" name="bankAccountName" placeholder="환불 계좌 성명" required="required"></p>
		
		
		<p>
		<p>환불받을 은행 선택</p>
		<select name="bankName" required="required" style="width : 200px; text-align: center;">
			<option value="">== 카테고리를 선택하세요 ==</option>
			<option value="국민은행">국민은행</option>
			<option value="우리은행">우리은행</option>
			<option value="부산은행">부산은행</option>
			<option value="경남은행">경남은행</option>
			<option value="카카오뱅킹">카카오뱅킹</option>
			
		</select>
		</p>
		
		<p>환불받을 계좌 입력</p>
		<p><input type="number" style="width : 195px; text-align: center;" name="bankAccountNumber" placeholder="환불받을 계좌 '-'없이 입력" required="required"></p>
		
		<div><button class="search_button2 " type="submit">환불 신청</button></div>	
	
	</form>
	
</div>	


</div><!-- searchModal div  -->
</div>


<script>

const search_button1 = document.querySelector('button.search_button1') 
search_button1.onclick = clickSearch_Modal1

	
</script>

<script>

const search_button3 = document.querySelector('button.search_button3') 
search_button3.onclick = clickSearch_Modal2

</script>


<script>
	

</script>



</body>
</html>