<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<main>
<section>
	<div id="categoryName"><h2>주문서 작성</h2></div>
	<form method="POST">
	<table id="purchaseProductList">
		<thead>
			<tr>
				<th><input type="checkbox" name="multi" value=""></th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>배송구분</th>
				<th>배송비</th>
				<th>합계</th>
			</tr>	
		</thead>
		
		<tbody>
		<c:forEach var="dto" items="${list }">
			<tr>
				<td><input type="checkbox" each="each" name="${dto.itemIdx}_${dto.itemOpt }" value="${dto.itemIdx }_${dto.itemOpt }"></td>
				<td><img border="1px solid black" width="100px" height="100px" src="${cpath}/itemImg/${dto.product_t_img}"></td>
				<td>
					<strong>${dto.itemName }</strong><br>
					[${dto.itemOpt }]
				</td>
				<td><fmt:formatNumber>${dto.itemEachPrice }</fmt:formatNumber></td>
				<td>${dto.itemAmount }</td>
				<td>기본배송</td>
				<td>무료</td>
				<td class="itemPrice">￦ <fmt:formatNumber> ${dto.itemPrice }</fmt:formatNumber></td>
			</tr>
			</c:forEach>
			<tr>
			<td class="purchaseTotalPrice" colspan="8" style="text-align: right; padding-right: 20px; border-top: 1px solid #dadada">
				
			</td>
			</tr>
		</tbody>
	</table>
	<div style="width: 90%; margin: auto;">
		<input type="submit" value="삭제하기">
	</div>
</form>
</section>

<!-- 회원주문 -->
<c:if test="${not empty user}">
<form method="POST" action="${cpath }/product/purchasingUser">
<input type="hidden" name="user_id" value="${user.user_id }">
<input type="hidden" name="order_total_price" value="">
<section class="userPurchase">
	<table id="purchaseDelivery">
		<tr>
			<th>배송지 선택</th>
			<td>
				<label><input type="radio" name="address" flag="1" checked>회원 정보와 동일</label>
				<label><input type="radio" name="address" flag="0">새로운 배송지</label>
			</td>
		</tr>
		<tr>
			<th>받으시는 분</th>
			<td><input type="text" class="erase" name="receiver_name" value="${user.user_name }" required></td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<input class="erase" type="text" id="sample6_postcode" name="address1"value="${user.user_address1 }" placeholder="우편번호" required>
			    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			    <input class="erase" type="text" id="sample6_address" required name="address2" placeholder="주소" value="${user.user_address2 }" style="width: 300px"><br>
			    <input class="erase" type="text" id="sample6_detailAddress" required name="address3" placeholder="상세주소" value="${user.user_address3 }" style="width: 300px">
			</td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td><input type="text" value="${user.user_phone }" name="receiver_phone" class="erase" required placeholder="ex)010-0000-0000" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" value="${email1 }" name="email1" class="erase" >@<input type="text" name="email2" value="${email2 }" class="erase" >
			<select id="email2Auto">
				<option>naver.com</option>
				<option>daum.net</option>
				<option>nate.com</option>
				<option>hotmail.com</option>
				<option>yahoo.com</option>
				<option>empas.com</option>
				<option>korea.com</option>
				<option>dreamwiz.com</option>
				<option>gmail.com</option>
				<option value="etc" selected>직접입력</option>
			</select>
			</td>
		</tr>
		<tr>
			<th>배송메세지</th>
			<td><textarea style="width: 300px; height:50px; resize: none;"></textarea></td>
		</tr>
	</table>
</section>
<section class="nonouserPurchase">
</section>
<section class="payment">
	<div>
		<div>
			<div>
				<label><input type="radio" name="paymentMethod" value="무통장 입금" checked>무통장 입금</label>
				<label><input type="radio" name="paymentMethod" value="신용카드결제">신용카드 결제</label>
				<label><input type="radio" name="paymentMethod"	value="휴대폰결제">휴대폰결제</label>
			</div>
			<div>
				<table id="purchaseDelivery">
					<tr>
						<th>입금자명</th>
						<td><input type="text" name="DepositName" required></td>
					</tr>
					<tr>
						<th>입금은행</th>
						<td><select name="adminBankAccount" required>
							<option value="평양은행:001-12345-678910">:::선택해 주세요:::</option>
							<option>평양은행:001-12345-678910</option>
						</select></td>
					</tr>
				</table>
			</div>
			<div>
				<div>현금영수증 신청</div>
				<div>
					<label><input type="radio" name="cashReceipt" value="1">현금영수증 신청</label>
					<label><input type="radio" name="cashReceipt" checked value="0">신청안함</label>
				</div>
				<div><input type="text" class="hidden" id="cash"></div>
			</div>
		</div>
		<div>
		
			<div>무통장입금 최종결제 금액</div>
			<div class="finalPaymentPrice"></div>
			<div><input type="submit" value="결제하기" id="purchasingBtn"></div>
			<div></div>
		</div>
	</div>
	
</section>
	</form>
</c:if>


<!-- 비회원주문 -->
<c:if test="${empty user}">
<form method="POST" action="${cpath }/product/purchasingNonuser">
<input type="hidden" name="order_total_price" value="">
<section class="userPurchase">
	<table id="purchaseDelivery">
		<tr>
			<th>받으시는 분</th>
			<td><input type="text" class="erase" name="receiver_name" required></td>
		</tr>
		<tr>
			<th>주문 비밀번호</th>
			<td><input type="password" class="erase" name="nonuser_pwd"  required></td>
		</tr>
		<tr>
			<th>주소</th>
			<td>
				<input class="erase" type="text" id="sample6_postcode" name="address1"value="${user.user_address1 }" placeholder="우편번호" required>
			    <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" ><br>
			    <input class="erase" type="text" id="sample6_address" name="address2" required placeholder="주소" value="${user.user_address2 }" style="width: 300px"><br>
			    <input class="erase" type="text" id="sample6_detailAddress" name="address3" required placeholder="상세주소" value="${user.user_address3 }" style="width: 300px">
			</td>
		</tr>
		<tr>
			<th>휴대전화</th>
			<td><input type="text" name="receiver_phone" class="erase" placeholder="ex)010-0000-0000" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" maxlength="13"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email1" class="erase" required>@<input type="text" name="email2" class="erase" required>
			<select id="email2Auto">
				<option>naver.com</option>
				<option>daum.net</option>
				<option>nate.com</option>
				<option>hotmail.com</option>
				<option>yahoo.com</option>
				<option>empas.com</option>
				<option>korea.com</option>
				<option>dreamwiz.com</option>
				<option>gmail.com</option>
				<option value="etc" selected>직접입력</option>
			</select>
			</td>
		</tr>
		<tr>
			<th>배송메세지</th>
			<td><textarea style="width: 300px; height:50px; resize: none;"></textarea></td>
		</tr>
	</table>
</section>
<section class="nonouserPurchase">
</section>
<section class="payment">
	<div>
		<div>
			<div>
				<label><input type="radio" name="paymentMethod" value="무통장 입금" checked>무통장 입금</label>
				<label><input type="radio" name="paymentMethod" value="신용카드결제">신용카드 결제</label>
				<label><input type="radio" name="paymentMethod"	value="휴대폰결제">휴대폰결제</label>
			</div>
			<div>
				<table id="purchaseDelivery">
					<tr>
						<th>입금자명</th>
						<td><input type="text" name="DepositName" required></td>
					</tr>
					<tr>
						<th>입금은행</th>
						<td><select name="adminBankAccount" required>
							<option value="평양은행:001-12345-678910" >:::선택해 주세요:::</option>
							<option>평양은행:001-12345-678910</option>
						</select></td>
					</tr>
				</table>
			</div>
			<div>
				<div>현금영수증 신청</div>
				<div>
					<label><input type="radio" name="cashReceipt" value="1">현금영수증 신청</label>
					<label><input type="radio" name="cashReceipt" value="0" checked>신청안함</label>
				</div>
				<div><input type="text" class="hidden" id="cash"></div>
			</div>
		</div>
		<div>
		
			<div>무통장입금 최종결제 금액</div>
			<div class="finalPaymentPrice"></div>
			<div><input type="submit" value="결제하기" id="purchasingBtn"></div>
			<div></div>
		</div>
	</div>
	
</section>
	</form>
</c:if>
<section>
	   <div class="Information_Use">
         <div class="Information_titel">이용안내</div>   
<div class="Information_content">         
WindowXP 서비스팩2를 설치하신후 결제가 정상적인 단계로 처리되지 않는경우, 아래의 절차에 따라 해결하시기 바랍니다.<br>
안심클릭 결제모듈이 설치되지 않은 경우 ActiveX 수동설치<br>
Service Pack 2에 대한 Microsoft사의 상세안내<br>
아래의 쇼핑몰일 경우에는 모든 브라우저 사용이 가능합니다.<br>

KG이니시스, KCP, LG U+를 사용하는 쇼핑몰일 경우<br>
결제가능브라우저 : 크롬,파이어폭스,사파리,오페라 브라우저에서 결제 가능<br>
(단, window os 사용자에 한하며 리눅스/mac os 사용자는 사용불가)<br>
최초 결제 시도시에는 플러그인을 추가 설치 후 반드시 브라우저 종료 후 재시작해야만 결제가 가능합니다.<br>
(무통장, 휴대폰결제 포함)<br>
세금계산서 발행 안내<br>
부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.<br>
세금계산서는 사업자만 신청하실 수 있습니다.<br>
배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.<br>
[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.<br>
[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.<br>
부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경안내<br>
변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며<br>
신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)<br>
상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.<br>
현금영수증 이용안내<br>
현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.<br>
현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.<br>
발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.<br>
현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)<br>
현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.<br>
   </div>
   </div>
</section>
</main>

<script>
	const tdPurchaseTotalPrice = document.querySelector('td.purchaseTotalPrice')
	const tdItemPriceList = document.querySelectorAll('td.itemPrice')
	const inputTotalPrice = document.querySelector('input[name="order_total_price"]')
	function removeComma(data) {
		data = data.replace('￦ ','')
		data = data.replace(',', '')
		return data
	}
	let totalPrice = 0
	tdItemPriceList.forEach(e => {
		e = removeComma(e.innerText)
		totalPrice += +e
	})
	inputTotalPrice.value = totalPrice
	tdPurchaseTotalPrice.innerText = '합계: ' + totalPrice.toLocaleString() + '원'
	const finalPaymentPrice = document.querySelector('div.finalPaymentPrice')
	finalPaymentPrice.innerText = totalPrice.toLocaleString()
	
</script>

<script>
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
	
	const addressBtn = document.querySelectorAll('input[name="address"]')

	
	const email2Auto = document.querySelector('select#email2Auto')
	email2Auto.onchange = (event) => {
		const eValue = event.target.value
		const email2  = document.querySelector('input[name="email2"]')
		if(eValue != 'etc'){
			email2.value = eValue
		}else{
			email2.value = ''
			email2.focus()
		}
	}
	
	const cash = document.querySelector('input[id="cash"]')
	const cashReceipt = document.querySelectorAll('input[name="cashReceipt"]')
	cashReceipt.forEach(e => e.onchange = cashReceiptHandler)
	
	function cashReceiptHandler(event) {
		if(event.target.value == 1) {
			cash.classList.remove('hidden')
		}else{
			cash.classList.add('hidden')
		}
	}
	
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                   
            
                } 

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<script>
	const eraseAll = document.querySelectorAll('input.erase')
	const eraseBtn = document.querySelector('input[flag="0"]')
	const restoreBtn = document.querySelector('input[flag="1"]')
	restoreBtn.onclick = () => {
		document.querySelector('input[name="receiver_name"]').value = '${user.user_name }'
		document.querySelector('input[name="address1"]').value = '${user.user_address1 }'
		document.querySelector('input[name="address2"]').value = '${user.user_address2 }'
		document.querySelector('input[name="address3"]').value = '${user.user_address3 }'
		document.querySelector('input[name="receiver_phone"]').value = '${user.user_phone }'
		document.querySelector('input[name="email1"]').value = '${email1 }'
		document.querySelector('input[name="email2"]').value = '${email2 }'
	}
	eraseBtn.onclick = () => {
		eraseAll.forEach(e => {
			e.value = ''
		})
	}
</script>

<script>
	abc = document.querySelectorAll('input[type="checkbox"]')
	abc.forEach(e => console.log(e.value))
</script>
<script>
// 	const form0 = document.forms[0]
// 	form0.onsubmit = (event) => {
// 		console.log('dd')
// 		event.preventDefault()
		
// 		const url = '${cpath}/product/purchasing'
// 		fetch(url)
// 		.then(resp => resp.text())
// 		.then(text => {
// 			if(text == 1){
// 				location.href='${cpath}/product/purchase'
// 			}
// 		})
// 	}
</script>
<script>
// 	const purchasingBtn = document.querySelector('input.purchasingBtn')
// 	const form1 = document.forms[1]
// 	form1.onsubmit = (event) => {
// 		event.preventDefault()
// 		const url = '${cpath}/product/purchasing'
// 		fetch(url)
// 		.then(resp => resp.text())
// 		.then(text => {
			
// 		})
// 	}
</script>
</body>
</html>