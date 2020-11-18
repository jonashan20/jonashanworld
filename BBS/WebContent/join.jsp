<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html"; charset="EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale="1"> <%-- 기본적으로 부트스트랩은 컴퓨터 핸드폰 어떤것으로 접속하든 깔쌈하게 변경되는 템플릿 반응형 메타택을 설정 --%>
<link rel="stylesheet" href="css/bootstrap.css"> <%-- 스타일시트를 참조하겠다고 선언 /css의 폴더 안에 bootstrap.css를 사용하여 기본적인  디자인으로사용하겠다고 선언  --%>
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
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
				<li><a href="bbs.jsp">게시판</a></li> <%-- 게시판.jsp로 이동하게 해주는 링크넣어준다  --%>
			</ul> 
			<ul class="nav navbar-nav navbar-right"> <%-- 오른쪽에 넣을 navbar를 만듬 --%>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a> <%-- span 태그는 하나의 아이콘 같은것 --%>
					<ul class="dropdown-menu"> 
						<li class="active"><a href="login.jsp">로그인</a></li> <%-- 하나의 원소를 넣어주는데 class="active"는 선택이 되었을때를 말함 --%>
						<li><a href="join.jsp">회원가입</a><li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container"> <%-- 회원가입 양식 만들기 /컨테이너처럼 감싼다. --%>
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;"> 
				<form method="post" action="joinAction.jsp"> <%-- form 회원가입과 로그인 같이 정보를 숨기면서 보낼때 사용함 / action=joinAction.jsp 이란 페이지로  로그인 정보주겠단 의미 --%>
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20"> <%-- placeholder 어떠한것도 입력되지 않았을때 보여지게 해주는것 / name으로 독자적인 아이디를 지정해주고 / maxlength 글자는 20으로 지정 --%>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
						<div class="form-group" style="text-align: center;"> <%-- 스타일의 text-align으로 센터로 정렬함 --%>
							<div class="btn-group" data-toggle="buttons">
								<lable class="btn btn-primary active">  <%-- 기본적으로 active는 선택이 되있는 상태 --%>
									<input type="radio" name="userGender" autocomplete="off" value="남자"	 checked >남자					
								</lable>
								<lable class="btn btn-primary">
									<input type="radio" name="userGender" autocomplete="off" value="여자"	  >여자				
								</lable>
							</div>
						</div>
						<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
						</div>
					<input type="submit" class="btn-primary form-control" value="회원가입">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script><%-- 애니메이션을 담당할 jquery를 참조 --%>
	<script src="js/bootstrap.js"></script><%-- js폴더아래 bootstrap.js를 참조 --%>
</body>
</html>