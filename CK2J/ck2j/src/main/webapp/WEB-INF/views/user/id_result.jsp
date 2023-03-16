<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/id_result.css">
<!-- 0220 -->

<main>
	<section>


<div id="id_result_root">
	<c:if test="${msg != null }">
		<script>
			alert('${msg}')
			location.href="${cpath}/user/login"
		</script>
	</c:if>
	
	<c:if test="${msg == null }">
		<div class="id_result_head">
			
			<h1>FIND ID</h1>
		</div>
		<div class="id_result_info">
			<h3>고객님 아이디 찾기가 완료 되었습니다.</h3>
		</div>
		<div class="id_result_body">
			<div class="id_result_message">
			<p>저희 쇼핑몰을 이용해주셔서 감사합니다<br>
				다음정보로 가입된 아이디가 총 <strong>1</strong>개 있습니다.
			</p>
			</div>
			<div class="id_result_table">
				<div class="id_result_pic"><img src="${cpath }/resources/img/user.png"></div>
				<div class="id_result_user">
					<p>
					<strong>이름 :</strong>
					<strong>${ob.user_name }</strong>
					</p>
					<p>
					<strong>이메일 :</strong>
					<strong>${ob.user_email }</strong>
					</p>
					<p>
					<strong>아이디 :</strong>
					<strong>${ob.user_id }</strong>
					</p>
					<p> 고객님 즐거운 쇼핑 하세요!</p>
				</div>
				</div>
			</div>
			<div class="id_result_foot">
				<p>고객님의 아이디 찾기가 성공적으로 이루어졌습니다. 항상 고객님의<br>
				즐겁고 편리한 쇼핑을 위해 최선의 노력을 다하는 쇼핑몰이 되도록 하겠습니다. 
				</p>
			</div>
			<div class="id_result_button">
				<a href="${cpath }/user/login">로그인</a>
				<a href="${cpath }/user/find_Pwd">비밀번호 찾기</a>
			</div>
		
		
	</c:if>
</div>

	</section>
</main>

</body>
</html>