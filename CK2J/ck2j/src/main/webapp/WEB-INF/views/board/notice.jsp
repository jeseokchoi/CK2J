<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/noticeStyle.css">
<main>
<section>
	<div class="wrap">
		<div id="noti_title">
			<h2>공지사항</h2>
		</div>
		<table id="noticeList">
			<thead>
				<tr>
					<th>No</th>
					<th>SUBJECT</th>
					<th>NAME</th>
					<th>DATE</th>
				</tr>
			</thead>	
			<tbody>
				<c:forEach var="dto" items="${list }">
					<c:if test="${dto.show_check == 'Y'}">
					<tr>
						<td>${dto.notice_idx }</td>
							<td><a href="${cpath }/board/notiView/${dto.notice_idx}">${dto.notice_title }</a></td>
						<td>${dto.notice_writer }</td>
						<td><fmt:formatDate value="${dto.notice_writeDate }" /></td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	
		<div class="pageNumber">
			<c:if test="${paging.prev }">
				<a href="${cpath }/board/notice?page=${paging.begin - 1}">이전</a>
			</c:if>
			
			<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
				<a class="${paging.page == i ? 'bold' : '' }" 
				   href="${cpath }/board/notice?page=${i}">${i }</a>
			</c:forEach>
			
			<c:if test="${paging.next }">
				<a href="${cpath }/board/notice?page=${paging.end + 1}">다음</a>
			</c:if>
		</div>
		
		<div class="sb">
			<div>
				<form method="POST">
					<p>
						<input type="search" name="keyword">
						<input type="submit" value="검색">
					</p>
				</form>
			</div>
		</div>
	</div>
</section>
</main>
</body>
</html>