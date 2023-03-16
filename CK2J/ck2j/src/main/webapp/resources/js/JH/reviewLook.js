
function deleteReview(event){
		event.preventDefault()
		const kill = confirm('리뷰 답글을 삭제 할까요?')
		if(kill){
			const url = event.target.parentNode.href
			console.log(url)
			const opt = {
					method:'DELETE'
			}
			
			fetch(url, opt)
			.then(resp => resp.text())
			.then(text => {
				console.log(text)
				if(text !=0 ){
					location.reload()
				}
			})		
		}
	}
	