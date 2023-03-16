<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>


<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="${cpath }/resources/css/newSpring/map.css" type="text/css"/>
<%-- <script src="${cpath }/resources/js/newSpring/searchList.js"></script> --%>

	<meta charset="utf-8"/>
	<title>Kakao 지도 시작하기</title>
	
	
  
	
</head>
<body>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9fbe4cd09ec5306e4e8c30de94e79d0"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>

	
<!-- 쇼핑몰 회사 주소 -> 	X :127.061594, Y :37.5462159 -->
<div class="homeWindow">
<div class="mapAPI">
	<div class="mapAPI_left">
			
			<a class="mapText1">
				MAP<br>
			</a>
			<br>
			<a class="mapText2">
					04796 서울 특별시 성동구
					아차산로13길 33<br>
					(성수동2가) 협성빌딩 5층  
			</a>
		
		
	</div>

	<div class="mapAPI_right">
	<div id="map" style="width:100%; height:730px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b9fbe4cd09ec5306e4e8c30de94e79d0"></script>
	<script>
		
	var container = document.getElementById('map');

	var options = {
				center: new kakao.maps.LatLng(37.5462159, 127.061594),
				level: 3
			};

	var map = new kakao.maps.Map(container, options);

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(37.5462159, 127.061594); 
	        // 마커를 생성합니다
	        var marker = new kakao.maps.Marker({
	            position: markerPosition
	        });
	        
        // 마커가 지도 위에 표시되도록 설정합니다
         marker.setMap(map);

        // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
        // marker.setMap(null);    


	</script>
</div>

	
</div>	

</div>



<%@ include file="footer.jsp" %>


</body>
</html>
