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
		msg = URLEncoder.encode("과목을 알 수 없습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
		return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	Subject subject = subjectDao.selectSubjectOne(subjectNo); //과목 데이터를 조회하는 메서드
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>subject one</title>
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

	<!-- 과목상세 -->
	<h1>과목 상세내용</h1>
	<table class="table">
		<tr>
			<th>과목번호</th>
			<td><%=subject.getSubjectNo()%></td>
		</tr>
		<tr>
			<th>과목이름</th>
			<td><%=subject.getSubjectName()%></td>
		</tr>
		<tr>
			<th>과목시수</th>
			<td><%=subject.getSubjectTime()%></td>
		</tr>
		<tr>
			<th>수정일</th>
			<td><%=subject.getUpdatedate()%></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%=subject.getCreatedate()%></td>
		</tr>
	</table>
		
	<!-- 수정, 삭제 버튼 -->
	<a class="btn btn-primary" href="<%=request.getContextPath()%>/subject/modifySubject.jsp?subjectNo=<%=subject.getSubjectNo()%>">수정</a>
	<a class="btn btn-primary" href="<%=request.getContextPath()%>/subject/removeSubjectAction.jsp?subjectNo=<%=subject.getSubjectNo()%>">삭제</a>
</div>
</body>
</html>