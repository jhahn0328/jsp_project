<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
			<script>
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+"seoul&units=metric"+"&appid="+"80f06e79bafdd4b9ff2c1ca407186c88";
			$.ajax({
   	 		url: apiURI,
    		dataType: "json",
    		type: "GET",
    		async: "false",
    		success: function(resp) {	
    		var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
        	// 아이콘 표시
        	$('#weather').attr("src", imgURL);
        	$('#temp').append(resp.main.temp+"도");
    		}
		})
		</script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<meta charset="utf-8"/>
	<title>우리회사 맛집</title>
</head>
<body>
<%
			//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
			String userID = null;
			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
			}
%>
<!-- 네비게이션  -->
		<nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">통합게시판</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li ><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">게시판</a></li>
                <li class="active"><a href="map.jsp">맛집</a></li>
            </ul>
            <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
           		<li><img src="" id="weather"></li>
    			<li><a href="weather.jsp"><div id=temp></div></a></li>
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %>
            <ul class="nav navbar-nav navbar-right">
            	<li><img src="" id="weather"></li>
    			<li><a href="weather.jsp"><div id=temp></div></a></li>
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                    	<%if(userID!="kakao사용자"){ %>
                    	<li><a href="userUpdate.jsp">정보수정</a></li>
                    	<%} %>
                    	<%if(userID.equals("super")){ %>
                    	<li><a href="user_management.jsp">사용자 관리</a></li>
                    	<%} %>
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
            <%
                }
            %>
        </div>
    </nav>
	 <div class="container">
        <div class="jumbotron">	
        	<div class="container">
        	<h1>회사 맛집</h1>
			<div id="map" style="width:100%;height:350px;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=bab08db733a142be539b68943636fc15&libraries=services"></script>
			<script>
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  
			var map = new kakao.maps.Map(mapContainer, mapOption);
			
			var ps = new kakao.maps.services.Places(); 

			// 키워드로 장소를 검색합니다
			ps.keywordSearch('동대문역사문화공원역 음식점', placesSearchCB); 

			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB (data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {

			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        var bounds = new kakao.maps.LatLngBounds();

			        for (var i=0; i<data.length; i++) {
			            displayMarker(data[i]);    
			            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			        }       

			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			        map.setBounds(bounds);
			    } 
			}

			// 지도에 마커를 표시하는 함수입니다
			function displayMarker(place) {
			    
			    // 마커를 생성하고 지도에 표시합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: new kakao.maps.LatLng(place.y, place.x) 
			    });

			    // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
			        infowindow.open(map, marker);
			    });
			}
			</script>
			</div>
		</div>
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>