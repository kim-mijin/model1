<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//1.컨트롤러계층
	//수정 전 Subject정보 보여주기
	SubjectDao subjectDao = new SubjectDao();
	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("subjectNo") + " <--modifySubject param subjectNo");

	//요청값 유효성검사: subjectNo(int) 공백이거나 null이면 subjectList로 리다이렉션
	String msg = null;
	if(request.getParameter("subjectNo") == null || request.getParameter("subjectNo").equals("")){
		msg = URLEncoder.encode("수정할 과목을 알 수 없습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	Subject subject = subjectDao.selectSubjectOne(subjectNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modify subject</title>
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
	<form action="<%=request.getContextPath()%>/subject/modifySubjectAction.jsp" method="post">
		<table class="table">
			<tr>
				<th>과목번호</th>
				<td><input type="number" value="<%=subject.getSubjectNo()%>" name="subjectNo" readonly></td>
			</tr>
			<tr>
				<th>과목이름</th>
				<td><input type="text" value="<%=subject.getSubjectName()%>" name="subjectName"></td>
			</tr>
			<tr>
				<th>과목시수</th>
				<td><input type="number" value="<%=subject.getSubjectTime()%>" name="subjectTime" min="0"></td>
			</tr>
			<tr>
				<th>수정일</th>
				<td><input type="text" value="<%=subject.getUpdatedate()%>" name="updatedate" readonly></td>
			</tr>
			<tr>
				<th>등록일</th>
				<td><input type="text" value="<%=subject.getCreatedate()%>" name="createdate" readonly></td>
			</tr>
		</table>
		<button class="btn btn-primary" type="submit">수정하기</button>
	</form>
</div>
</body>
</html>