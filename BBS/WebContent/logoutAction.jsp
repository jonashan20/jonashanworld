<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="EUC-KR">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<% 
		session.invalidate(); // 현재 이페이지에 접속한 회원이 세션을 빼앗기도록 해서 로그아웃 시킴
	%>
	<script>	
		location.href = 'main.jsp'; // 링크를 걸어서 main.jsp 이동하게 함
	</script> 
</body>
</html>