	const deleteBtn = document.getElementById('deleteBtn')
		function deleteButton(event) {
		event.preventDefault()
		const qna_title = event.target.getAttribute('title')
		const qna_idx = event.target.getAttribute('idx')
		const url = cpath + '/board/qnaDelete/' + qna_idx
		const flag = confirm(qna_title + ' 삭제하시겠습니까?')
		if(flag) {
			location.href = url
		}
	}