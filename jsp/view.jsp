<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.comment"%>
<%@ page import="bbs.commentDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.css">
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
		
<%
	//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
%>
<title><%= bbs.getBbsTitle() %></title>
</head>
<body>
	
	<!-- 네비게이션  -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">통합게시판</a>
		</div>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="map.jsp">맛집</a></li>
			</ul>
			<%
				//라긴안된경우
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><img src="" id="weather"></li>
    			<li><a href="weather.jsp"><div id=temp></div></a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li><img src="" id="weather"></li>
    			<li><a href="weather.jsp"><div id=temp></div></a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<%if(userID!="kakao사용자"){ %>
                    	<li><a href="userUpdate.jsp">정보수정</a></li>
                    	<%} %>
                    	<%if(userID.equals("super")){ %>
                    	<li><a href="user_management.jsp">사용자 관리</a></li>
                    	<%} %>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
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
							<th colspan="3"
								style="background-color: #eeeeee; text-align: center;">글 보기 </th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;"> 글 제목 </td>
							<td colspan="2"><%= bbs.getBbsTitle() %></td>
						</tr>
						<tr>
							<td>작성자</td>	
							<td colspan="2"><%= bbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일</td>	
							<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"
							+ bbs.getBbsDate().substring(14, 16) + "분"%></td>
						</tr>
						<tr>
							<td>내용</td>	
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br/>") %></td>
						</tr>
					</tbody>
				</table>	
				
		<h3>댓글</h3>
		<div class="container">
			<div class="row">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<tbody>
						<%
							commentDAO commentDAO = new commentDAO();
							ArrayList<comment> list = commentDAO.getList(bbsID);
							for (int i = 0; i < list.size(); i++) {
						%>
						<tr>
							<td><%=list.get(i).getUserID()%></td>
							<td><%=list.get(i).getComment_content() %></td>
							<td><%=list.get(i).getCommentDate().substring(0, 11) + list.get(i).getCommentDate().substring(11, 13) + ":"
							+ list.get(i).getCommentDate().substring(14, 16)%></td>
							<%
							if(userID!=null){
								if(userID.equals(list.get(i).getUserID())||userID.equals("super")){
							%>
							<td><a href="deletecommentAction.jsp?commentID=<%=list.get(i).getCommentID()%>&bbsID=<%=bbs.getBbsID()%>">삭제</a></td>
							<%		
								}
							}
							%>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				
			<%
			//if logined userID라는 변수에 해당 아이디가 담기고 if not null
			if (session.getAttribute("userID") != null) {
			%>
			<div class="container">
			<div class="row">
				<form method="post" action="writecommentAction.jsp?bbsID=<%=bbs.getBbsID()%>">
					<table class="table table-striped"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2"
									style="background-color: #eeeeee; text-align: center;">댓글</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="comment_content" maxlength="2048" style="height: 150px;"></textarea></td>
							</tr>
						</tbody>
					</table>	
					<input type="submit" class="btn btn-primary pull-right" value="글쓰기" />
				</form>
			</div>
		</div>
		<%
			}
		%>					
		<a href = "bbs.jsp" class="btn btn-primary">목록</a>
		<%
			if(userID!=null){
			if(userID.equals(bbs.getUserID())||userID.equals("super")){
		%>
		<a href="Update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
		<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary	">삭제</a>
		<%		
				}
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