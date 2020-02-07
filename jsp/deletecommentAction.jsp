<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.commentDAO"%>
<%@ page import="bbs.comment"%>
<!-- bbsdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userID =null;
	if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
	}
	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	int commentID=0;
	if(request.getParameter("commentID")!=null){
		commentID = Integer.parseInt(request.getParameter("commentID"));
	}
	if(commentID==0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	commentDAO commentDAO=new commentDAO();
	int result = commentDAO.delete(commentID);
	if(result==-1){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('댓글 삭제에 실패했습니다.')");
		script.println("history.back()");

		script.println("</script>");

	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='view.jsp?bbsID="+request.getParameter("bbsID")+"'");//추가해야함
		script.println("</script>");
	}
%>
</body>
</html>