function menuOpen(event) {
		const rightAside = document.querySelector('aside#right')
		rightAside.classList.add('selected')
		homeWindow.classList.add('overlay')
}

function menuClose() {
	const rightAside = document.querySelector('aside#right')
	rightAside.classList.remove('selected')
	homeWindow.classList.remove('overlay')
}



function openModal(event) {

const modal = document.querySelector('div#modal')    
document.getElementById('modal').classList.remove('hidden')
modalWindow.classList.add('modal_overlay')

}

function closeModal() {

const modal = document.querySelector('div#modal')
document.getElementById('modal').classList.add('hidden')  // hidden css까먹지 말자.
modalWindow.classList.remove('modal_overlay')

}

function clickHandler(event) {
	const dropDown = event.target.querySelector('ol')
	if(dropDown.classList.contains('selected')){
		dropDown.classList.remove('selected')
		return
	}
	olList.forEach(e => e.classList.remove('selected'))
	
	
	dropDown.classList.add('selected')
}
function bodyChange(event) {
	let target = event.target
	while(!target.classList.contains('completed')){
		target = target.parentNode
	}
	if(target.classList.contains('completed')){
		if(event.wheelDeltaY < 0){
        	if(target.getAttribute('id') == 'body3'){return}
        	target.classList.remove('completed')
        	const bodyNum = target.getAttribute('id').split('y')[1]
        	const rename = 'body' + (+bodyNum+1)
        	const nextBody = document.querySelector('#'+rename)
        	target.classList.add('up')
        	target.classList.add('outOfBound')
        	nextBody.classList.remove('outOfBound')
        	nextBody.classList.remove('down')
        	nextBody.classList.add('loading')
        }else{
        	if(target.getAttribute('id') == 'body1'){return}
        	target.classList.remove('completed')
        	const bodyNum = target.getAttribute('id').split('y')[1]
        	const rename = 'body' + (+bodyNum-1)
        	const nextBody = document.querySelector('#'+rename)
        	target.classList.add('down')
        	target.classList.add('outOfBound')
        	nextBody.classList.remove('outOfBound')
        	nextBody.classList.remove('up')
        	nextBody.classList.add('loading') 
        }
    	setTimeout(addClass, 1000)
	}
}


function addClass(){
	const loading = document.querySelector('.loading')
	loading.classList.add('completed')
	loading.classList.remove('loading')
}