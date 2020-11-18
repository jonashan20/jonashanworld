<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %><%-- 자바스크립트 문장을 작성하기 위해 사용 --%> 
<% request.setCharacterEncoding("UTF-8"); %> <%-- 건너오는 모든 데이터를 utf-8로 받을수 있도록함 --%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/> <%-- scope로 페이지 안에서만 beans가 사용되게 설정 --%>
<jsp:setProperty name="bbs" property="bbsTitle" /> <%-- join페이지에서 넘겨준 userID의 값을 받아서 한명의 사용자인 userID에 넣어주는것 --%>
<jsp:setProperty name="bbs" property="bbsContent" />  <%-- join페이지에서 넘겨준 userPassword의 값을 받아서 한명의 사용자인 userPassword에 넣어주는것 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="EUC-KR">
<link rel="stylesheet" href="css/bootstrap.css"> <%-- 스타일시트를 참조하겠다고 선언 /css의 폴더 안에 bootstrap.css를 사용하여 기본적인  디자인으로사용하겠다고 선언  --%>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<% 
		String userID = null;
		if (session.getAttribute("userID") != null) { // 현재 세션값이 있다면 
			userID = (String) session.getAttribute("userID");
 		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO(); // userdao 라는 하나의 인스턴스를 만들어줌
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); 
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>