<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adHeader.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<main>
<section>
<div class="box">
	<div class="title">
		매출통계
	</div>
</div>
<div class="box">
	<select id="SaleCategory">
		<option value="">===선택해주세요===</option>
		<option value="recentWeek">최근 일주일 매출</option>
		<option value="recentMonth">일별 매출</option>
		<option value="monthly">월별 매출</option>
		<option value="yearly">연도별 매출</option>
	</select>
</div>
<div class="box">
	<div id="sales" style="width: 60%; margin: auto;">
		<canvas id="myChart"></canvas>
	</div>
</div>
</section>
</main>
<script src="${cpath }/resources/js/functionCH.js"></script>
<script>
	var myChart
	const saleCategory = document.querySelector('select#SaleCategory')
	saleCategory.onchange = chartLoadHandler
	
</script>

</body>
</html>