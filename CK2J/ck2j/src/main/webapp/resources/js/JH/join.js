

        function passwordCheck(event) {       	
            const exp = /^(?=.*?[0-9])(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[!@#$%^&*]).{8,16}$/
            if(event.target.value.match(exp) == null) {
            	pw1Check.innerText = '영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자.'
            		pw1Check.style.color = 'red'
            }
            else {
            	pw1Check.innerText = '사용가능합니다.'
            		pw1Check.style.color = 'blue'
            }
        }
	
	 	 function passwordCheck2(event) {
	        
	         console.log(user_pwd.value)
	         console.log(pwCheck.value)
	         
	         if(user_pwd.value == pwCheck.value) {
	         	pw2Check.innerText = '사용가능합니다'
	         		pw2Check.style.color = 'blue'
	         }
	         else {
	         	pw2Check.innerText = '비밀번호가 일치하지 않습니다.'
	         		pw2Check.style.color = 'red'
	         }
	     }
	 	 
	 	// ####################### 아이디 중복 체크
	 	
	 			
	 	function dupchecking(event){
	 		event.preventDefault()
	 		const inputId = document.querySelector('input[name="user_id"]')	 	
	 		
	 		const url = cpath + '/user/join/dupCheck/' + inputId.value
	 		fetch(url)
	 		.then(resp => resp.text())
	 		.then(text => {
	 			console.log(text)
	 			dupResult.innerText = text
	 		})
	 				
	 	}
	 	 
	 	 
 		
	 		function joinProgress(event){
	 			
	        	const agreeLabels = document.querySelectorAll('input[name="agreement"]:checked').length == 3 ? true : false
	     		if(agreeLabels == false){
	         		alert('약관을 동의해주세요')
	         		event.preventDefault()
	         		return
	         	}if(pw1Check.innerText != '사용가능합니다.'){
	 				alert('비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자.로 작성되어야 합니다.')
	 				event.preventDefault()
	 				return
	 			}if(pw2Check.innerText != '사용가능합니다'){
	 				alert('비밀번호를 확인해주세요')
	 				event.preventDefault()
	 				return
	 			}if(dupResult.innerText != '사용 가능한 ID입니다'){
	 				alert('아이디를 확인해주세요')
	 				event.preventDefault()
	 				return
	 			}
	 		}
	 		
	 		function checkAgreementAll(event){
	    		const agreeLabels = document.querySelectorAll('input[name="agreement"]')
	    		if(event.target.checked == true){
	    			agreeLabels.forEach(e => {
	    				e.checked = true;
	    			})
	    		}else {
	    			agreeLabels.forEach(e => {
	    				e.checked = false;
	    			})
	    		}
	    	}
	 		
	 		
	 	 