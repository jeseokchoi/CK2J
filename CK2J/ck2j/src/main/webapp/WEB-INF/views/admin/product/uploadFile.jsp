<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<section>
	<div class="box">
		<div class="title">
			상품등록
		</div>
	</div>
	<div class="box">
		<div>
			<form method="POST" enctype="multipart/form-data">
				<select name="product_code">
					<option value="">====카테고리====</option>
					<option value="w_outer">여자/아우터</option>
					<option value="w_shirts">여자/셔츠</option>
					<option value="w_top">여자/상의</option>
					<option value="w_bottom">여자/하의</option>
					<option value="w_knit">여자/니트</option>
					<option value="m_suit">남자/수트</option>
					<option value="m_outer">남자/아우터</option>
					<option value="m_top">남자/상의</option>
					<option value="m_pants">남자/하의</option>
					<option value="m_knit">남자/니트</option>
					<option value="m_shirts">남자/셔츠</option>
					<option value="m_shoes">신발</option>
				</select>
				<p><input type="text" name="product_name" placeholder="제품이름"></p>
				<p><input type="text" name="sizeOptForUpload" placeholder="사이즈(ex.S/M/L/XL)"></p>
				<p><input type="text" name="colorOptForUpload" placeholder="색상(ex.블랙/아이보리/레드)"></p>
				<p><input type="number" name="product_price" placeholder="가격"></p>
				<p>
					썸네일이미지
					<input type="file" name="upload_t_file" multiple>
				</p>
				<p>
					상세이미지
					<input type="file" name="upload_d_file" multiple>
				</p>
				<p><input type="submit" value="등록"></p>
			</form>
		</div>
	</div>
</section>
</main>

</body>
</html>