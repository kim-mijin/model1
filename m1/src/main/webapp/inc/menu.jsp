<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>menu</title>
</head>
<body>
	<nav>
		<ul class="nav">
			<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/subject/subjectList.jsp">과목목록</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp">강사목록</a>
			</li>
		</ul>
	</nav>
</body>
</html>