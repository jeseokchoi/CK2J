<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adHeader.jsp" %>
<section>

<div class="box">
	<h2>2023년도 현 매출 현황</h2>
	<div class="onlyFlex">
		<h3 class="count">0</h3><h3>원</h3>
	</div>
</div>
	<div class="saleChart"></div>
</section>


</main>
<script>
	const counter = ($counter, max) => {
	  let now = max;

	  const handle = setInterval(() => {
	    $counter.innerHTML = Math.ceil(max - now).toLocaleString();
	  
	    // 목표수치에 도달하면 정지
	    if (now < 1) {
	      clearInterval(handle);
	    }
	    
	    // 증가되는 값이 계속하여 작아짐
	    const step = now / 3;
	    
	    // 값을 적용시키면서 다음 차례에 영향을 끼침
	    now -= step;
	  }, 50);
	}

	window.onload = () => {
		const url = '${cpath}/admin/getTotal_price'
		fetch(url)
		.then(resp =>resp.text())
		.then(text =>{
			 const $counter = document.querySelector(".count");
			  
			  // 목표 수치
			  const max = +text;
			  counter($counter, max)
		})
	  // 카운트를 적용시킬 요소
	 
	}
</script>
</body>
</html>