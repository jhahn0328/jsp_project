<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>통합게시판</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
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
	int pageNumber = 1; //기본 페이지 넘버
	//페이지넘버값이 있을때
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
       	<li class="active"><a href="bbs.jsp">게시판</a></li>
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
<!-- 게시판 -->
<div class="container">
	<div class="row">
		<table class="table table-striped"
			style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				</tr>
			</thead>
			<tbody>
				<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i).getBbsID()%></td>
					<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>
					<td><%=list.get(i).getUserID()%></td>
					<td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
					+ list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
			<!-- 페이지 넘기기 -->
			<%
				if (pageNumber != 1) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
				if (bbsDAO.nextPage(pageNumber)) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<!-- 회원만넘어가도록 -->
			<%
				//if logined userID라는 변수에 해당 아이디가 담기고 if not null
				if (session.getAttribute("userID") != null) {
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<%
				} else {
			%>
			<button class="btn btn-primary pull-right"
				onclick="if(confirm('로그인 하세요'))location.href='login.jsp';"
				type="button">글쓰기</button>
			<%
				}
			%>
		</div>
	</div>

	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>