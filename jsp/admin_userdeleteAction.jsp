<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유저 삭제</title>
</head>
<body>
<%
	String userID =request.getParameter("UserID");
	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	UserDAO UserDAO=new UserDAO();
	int result = UserDAO.delete(userID);
	if(result==-1){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('회원 삭제에 실패했습니다.')");
		script.println("history.back()");

		script.println("</script>");

	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='user_management.jsp'");
		script.println("</script>");
}
%>
</body>
</html>