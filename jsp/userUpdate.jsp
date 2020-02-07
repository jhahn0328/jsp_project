<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">

<title>회원정보수정</title>
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
</head>
<body>
<%
	//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	} 
	//로그인 안한 경우
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}
	User user=new UserDAO().getUser(userID);
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
                <li ><a href="bbs.jsp">게시판</a></li>
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
    <!-- 로긴폼 -->
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<!-- 점보트론 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- 로그인 정보를 숨기면서 전송post -->
				<form method="post" action="userUpdateAction.jsp">
					<h3 style="text-align: center;">회원정보수정</h3>
					<div class="form-group">
					<div>아이디</div>
					<div><%=user.getUserID() %></div>
					</div>
					<div class="form-group">
					<div>비밀번호</div>
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20" value="<%=user.getUserPassword()%>">
					</div>
					<div class="form-group">
					<div>이름</div>
						<input type="text" class="form-control" placeholder="이름"
							name="userName" maxlength="20" value="<%=user.getUserName()%>">
					</div>
					<div class="form-group">
					<div>이메일(필수x)</div>
						<input type="text" class="form-control" placeholder="이메일"
							name="userEmail" maxlength="50" value="<%=user.getUserEmail()%>">
					</div>
					<input type="submit" class="btn btn-primary form-control"
						value="수정">
				</form>
				<div style="padding-top: 10px;">
				<a class="btn btn-primary form-control" onclick="return confirm('정말로 삭제하시겠습니까?')" href="userdeleteAction.jsp" class="btn btn-primary	">삭제</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 애니매이션 담당 JQUERY -->
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<!-- 부트스트랩 JS  -->
		<script src="js/bootstrap.js"></script>
</body>
</html>