<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="${cpath }/resources/css/newSpring/footer.css" type="text/css"/>

<main>
<section id="list">
	<div id="categoryName"><h3>${category }</h3></div>

	<div class="list_Filter">
		<div id="column">
			<div class="item_Filter">
				<div class="" style="margin: 10px"><a href="${cpath }/product/productList/${cat}?sort_method=0">신상품</a></div>
				<div class="lowPrice" style="margin: 10px"><a href="${cpath }/product/productList/${cat}?sort_method=1">낮은가격</a></div>
				<div class="highPrice" style="margin: 10px"><a href="${cpath }/product/productList/${cat}?sort_method=2">높은가격</a></div>
			</div>
		</div>
	</div>

	<div id="wrap">
	<c:forEach var="dto" items="${list }">
		<div class="item">
			<div class="img">
				<a href="${cpath }/product/view/${dto.product_idx}"><img class="listImg" src="${cpath}/itemImg/${dto.product_t_img[0]}"></a>
			</div>
			<div class="listName">${dto.product_name }</div>
			<div class="listPrice">KRW <fmt:formatNumber>${dto.product_price }</fmt:formatNumber></div>
		</div>
	</c:forEach>
	</div>
	<div class="pageNumberProductList">
		<c:if test="${paging.prev }">
			<a href="${cpath }/product/productList/${cat }?page=${paging.begin - 1}&sort_method=${sort_method}">[이전]</a>
		</c:if>
		
		<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
			<a class="${paging.page == i ? 'bold' : '' }" 
			   href="${cpath }/product/productList/${cat }?page=${i}&sort_method=${sort_method}">[${i }]</a>
		</c:forEach>
		
		<c:if test="${paging.next }">
			<a href="${cpath }/product/productList/${cat }?page=${paging.end + 1}&sort_method=${sort_method}">[다음]</a>
		</c:if>
	</div>
	<%@ include file="../footer.jsp" %>
</section>
</main>
<script>
	const categoryForSide = '${cat}'
	console.log(categoryForSide)
	const wOl = document.querySelector('ol.w')
	const mOl = document.querySelector('ol.m')
	if(categoryForSide.includes('w_')){
		wOl.classList.add('wSelecting')
		mOl.classList.remove('mSelecting')
	}else{
		mOl.classList.add('mSelecting')
		wOl.classList.remove('wSelecting')
	}
</script>
</body>
</html>