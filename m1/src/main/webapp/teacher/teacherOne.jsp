<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//1.컨트롤러계층
	TeacherDao tDao = new TeacherDao();
	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("teacherNo") + " <--teacherOne param teacherNo");

	//요청값 유효성검사: teacherNo(int) 공백이거나 null이면 teacherList로 리다이렉션
	String msg = null;
	if(request.getParameter("teacherNo") == null || request.getParameter("teacherNo").equals("")){
		msg = URLEncoder.encode("강사번호를 알 수 없습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
		return;
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	Teacher teacher = tDao.selectTeacherOne(teacherNo); //강사 데이터를 조회하는 메서드
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>teacher one</title>
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
	
	<!-- -------------------------------------------강사목록시작----------------------------------------- -->
	<h1>강사 상세정보</h1>
	
	<!-- 리다이렉션 메시지 -->
	<%
		if(request.getParameter("msg") != null){
	%>
			<div class="alert alert-primary"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	
	<!-- 상세내용보기 -->
	<div>
	<table class="table table-bordered">
		<tr>
			<th>강사번호</th>
			<td><%=teacher.getTeacherNo()%></td>
		</tr>
		<tr>
			<th>강사ID</th>
			<td><%=teacher.getTeacherId()%></td>
		</tr>
		<tr>
			<th>강사이름</th>
			<td><%=teacher.getTeacherName()%></td>
		</tr>
		<tr>
			<th>강사경력</th>
			<td><%=teacher.getTeacherHistory()%></td>
		</tr>
		<tr>
			<th>수정일</th>
			<td><%=teacher.getUpdatedate()%></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%=teacher.getCreatedate()%></td>
		</tr>
	</table>
	</div>
	
	<!-- 수정, 삭제버튼 -->
	<a class="btn btn-primary" href="<%=request.getContextPath()%>/teacher/modifyTeacher.jsp?teacherNo=<%=teacherNo%>">수정</a>
	<a class="btn btn-primary" href="<%=request.getContextPath()%>/teacher/removeTeacherAction.jsp?teacherNo=<%=teacherNo%>">삭제</a>
</div>
</body>
</html>