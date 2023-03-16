<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<section>
	<div class="box">
		<div class="title">
			상품수정
		</div>
	</div>
	<div class="box">
		<div>
			<form method="POST" enctype="multipart/form-data">
				<input type="hidden" name="product_idx" value="${dto.product_idx }">
				<select name="product_code">
					<option value="">====카테고리====</option>
					<option ${dto.product_code == 'w_outer' ? 'selected' : '' } value="w_outer">여자/아우터</option>
					<option ${dto.product_code == 'w_shirts' ? 'selected' : '' } value="w_shirts">여자/셔츠</option>
					<option ${dto.product_code == 'w_top' ? 'selected' : '' } value="w_top">여자/상의</option>
					<option ${dto.product_code == 'w_bottom' ? 'selected' : '' } value="w_bottom">여자/하의</option>
					<option ${dto.product_code == 'w_knit' ? 'selected' : '' } value="w_knit">여자/니트</option>
					<option ${dto.product_code == 'm_suit' ? 'selected' : '' } value="m_suit">남자/수트</option>
					<option ${dto.product_code == 'm_outer' ? 'selected' : '' } value="m_outer">남자/아우터</option>
					<option ${dto.product_code == 'm_top' ? 'selected' : '' } value="m_top">남자/상의</option>
					<option ${dto.product_code == 'm_pants' ? 'selected' : '' } value="m_pants">남자/하의</option>
					<option ${dto.product_code == 'm_knit' ? 'selected' : '' } value="m_knit">남자/니트</option>
					<option ${dto.product_code == 'm_shirts' ? 'selected' : '' } value="m_shirts">남자/셔츠</option>
					<option ${dto.product_code == 'm_shoes' ? 'selected' : '' } value="m_shoes">신발</option>
				</select>
				<p>
				제품이름<br>
					<input type="text" name="product_name" value="${dto.product_name }" placeholder="제품이름">
				</p>
				<p>
				가격<br>
					<input type="number" name="product_price" value="${dto.product_price }" placeholder="가격">
				</p>
				<p>
				사이즈 
					<button id="optStock">옵션별 재고</button>
				<br>
					<input type="text" name="sizeOptForUpload" value="${dto.sizeOptForUpload }">
					<input type="hidden" name="sizeOptForUploadForCompare" value="${dto.sizeOptForUpload }">
				</p>
				<p>
				색상<span style="font-size: 10px; color: red;">* 옵션(사이즈/색상) 수정 시 재고 초기화</span>
				<br>
					<input type="text" name="colorOptForUpload" value="${dto.colorOptForUpload }">
					<input type="hidden" name="colorOptForUploadForCompare" value="${dto.colorOptForUpload }">
				</p>
				<p>
					썸네일이미지
				<br>
					<span id="t_img_files">
					<c:forEach var="img" items="${dto.product_t_img }">
						${img }/
					</c:forEach>
					</span><br>
					<input type="file" name="upload_t_file" multiple>
				</p>
				<p>
					상세이미지
				<br>
					<span id="d_img_files">
					<c:forEach var="img" items="${dto.product_d_img }">
						${img }/
					</c:forEach>
					</span><br>
					<input type="file" name="upload_d_file" multiple>
				</p>
				<input type="hidden" name="t_imgForDelete" value="">
				<input type="hidden" name="d_imgForDelete" value="">
				<p>
					<input type="submit" value="수정">
					<button id="back" onclick="window.history.back()">뒤로가기</button>
				</p>
			</form>
		</div>
	</div>
</section>
</main>

<script>
	const beforeColor = '${dto.sizeOptForUpload}'
	const beforeSize = '${dto.colorOptForUpload }'
	const form = document.forms[0]
	const optStockBtn = document.querySelector('button#optStock')
	optStockBtn.onclick = function(event) {
		event.preventDefault()
		location.href='${cpath }/admin/product/optStock/${dto.product_idx}'
	}
	
	function putImgFileName(event) {
		const t_imgText = document.querySelector('span#t_img_files')
		document.querySelector('input[name="t_imgForDelete"]').value = t_imgText.innerText
		const d_imgText = document.querySelector('span#d_img_files')
		document.querySelector('input[name="d_imgForDelete"]').value = d_imgText.innerText
	}
	window.onload = putImgFileName
	
form.onsubmit = function(event){
		event.preventDefault()
		console.log('여기오나?')
		const flag = confirm('수정하시겠습니까?')
		if(flag){
			form.submit()
		}
	}
// 	document.querySelector('button#back').onclick = function(event) {
// 		event.preventDefault()
// 		window.history.back()
// 	}
	
</script>
</body>
</html>