<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<meta charset="utf-8"/>
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
        	$('#img').attr("src", imgURL);
        	$('#weather').attr("src", imgURL);
        	$('#city').append("<h2>"+resp.name+"("+resp.sys.country+")"+"</h2>");
        	$('#main').append("<LI>현재온도 : "+resp.main.temp+"도</LI>"+"<LI>현재습도 : "+resp.main.humidity+"%</LI>"+"<LI>날씨 : "+resp.weather[0].main+"</LI>"
        					+"<LI>바람 : "+resp.wind.speed+"</LI>"+"<LI>구름 : "+(resp.clouds.all)+"%</LI>");
        	$('#temp').append(resp.main.temp+"도");
    		}
		})
		</script>
		<script>
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+"tokyo&units=metric"+"&appid="+"80f06e79bafdd4b9ff2c1ca407186c88";
			$.ajax({
   	 		url: apiURI,
    		dataType: "json",
    		type: "GET",
    		async: "false",
    		success: function(resp) {	
    		var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
        	// 아이콘 표시
        	$('#tokyo_img').attr("src", imgURL);
        	$('#tokyo_city').append("<h2>"+resp.name+"("+resp.sys.country+")"+"</h2>");
        	$('#tokyo_main').append("<LI>현재온도 : "+resp.main.temp+"도</LI>"+"<LI>현재습도 : "+resp.main.humidity+"%</LI>"+"<LI>날씨 : "+resp.weather[0].main+"</LI>"
        					+"<LI>바람 : "+resp.wind.speed+"</LI>"+"<LI>구름 : "+(resp.clouds.all)+"%</LI>");
    		}
		})
		</script>
		<script>
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+"beijing&units=metric"+"&appid="+"80f06e79bafdd4b9ff2c1ca407186c88";
			$.ajax({
   	 		url: apiURI,
    		dataType: "json",
    		type: "GET",
    		async: "false",
    		success: function(resp) {	
    		var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
        	// 아이콘 표시
        	$('#beijing_img').attr("src", imgURL);
        	$('#beijing_city').append("<h2>"+resp.name+"("+resp.sys.country+")"+"</h2>");
        	$('#beijing_main').append("<LI>현재온도 : "+resp.main.temp+"도</LI>"+"<LI>현재습도 : "+resp.main.humidity+"%</LI>"+"<LI>날씨 : "+resp.weather[0].main+"</LI>"
        					+"<LI>바람 : "+resp.wind.speed+"</LI>"+"<LI>구름 : "+(resp.clouds.all)+"%</LI>");
    		}
		})
		</script>
		<script>
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+"new%20york&units=metric"+"&appid="+"80f06e79bafdd4b9ff2c1ca407186c88";
			$.ajax({
   	 		url: apiURI,
    		dataType: "json",
    		type: "GET",
    		async: "false",
    		success: function(resp) {	
    		var imgURL = "http://openweathermap.org/img/w/" + resp.weather[0].icon + ".png";
        	// 아이콘 표시
        	$('#new_york_img').attr("src", imgURL);
        	$('#new_york_city').append("<h2>"+resp.name+"("+resp.sys.country+")"+"</h2>");
        	$('#new_york_main').append("<LI>현재온도 : "+resp.main.temp+"도</LI>"+"<LI>현재습도 : "+resp.main.humidity+"%</LI>"+"<LI>날씨 : "+resp.weather[0].main+"</LI>"
        					+"<LI>바람 : "+resp.wind.speed+"</LI>"+"<LI>구름 : "+(resp.clouds.all)+"%</LI>");
    		}
		})
		</script>
	<title>오늘의 날씨</title>
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
                <li><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">게시판</a></li>
                <li><a href="map.jsp">맛집</a></li>
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
        	<h1 class="row text-center" style="width: 100%">오늘의 날씨</h1>
        	
		<div id=city class="row text-center" style="width: 100%"></div>
		<img class="img-responsive center-block" src="" id="img"></img>
		<div id=main class="row text-center" style="width: 100%"></div>
		</div>
	</div>
	<div class="container">
        <div class="jumbotron">	
        	<div class="container">
        	<h1 class="row text-center" style="width: 100%">해외 날씨</h1>
        	
		<div id=tokyo_city class="row text-center" style="width: 100%"></div>
		<img class="img-responsive center-block" src="" id="tokyo_img"></img>
		<div id=tokyo_main class="row text-center" style="width: 100%"></div>
		
		<div id=beijing_city class="row text-center" style="width: 100%"></div>
		<img class="img-responsive center-block" src="" id="beijing_img"></img>
		<div id=beijing_main class="row text-center" style="width: 100%"></div>
		
		<div id=new_york_city class="row text-center" style="width: 100%"></div>
		<img class="img-responsive center-block" src="" id="new_york_img"></img>
		<div id=new_york_main class="row text-center" style="width: 100%"></div>
		</div>
	</div>
</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>