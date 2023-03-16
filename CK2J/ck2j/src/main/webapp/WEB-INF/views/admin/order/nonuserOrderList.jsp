<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<link type="text/css" rel="stylesheet" href="${cpath }/resources/css/CH/nonuserOrderList.css">

<section>
<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">주문 상세 내역</h1>
      </div>
      <div class="modal-body">
      	<div class="modal-bodyDetail">
      
      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="box">
	<div class="title">
		비회원 주문목록
	</div>
	<div style="display: flex;justify-content: space-between;">
		<div class="onlyFlex">
		<p>
			<select name="searchCategory">
				<option value="">===카테고리===</option>
				<option>주문 번호</option>
				<option>제품</option>
				<option>수령자명</option>
				<option>주문처리현황</option>
			</select>
			<input type="text" name="keyword" class="hidden">
			<span>
				<select name="statusForSearch" class="hidden">
					<option value="all">===전체===</option>
					<option>신규주문</option>
					<option>주문확인중</option>
					<option>배송준비중</option>
					<option>발송처리</option>
					<option>배송중</option>
					<option>배송완료</option>
					<option>변경있음</option>
				</select>
			</span>
			<span>
				<button class="reloadBtn hidden" onclick="location.reload()">전체목록</button>
			</span>
		</p>
			<a href="${cpath }/admin/productList" style="margin-left: 5px">${empty allList ? '' :'전체목록' }</a>
		</div>
		<div style="display:flex; align-items:flex-end; font-size: 10px; margin-right:30px; ">
			* 제품 칸 클릭 시 상세페이지가 보입니다.
		</div>
	</div>
</div>

<div class="box itemBox">
	<div class="userOrderItems">
		<div class="item itemHeader">
			<div class="nonuser_order_idx">주문번호<span class="arrow"></span></div>
			<div class="receiver_name">수령자명<span class="arrow"></span></div>
			<div class="product_name">제품<span class="arrow"></span></div>
			<div class="order_total_price">금액<span class="arrow"></span></div>
			<div class="order_date">주문날짜<span class="arrow"></span></div>
			<div class="product_status">주문처리현황<span class="arrow"></span></div>
			<div class="deleteOrderDiv">주문취소<span class="arrow"></span></div>
		</div>
		<c:forEach var="dto" items="${list}">
			<div class="item" idx="${dto.nonuser_order_idx }">
				<div class="nonuser_order_idx">${dto.nonuser_order_idx}</div>
				<div class="receiver_name">${dto.receiver_name}</div>
				<div class="product_name">${dto.product_name}[${dto.product_total_count }]</div>
				<div class="order_total_price">￦ <fmt:formatNumber>${dto.order_total_price}</fmt:formatNumber></div>
				<div class="order_date">${dto.order_date}</div>
				<div class="order_status">
					<select name="order_status">
						<option ${dto.status_for_admin == '신규주문' ? 'selected' : '' }>신규주문</option>
						<option ${dto.status_for_admin == '주문확인중' ? 'selected' : '' }>주문확인중</option>
						<option ${dto.status_for_admin == '배송준비중' ? 'selected' : '' }>배송준비중</option>
						<option ${dto.status_for_admin == '발송처리' ? 'selected' : '' }>발송처리</option>
						<option ${dto.status_for_admin == '배송중' ? 'selected' : '' }>배송중</option>
						<option ${dto.status_for_admin == '배송완료' ? 'selected' : '' }>배송완료</option>
						<option ${dto.status_for_admin == '변경있음' ? 'selected' : '' }>변경있음</option>
					</select>
					<button id="status_submit" class="hidden">수정</button>
				</div>
				<div class="deleteOrderDiv">
					<button class="deleteBtn" idx="${dto.nonuser_order_idx }">삭제</button>
				</div>
			</div>
		</c:forEach>
	</div>
	<button type="button" class="btn btn-primary hidden" data-bs-toggle="modal" data-bs-target="#exampleModal"></button>
</div>
</section>
</main>

<script src="${cpath }/resources/js/functionCH.js"></script>
<script>
	const itemList = document.querySelectorAll('div.item > .product_name')		// 경로변경함
	itemList.forEach(e => {
		e.onclick = showUserOrderDetailNonuser
	})
	
	const status_for_admin = document.querySelectorAll('div.item > .order_status > select')
	status_for_admin.forEach(e => {
		e.onchange = statusFormHandler
	})

// 02.28	
	const orderselect = document.querySelectorAll('div.item > .order_status > #status_submit')
	orderselect.forEach(e => {
		e.onclick = nonuserOrderModify			// status_submit 버튼을 눌렀을때 밑의 펑션이 작동한다
	})
			
	const deleteBtn = document.querySelectorAll('.deleteOrderDiv > .deleteBtn')
	console.log(deleteBtn)
	deleteBtn.forEach(e => e.onclick = deletingNonuserOrder)
	
	const searchCategory = document.querySelector('select[name="searchCategory"]')
	const searchProductName = document.querySelector('input[name="keyword"]')
	const statusForSearch = document.querySelector('select[name="statusForSearch"]')
	const reloadBtn = document.querySelector('button.reloadBtn')
	console.log(searchProductName)
	searchProductName.onkeyup = searchingProductNonuser
	statusForSearch.onchange = searchingProductByStatus
	
	searchCategory.onchange = (event) => {
		if(event.target.value != '주문처리현황'){
			statusForSearch.classList.add('hidden')
			searchProductName.classList.remove('hidden')
			reloadBtn.classList.remove('hidden')
			searchProductName.value = ''
		}else {
			searchProductName.classList.add('hidden')
			statusForSearch.classList.remove('hidden')
			reloadBtn.classList.add('hidden')
		}
	}
		
	
</script>

</body>
</html>