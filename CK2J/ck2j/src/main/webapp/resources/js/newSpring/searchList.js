function searching(event){
	event.preventDefault()
	const keyword = document.querySelector('input#detailKeyword')
	console.log('sss = ', keyword)
	if(keyword.value == ''){
		alert('검색어를 입력하세요')
	}else{
		searchForm.submit()
	}
}


function clickSearch_Modal() {
	
	const search_Modal = document.querySelector('div#search_Modal')
	if(search_Modal.classList.contains('displaynoneSearch')){
		document.querySelector('button.search_button1').innerText = '닫기'
		search_Modal.classList.remove('displaynoneSearch')
	}else{
		search_Modal.classList.add('displaynoneSearch')
		document.querySelector('button.search_button1').innerText = '상세검색 열기'
	}
	
	
}