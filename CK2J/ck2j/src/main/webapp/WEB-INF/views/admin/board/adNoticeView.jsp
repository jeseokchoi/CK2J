<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/adnoticeView.css">

<script>
	const notice_title = '${dto.notice_title}'
	const notice_idx = '${dto.notice_idx}'
</script>
<script src="${cpath }/resources/js/cj/adNoticeView.js"></script>

<main>    
    <section>
        <div class="wrap">
            <div id="noti_title">
                <h2>공지사항</h2>
            </div>
            <div id="root">
				<div class="notiView_title">
						<div class="noti_title">제목</div>
						<c:if test="${dto.show_check == 'Y'}">
							<div class="noti_title2">${dto.notice_title }</div>
						</c:if>
						<c:if test="${dto.show_check == 'N'}">
							<div class="noti_title2">${dto.notice_title }
							[비공개]</div>
						</c:if>
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
                <div class="adnoti_return">
                    <a href="${cpath }/admin/board/adNotice"><button>목록</button></a>
                </div>
                <div class="adnoti_submit">
                    <div class="adnoti_modiBtn">
                        <a href="${cpath }/admin/board/adNotiModify/${dto.notice_idx }"><button>수정</button></a>
                    </div>
                    <div class="adnoti_delBtn">
                        <a href="${cpath }/admin/board/adNotiDelete/${dto.notice_idx }">
                            <button id="deleteBtn" title="${dto.notice_title }" idx="${dto.notice_idx }">삭제</button>
                        </a>
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