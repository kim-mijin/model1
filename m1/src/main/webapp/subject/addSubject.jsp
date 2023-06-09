<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>add subject</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
	<!-- 과목목록보기 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<h1>과목 추가하기</h1>

	<!-- 리다이렉션 메시지 -->
	<%
		if(request.getParameter("msg") != null){
	%>
			<div class="alert alert-primary"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	
	<!-- 과목추가폼 -->
	<div>
	<form action="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
		<table class="table">
			<tr>
				<th>과목이름</th>
				<td><input type="text" name="subjectName"></td>
			</tr>
			<tr>
				<th>과목시수</th>
				<td><input type="number" name="subjectTime" min="0"></td>
			</tr>
		</table>
		<button class="btn btn-primary" type="submit">추가하기</button>
	</form>
	</div>
</div>
</body>
</html>