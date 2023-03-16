

async function chartLoadHandler(event){
	const root = document.getElementById('root')
	await destroy()
	const sales = document.getElementById('sales')
	const url = cpath + '/admin/getSalesChart/'+SaleCategory.value
	await fetch(url)
	.then(resp => resp.json())
	.then(json => {
		console.log(json)
		const dataArray = Array.from(json)
		const selectCategory =document.querySelector('select#SaleCategory')
		const category = chooseCategory(event.target.value)
			
		const labels = dataArray.map(e => dateFormat(e.dt, category))
		const data ={
			labels: labels,
			datasets:[{
				label:category,
				data: dataArray.map(e => e.order_total_price),
			}]
		}
		const config = {
	           type: 'bar',
	           data: data,
	           options: {}
	    }
		
		var context = document.getElementById('myChart').getContext('2d')
		myChart = new Chart(context, config)
	})
}

function destroy(event){
	if(myChart != undefined){
		myChart.destroy()
	}
}

function chooseCategory(value){
	if(value == 'recentWeek') return '최근 일주일 매출'
	else if(value == 'recentMonth') return  '일별 매출'
	else if(value == 'monthly') return  '월별 매출'
	else return  '연도별 매출'
}


function dateFormat(dtoDate, category){
	if (category == '월별 매출'){
		let Ddate = new Date(dtoDate)
		let year = Ddate.getFullYear()
		let month = Ddate.getMonth()+1
		return year+'년 '+month + '월'
	}else if(category == '연도별 매출'){
		let Ddate = new Date(dtoDate)
		let year = Ddate.getFullYear()
		return year+'년'
	}else{
		let Ddate = new Date(dtoDate)
		let year = Ddate.getFullYear()
		let month = Ddate.getMonth()+1
		let date = Ddate.getDate()
		return year+'.'+month+'.'+date
	}
	
}

function showUserOrderDetail(event){
	let target = event.target
	
	while(target.getAttribute('idx') == null){
		target = target.parentNode
	}
	const idx = target.getAttribute('idx')
	
	const modalBtn = document.querySelector('button.btn-primary')
	modalBtn.click()
	const url = cpath+'/admin/order/userOrderDetail/'+ idx
	fetch(url)
	.then(resp => resp.json())
	.then(json => {
		console.log('json = ',json)
		const OrderModalInner = document.querySelector('div.modal div.modal-body div.modal-bodyDetail')
		const innerItems = document.querySelectorAll('.detailItem:not(.detailHeader)')
		let html = '<h2 class="detailItem">주문번호['+ json[0].userOrder_idx + ']</h2>'
		html += '<div class="detailItem detailHeader">'
		html += '<div class="product_name">제품이름</div>'
		html += '<div class="product_opt">옵션</div>'
		html += '<div class="product_count">제품수량</div>'
		html += '<div class="product_price">금액</div>'
		html += '<div class="order_detail_status">처리상태</div>'
		html += '</div>'
		OrderModalInner.innerHTML = html
		if(innerItems != null){
			innerItems.forEach(e => {
				e.remove()
			})
		}
		
		json.forEach(dto => {
			let html= '	<div class="detailItem" idx="' + dto.userOrder_detail_idx + '">'
			html += '		<div class="product_name">'+ dto.product_name + '</div>'
			html += '		<div class="product_opt">'+ dto.product_opt + '</div>'
			html += '		<div class="product_count">'+ dto.product_count + '</div>'
			html += '		<div class="product_price">￦ '+ dto.product_price.toLocaleString() + '</div>'
			html += '		<div>'
			html += '			<select class="order_detail_status">'
			html += '				<option ' + (dto.order_detail_status == "주문확인중" ? "selected" : "") + '>주문확인중</option>'
			html += '				<option ' + (dto.order_detail_status == "배송준비중" ? "selected" : "") + '>배송준비중</option>'
			html += '				<option ' + (dto.order_detail_status == "배송중" ? "selected" : "") + '>배송중</option>'
			html += '				<option ' + (dto.order_detail_status == "배송완료" ? "selected" : "") + '>배송완료</option>'
			html += '				<option ' + (dto.order_detail_status == "교환진행중" ? "selected" : "") + '>교환진행중</option>'
			html += '				<option ' + (dto.order_detail_status == "교환완료" ? "selected" : "") + '>교환완료</option>'
			html += '				<option ' + (dto.order_detail_status == "환불진행중" ? "selected" : "") + '>환불진행중</option>'
			html += '				<option ' + (dto.order_detail_status == "환불완료" ? "selected" : "") + '>환불완료</option>'
			html += '			</select>'
			html += '			<button id="status_submit" class="hidden">수정</button>'
			html += '		</div>'
			html += '	</div>'
			OrderModalInner.innerHTML += html
		})
		
		const status = document.querySelectorAll('select.order_detail_status')
		status.forEach(e => {
			e.onchange = statusFormHandler
		})
		
		const statusBtn = document.querySelectorAll('div.detailItem #status_submit')
		statusBtn.forEach(e => {
			e.onclick = userOrderDetailModify
		})
	})
}

function statusFormHandler(event){
	const submit = event.target.parentNode.querySelector('#status_submit')
	submit.classList.remove('hidden')
}

function userOrderModify(event) {
	
	const user_order_idx = event.target.parentNode.parentNode.getAttribute('idx')	// user_order_idx의 위치를 찾아서 담아준다
		
	const status_for_admin = event.target.parentNode.querySelector('select').value	// status_for_admin select로 처리하는 값(문자열)들을 지정해서 담아준다
					
	const ob = {							// ob에 배열로 필요한 값(idx, 입력할 값(문자열))을 담는다
		user_order_idx: user_order_idx,			
		status_for_admin: status_for_admin
	}
		
	const url = cpath + '/admin/userOrderList'			// 펑션이 작동할 때 돌아가는 주소를 요청한다
	const opt = {
		method: 'POST',									// 맵핑 컨트롤러 맞춰서 작성 (Ajax = requestmapping)확인
		body: JSON.stringify(ob),						// 바디부분 생성
		headers: {
			'Content-Type' : 'application/json; charset=utf-8'
		}
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		if(text == 1) {
			location.reload()
		}
	})
}
function userOrderDetailModify(event) {
					
	const userOrder_detail_idx = event.target.parentNode.parentNode.getAttribute('idx')	// user_order_idx의 위치를 찾아서 담아준다
		
	const order_detail_status = event.target.parentNode.querySelector('select').value	// status_for_admin select로 처리하는 값(문자열)들을 지정해서 담아준다
					
	const ob = {							// ob에 배열로 필요한 값(idx, 입력할 값(문자열))을 담는다
		userOrder_detail_idx: userOrder_detail_idx,			
		order_detail_status: order_detail_status
	}
		
	const url = cpath + '/admin/userOrderDetail'			// 펑션이 작동할 때 돌아가는 주소를 요청한다
	const opt = {
		method: 'POST',									// 맵핑 컨트롤러 맞춰서 작성 (Ajax = requestmapping)확인
		body: JSON.stringify(ob),						// 바디부분 생성
		headers: {
			'Content-Type' : 'application/json; charset=utf-8'
		}
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		if(text == 1) {
			location.reload()
		}
	})
}

function searchingProductByStatus(event){
	const targetValue = event.target.value
	const itemArray = Array.from(document.querySelectorAll('div.userOrderItems > .item:not(.itemHeader)'))
	const category = document.querySelector('select[name="searchCategory"]').value
    const result = itemArray.filter(data => (data.querySelector('select[name="order_status"]').value == (targetValue)) == false)
    itemArray.forEach(data => data.classList.remove('hidden'))
    
    if(targetValue == 'all') {
        return
    }
    
	itemArray.forEach(data => data.classList.remove('hidden'))
    result.forEach(data => data.classList.add('hidden'))
}

function searchingProduct(event){
	const targetValue = event.target.value
	const itemArray = Array.from(document.querySelectorAll('div.userOrderItems > .item:not(.itemHeader)'))
	const category = document.querySelector('select[name="searchCategory"]').value
    const result = itemArray.filter(data => data.querySelector(selectCategoryinOrderList(category)).innerText.split("[")[0].includes(targetValue) == false)
    itemArray.forEach(data => data.classList.remove('hidden'))
    
	itemArray.forEach(data => data.classList.remove('hidden'))
	
	if(result.length == itemArray.length) {
        return
    }
    result.forEach(data => data.classList.add('hidden'))
}

function selectCategoryinOrderList(category){
	let result
	if(category == '주문 번호'){
		result =  'div.user_order_idx'
	} else if(category == '제품') {
		result = 'div.product_name'
	} else {
		result = 'div.user_id'
	}
	return result
}

function cancelingOrder(event) {
	
	const user_order_idx = event.target.getAttribute('idx')

	const flag = confirm('주문을 취소하시겠습니까?')

	if(flag == true){
		const url = cpath+'/admin/order/userOrderList/' + user_order_idx
		const opt = {
			method: 'DELETE'
		}
		fetch(url, opt)
		.then(resp => resp.text())
		.then(text => {
			console.log(text)
			if(text == 1){
				location.reload()
			}
		})
	}
}

function showUserOrderDetailNonuser(event){
	let target = event.target
	
	while(target.getAttribute('idx') == null){
		target = target.parentNode
	}
	const idx = target.getAttribute('idx')
	
	const modalBtn = document.querySelector('button.btn-primary')
	modalBtn.click()
	const url = cpath+'/admin/order/nonuserOrderDetail/'+ idx
	fetch(url)
	.then(resp => resp.json())
	.then(json => {
		console.log('json = ',json)
		const OrderModalInner = document.querySelector('div.modal div.modal-body div.modal-bodyDetail')
		const innerItems = document.querySelectorAll('.detailItem:not(.detailHeader)')
		let html = '<h2 class="detailItem">주문번호['+ json[0].nonuser_order_idx + ']</h2>'
		html += '<div class="detailItem detailHeader">'
		html += '<div class="product_name">제품이름</div>'
		html += '<div class="product_opt">옵션</div>'
		html += '<div class="product_count">제품수량</div>'
		html += '<div class="product_price">금액</div>'
		html += '<div class="order_detail_status">처리상태</div>'
		html += '</div>'
		OrderModalInner.innerHTML = html
		if(innerItems != null){
			innerItems.forEach(e => {
				e.remove()
			})
		}
		
		json.forEach(dto => {
			let html= '	<div class="detailItem" idx="' + dto.nonuserOrder_detail_idx + '">'
			html += '		<div class="product_name">'+ dto.product_name + '</div>'
			html += '		<div class="product_opt">'+ dto.product_opt + '</div>'
			html += '		<div class="product_count">'+ dto.product_count + '</div>'
			html += '		<div class="product_price">￦ '+ dto.product_price.toLocaleString() + '</div>'
			html += '		<div>'
			html += '			<select class="order_detail_status">'
			html += '				<option ' + (dto.order_detail_status == "주문확인중" ? "selected" : "") + '>주문확인중</option>'
			html += '				<option ' + (dto.order_detail_status == "교환진행중" ? "selected" : "") + '>교환진행중</option>'
			html += '				<option ' + (dto.order_detail_status == "교환완료" ? "selected" : "") + '>교환완료</option>'
			html += '				<option ' + (dto.order_detail_status == "환불진행중" ? "selected" : "") + '>환불진행중</option>'
			html += '				<option ' + (dto.order_detail_status == "환불완료" ? "selected" : "") + '>환불완료</option>'
			html += '				<option ' + (dto.order_detail_status == "배송완료" ? "selected" : "") + '>배송완료</option>'
			html += '			</select>'
			html += '			<button id="status_submit" class="hidden">수정</button>'
			html += '		</div>'
			html += '	</div>'
			OrderModalInner.innerHTML += html
		})
		
		const status = document.querySelectorAll('select.order_detail_status')
		status.forEach(e => {
			e.onchange = statusFormHandler
		})
		
		const statusBtn = document.querySelectorAll('div.detailItem #status_submit')
		statusBtn.forEach(e => {
			e.onclick = nonuserOrderDetailModify
		})
	})
}

function nonuserOrderModify(event) {
	
	const nonuser_order_idx = event.target.parentNode.parentNode.getAttribute('idx')	// user_order_idx의 위치를 찾아서 담아준다
		
	const status_for_admin = event.target.parentNode.querySelector('select').value	// status_for_admin select로 처리하는 값(문자열)들을 지정해서 담아준다
					
	const ob = {							// ob에 배열로 필요한 값(idx, 입력할 값(문자열))을 담는다
		nonuser_order_idx: nonuser_order_idx,			
		status_for_admin: status_for_admin
	}
		
	const url = cpath + '/admin/nonuserOrderList'			// 펑션이 작동할 때 돌아가는 주소를 요청한다
	const opt = {
		method: 'POST',									// 맵핑 컨트롤러 맞춰서 작성 (Ajax = requestmapping)확인
		body: JSON.stringify(ob),						// 바디부분 생성
		headers: {
			'Content-Type' : 'application/json; charset=utf-8'
		}
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		if(text == 1) {
			location.reload()
		}
	})
	
}

function nonuserOrderDetailModify(event) {
	
	const nonuserOrder_detail_idx = event.target.parentNode.parentNode.getAttribute('idx')	// user_order_idx의 위치를 찾아서 담아준다
		
	const order_detail_status = event.target.parentNode.querySelector('select').value	// status_for_admin select로 처리하는 값(문자열)들을 지정해서 담아준다
					
	const ob = {							// ob에 배열로 필요한 값(idx, 입력할 값(문자열))을 담는다
		nonuserOrder_detail_idx: nonuserOrder_detail_idx,			
		order_detail_status: order_detail_status
	}
		
	const url = cpath + '/admin/nonuserOrderDetail'			// 펑션이 작동할 때 돌아가는 주소를 요청한다
	const opt = {
		method: 'POST',									// 맵핑 컨트롤러 맞춰서 작성 (Ajax = requestmapping)확인
		body: JSON.stringify(ob),						// 바디부분 생성
		headers: {
			'Content-Type' : 'application/json; charset=utf-8'
		}
	}
	fetch(url, opt)
	.then(resp => resp.text())
	.then(text => {
		if(text == 1) {
			location.reload()
		}
	})
}

function deletingNonuserOrder(event) {
	
	const nonuser_order_idx = event.target.getAttribute('idx')

	const flag = confirm('주문을 취소하시겠습니까?')

	if(flag == true){
		const url = cpath+'/admin/order/nonuserOrderList/' + nonuser_order_idx
		const opt = {
			method: 'DELETE'
		}
		fetch(url, opt)
		.then(resp => resp.text())
		.then(text => {
			console.log(text)
			if(text == 1){
				location.reload()
			}
		})
	}
}

function searchingProductNonuser(event){
	const targetValue = event.target.value
	const itemArray = Array.from(document.querySelectorAll('div.userOrderItems > .item:not(.itemHeader)'))
	const category = document.querySelector('select[name="searchCategory"]').value
    const result = itemArray.filter(data => data.querySelector(selectCategoryinOrderListNonuser(category)).innerText.split("[")[0].includes(targetValue) == false)
    itemArray.forEach(data => data.classList.remove('hidden'))
    
	itemArray.forEach(data => data.classList.remove('hidden'))
	
	if(result.length == itemArray.length) {
        return
    }
    result.forEach(data => data.classList.add('hidden'))
}

function selectCategoryinOrderListNonuser(category){
	let result
	if(category == '주문 번호'){
		result =  'div.nonuser_order_idx'
	} else if(category == '제품') {
		result = 'div.product_name'
	} else {
		result = 'div.receiver_name'
	}
	return result
}

function statusFormHandler(event){
	const submit = event.target.parentNode.querySelector('#status_submit')
	submit.classList.remove('hidden')
}

function orderHandler(event){
    const order = event.target.className

//     클릭한 타겟의 asc 속성 불러오기
    let flag = +event.target.getAttribute('asc')    // flag = 1

    itemList.sort((a,b) => {
        const aa = a.querySelector('.'+order).innerText
        const bb = b.querySelector('.'+order).innerText
        
        headerList.forEach(h => h.querySelector('.arrow').innerText = '')
        // flag가 1이면 
        if(flag == 1){
            // 타겟 asc 값 재설정 후 정방향 정렬
            event.target.setAttribute('asc', -1)
            event.target.querySelector('.arrow').innerText = '↑'
            if(order == 'product_idx' || order == 'product_price') return +aa > +bb ? 1 : -1
            else                return aa > bb ? 1 : -1
        }else{
            event.target.setAttribute('asc', 1)
            event.target.querySelector('.arrow').innerText = '↓'
            if(order == 'product_idx' || order == 'product_price') return +aa < +bb ? 1 : -1
            else                return aa < bb ? 1 : -1
        }
    })
    itemList.forEach(data => productItems.appendChild(data))
}

function filterCode(code) {
	let genderStr = ''
	let catStr = ''
	
	if(code.indexOf('m_') == 0){
		genderStr = "m_"
	} else{
		genderStr = "w_"
	}
	if(code.indexOf('top') == 2){
		catStr = 'top'
	}else if(code.indexOf('shirts') == 2) {
		catStr = 'shirts'
	}else if(code.indexOf('shoes') == 2){
		catStr = 'shoes'
	}else if(code.indexOf('pants') == 2){
		catStr = 'pants'
	}else if(code.indexOf('outer') == 2){
		catStr = 'outer'
	}else if(code.indexOf('knit') == 2){
		catStr = 'knit'
	}else if(code.indexOf('bottom') == 2){
		catStr = 'bottom'
	}else if(code.indexOf('suit') == 2){
		catStr = 'suit'
	}
		const ob ={
			genderStr: genderStr,
			catStr: catStr
	}
		return ob
}


function deleteProduct(event){
	const idx = event.target.getAttribute('idx')
	const title = event.target.getAttribute('title')
	const flag = confirm('['+title+'] 을 삭제하시겠습니까?')
	if(flag){
		location.href= cpath + '/admin/product/delete/'+idx
	}
}


function adminProductLoadHandler() {
	
	const itemList = Array.from(document.querySelectorAll('.item:not(.itemHeader)'))
	
	itemList.forEach(e => {
		const product_code = e.querySelector('div.product_code').innerText
		const ob = filterCode(product_code)
		let html = '<input type="hidden" name="gender" value="' + ob.genderStr + '">'
		html += '<input type="hidden" name="category" value="' + ob.catStr + '">'
		e.innerHTML += html
	})

	const showTBtnList = document.querySelectorAll('button.showTBtn')
	showTBtnList.forEach(e => e.onclick = showImg)
	
	const toDetail = document.querySelectorAll('div.item:not(.itemHeader) > div:not(.product_t_img)')
	toDetail.forEach(e => e.onclick = function(event) {
	const idx = event.target.parentNode.getAttribute('idx')
	location.href= cpath + '/admin/product/modify/'+idx
	})
	
	const deleteBtnList = document.querySelectorAll('button.deleteBtn')
	deleteBtnList.forEach(e => e.onclick = deleteProduct)
	
}

function filtering(event){
    const checkedGenderBoxArray = Array.from(document.querySelectorAll('div.genderBox input[name="gender"]:checked')).map(e => e.value)
	const checkedCategoryBoxArray = Array.from(document.querySelectorAll('input[name="category"]:checked')).map(e => e.value)
    const result1 = itemList.filter(data => checkedGenderBoxArray.includes(data.querySelector('input[name="gender"]').value) == false)
    const result2 = itemList.filter(data => checkedCategoryBoxArray.includes(data.querySelector('input[name="category"]').value) == false)
    console.log(result1)
    itemList.forEach(data => data.classList.remove('hidden'))
    
    if(document.querySelectorAll('div.genderBox input[name="gender"]:checked').length == 0 && document.querySelectorAll('div.categoryBox input[name="category"]:checked').length == 0){
    	console.log('ㅎㅇ')
    	return
    }
	if(result1.length != itemList.length){
	    result1.forEach(data => data.classList.add('hidden'))
	}
	if(result2.length != itemList.length){
	    result2.forEach(data => data.classList.add('hidden'))
	}
}

function showImg(event) {
	console.log('event.target',event.target)
	const img = event.target.parentNode.querySelector('div.product_t_img > img')
	if(img.classList.contains('hidden')){
		event.target.innerText = '썸네일 닫기'
		img.classList.remove('hidden')
	}else{
		event.target.innerText = '썸네일 보기'
		img.classList.add('hidden')
	}
}


