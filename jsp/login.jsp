 <%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<title>로그인</title>
</head>
<body>
 <!-- 네비게이션  -->
 <nav class="navbar navbar-default">
  <div class="navbar-header">
   <button type="button" class="navbar-toggle collapsed" 
    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
    aria-expaned="false">
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="main.jsp">통합게시판</a>
  </div>
  <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
   <ul class="nav navbar-nav">
    <li><a href="main.jsp">메인</a></li>
    <li><a href="bbs.jsp">게시판</a></li>
    <li><a href="map.jsp">맛집</a></li>
   </ul>

   <ul class="nav navbar-nav navbar-right">
    <li><img src="" id="weather"></li>
    <li><a href="weather.jsp"><div id=temp></div></a></li>
    <li class="dropdown">
     <a href="#" class="dropdown-toggle"
      data-toggle="dropdown" role="button" aria-haspopup="true"
      aria-expanded="false">접속하기<span class="caret"></span></a>
     <ul class="dropdown-menu">
      <li class="active"><a href="login.jsp">로그인</a></li>
      <li><a href="join.jsp">회원가입</a></li>
     </ul>
    </li>
   </ul>
  </div> 
 </nav>

 <!-- 로긴폼 -->
 <div class="container">
  <div class="col-lg-4"></div>
  <div class="col-lg-4">
  <!-- 점보트론 -->
   <div class="jumbotron" style="padding-top: 20px;">
   <!-- 로그인 정보를 숨기면서 전송post -->
   <form method="post" action="loginAction.jsp">
    <h3 style="text-align: center;"> 로그인화면 </h3>
    <div class="form-group">
     <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
    </div>
    <div class="form-group">
     <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
    </div>
    <input type="submit" class="btn btn-primary form-control" value="로그인">
   </form>
   <div class="jumbotron" style="padding-top: 20px;">
   <a class="img-responsive center-block" id="custom-login-btn" href="javascript:loginWithKakao()">
	<img class="img-responsive center-block" src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
	</a>
	<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('bab08db733a142be539b68943636fc15');
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.loginForm({
        success: function(authObj) {
          location.href = 'kakaologinAction.jsp'
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
    };
  //]]>
</script>
	 </div>
	  <div style="text-align: center;"> <a href="administrator.jsp">관리자 로그인</a> </div>
  </div>
 </div>
</div>
 <!-- 애니매이션 담당 JQUERY -->
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <!-- 부트스트랩 JS  -->
 <script src="js/bootstrap.js"></script>
</body>
</html>