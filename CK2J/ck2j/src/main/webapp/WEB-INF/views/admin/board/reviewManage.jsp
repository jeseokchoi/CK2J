<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/review_manage.css">


<main>
<section>
<div class="box">
<div id="review_manage">
	<div class="review_manage_head">
		<h1>REVIEW MANAGE</h1>
		<h4>고객님들의 리뷰를 관리 할 수 있습니다. 답글을 받은 고객일 수록 재구매가 높아집니다. 답변을 달아보세요</h4>
	</div>
	<div class="review_manage_body">
	<table class="review_list_table">
		<thead>
			<tr>
				<th>리뷰 번호</th>
				<th>제품 옵션 번호</th>
				<th>유저 아이디</th>
				<th>별점</th>
				<th>내용</th>
				<th>작성일</th>
				<th>삭제여부</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.product_review_idx }</td>
				<td>${dto.product_opt_idx }</td>
				<td>${dto.user_id }</td>
				<td>${dto.rate }</td>
				<td class="content"><a href="${cpath }/admin/board/reviewLook/${dto.product_review_idx}">${fn:substring(dto.content,0,5) }...${dto.review_reply_idx =='' ? '':'[답변완료]' }</a></td>
				<td>${dto.writing_date }</td>
				<td>${dto.delete_check =='n' ?'등록':'삭제됨' }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	<div class="pageNumber">
		<c:if test="${paging.prev }">
			<a href="${cpath }/admin/board/reviewManage?page=${paging.begin - 1}${searchParam}">이전</a>
		</c:if>
		
		<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
			<a class="${paging.page == i ? 'bold' : '' }" 
			   href="${cpath }/admin/board/reviewManage?page=${i}${searchParam}">${i }</a>
		</c:forEach>
		
		<c:if test="${paging.next }">
			<a href="${cpath }/admin/board/reviewManage?page=${paging.end + 1}${searchParam}">다음</a>
		</c:if>
	</div>
</div>
</div>
</section>
</main>


</body>
</html>