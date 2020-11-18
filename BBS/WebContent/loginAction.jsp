<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %><%-- 자바스크립트 문장을 작성하기 위해 사용 --%> 
<% request.setCharacterEncoding("UTF-8"); %> <%-- 건너오는 모든 데이터를 utf-8로 받을수 있도록함 --%>
<jsp:useBean id="user" class="user.User" scope="page"/> <%-- scope로 페이지 안에서만 beans가 사용되게 설정 --%>
<jsp:setProperty name="user" property="userID" /> <%-- login페이지에서 넘겨준 userID의 값을 받아서 한명의 사용자인 userID에 넣어주는것 --%>
<jsp:setProperty name="user" property="userPassword" />  <%-- login페이지에서 넘겨준 userPassword의 값을 받아서 한명의 사용자인 userPassword에 넣어주는것 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="EUC-KR">
<link rel="stylesheet" href="css/bootstrap.css"> <%-- 스타일시트를 참조하겠다고 선언 /css의 폴더 안에 bootstrap.css를 사용하여 기본적인  디자인으로사용하겠다고 선언  --%>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<% 
		UserDAO userDAO = new UserDAO(); // userdao 라는 하나의 인스턴스를 만들어줌
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); 
		// int result와 login함수를 사용하여  로그인을 시도할수 있게함 getUserID/Password를 사용하여 로그인 페이지 에서 아이디와 패스워드가 각각 입력된 값을 로그인 함수에 넣어서 실행을함
		// 그 값이 int result 에 login 함수에 설정해뒀던 로그인 성공 될때  리턴값 1,2 등등이 넣어지게됨
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if (result == 0) {
		System.out.println(result);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>