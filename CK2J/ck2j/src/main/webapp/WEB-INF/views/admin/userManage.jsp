<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="adHeader.jsp"%>

<link rel="stylesheet" href="${cpath }/resources/css/JH/userManage.css">

<section>
	<div class="box">
		<div id="userManage">
			<div class="userManage_head">
				<h1>고객 관리</h1>
			</div>
			<div class="userManage_body">
				<div class="search">
					<form style="text-align: right; margin-bottom: 5px;">
						<select name="type">
							<option ${param.type == 'user_name' ? 'selected' : '' }
								value="user_name">이름으로 검색</option>
							<option ${param.type == 'user_id' ? 'selected' : '' }
								value="user_id">아이디 검색</option>
							<option ${param.type == 'user_email' ? 'selected' : '' }
								value="user_email">이메일 검색</option>
							<option ${param.type == 'user_role' ? 'selected' : '' }
								value="user_role">관리자, 일반회원(admin,user)검색</option>
							<option ${param.type == 'user_grade' ? 'selected' : '' }
								value="user_grade">회원 등급으로 검색(bronze,silver,gold)</option>
							<option ${param.type == 'user_gender' ? 'selected' : '' }
								value="user_gender">성별로 검색</option>
						</select> <input type="search" name="keyword" value="${param.keyword }"
							placeholder="검색어를 입력하세요" autofocus> <input type="submit"
							value="검색">
					</form>
				</div>
				<table>
					<thead>
						<tr>
							<th>회원번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>연락처</th>
							<th>이메일</th>
							<th>메일수신</th>
							<th>성별</th>
							<th>회원권한</th>
							<th>회원등급</th>
							<th>회원가입일</th>
							<th>생일</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list }">
							<tr>
								<td>${dto.user_idx }</td>
								<td>${dto.user_id }</td>
								<td>${dto.user_name }</td>
								<td>${dto.user_phone }</td>
								<td>${dto.user_email }</td>
								<td>${dto.email_check }</td>
								<td>${dto.user_gender }</td>
								<td>${dto.user_role }</td>
								<td>${dto.user_grade }</td>
								<td>${dto.user_insertDate }</td>
								<td>${dto.user_birth }</td>
								<td><a
									href="${cpath }/admin/userModify?user_id=${dto.user_id}"><button>수정하기</button></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="pageNumber">
				<c:if test="${paging.prev }">
					<a
						href="${cpath }/admin/userManage?page=${paging.begin - 1}${searchParam}">[이전]</a>
				</c:if>

				<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
					<a class="${paging.page == i ? 'bold' : '' }"
						href="${cpath }/admin/userManage?page=${i}${searchParam}">[${i }]</a>
				</c:forEach>

				<c:if test="${paging.next }">
					<a
						href="${cpath }/admin/userManage?page=${paging.end + 1}${searchParam}">[다음]</a>
				</c:if>
			</div>



		</div>
	</div>
</section>
</main>
<script>
	
</script>

</body>
</html>