<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 로그인</title>
</head>
<body>
<form method="post" action="loginAction.jsp">
<div class="form-group">
     <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
</div>
<div class="form-group">
     <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
</div>
<input type="submit" class="btn btn-primary form-control" value="로그인">
</form>
</body>
</html>