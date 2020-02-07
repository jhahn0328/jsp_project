<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="user.User"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	//sresponse.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
<%

		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		User user=new UserDAO().getUser(userID);
		if (request.getParameter("userPassword") == null || request.getParameter("userName") == null
				|| request.getParameter("userPassword").equals("") || request.getParameter("userName").equals("") ) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO UserDAO=new UserDAO();
			int result=UserDAO.update(userID,request.getParameter("userPassword"),request.getParameter("userName"),request.getParameter("userEmail"));
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('수정에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='main.jsp'");
				//script.println("history.back()");
				script.println("</script>");
			}
		}
%>
</body>
</html>