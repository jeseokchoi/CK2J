<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="${cpath }/resources/css/newSpring/searchList.css" type="text/css"/>
<script src="${cpath }/resources/js/newSpring/searchList.js"></script>
<link rel="stylesheet" href="${cpath }/resources/css/newSpring/footer.css" type="text/css"/>



<section class="searchDetailT">
	<div class="searchText1"><h1 class="searchText2">SEARCH</h1></div>


	
	
	<div class="searchDetail">
	
	
	<div><button class="search_button1" type="submit">상세검색 열기</button></div>
	
	
	<div id="search_Modal" class="displaynoneSearch">
	
	
	<form class="searchForm" method="GET" name="search">
	
	<p>
	
		상품분류     <select class="searchSelect" name="product_code">
		<option value="">상품분류 선택</option>
		<option value="w_"># WOMAN</option>
		<option value="m_"># MAN</option>
		
		</select>
	
	</p>
	
	        검색조건     <input class="searchKeyword" type="search" name="keyword" id="detailKeyword"
				   value="${param.keyword }"
				   placeholder="검색어를 입력하세요" autofocus>
	
	
	<div><button class="search_button2" type="submit">SEARCH</button></div>
	
	</form>
	
	</div><!-- searchModal div  -->
	
	</div> 

</section>

<main>
<section id="list">
	<c:if test="${empty list }">
		<div class="list_Filter">
			<div id="column">
				<div class="item_Filter">
					<div class="" style="margin: 10px"><a href="${cpath }/search/searchList?keyword=${param.keyword }&sort_method=0">신상품</a></div>
					<div class="lowPrice" style="margin: 10px"><a href="${cpath }/search/searchList?keyword=${param.keyword }&sort_method=1">낮은가격</a></div>
					<div class="highPrice" style="margin: 10px"><a href="${cpath }/search/searchList?keyword=${param.keyword }&sort_method=2">높은가격</a></div>
	<!-- 				<div class="" style="margin: 10px">인기상품</div> -->
				</div>
			</div>
		</div>
	</c:if>


	<div id="wrap">
	
	<c:if test="${empty list }">
		<tr>
			<th>
				<div class="errorText">
					<h2 class="errorBlue">검색결과가 없습니다.<br>
					<br>
					정확한 검색어 인지 확인하시고 다시 검색해 주세요.</h2>
	
					<h3 class="errorGray">검색어/제외검색어의 입력이 정확한지 확인해 보세요.<br>
						두 단어  이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.<br>
					검색 옵션을 다시 확인해 보세요.</h3>
				</div>
			</th>
		</tr>
	</c:if>
	
	<c:forEach var="dto" items="${list }">
		
		<div class="item">
		
			<div class="img">
				<a href="${cpath }/product/view/${dto.product_idx}">
					<img class="listImg" src="${cpath}/itemImg/${dto.product_t_imgOne}"></a>
			</div>
			<div class="listName">${dto.product_name }</div>
			<div class="listPrice">KRW <fmt:formatNumber>${dto.product_price }</fmt:formatNumber></div>
		</div>
	</c:forEach>
	</div>
	
	
	<%--http://localhost:8080/spn_project_chReal/search/searchList?keyword=셔츠 --%>
	
	<div class="pageNumberProductList">
		<c:if test="${paging.prev }">
			<a href="${cpath }/search/searchList?keyword=${param.keyword }&page=${paging.begin - 1}&sort_method=${param.sort_method}">[이전]</a>
		</c:if>
		
		<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
			<a class="${paging.page == i ? 'bold' : '' }" 
			   href="${cpath }/search/searchList?keyword=${param.keyword }&page=${i}&sort_method=${param.sort_method}">[${i }]</a>
		</c:forEach>
		
		<c:if test="${paging.next }">
			<a href="${cpath }/search/searchList?keyword=${param.keyword }&page=${paging.end + 1}&sort_method=${param.sort_method}">[다음]</a>
		</c:if>
	</div>
	
	<%@ include file="../footer.jsp" %>
</section>
</main>



<script>
const searchForm = document.querySelector('form[name="search"]')
console.log(searchForm)
searchForm.onsubmit = searching
	
</script>

<!-- 상세검색 버튼 눌리면 오픈액션 모달 -->

<script>

const search_button1 = document.querySelector('button.search_button1') 

search_button1.onclick = clickSearch_Modal

	
</script>

