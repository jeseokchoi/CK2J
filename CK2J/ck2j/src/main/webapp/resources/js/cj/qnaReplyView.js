function deleteHandler(event) {
	const replyWriter = event.target.parentNode.parentNode.querySelector('.writer')
	const flag = confirm('삭제하시겠습니까?')
		if(flag) {
			const idx = replyWriter.parentNode.parentNode.parentNode.getAttribute('qna_idx')
			const qna_reply_idx = event.target.parentNode.parentNode.parentNode.getAttribute('idx')
			const url = `${cpath}/admin/board/reply/${qna_idx}/${qna_reply_idx}`
			const opt = {
				method: 'DELETE'
			}
			fetch(url, opt)
			.then(resp => resp.text())
			.then(text => {
				if(text == 1){
					const url = `${cpath}/admin/board/qnaReplyView/${qna_idx}`
					location.href = url

				}
			})
		}
	}


async function replyLoadHandler(){
	const replyDiv = document.getElementById('reply')
	const url = cpath + '/admin/board/reply/' + qna_idx
	
	await fetch(url)
	.then(resp => resp.json())
	.then(json => {
		const arr = json
		replyDiv.innerHTML = ''
			
		arr.forEach(dto => {
			const html = convertHTMLfromJSON(dto)
			replyDiv.innerHTML += html
		})
		document.querySelectorAll('div.reply button.modify').forEach(e => e.onclick = replyModifyFormHandler)
		
	})
	const deleteBtnList = document.querySelectorAll('button.delete')
	deleteBtnList.forEach(btn => btn.onclick = deleteHandler)
	if(replyDiv.innerText != ''){
		const replyWriteForm= document.querySelector('form#replyWriteForm')
		replyWriteForm.classList.add('hidden')
	}
}

function convertHTMLfromJSON(dto){
	let html = `<div class="reply" idx="${dto.qna_reply_idx}">`
		html += `	<div class="replyTOP">`
			
		html += `		<div class="left">`
		html += `			<div class="writer">관리자</div>`
		html += `			<div class="writedate">${getYMD(dto.writing_date)}</div>`
		html += `		</div>`
			
		html += `		<div class="right">`
		html += `			<pre class="content">${dto.content}</pre>`
		html += `			<button class="modify">수정</button>`
		html += `			<button class="delete">삭제</button>`
		html += `		</div>`
			
		html += `	</div>`
		html += `</div>`
		return html	
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

function replyWriteHandler(event) {
	console.log(111)
	event.preventDefault()
	const content = document.querySelector('#replyWriteForm textarea')
	const ob = {
		qna_idx: qna_idx,
		content: content.value
	}
	const url = cpath + '/admin/board/reply/' + qna_idx
	const opt = {
		method: 'POST',
		body: JSON.stringify(ob),
		headers: {
			'Content-Type' : 'application/json; charset=utf-8'
		}
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		if(text == 1) {
			alert('작성완료')
			replyLoadHandler()
			content.value = ''
		}
	})
}



function replyModifyFormHandler(event) {
	const modifyForm = document.getElementById('replyModify')
	modifyForm.classList.remove('hidden')
	let target = event.target
	
	while(target.classList.contains('reply') == false) {
		target = target.parentNode
	}
	target.classList.add('hidden')
	const textarea = modifyForm.querySelector('textarea') 
	textarea.innerText = target.querySelector('pre').innerText
	target.parentNode.appendChild(modifyForm)
	textarea.select()
	
	const reply_modify = document.querySelector('.reply_modify')
	console.log(reply_modify)
	reply_modify.onclick = replyModify
			
}

function replyModifyFormRollback(event) {
	
	const modifyForm = document.getElementById('replyModify')
	modifyForm.classList.add('hidden')
	
	const reply = document.querySelector('div.reply')
	reply.classList.remove('hidden')
}

function replyModify(event) {
	event.preventDefault()
	console.log(event.target.parentNode.parentNode)
	
	const content = event.target.parentNode.parentNode.querySelector('.modifyText').value
	
	const ob = {
		qna_idx: qna_idx,
		content: content
	}
	const url = cpath + '/admin/board/reply/' + qna_idx
	const opt = {
		method: 'PUT',
		body: JSON.stringify(ob),
		headers: {
			'Content-Type' : 'application/json; charset=utf-8'
		} 
	}
	
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		console.log(text)
		if(text == 1) {
			location.reload()
		}
	})
}