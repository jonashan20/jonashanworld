<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter" %> <%-- 스크립트 문장을 실행활수 있도록 import 한다 라이브러리를 불러올수 있도록 --%>
<%@ page import="bbs.BbsDAO" %> <%-- 스크립트 문장을 실행활수 있도록 import 한다 라이브러리를 불러올수 있도록 --%>
<%@ page import="bbs.Bbs" %> <%-- 스크립트 문장을 실행활수 있도록 import 한다 라이브러리를 불러올수 있도록 --%>
<%@ page import="java.util.ArrayList" %> <%-- 스크립트 문장을 실행활수 있도록 import 한다 라이브러리를 불러올수 있도록 --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale="1"> <%-- 기본적으로 부트스트랩은 컴퓨터 핸드폰 어떤것으로 접속하든 깔쌈하게 변경되는 템플릿 반응형 메타택을 설정 --%>
<link rel="stylesheet" href="css/bootstrap.css"> <%-- 스타일시트를 참조하겠다고 선언 /css의 폴더 안에 bootstrap.css를 사용하여 기본적인  디자인으로사용하겠다고 선언  --%>
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if ( session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>


	<nav class="navbar navbar-default"> <%-- 웹사이트의 전반적인 구성을 보여주는 네비게이션 생성 --%>
		<div class="navbar-header"> <%-- 홈페이지의 로고를 담는 영역 --%>
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span><%-- 하나가 버튼의 짝대기를 지칭 --%>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a><%-- 로고를 말함 --%>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav"> <%-- 하나의 리스트를 보여줄때 사용 --%>
				<li><a href="main.jsp">메인</a></li> <%-- 메인.jsp로 이동하게 해주는 링크넣어준다  --%>
				<li class="active"><a href="bbs.jsp">게시판</a></li> <%-- 현재의 페이지를 알려줄수 있는 active  --%>
			</ul> 
			<%
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right"> <%-- 오른쪽에 넣을 navbar를 만듬 --%>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a> <%-- span 태그는 하나의 아이콘 같은것 --%>
					<ul class="dropdown-menu"> 
						<li><a href="login.jsp">로그인</a></li> <%-- 하나의 원소를 넣어주는데 class="active"는 선택이 되었을때를 말함 --%>
						<li><a href="join.jsp">회원가입</a><li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right"> <%-- 오른쪽에 넣을 navbar를 만듬 --%>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a> <%-- span 태그는 하나의 아이콘 같은것 --%>
					<ul class="dropdown-menu"> 
						<li><a href="logoutAction.jsp">로그아웃</a></li> <%-- 하나의 원소를 넣어주는데 class="active"는 선택이 되었을때를 말함 --%>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
	<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
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
					for(int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%= list.get(i).getBbsID() %></td>
					<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) +"시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
				</tr>
				<% 
					}
				%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-lef">이전</a>
			<% 
				} if(bbsDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-lef">다음</a>
			<%		
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script><%-- 애니메이션을 담당할 jquery를 참조 --%>
	<script src="js/bootstrap.js"></script><%-- js폴더아래 bootstrap.js를 참조 --%>
</body>
</html>