<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/qnaView.css">
<script src="${cpath }/resources/js/cj/qnaView.js"></script>

<main>
	<section>
	   <div class="wrap">
	   	<div id="qna_title">
			<h2>Q&A</h2>
		</div>
		   <div id="root">
			   <div class="qnaView_title">
				   <div class="qna_title">제목</div>
				   <c:if test="${dto.qna_secret == 'Y'}">
				   <div class="qna_title2">${dto.qna_title }
				   <img src="${cpath }/resources/icon/icon_lock.png" width="15px">
				   ${dto.reply_check == 0 ? '' : '[답변완료]'}</div>
				   </c:if>
				   <c:if test="${dto.qna_secret != 'Y'}">
				   <div class="qna_title2">${dto.qna_title }
				   ${dto.reply_check == 0 ? '' : '[답변완료]'}</div>
				   </c:if>
			   </div>
			   <div class="qnaView_writer">
				   <div class="qna_writer">작성자</div>
				   <div class="qna_writer2">${dto.user_id }</div>
			   </div>
			   <div class="qnaView_date">
				   <div class="qna_date">작성일</div>
				   <div class="qna_date2">${dto.qna_writeDate }</div>
			   </div>
			   <div class="qnaView_content">
				   <div class="qna_content">${dto.qna_content }</div>
			   </div>
			   <div class="qnaView_reply">
				   <c:forEach var="dto" items="${list }">
					   <div class="admin_status">
						   <div class="admin">관리자</div>
						   <div class="date">${dto.writing_date }</div>
					   </div>
					   <div class="admin_contents">${dto.content}</div>
				   </c:forEach>
			   </div>
		   </div>
		   
		   <div class="sb">
			   <div>
				   <a href="${cpath }/board/qna"><button>목록</button></a>
			   </div>
			   <div class="qna_rightBtn">
			   	<c:if test="${dto.user_id == user.user_id }">
				   <div class="qnaView_delete">
					   <a href="${cpath }/board/qnaDelete/${dto.qna_idx }">
						   <button id="deleteBtn" title="${dto.qna_title }" idx="${dto.qna_idx }">삭제</button>
					   </a>
				   </div>
				   </c:if>
				   <div class="qnaView_modify">
					   <a href="${cpath }/board/qnaModify/${dto.qna_idx }"><button>수정</button></a>
				   </div>
			   </div>
		   </div>
	   </div>
   </section>
</main>

<script>
	document.getElementById('deleteBtn').onclick = deleteButton
</script>

</body>
</html>