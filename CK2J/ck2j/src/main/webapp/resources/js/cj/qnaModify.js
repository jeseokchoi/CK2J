	const radio = document.querySelectorAll('input[name="qna_secret"]')
	function redioChange(event) {
		const passCheck = document.querySelector('p#passwordCheck')
		if(event.target.value == 'Y'){
			passCheck.classList.remove('hidden')
		}else{
			passCheck.classList.add('hidden')
			document.querySelector('input[name="qna_password"]').value = ''
		}
	}	
	
	
	const qnaReturn = document.querySelector('div.write_submit button')
	function qnaReturnBtn(event){
		event.preventDefault()
		location.href = event.target.parentNode.href
	}
	
	$(document).ready(function() {
	  $('#summernote').summernote();
	});


	$('#summernote').summernote({
		  toolbar: [
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['picture','link','video']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
	  })
	  
	  $('#summernote').summernote('fontName', '맑은 고딕')