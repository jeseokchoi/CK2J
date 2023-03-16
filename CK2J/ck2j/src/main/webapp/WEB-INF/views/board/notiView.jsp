<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/noticeView.css">

<main>
	<section>
		<div class="wrap">
		<div id="noti_title">
			<h2>공지사항</h2>
		</div>
			<div id="root">
				<div class="notiView_title">
						<div class="noti_title">제목</div>
						<div class="noti_title2">${dto.notice_title }</div>
				</div>
				<div class="notiView_writer">
						<div class="noti_writer">작성자</div>
						<div class="noti_writer2">${dto.notice_writer }</div>
				</div>
				<div class="notiView_date">
						<div class="noti_date">작성일</div>
						<div class="noti_date2">${dto.notice_writeDate }</div>
				</div>
				<div class="notiView_content">
						<div class="noti_content">${dto.notice_content }</div>
				</div>
				<div class="sb">
					<a href="${cpath }/board/notice"><button>목록</button></a>
				</div>
			</div>
		</div>
	</section>
</main>

</body>
</html>