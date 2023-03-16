<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adHeader.jsp" %>

<link rel="stylesheet" href="${cpath }/resources/css/JH/userModify.css">

	<section>
	<div id="userModify">
		<div class="userModify_head">
		<h1>회원 수정</h1>
		</div>
		<div class="userModify_body">
		<form method="POST">
		<%-- 	<p><input type="text" name="user_id" value="${dto.user_id }"></p> --%>
			<div class="userModify_content"><div class="userModify_th"><strong>이름</strong></div><div class="userModify_td"><input type="text" name="user_name" value="${dto.user_name }"></div></div>
			<div class="userModify_content"><div class="userModify_th"><strong>연락처</strong></div><div class="userModify_td"><input type="text" name="user_phone" value="${dto.user_phone }"></div></div>
			
			<div class="userModify_content"><div class="userModify_th"><strong>회원권한</strong></div>
				<div class="userModify_td">
				<label><input type="radio" name="user_role" ${dto.user_role =='admin' ? 'checked' : '' } value="admin" required>관리자</label>
				<label><input type="radio" name="user_role" ${dto.user_role =='user' ? 'checked' : '' } value="user" required>회원</label>
				</div>
			</div>
			<div class="userModify_content"><div class="userModify_th"><strong>회원등급</strong></div>
			<div class="userModify_td">
				<label><input type="radio" name="user_grade" ${dto.user_grade =='bronze' ? 'checked' : '' } value="bronze" required>브론즈</label>
				<label><input type="radio" name="user_grade" ${dto.user_grade =='silver' ? 'checked' : '' } value="silver" required>실버</label>			
				<label><input type="radio" name="user_grade" ${dto.user_grade =='gold' ? 'checked' : '' } value="gold" required>골드</label>
			</div>
			</div>
			<div class="userModify_content"><div class="userModify_th"><strong>이메일</strong></div>
			<div class="userModify_td"><input type="text" name="user_email" value="${dto.user_email}"></div>
			</div>
			
			<div class="userModify_content"><div class="userModify_th"><strong>메일수신</strong></div>
				<div class="userModify_td">
				<label><input type="radio" name="email_check" ${dto.email_check =='Y' ? 'checked' : '' } value="Y" required>예</label>
				<label><input type="radio" name="email_check" ${dto.email_check =='N' ? 'checked' : '' } value="N" required>아니오</label>
				</div>
			</div>
			<div class="userModify_content"><div class="userModify_th"><strong>가입일</strong></div>
			<div class="userModify_td"><input type="date" name="user_insertDate" value="${dto.user_insertDate }"></div>
			</div>
			<div class="userModify_content"><div class="userModify_th"><strong>생일</strong></div>
			<div class="userModify_td"><input type="date" name="user_birth" value="${dto.user_birth}"></div>
			</div>
			
			<div class="userModify_content"><div class="userModify_th"><strong>성별</strong></div>
				<div class="userModify_td">
				<label><input type="radio" name="user_gender" ${dto.user_gender =='남성' ? 'checked' : '' } value="남성" required>남성</label>
				<label><input type="radio" name="user_gender" ${dto.user_gender =='여성' ? 'checked' : '' } value="여성" required>여성</label>
				</div>
			</div>
			<div class="userModify_submit"><input type="submit" value="수정하기"></div>
			</form>
			</div>
	</div>
	</section>
</main>
</body>
</html>