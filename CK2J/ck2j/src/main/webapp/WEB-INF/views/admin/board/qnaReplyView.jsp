<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/qnaReplyView.css">
<script>
	const qna_idx = '${dto.qna_idx}'
	const user_user_id = '${user.user_id}'
</script>
<script src="${cpath }/resources/js/cj/qnaReplyView.js"></script>
<main>
    <section>
    <div class="box">
        <div class="wrap">
            <div id="qna_title">
                <h2>Q&A</h2>
            </div>
            <div id="root">
                <div class="qnaView_title">
                    <div class="qna_title">제목</div>
                     <c:if test="${dto.qna_secret == 'Y'}">
                    	<div class="qna_title2">${dto.qna_title }
                    	<img src="${cpath }/resources/icon/icon_lock.png" width="20px"></div>
                    </c:if>
                     <c:if test="${dto.qna_secret == 'N'}">
                    	<div class="qna_title2">${dto.qna_title }</div>
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
            </div>

            <div class="adQna_reply">
                <div class="adQna_replyWrite">
                    <form id="replyWriteForm">
                        <div class="adreply_write">
                            <textarea name="content" placeholder="QnA 답변작성"></textarea>
                        </div>
                        <div class="adreply_submit">
                            <button>답변작성</button>
                        </div>
                    </form>
                </div>    
				<div id="reply">
                </div>
            </div>

            <div id="replyModify" class="hidden">
                <div class="adreply_modi">
                    <textarea class="modifyText" name="modifyText"></textarea>
                </div>
                <div class="admodi_submit">
                    <button class="reply_modify">수정</button>
                    <button class="rollback">취소</button>
                </div>
            </div>
        
        
            
            <div class="sb">
                <div>
                    <a href="${cpath }/admin/board/qnaReply"><button>목록</button></a>
                </div>
            </div>
		</div>
	</div>
    </section>
</main>

<script>
	document.body.onload = replyLoadHandler
	document.getElementById('replyWriteForm').onsubmit = replyWriteHandler
	
	document.querySelector('button.reply_modify').onclick = replyModifyFormHandler
	document.querySelector('button.rollback').onclick = replyModifyFormRollback
</script>

</body>
</html>