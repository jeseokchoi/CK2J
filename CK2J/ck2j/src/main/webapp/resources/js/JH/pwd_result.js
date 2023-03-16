function ownerCheck(event){
		event.preventDefault()
		
		const uob = {email: user_email,
					 verification : document.querySelector('input[name="verification"]').value,
					 }
		
		
		
		const url = cpath +'/user/pwd_result'
		const opt = {
				method: 'POST',
				body: JSON.stringify(uob),
				headers: {
					'Content-Type': 'application/json; charset=utf-8'
				}
			}
		
		fetch(url, opt)
		.then(resp => resp.text())
		.then(text => {
			if(text == 1) {
				alert('인증이 완료되었습니다')
				location.href = cpath + "/user/pwd_change?user_id=" + user_id
			}
			else {
				alert('인증번호가 일치하지 않습니다. 다시 확인해주세요')
			}
		})
		
	}