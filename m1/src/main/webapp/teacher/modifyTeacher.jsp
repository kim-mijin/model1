<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//1.컨트롤러계층
	TeacherDao tDao = new TeacherDao();
	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("teacherNo") + " <--modifyTeacher param teacherNo");

	//요청값 유효성검사: teacherNo(int) 공백이거나 null이면 subjectList로 리다이렉션
	String msg = null;
	if(request.getParameter("teacherNo") == null || request.getParameter("teacherNo").equals("")){
		msg = URLEncoder.encode("수정할 강사를 알 수 없습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
		return;
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	Teacher teacher = tDao.selectTeacherOne(teacherNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modify teacher</title>
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
	
	<h1>과목 수정하기</h1>
	
	<!-- 리다이렉션 메시지 -->
	<%
		if(request.getParameter("msg") != null){
	%>
			<div class="alert alert-primary"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	
	<!-- 수정폼 -->
	<form action="<%=request.getContextPath()%>/teacher/modifyTeacherAction.jsp" method="post">
		<table class="table">
			<tr>
				<th>강사번호</th>
				<td><input type="number" value="<%=teacher.getTeacherNo()%>" name="teacherNo" readonly></td>
			</tr>
			<tr>
				<th>강사ID</th>
				<td><input type="text" value="<%=teacher.getTeacherId()%>" name="teacherId"></td>
			</tr>
			<tr>
				<th>강사이름</th>
				<td><input type="text" value="<%=teacher.getTeacherName()%>" name="teacherName"></td>
			</tr>
			<tr>
				<th>강사경력</th>
				<td><textarea name="teacherHistory" rows="10" cols="20"><%=teacher.getTeacherHistory()%></textarea></td>
			</tr>
			<tr>
				<th>수정일</th>
				<td><input type="text" value="<%=teacher.getUpdatedate()%>" name="updatedate" readonly></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><input type="text" value="<%=teacher.getCreatedate()%>" name="createdate" readonly></td>
			</tr>
		</table>
		<button class="btn btn-primary" type="submit">수정하기</button>
	</form>
</div>
</body>
</html>