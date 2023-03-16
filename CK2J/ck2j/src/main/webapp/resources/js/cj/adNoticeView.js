	const deleteBtn = document.getElementById('deleteBtn')
	function deleteButton(event) {
		event.preventDefault()
		const notice_title = event.target.getAttribute('title')
		const notice_idx = event.target.getAttribute('idx')
		const url = cpath + '/admin/board/adNotiDelete/' + notice_idx
		const flag = confirm(notice_title + '삭제 하시겠습니까?')
		if(flag) {
			location.href = url
		}
	}