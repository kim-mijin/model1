<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add subject</title>
</head>
<body>
	<h1>과목목록</h1>
	<!-- 과목목록보기 -->
	<div>
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp">과목목록보기</a>
	</div>
	
	<h1>과목 추가하기</h1>
	<!-- 리다이렉션 메시지 -->
	<%
		if(request.getParameter("msg") != null){
	%>
			<%=request.getParameter("msg")%>
	<%
		}
	%>
	<div>
	<form action="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
		<table>
			<tr>
				<th>과목</th>
				<td><input type="text" name="subjectName"></td>
			</tr>
			<tr>
				<th>시수</th>
				<td><input type="number" name="subjectTime" min="0"></td>
			</tr>
		</table>
		<button type="submit">추가하기</button>
	</form>
	</div>
</body>
</html>