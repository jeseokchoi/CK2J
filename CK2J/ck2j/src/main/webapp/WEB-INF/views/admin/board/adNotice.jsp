<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/adnoticeStyle.css">

<main>
    <section>
        <div class="wrap">
            <div id="adNoti_title">
                <h2>공지사항</h2>
            </div>
            <table id="adNoticeList">
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
                    <tr>
                        <td>${dto.notice_idx }</td>
                        <c:if test="${dto.show_check == 'Y'}">
                            <td style="display: flex;"><a href="${cpath }/admin/board/adNoticeView/${dto.notice_idx}">${dto.notice_title }</a></td>
                        </c:if>
                        <c:if test="${dto.show_check == 'N'}">
                            <td style="display: flex;"><a href="${cpath }/admin/board/adNoticeView/${dto.notice_idx}">${dto.notice_title }</a>
                            [비공개]</td>
                        </c:if>
                        <td>${dto.notice_writer }</td>
                        <td><fmt:formatDate value="${dto.notice_writeDate }" /></td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
    
        <div class="pageNumber">
            <c:if test="${paging.prev }">
                <a href="${cpath }/admin/board/notice?page=${paging.begin - 1}">이전</a>
            </c:if>
            
            <c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
                <a class="${paging.page == i ? 'bold' : '' }" 
                   href="${cpath }/admin/board/notice?page=${i}">${i }</a>
            </c:forEach>
            
            <c:if test="${paging.next }">
                <a href="${cpath }/admin/board/notice?page=${paging.end + 1}">다음</a>
            </c:if>
        </div>
        
            <div class="sb">
                <div>
                    <form method="POST">
                        <p>
                            <input type="search" name="keyword">
                            <input type="submit" value="찾기">
                        </p>
                    </form>
                </div>
                <div class="adnoti_write">
                    <a href="${cpath }/admin/board/adNoticeWrite"><button>작성</button></a>
                </div>
            </div>
        </div>
    </section>
</main>
</body>
</html>