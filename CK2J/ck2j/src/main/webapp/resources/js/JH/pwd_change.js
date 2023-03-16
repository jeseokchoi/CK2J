

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
	 	 
		 function modifyProgress(event){        	  
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
		
	