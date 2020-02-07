<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- userdao의 클래스 가져옴 -->
<%@ page import="user.User" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<%@ page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사용자관리</title>
<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>
<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">사용자 아이디</th>
						<th style="background-color: #eeeeee; text-align: center;">사용자 이름</th>
						<th style="background-color: #eeeeee; text-align: center;">사용자 성별</th>
						<th style="background-color: #eeeeee; text-align: center;">사용자 이메일</th>
						<th style="background-color: #eeeeee; text-align: center;">삭제 여부</th>
					</tr>
				</thead>
				<tbody>
					<%
						UserDAO UserDAO = new UserDAO();
						ArrayList<User> list = UserDAO.getList();
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getUserName()%></td>
						<td><%=list.get(i).getUserGender()%></td>
						<td><%=list.get(i).getUserEmail()%></td>
						<td><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="admin_userdeleteAction.jsp?UserID=<%=list.get(i).getUserID()%>" class="btn btn-primary	">삭제</a></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>