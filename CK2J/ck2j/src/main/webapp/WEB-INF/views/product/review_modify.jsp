<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="${cpath }/resources/css/JH/review_write.css">

<main>
	<section>
		<div id="review_write">
			<div class="review_write_head">
				<h1>REVIEW</h1>
				<h4>고객님의 사용 후기를 남겨 주세요 어떤 점이 좋으셨나요~?</h4>
			</div>
			
			<div class="review_write_body">
				<form method="POST">
				<input type="hidden" name="product_idx" value="${dto.product_idx }">
					<div class="rating_box">
				        <div class="rating">
				          	★★★★★
				          <span class="rating_star" style="width:${dto.rate * 20}%;">★★★★★</span>
				          <input type="range" name ="rate" value="${dto.rate }" step="1" min="1" max="5">
				        </div>
				      </div>
					<p>
						<textarea name="content" rows="20" cols="70">${dto.content }</textarea>
					</p>
					<p>
						<a class="review_write_cancel" href="${cpath }/user/userOrder">취소</a><input class="review_write_submit" type="submit" value="등록">
					</p>
				</form>
			</div>
		</div>
	</section>
</main>

     <script>
        const rating_input = document.querySelector('.rating input');
        const rating_star = document.querySelector('.rating_star');
        console.log(rating_star)
        rating_input.addEventListener('input', () => {
// 		const size = rating_input.value * 20%
        rating_star.style.width = (rating_input.value * 20) + '%'
        console.log(rating_input.value)
        });        
      </script>

</body>
</html>