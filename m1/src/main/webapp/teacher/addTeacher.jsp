<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>add teacher</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
	<!-- 강사목록보기 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<h1>강사 추가하기</h1>
	
	<!-- 리다이렉션 메시지 -->
	<%
		if(request.getParameter("msg") != null){
	%>
			<div class="alert alert-primary"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	
	<!-- 강사추가폼 -->
	<div>
	<form action="<%=request.getContextPath()%>/teacher/addTeacherAction.jsp" method="post">
		<table class="table">
			<tr>
				<th>강사ID</th>
				<td><input type="text" name="teacherId"></td>
			</tr>
			<tr>
				<th>강사이름</th>
				<td><input type="text" name="teacherName"></td>
			</tr>
			<tr>
				<th>강사경력</th>
				<td><textarea name="teacherHistory" rows="10" cols="30"></textarea></td>
			</tr>
		</table>
		<button class="btn btn-primary" type="submit">추가하기</button>
	</form>
	</div>
</div>
</body>
</html>