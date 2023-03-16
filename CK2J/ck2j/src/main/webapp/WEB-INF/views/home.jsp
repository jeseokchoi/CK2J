<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<div id="body1" class="body completed">
</div>
<div id="body2" class="body outOfBound down">
	<div id="body2Main">
		<div id="body2MainTitle">BEST</div>
		<div id="body2MainWrap">
			<c:forEach var="dto" items="${homeList }">
				<div class="homeItem">
					<a href="${cpath }/product/view/${dto.product_idx}"><img src="${cpath}/itemImg/${dto.product_t_img}"></a>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<div id="body3" class="body outOfBound down">
	<div id="body3Main">
		<div id="body3MainTitle">회원가입 혜택</div>
		<div id="body3MainWrap">
			<p>회원 가입시 +10,000</p>
		<div class="toPurchase" style="width: 200px;margin: auto"><a href="${cpath }/user/join">READ MORE</a></div> 
		</div>
	</div>
</div>


<script src="${cpath }/resources/js/ch/headerFunction.js"></script>
<script>
const divBody = document.querySelectorAll('div.body')
const body = document.querySelector('body')
divBody.forEach(e =>e.onmousewheel = bodyChange)
	
    
</script>
</body>
</html>