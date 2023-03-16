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
   	<link rel="stylesheet" href="${cpath }/resources/css/newSpring/statistics/gender.css" type="text/css"/>
	

    
    
</head>
<body>

<section class="doughnutTable">
    <h1>회원 성별 통계</h1>
   
  <table>
  	<thead>
  		<tr>
  		<th>성별</th>
  		<th>인원</th>
  		</tr>
  	</thead>
  	<tbody>
  	
  		<c:forEach var="dto" items="${list }">
	  		
	  		
	  		
	  		<c:if test="${dto.user_gender  == '여성'}">
		  		<tr>
		  			<td>${dto.user_gender }</td>
		  			<td class="WomanCnt">${dto.cnt }</td>
		  		</tr>
	  		</c:if>
	  		
	  		<c:if test="${dto.user_gender  == '남성' }">
	  		<tr>
	  			<td>${dto.user_gender }</td>
	  			<td class="ManCnt">${dto.cnt }</td>
	  		</tr>
	  		</c:if>
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


<script  class="doughnutChart" type="text/javascript">
const Woman = document.querySelector('여성') 
const Man = document.querySelector('남성') 
const WomanCnt = document.querySelector('.WomanCnt').innerText 
const ManCnt = document.querySelector('.ManCnt').innerText 

console.log(WomanCnt,ManCnt)


	const ctx = document.getElementById('chart')
	const data = {
	  labels: [
	    '여성',
	    '남성',
	 
	  ],
	  datasets: [{ 
// 		  label: ['여성'],
// 		  label: ['남성'],
	
	   data:[WomanCnt,ManCnt],

	    
	    backgroundColor: [
	      '#FE2EC8',
	      '#0080FF'
	      
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