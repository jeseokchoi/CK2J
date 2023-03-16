<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/mypageModify.css">

<script>
const user_id = '${user.user_id}'
</script>

<main>
<section>

<div id="mypage_modify">
	<div class="mypage_modify_head">
	<h1>MYPAGE</h1>
	<h4>고객님의 개인정보를 수정합니다.</h4>
	</div>
	<form method="POST">
                    <table>
                   <tr><th>아이디</th> <td><input type="text" name="user_id" value="${user.user_id }" readonly></td></tr>
                        <tr>
                            <th>비밀번호</th>
                            <td>
	                           <input type="password" name="user_pwd" required>
	                           <span> (영문 대소문자/특수문자/숫자 조합 11자리 이상)</span>
	                           <span class="pw1Check"></span>
                            </td>
                            
                        </tr>
                            
                        <tr>
                            <th>비밀번호 확인</th>
                            <td><input type="password" name="pwCheck"><span class="pw2Check"></span></td>
                            
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td><input type="text" name="user_name" value ="${user.user_name }" required></td>
                        </tr>
                        <tr>
                        <th>연락처</th>
                        <td><input type="text" name="user_phone" value ="${user.user_phone }" required></td>
                        </tr>
                        <tr>
                        <th>이메일</th>
                        <td><input type="email" name="user_email" value ="${user.user_email }" required></td>
                        </tr>
                        <tr>
                            <th>이메일 수신여부</th>
                            <td>
                                <label><input type="radio" name="email_check" ${user.email_check == 'Y' ? 'checked' : '' } value="Y" required>예</label>
                                <label><input type="radio" name="email_check" ${user.email_check == 'N' ? 'checked' : '' } value="N" required>아니오</label>
                               <span>(쇼핑몰에서 제공하는 유익한 이벤트 소식을 SMS로 받으실수 있습니다.)</span>
                            </td>
                        </tr>
                       <tr>
                        <th>생년월일</th><td><input type="date" name="user_birth" value ="${user.user_birth}" required></td>
                       </tr>
                       <tr>
                        <th>성별</th>
                        <td>
                            <label><input type="radio" name="user_gender" ${user.user_gender =='남성' ? 'checked' : '' } value="남성" required>남성</label>
                            <label><input type="radio" name="user_gender" ${user.user_gender =='여성' ? 'checked' : '' } value="여성" required>여성</label>
                        </td>
                       </tr>                 
                    </table>
                    <input class="mypage_modify_submit" type="submit" value="수정" >
                    </form>
                  <div class="withdraw"><a class="withdraw_member" href="">회원탈퇴</a> </div>
	</div>
	
	
</section>
</main>

<script>

// ##### 비밀번호 형식 확인 코드
 	const user_pwd = document.querySelector('input[name="user_pwd"]')
    const pw1Check = document.querySelector('span.pw1Check')
    
    const pwCheck = document.querySelector('input[name="pwCheck"]')
    const pw2Check = document.querySelector('span.pw2Check')

        function passwordCheck(event) {
            const exp = /^(?=.*?[0-9])(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[!@#$%^&*]).{8,16}$/
            if(event.target.value.match(exp) == null) {
            	pw1Check.innerText = '영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자.'
            		pw1Check.style.color = 'red'
            }
            else {
            	pw1Check.innerText = '👌사용가능합니다.'
            		pw1Check.style.color = '#1a2c7d'
            }
        }
	
	 	 function passwordCheck2(event) {
	        
	         console.log(user_pwd.value)
	         console.log(pwCheck.value)
	         
	         if(user_pwd.value == pwCheck.value) {
	         	pw2Check.innerText = '👌사용가능합니다.'
	         		pw2Check.style.color = '#1a2c7d'
	         }
	         else {
	         	pw2Check.innerText = '비밀번호가 일치하지 않습니다.'
	         		pw2Check.style.color = 'red'
	         }
	     }
	
 	user_pwd.onkeyup = passwordCheck
 	pwCheck.onkeyup = passwordCheck2

</script>

<script>
         const btnSubmit = document.querySelector('input[type="submit"]')
        		
 		btnSubmit.onclick = function(event){        	  
         	if(pw1Check.innerText != '👌사용가능합니다.'){
 				alert('비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자.로 작성되어야 합니다.')
 				event.preventDefault()
 				return
 			}if(pw2Check.innerText != '👌사용가능합니다.'){
 				alert('비밀번호를 확인해주세요')
 				event.preventDefault()
 				return
 			}
 		}
        
         const withdraw = document.querySelector('.withdraw_member')
         
         function deleteMember(event) {
        	 event.preventDefault()
        	 const flag = confirm('정말 탈퇴를 진행 하시겠습니까? 😢')
        	 if(flag){
        		 const url = cpath + '/user/withdraw/'+ user_id
        		 const opt = {
        				 method : 'DELETE'
        		 }
        		 fetch(url,opt)
        		 .then(resp => resp.text())
        		 .then(text => {
        			 if(text == 1){
        				 alert('이용해 주셔서 감사합니다. 고객님의  계정 정보가 정상적으로 탈퇴 처리 되었습니다.')
        				 location.href = cpath
        			 }
        		 })
        	 }
         }
         withdraw.onclick = deleteMember
</script>


</body>
</html>