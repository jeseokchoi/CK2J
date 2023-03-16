<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../adHeader.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<link rel="stylesheet" href="${cpath }/resources/css/newSpring/statistics/age.css" type="text/css"/>



</head>
<body>

<section class="doughnutTable">
    <h1>회원 연령대별 통계</h1>
   
  <table>
  	<thead>
  		<tr>
  		<th>연령대별</th>
  		<th>인원</th>
  		</tr>
  	</thead>
  	<tbody>
  	

	  		<c:forEach var="dto" items="${list }">
<%-- 	  		<c:if test="${dto.age == 10 }"> --%>
<!-- 		  		<tr> -->
<%-- 		  			<td class="age_group1">${dto.age }</td> --%>
<%-- 		  			<td class="age_group1_2">${dto.cnt }</td> --%>
<!-- 		  		</tr> -->
<%-- 	  		</c:if> --%>
	  		
	  		
	  		
	  		<c:if test="${dto.age == 20 }">
		  		<tr>
		  			<td class="age_group2">${dto.age }</td>
		  			<td class="age_group2_2">${dto.cnt }</td>
		  		</tr>
	  		</c:if>
	  		
	  			<c:if test="${dto.age == 30 }">
		  		<tr>
		  			<td class="age_group3">${dto.age }</td>
		  			<td class="age_group3_2">${dto.cnt }</td>
		  		</tr>
	  		</c:if>
	  		
	  		
	  		<c:if test="${dto.age == 40 }">
		  		<tr>
		  			<td class="age_group4">${dto.age }</td>
		  			<td class="age_group4_2">${dto.cnt }</td>
		  		</tr>
	  		</c:if>
	  		
	 
	  		
<%-- 	  		<c:if test="${dto.age == 50 }"> --%>
<!-- 		  		<tr> -->
<%-- 		  			<td class="age_group5">${dto.age }</td> --%>
<%-- 		  			<td class="age_group5_2">${dto.cnt }</td> --%>
<!-- 		  		</tr> -->
<%-- 	  		</c:if> --%>
	  		

  		</c:forEach>
  	
  	
  	</tbody>
  
  
  
  </table>



</section>


<!--     <div id="root"> -->
<!--         <canvas id="myChart"></canvas> -->
<!--     </div> -->

<section class="main-section">
		

		<canvas class="chart" id="chart"></canvas>
		
		
	</section>	


<script class="doughnutChart" type="text/javascript">

// const teenager = document.querySelector('.age_group1').innerText 
const twenites = document.querySelector('.age_group2').innerText 
const thirites = document.querySelector('.age_group3').innerText 
const forties = document.querySelector('.age_group4').innerText 
// const fifties = document.querySelector('.age_group5').innerText  

// const age_group1 = document.querySelector('.age_group1').innerText 
const age_group2_2 = document.querySelector('.age_group2_2').innerText 
const age_group3_2 = document.querySelector('.age_group3_2').innerText 
const age_group4_2 = document.querySelector('.age_group4_2').innerText 
// const age_group5_2 = document.querySelector('.age_group5_2').innerText 


console.log(age_group2_2,age_group3_2,age_group4_2)


	const ctx = document.getElementById('chart')
	const data = {
	  labels: [
// 	    '10대',
	    '20대',
	    '30대',
	    '40대',
// 	    '50대',
	 
	  ],
	  datasets: [{
	
	   data:[age_group2_2,age_group3_2,age_group4_2],

	    
	    backgroundColor: [
// 	      '#81F781',
		  '#F7FE2E',
		  '#58FA82',
	      '#FAAC58',
	      '#81F781'
	    
	      
	      
	    ],
	    hoverOffset: 4
	  }]
	};
	const config = {
		  type: 'doughnut',
		  data: data,
	};
	const chart = new Chart(ctx, config)
	
</script>	

</body>
</html>