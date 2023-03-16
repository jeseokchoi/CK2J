<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/adnoticeModify.css">
<!-- Write 텍스트 폼 -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script src="${cpath }/resources/js/cj/adNoticeModi.js"></script>
<script src="summernote-custom.js"></script>

<main>
    <section>
        <div class="wrap">
            <div id="noti_title">
                <h2>공지사항</h2>
            </div>
            <form method="POST">
                <div class="adwrite_form">
                    <div class="adwrite_title">제목</div>
                        <div class="ad_title">
                            <input type="text" name="notice_title" value="${dto.notice_title }" required>
                        </div>
                </div>    
                <div class="adwrite_form2">
                    <div class="adwrite_text">작성자</div>
                        <div class="adwrite_ID">
                            <input type="text" name="notice_writer" value="관리자" required>
                        </div>
                </div>
                <div class="adwrite_content">
                	<textarea id="summernote" name="notice_content" required>${dto.notice_content }</textarea>
                </div>
                <div class="adwrite_form3">
                    <div class="adnotice_secret">노출</div>
                        <div class="adnotice_radio">
                            <label><input type="radio" name="show_check" value="Y" ${dto.show_check == 'Y' ? 'checked' : '' } required>Y</label>
                            <label><input type="radio" name="show_check" value="N" ${dto.show_check == 'N' ? 'checked' : '' } required>N</label>
                        </div>
                </div>
                <div class="adnotice_submit">
                    <p>
                        <a href="${cpath }/admin/board/adNoticeView/${dto.notice_idx}"><button>돌아가기</button></a>
                        <input type="submit" value="수정">
                    </p>
                </div>
            </form>
        </div>
    </section>
</main>

<script>
	$(document).ready(function() {
		  $('#summernote').summernote();
		});
	
	document.querySelector('div.adnotice_submit button').onclick = qnaReturnBtn
</script>
</body>
</html>