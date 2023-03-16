<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>


<section>
<div class="box">
	<div class="title">
		상품목록
	</div>
	<div style="display: flex;justify-content: space-between;">
		<div class="onlyFlex">
			<form method="POST">
				<input type="text" name="product_name">
				<input type="submit" value="검색">
			</form>
			<a href="${cpath }/admin/productList" style="margin-left: 5px">${empty allList ? '' :'전체목록' }</a>
		</div>
		<div style="display:flex; align-items:flex-end; font-size: 10px; margin-right:30px; ">
			* 상품 클릭 시 수정페이지로 이동합니다.
		</div>
	</div>
</div>

<div class="box genderBox">
	<label>
		<input type="checkbox" name="gender" value="m_">남성
	</label>	
	<label>
		<input type="checkbox" name="gender" value="w_">여성
	</label>	
</div>
<div class="box categoryBox">
	<label>
		<input type="checkbox" name="category" value="suit">SUIT
	</label>	
	<label>
		<input type="checkbox" name="category" value="top">TOP
	</label>	
	<label>
		<input type="checkbox" name="category" value="pants">PANTS(남성하의)
	</label>	
	<label>
		<input type="checkbox" name="category" value="bottom">BOTTOM(여성하의)
	</label>	
	<label>
		<input type="checkbox" name="category" value="outer">OUTER
	</label>	
	<label>
		<input type="checkbox" name="category" value="shirts">SHIRTS
	</label>	
	<label>
		<input type="checkbox" name="category" value="knit">KNIT
	</label>	
	<label>
		<input type="checkbox" name="category" value="shoes">SHOES
	</label>	
</div>
<div class="box itemBox">
	<div class="productItems">
		<div class="item itemHeader">
			<div class="product_idx">상품번호<span class="arrow"></span></div>
			<div class="product_code">카테고리<span class="arrow"></span></div>
			<div class="product_name">상품이름<span class="arrow"></span></div>
			<div class="product_price">가격<span class="arrow"></span></div>
			<div class="product_t_img">썸네일<span class="arrow"></span></div>
		</div>
		<c:forEach var="dto" items="${list}">
			<div class="item" idx="${dto.product_idx }">
				<div class="product_idx">${dto.product_idx}</div>
				<div class="product_code">${dto.product_code }</div>
				<div class="product_name">${dto.product_name}</div>
				<div class="product_price"><fmt:formatNumber>${dto.product_price}</fmt:formatNumber></div>
				<div class="product_t_img" notMove="notMove">
					<button class="showTBtn">썸네일 보기</button><img class="hidden" src="${cpath}/itemImg/${dto.product_t_imgOne}" height="150px" width="100px">
					<div class="deleteProductDiv"><button class="deleteBtn" idx="${dto.product_idx }" title="${dto.product_name }">삭제</button></div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>


</section>

</main>
<script src="${cpath }/resources/js/functionCH.js"></script>
<script>
const boxGenderList = document.querySelectorAll('div.genderBox input[name="gender"]')
const boxCategoryList = document.querySelectorAll('div.categoryBox input[name="category"]')
const itemList = Array.from(document.querySelectorAll('.item:not(.itemHeader)'))

const boxList = document.querySelectorAll('input[type="checkbox"]')
boxList.forEach(box => box.onchange = filtering)

const headerList = document.querySelectorAll('.item.itemHeader > div')
const productItems = document.querySelector('div.productItems')
headerList.forEach(h => {   // asc 속성 추가 (값=1)
    h.setAttribute('asc',1)
})


headerList.forEach(e => e.onclick = orderHandler)
window.onload = adminProductLoadHandler



	
	
</script>
</body>
</html>