 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>


<main>
<section>

<div id="categoryName"><h2>장바구니</h2></div>
	<form method="POST">
	<table id="purchaseProductList">
		<thead>
			<tr>
				<th><input type="checkbox" name="multi" value=""></th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>합계</th>
				<th>선택</th>
			</tr>	
		</thead>
		
		<tbody>
		<c:forEach var="dto" items="${list }">
			<tr>
				<td style="display: none;">
					<div class="items">
						<input type="hidden" name="itemIdx" value="${dto.itemIdx }">
						<input type="hidden" name="itemOpt" value="${dto.itemOpt }">
						<input type="hidden" name="itemName" value="${dto.itemName }"> 
						<input type="hidden" name="itemPrice" value="${dto.itemPrice }"> 
						<input type="hidden" name="itemEachPrice" value="${dto.itemEachPrice }"> 
						<input type="hidden" name="itemAmount" value="${dto.itemAmount }">
					</div>
				</td>
				<td><input type="checkbox" each="each" value="${dto.itemIdx }_${dto.itemOpt }"></td>
				<td><img border="1px solid black" width="100px" height="100px" src="${cpath}/itemImg/${dto.product_t_img}"></td>
				<td>
					<strong>${dto.itemName }</strong><br>
					[${dto.itemOpt }]
				</td>
				<td><fmt:formatNumber>${dto.itemEachPrice }</fmt:formatNumber></td>
				<td>${dto.itemAmount }</td>
				<td class="itemPrice">￦ <fmt:formatNumber> ${dto.itemPrice }</fmt:formatNumber></td>
				<td><button class="deleteCartItem" value="${dto.itemIdx }_${dto.itemOpt }">삭제하기</button></td>
			</tr>
			</c:forEach>
			<tr>
			<td class="purchaseTotalPrice" colspan="8" style="text-align: right; padding-right: 20px; border-top: 1px solid #dadada">
				
			</td>
			</tr>
		</tbody>
	</table>
	<div class="btnSubmit" style="width: 300px; margin: auto;">
		<div class="toPurchase toPurchaseBtn" style="flex: 1">전체상품주문</div>
		<div class="toBasket toPurchaseBtn">선택상품주문</div>
	</div>
</form>


</section>
</main>

<script>
	const tdPurchaseTotalPrice = document.querySelector('td.purchaseTotalPrice')
	const tdItemPriceList = document.querySelectorAll('td.itemPrice')
	function removeComma(data) {
		data = data.replace('￦ ','')
		data = data.replace(',', '')
		data = data.replace(' ', '')
		return data
	}
	let totalPrice = 0
	tdItemPriceList.forEach(e => {
		e = removeComma(e.innerText)
		totalPrice += +e
	})
	tdPurchaseTotalPrice.innerText = '합계: ' + totalPrice.toLocaleString() + '원'
	
	const checkBoxList = document.querySelectorAll('input[each="each"]')
	const multiCheckBox = document.querySelector('input[name="multi"]')
	
	multiCheckBox.onclick = (event) =>{
		
		checkBoxList.forEach(e => {
			if(event.target.checked == true){
				e.checked = true
			}else{
				e.checked = false
			}
		})
	}
</script>

<script>
	const deleteCartItemBtnList = document.querySelectorAll('button.deleteCartItem')
	deleteCartItemBtnList.forEach(e => e.onclick = deletingCartItem)
	
	function deletingCartItem(event) {
		event.preventDefault()
		location.href='${cpath}/product/cart/delete/?value='+event.target.value
	}
	
</script>

<script>
	if(${list} == ''){
		
		alert('장바구니에 상품이 없습니다.')
		location.href='${cpath}/'
	}
</script>

<script>
	const toPurchaseBtn = document.querySelectorAll('div.btnSubmit > div.toPurchaseBtn')
	toPurchaseBtn.forEach(e => e.onclick = toPurchaseHandler)
	function toPurchaseHandler(event) {
		
		const checkedBox = document.querySelectorAll('input[each="each"]:checked')
		checkedBox.forEach(e => e.parentNode.parentNode.querySelector('.items').classList.add('checked'))
		
		const selectedItem = document.querySelector('.items')
		if(selectedItem == null){
			alert('상품을 선택해주세요')
			return
		}else{
			const ob = {}
			let selectedItemAll = null
			if(event.target.classList.contains('toPurchase')){
				console.log('전체')
				selectedItemAll = document.querySelectorAll('.items')
			}else{
				console.log('선택')
				selectedItemAll = document.querySelectorAll('.items.checked')
			}
			console.log('selectedItemAll',selectedItemAll)
			
			const items = []

			for(let i = 0; i < selectedItemAll.length; i++){
				items.push('item'+i)
			}
			let j = 0
				selectedItemAll.forEach(e =>{
					
					const itemName = e.querySelector('input[name="itemName"]').value
					const itemEachPrice = e.querySelector('input[name="itemEachPrice"]').value
					const itemIdx = e.querySelector('input[name="itemIdx"]').value
					const itemOpt = e.querySelector('input[name="itemOpt"]').value
					const itemAmount = e.querySelector('input[name="itemAmount"]').value
					const itemPrice = e.querySelector('input[name="itemPrice"]').value
					
					const form = {}
					const names = ['itemIdx', 'itemName', 'itemOpt', 'itemEachPrice', 'itemAmount', 'itemPrice']
					const datas = [itemIdx, itemName, itemOpt, itemEachPrice, itemAmount, itemPrice]
					console.log('datas: ', datas)
					for(let i = 0; i < datas.length; i++){
						if(i == 0 || i == 3 || i == 4){
							form[names[i]] = +datas[i]
						}else{
							form[names[i]] = datas[i]
						}
					}
					ob[items[j]] = form
					j++
				})
			console.log(ob)
			
			const url = '${cpath}/product/toPurchase'
			const opt ={
					method:'POST',
					body:JSON.stringify(ob),
					headers: {
						'Content-Type': 'application/json; charset=utf-8'
					}
			}
					
			fetch(url,opt)
			.then(resp => resp.text())
			.then(text => {
				if(text == 1){
					location.href='${cpath}/product/purchase'
				}
			})
		}
	}
</script>


</body>
</html>