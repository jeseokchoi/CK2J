<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/qnaReply.css">

<main>
    <section>
        <div class="wrap">
            <div id="qna_title">
                <h2>Q&A</h2>
            </div>
                <table id="qnaList">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>SUBJECT</th>
                            <th>ID</th>
                            <th>DATE</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${list }">
                        <tr>
                            <td>${dto.qna_idx}</td>
                            <c:if test="${dto.qna_secret == 'Y'}">
                                <td><a href="${cpath }/admin/board/qnaReplyView/${dto.qna_idx}">${dto.qna_title }</a>
                                    <img src="${cpath }/resources/icon/icon_lock.png" width="15px">
                                    ${dto.reply_check == 0 ? '' : '[답변완료]'}</td>
                            </c:if>
                            <c:if test="${dto.qna_secret != 'Y'}">
                                <td><a href="${cpath }/admin/board/qnaReplyView/${dto.qna_idx}">${dto.qna_title }</a>
                                ${dto.reply_check == 0 ? '' : '[답변완료]'}</td>
                            </c:if>
                            <td>${dto.user_id }</td>
                            <td><fmt:formatDate value="${dto.qna_writeDate }" /></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
			
			<div class="pageNumber">
				<c:if test="${paging.prev }">
					<a href="${cpath }/admin/board/qnaReply?page=${paging.begin - 1}">이전</a>
				</c:if>
				
				<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
					<a class="${paging.page == i ? 'bold' : '' }" 
					   href="${cpath }/admin/board/qnaReply?page=${i}">${i }</a>
				</c:forEach>
				
				<c:if test="${paging.next }">
					<a href="${cpath }/admin/board/qnaReply?page=${paging.end + 1}">다음</a>
				</c:if>
		    </div>
        </div>    
    </section>
</main>        
</body>
</html>