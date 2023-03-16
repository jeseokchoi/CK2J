
function deleteHandler(event) {
	event.preventDefault()
		const flag = confirm('정말 리뷰를 삭제하시겠습니까?')
		if(flag) {
			
			const url = event.target.parentNode.href
			console.log(url)
			const opt = {
				method: 'DELETE'
			}
			fetch(url, opt)
			.then(resp => resp.text())
			.then(text => {
				if(text != 0){
					location.reload()
				}
			})
			
		}
}
	

	async function replyLoadHandler() {
	const reviewDiv = document.getElementById('review')
	const url = cpath + '/product/review/' + product_idx
	
	await fetch(url)
	.then(resp => resp.json())
	.then(json => {
		const arr = json
		reviewDiv.innerHTML = ''
		
		arr.forEach(dto2 => {
			const html = convertHTMLfromJSON(dto2)
			reviewDiv.innerHTML += html
		})
	})
	// ====================================== 0226 ===========================================================
		const deleteBtn = document.querySelector('button.delete')
		if(deleteBtn) {
			deleteBtn.onclick = deleteHandler 
		}
}

	
function convertHTMLfromJSON(dto2) {

		let html = `       <div class="reply">`
		html+= `           	<div class="replyTop">`
		html+= `           		<div class="reviewLeft">`
		html+= `           			<div class="review_rate"><span>평점  </span>${rateConvert(dto2.rate)}</div>`		
		html+= `           			<div class="user_id"><span>작성자 </span>${dto2.user_id} <span class="review_date">${getYMD(dto2.writing_date)}</span></div>`
		html+= `           			<div class="review_size"><span>색상,사이즈  </span> ( ${dto2.product_size} , ${dto2.product_color})</div>`
		html+= `           	        <div class="review_view"><div class="review_content_title"><span>리뷰</span></div> <div class="review_content">${rnConvert(dto2.content)}</div></div>`
		html+= `           		</div>`
		html+= `           		<div class="reviewRight">`
		html+= `           		<a href="${cpath}/product/review_modify/${dto2.product_review_idx}"><button class="modify" ${login_user != dto2.user_id ? 'hidden' : ''}> 수정 </button></a>`
		html+= `           		<a href="${cpath}/product/review_delete/${dto2.product_review_idx}"><button class="delete" ${login_user != dto2.user_id ? 'hidden' : ''}> 삭제 </button></a>`
		html+= `           		</div>`
		html+= `           	</div>`
		html+= `           	<div class="reviewReply" ${dto2.review_reply_idx == '' ? 'hidden' : ''}>`
		html+= `                   <div class="reply_writer"><strong>판매자</strong><span>${getYMD(dto2.reply_writing_date)}</span></div>`
		html+= `           		<div class="review_reply_content">${rnConvert(dto2.reply_content)}</div>`
		html+= `           	</div>`
		html+= `           </div>`
		html+= `           <hr class="review_hr">`

			
	return html
}

function rnConvert(context){
	if(context != null){
	context = context.replaceAll('\r\n', '<br>')}
	return context
}

function getYMD(date) {			
	const d = new Date(date)	
	const yyyy = d.getFullYear()	
	let mm = d.getMonth() + 1		
	let dd = d.getDate()			
	if(mm < 10) {					
		mm = '0' + mm				
	}
	if(dd < 10) {					
		dd = '0' + dd				
	}
	return `${yyyy}-${mm}-${dd}`	
}
function rateConvert(rate){
	let star = ''
	for(let i = 0; i < rate; i++){
		star += '⭐'
	}
	return star
}

