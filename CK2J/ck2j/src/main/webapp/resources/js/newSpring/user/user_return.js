

function clickSearch_Modal1() {
	
	const search_Modal1 = document.querySelector('div#search_Modal1')
	
	if(search_Modal1.classList.contains('displaynoneSearch')){
		document.querySelector('button.search_button1').innerText = '상품교환 닫기'
		search_Modal1.classList.remove('displaynoneSearch')

		
	}else{
		search_Modal1.classList.add('displaynoneSearch')
		document.querySelector('button.search_button1').innerText = '상품교환 신청'
	}
	
	
}








function clickSearch_Modal2() {
	
	const search_Modal2 = document.querySelector('div#search_Modal2')
	if(search_Modal2.classList.contains('displaynoneSearch')){
		document.querySelector('button.search_button3').innerText = '상품환불 닫기'
		search_Modal2.classList.remove('displaynoneSearch')
	}else{
		search_Modal2.classList.add('displaynoneSearch')
		document.querySelector('button.search_button3').innerText = '상품환불 신청'
	}
	
	
}

