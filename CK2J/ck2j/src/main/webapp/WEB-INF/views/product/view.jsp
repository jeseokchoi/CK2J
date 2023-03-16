<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet"
	href="${cpath }/resources/css/newSpring/footer.css" type="text/css" />

<!-- =============================0222================================================================== -->
<script src="${cpath }/resources/js/functionJH.js"></script>
<link rel="stylesheet" href="${cpath }/resources/css/JH/review.css">
<script>
const product_idx = '${dto.product_idx}'
const login_user ='${user.user_id}'

</script>

<!-- 0217 -->
<main>
<section id="viewItem">

	<div class="viewItemInfo">
		<div class="viewItemThumbnail">
			<ul class="small_t_img">
				<c:forEach var="t_img" items="${dto.product_t_img }">
					<li><img class="vit" src="${cpath}/itemImg/${t_img}"
						height="110px" width="90px"></li>
				</c:forEach>
			</ul>
		</div>
		<div class="viewItemMainThumbnail">
			<img src="${cpath}/itemImg/${dto.product_t_img[0]}">
		</div>

		<div id="viewItemDetails">
			<div id="viewItemName">
				<h2 style="font-size: 25px;">${dto.product_name }</h2>
			</div>
			<table class="viewItemTable first">
				<tr>
					<td>판매가</td>
					<td style="font-size: 15px; font-weight: bold;">KRW <fmt:formatNumber>${dto.product_price }</fmt:formatNumber></td>
				</tr>
				<tr>
					<td>SHARE</td>
					<td><a href="https://twitter.com/"> <img
							src="${cpath }/resources/img/twitter.gif" height="20px">
					</a> <a href="https://ko-kr.facebook.com/"> <img
							src="${cpath }/resources/img/facebook.gif" height="20px">
					</a></td>
				</tr>
			</table>

			<form>
				<table class="viewItemTable">
					<tr>
						<td>색상</td>
						<td><select name="product_color" style="height: 28px;">
								<option value="">-[필수]옵션을 선택해주세요-</option>
								<c:forEach var="color" items="${colors }">
									<option>${color }</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td>사이즈</td>
						<td><select name="product_size" style="height: 28px;">
								<option>-[필수]옵션을 선택해주세요-</option>
						</select></td>
					</tr>

				</table>
			</form>

			<!-- 옵션 선택된 아이탬 정보 출력 -->
			<div class="buy">
				<input type="hidden" name="product_idx" value="${dto.product_idx }">
			</div>
			<!-- 옵션선택 완료된 아이탬 총 금액 출력 -->
			<div class="buyPrice"></div>
			<div class="viewBox"></div>
			<div class="btnSubmit">
				<div class="toPurchase">구매하기</div>
				<div class="toBasket">장바구니</div>
			</div>
		</div>
	</div>
	<div class="productViewBody">
		<div class="productViewBodyHeader">
			<div class="bodyHeadMenu">
				<div class="bodyHeadMenu1 real">상품정보</div>
				<div class="bodyHeadMenu2">배송/반품/교환</div>
				<div class="bodyHeadMenu3">상품후기</div>
			</div>
			<hr>
		</div>
		<c:forEach var="d_img" items="${dto.product_d_img }">
			<img src="${cpath}/itemImg/${d_img}" width="1000px">
		</c:forEach>
		<div class="productViewBodyHeader">
			<div class="bodyHeadMenu">
				<div class="bodyHeadMenu1">상품정보</div>
				<div class="bodyHeadMenu2 real">배송/반품/교환</div>
				<div class="bodyHeadMenu3">상품후기</div>
			</div>
			<hr>
		</div>
		<div class="bsPrdinfoWrap"
			style="width: 100%; background-color: #fcfcfc; padding: 30px 0; font-size: 14px; color: #888; line-height: 25px; letter-spacing: 0.03em;">
			<div class="cont">
				<h3>상품결제정보</h3>
				고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.&nbsp;
				<div>
					확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는
					취소할 수 있습니다. &nbsp; <br> <br> 무통장 입금은 상품 구매 대금은 PC뱅킹,
					인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다. &nbsp;<br> 주문시
					입력한&nbsp;입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일(영업일 기준) 이내로 입금을 하셔야
					하며&nbsp;입금되지 않은 주문은 자동취소 됩니다. <br>
				</div>
			</div>
			<div class="cont">
				<h3>배송정보</h3>
				<ul class="delivery" style="padding-left: 0;">
					<li>배송 방법 : 택배</li>
					<li>배송 지역 : 전국지역</li>
					<li>배송 비용 : KRW 3,000</li>
					<li>배송 기간 : 3일 ~ 5일</li>
					<li>배송 안내 :
						<div>
							- 쇼핀은 <strong>고객 주문>상품 입고>검수 후 발송 시스템</strong>으로 <strong>익일발송</strong>
							운영되고 있습니다.
						</div>
						<div>(배송이 조금 늦더라도 꼼꼼히 검수하여 보내드리는 것을 원칙으로 하고 있습니다.)</div>
						<div>
							- 당일 <strong>오후 4시</strong> 입금 확인 된 주문건까지만 접수되어 익일발송하고 있습니다.
						</div>
						<div>(오후 6시 이후 주문건은 다음날 주문건에 포함되어 다다음날 발송됩니다.)</div>
						<div>
							-<span style="font-size: 9pt;"> 기본배송료는 <strong>3,000원</strong>
								이며 70,000원 이상 구매시 무료배송입니다.
							</span>
						</div>
						<div>
							- 평균 배송일은 <strong>결제일 기준 3~5일 이내에 발송</strong>됩니다. (주말,공휴일 제외)
						</div>
						<div>- 택배사는 한진택배(1588-0011)를 이용하고 있습니다.</div>
						<div>- 주문하신 상품은 입금 확인순으로 순차배송되므로 준비기간이 소요되는점 양해 부탁드립니다.</div>
						<div>- 주문하신 상품이 발송된 경우 주문취소 또는 변경이 불가합니다.</div>
						<div>- 제주도/도서산간 지역은 3,000원 배송비가 추가됩니다.</div>
						<div>(도서산간 지역마다 배송비 차이가 있습니다.)</div>
						<div>- 주소가 정확하지 않거나 연락이 되지않아 반송되는 경우 택배비용은 고객부담으로 처리되니 주문시
							정확한 주소와 연락처를 입력해주세요.</div>
						<div>
							<br>
						</div>
					</li>
				</ul>
			</div>
			<div class="cont">
				<h3>교환 및 반품정보</h3>
				<div>
					<div>
						<div>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">교환 및 반품 상품은 상품을 수령하신
										날로부터 7일 이내에 상품 보내주셔야 교환 및 반품이 가능합니다.</span></span></span>
						</div>
						<div>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 한진택배(1588-0011) 반품교환신청
										후 착불로 접수 후 반송</span></span></span>
						</div>
					</div>
					<div>
						<span style="color: red;"><span
							style="color: rgb(70, 70, 70);"><span
								style="color: rgb(99, 99, 99);">- 반품 배송비는 환불금액에서 차감 후
									환불처리 됩니다.</span></span></span>
					</div>
					<div>
						<span style="color: red;"><span
							style="color: rgb(70, 70, 70);"><span
								style="color: rgb(99, 99, 99);">- 변심 교환시에는 왕복 배송비 6,000원
									입금 해주시기 바랍니다.</span></span></span>
					</div>
					<div>&nbsp; 계좌번호 / 기업은행 063-080907-01019 송진우</div>
					<div>
						<br>
						<span style="color: red;"><span
							style="color: rgb(70, 70, 70);"><span
								style="color: rgb(99, 99, 99);">※ 변심으로 인한 교환, 반품시 발생하는
									배송비는 고객님께서 부담해 주셔야 합니다.</span></span></span><br>
						<span style="color: red;"><span
							style="color: rgb(70, 70, 70);"><span
								style="color: rgb(99, 99, 99);"> &nbsp; (색상 교환, 사이즈 교환 등
									포함)</span></span></span>
					</div>
					<div>
						<br>
					</div>
					<div>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">[교환∙반품시 유의사항]</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<br>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 상품을 인도 받은 날로부터 7일 이내에
										당해 계약에 관한 청약철회가 가능합니다.</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 단순 변심 교환,반품은 1회에 한해서
										처리가 가능합니다.</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 상품에 하자가 있는 경우에는 그 사실을
										안 날 또는 알 수 있었던 날부터 30일 이내에 청약 철회를 할 수 있습니다.</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 교환시, 교환 상품이 도착 한 후에
										상품을 배송 해 드립니다.</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 반품시, 반품 상품이 도착 한 후에
										결제가 취소 됩니다.﻿</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 배송비는 반품 및 교환시 반송 택배를
										보내시는 횟수 만큼 각각 부과됩니다. 즉, 택배 운송장 1건당 배송비 1건 발생합니다.</span></span></span>
						</p>
						<span style="color: red;"><span
							style="color: rgb(70, 70, 70);"><span
								style="color: rgb(99, 99, 99);">- 세트상품으로 구매하고 부분 반품시
									단품가격으로 적용되어 처리됩니다.</span></span></span><br>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<br>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">단, 다음의 경우에는 교환∙반품 가능기간에도
										불구하고 거절될 수 있습니다.</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 반품/교환 가능 기간 초과</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 상품 사용시 상품 설명에 기재된 주의
										사항을 지키지 않은 경우</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 구매자 부주의로 인해 상품의 가치를
										훼손한 경우 (화장품, 향수, 담배, 음식물 등으로 인한 오염)</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- 착용의 흔적으로 상품의 가치가 떨어진
										경우</span></span></span>
						</p>
						<p
							style='color: rgb(53, 53, 53); font-family: "Gill Sans W01 Medium", AppleGothic, sans-serif;'>
							<span style="color: red;"><span
								style="color: rgb(70, 70, 70);"><span
									style="color: rgb(99, 99, 99);">- '전자상거래 등에서의 소비자보호에 관한
										법률'이 정하는 청약철회 제한사유에 해당되는 경우 (예, 고의적 훼손)</span></span></span>
						</p>
					</div>
					<span style="color: red;"><span
						style="color: rgb(70, 70, 70);"><span
							style="color: rgb(99, 99, 99);"><span
								style="color: rgb(125, 125, 125);"><span
									style="color: rgb(99, 99, 99);"></span></span></span></span></span><span
						style="color: rgb(99, 99, 99);"></span><span
						style="color: rgb(125, 125, 125);"><span
						style="color: rgb(99, 99, 99);"></span></span><span
						style="color: rgb(99, 99, 99);"></span>
				</div>
			</div>
			<div class="cont bsDisplayNone">
				<h3>서비스문의</h3>
				<p>
					<span style="color: rgb(255, 0, 0);"><span
						style="color: rgb(0, 0, 0);">MODEL 남</span></span><span
						data-sheets-userformat="{&quot;2&quot;:14851,&quot;3&quot;:{&quot;1&quot;:0},&quot;4&quot;:{&quot;1&quot;:2,&quot;2&quot;:16777215},&quot;12&quot;:0,&quot;14&quot;:{&quot;1&quot;:2,&quot;2&quot;:0},&quot;15&quot;:&quot;Gulim, 굴림, Arial, Tahoma, AppleGothic, sans-serif&quot;,&quot;16&quot;:9}"
						data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;(182/66)&quot;}"
						style="font-size: 9pt; font-family: Gulim;">(182/66)</span><span
						style="font-size: 9pt;">&nbsp;-&nbsp;M</span><span
						style="font-size: 9pt; color: rgb(255, 0, 0);"><span
						style="color: rgb(0, 0, 0);">&nbsp;</span></span><span
						style="font-size: 9pt;">사이즈 착용</span>
				</p>
				<p>
					<span style="color: rgb(255, 0, 0);"><span
						style="color: rgb(0, 0, 0);">MODEL 여</span></span><span
						data-sheets-userformat="{&quot;2&quot;:14851,&quot;3&quot;:{&quot;1&quot;:0},&quot;4&quot;:{&quot;1&quot;:2,&quot;2&quot;:16777215},&quot;12&quot;:0,&quot;14&quot;:{&quot;1&quot;:2,&quot;2&quot;:0},&quot;15&quot;:&quot;Gulim, 굴림, Arial, Tahoma, AppleGothic, sans-serif&quot;,&quot;16&quot;:9}"
						data-sheets-value="{&quot;1&quot;:2,&quot;2&quot;:&quot;(182/66)&quot;}"
						style="font-size: 9pt; font-family: Gulim;">(170/50)</span><span
						style="font-size: 9pt;">&nbsp;- XS</span><span
						style="font-size: 9pt; color: rgb(255, 0, 0);"><span
						style="color: rgb(0, 0, 0);">&nbsp;</span></span><span
						style="font-size: 9pt;">사이즈 착용</span>
				</p>
			</div>
		</div>

		<div class="productViewBodyHeader">
			<div class="bodyHeadMenu">
				<div class="bodyHeadMenu1">상품정보</div>
				<div class="bodyHeadMenu2">배송/반품/교환</div>
				<div class="bodyHeadMenu3 real">상품후기</div>
			</div>
			<hr>
		</div>
		<div>상품후기</div>
			<!-- ================================ 0223 ========================================================================= -->
			<div id="review" style="margin-bottom: 500px;">
				고객리뷰
				<hr>
			</div>
	</div>

	<%@ include file="../footer.jsp"%>
</section>
</main>

<script>
	const color = document.querySelector('select[name="product_color"]')
	const size = document.querySelector('select[name="product_size"]')
	const buy = document.querySelector('div.buy')
	
	function optCheck(event){
		if(color != ""){
			const url = '${cpath}/board/optCheck/' + '${dto.product_idx}/'+color.value
			console.log(url)
			fetch(url)
			.then(resp => resp.json())
			.then(json => {
				
				size.innerHTML = '<option value="0" required>-[필수]옵션을 선택해주세요-</option>'
				
				json.forEach(e => {
					if(e.product_stock == 0){
						size.innerHTML += '<option disabled>' + e.product_size + '  [품절]</option>'
					}
					else{
						size.innerHTML += '<option>' + e.product_size + '</option>'
					}
				})
			})
		}
	}
	
	color.onchange = optCheck
	
	function buyCheck(event){
		let flag = 0
		if(event.target.value != 0 && color.value != null){
			const dupCheckOpt = color.value + '/' + event.target.value
			if(document.querySelector('div.buy').querySelectorAll('div.itemOpt') != null){
				document.querySelector('div.buy').querySelectorAll('div.itemOpt').forEach(e => {
					if(e.innerText == dupCheckOpt){
						alert('아래 리스트에서 이미 선택된 옵션을 삭제 후 다시 선택해 주세요.')
						flag = 1
						return
					}
				})
				
			}
			if(flag != 1){
				const selectedItem = document.createElement('div')
				const productPrice = +${dto.product_price}
				selectedItem.className = 'selectedItem'
				let html = '<div class="itemName" name="itemName">' + '${dto.product_name}' + '</div>'
				html += '<div class="itemOpt" name="itemOpt">'+ color.value + '/' + size.value + '</div>'
				html += '<input type="number" name="amount" value="1" min="1" required>'
				html += '<div class="totalPrice" name="totalPrice">' + productPrice.toLocaleString() + '</div>'
				html += '<div><button class="cancelProductBtn">X</button></div>'
				selectedItem.innerHTML = html
				buy.appendChild(selectedItem)
				insertAllTotalPrice()
				
				
				const itemOptAmount = document.querySelectorAll('div.selectedItem input')
				
				itemOptAmount.forEach(e => e.onchange = function(event) {
					const value = event.target.value
					const totalPrice = event.target.parentNode.querySelector('div.totalPrice')
					
// 					const price = +document.querySelector('#viewItem > div:nth-child(3)').innerText
					const priceInput = +${dto.product_price} * value
					totalPrice.innerText = priceInput.toLocaleString()
					
					const total = document.querySelector('span.total')
					console.log('total : ', total)
					total.innerHTML = '<strong>' + totalCalc() + '</strong>'
					
					const inTtotalPrice = document.querySelector('div.ttotalPrice')
					inTtotalPrice.appendChild(total)
					
					
					
				})
				
				const cancelProductBtn = document.querySelectorAll('button.cancelProductBtn')
				cancelProductBtn.forEach(e => e.onclick = itemDel)
			}
		}
	}
	
	function insertAllTotalPrice(){
		const ttotalPrice = document.createElement('div')
		ttotalPrice.className = 'ttotalPrice'
		let ttHtml = '		<strong>TOTAL : KRW </strong>'
		ttHtml += '		<span class="total">'
		ttHtml += '			<strong>' + totalCalc() + '</strong>'
		ttHtml += '		</span>'
		ttotalPrice.innerHTML = ttHtml
		const buyPrice = document.querySelector('div.buyPrice')
		buyPrice.innerHTML = ''
		buyPrice.appendChild(ttotalPrice)
	}
	function itemDel(event) {
		const sltItem = event.target.parentNode.parentNode
		console.log('sltItem = ', sltItem)
		sltItem.remove()
		insertAllTotalPrice()
	}
	function totalCalc() {
		const num = document.querySelectorAll('div.totalPrice')
		let sum = 0;
		if(num == null){
			return +${dto.product_price}
		}
		else{
			num.forEach(e => {
				const ee =e.innerText.replace(',','') 
				sum += +ee
		})
				return sum.toLocaleString()
		}
	}

	size.onchange = buyCheck
	
</script>

<script>
	const viewItemMainThumbnail = document.querySelector('div.viewItemMainThumbnail')
	const vitList = document.querySelectorAll('img.vit')
	
	function changeMainImg(event) {
		console.log(event.target)
		viewItemMainThumbnail.innerHTML = '<img src="' + event.target.getAttribute('src') + '">'
	}
	vitList.forEach(e => e.onmouseover = changeMainImg)
	
</script>

<script>

document.querySelectorAll('div.productViewBody > div.productViewBodyHeader > div.bodyHeadMenu > div').forEach(e => e.onclick = function(event){
	if(event.target.classList.contains('bodyHeadMenu1')){
		console.log('1이동')
		document.querySelector('.bodyHeadMenu1.real').scrollIntoView()
	}
	if(event.target.classList.contains('bodyHeadMenu2')){
		console.log('2이동')
		document.querySelector('.bodyHeadMenu2.real').scrollIntoView()
	}
	if(event.target.classList.contains('bodyHeadMenu3')){
		console.log('3이동')
		document.querySelector('.bodyHeadMenu3.real').scrollIntoView()
	}
	
})
</script>
<script>
	const toPurchaseBtn = document.querySelector('div.btnSubmit > div.toPurchase')
	toPurchaseBtn.onclick = toPurchaseHandler
	function toPurchaseHandler() {
		const selectedItem = document.querySelector('.selectedItem')
		if(selectedItem == null){
			alert('상품을 선택해주세요')
			return
		}else{
			const ob = {}
			const selectedItemAll = document.querySelectorAll('.selectedItem')
			const itemName = selectedItemAll[0].querySelector('.itemName').innerText
			const itemEachPrice = +${dto.product_price}
			const items = []

			for(let i = 0; i < selectedItemAll.length; i++){
				items.push('item'+i)
			}
			let j = 0
				selectedItemAll.forEach(e =>{
					const itemIdx = document.querySelector('div.buy input[name="product_idx"]').value
					const itemOpt = e.querySelector('.itemOpt').innerText
					const itemAmount = e.querySelector('input[name="amount"]').value
					let itemPrice = e.querySelector('.totalPrice').innerText
					itemPrice = itemPrice.replace(',','')
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

<script>
	const toCartBtn = document.querySelector('div.btnSubmit > div.toBasket')
	toCartBtn.onclick = toCartHandler
	function toCartHandler() {
		const selectedItem = document.querySelector('.selectedItem')
		if(selectedItem == null){
			alert('상품을 선택해주세요')
			return
		}else{
			const ob = {}
			const selectedItemAll = document.querySelectorAll('.selectedItem')
			const itemName = selectedItemAll[0].querySelector('.itemName').innerText
			const itemEachPrice = +${dto.product_price}
			const items = []

			for(let i = 0; i < selectedItemAll.length; i++){
				items.push('item'+i)
			}
			let j = 0
				selectedItemAll.forEach(e =>{
					const itemIdx = document.querySelector('div.buy input[name="product_idx"]').value
					const itemOpt = e.querySelector('.itemOpt').innerText
					const itemAmount = e.querySelector('input[name="amount"]').value
					let itemPrice = e.querySelector('.totalPrice').innerText
					itemPrice = itemPrice.replace(',','')
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
			
			
			const url = '${cpath}/product/toBasket'
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
				console.log(text)
				if(text != 0){
					const flag = confirm('장바구니에 담겼습니다. 장바구니로 이동하시겠습니까?')
					if(flag){
						location.href='${cpath}/product/cart/${user.user_id}'
					}else{
						location.reload()
					}
				}
			})
		}
	}
</script>

<script>
	document.body.onload = replyLoadHandler
</script>

<script>
	
</script>

</body>
</html>