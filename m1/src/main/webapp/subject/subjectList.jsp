<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	//컨트롤러 계층: 요청값 currentPage(int), rowPerPage(int)
	//요청값 유효성검사: 요청값이 null이 아니면 해당 값을 변수에 저장하고 아니면 null이거나 공백이면 초기값
	int currentPage = 1;
	int rowPerPage = 10;
	if(request.getParameter("currentPage") != null && request.getParameter("rowPerPage") != null
			&& !request.getParameter("currentPage").equals("") && !request.getParameter("rowPerPage").equals("")){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	//디버깅
	System.out.println(currentPage + " <--subjectList currentPage");
	System.out.println(rowPerPage + " <--subjectList rowPerPage");
	
	int beginRow = (currentPage-1)*rowPerPage;
	SubjectDao subjectDao = new SubjectDao();
	ArrayList<Subject> list = subjectDao.selectSubjectListByPage(beginRow, rowPerPage);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>subject list</title>
</head>
<body>
	<h1>과목목록</h1>
	<!-- 과목목록보기 -->
	<div>
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp">과목목록보기</a>
	</div>
	
	<!-- 리다이렉션 메시지 -->
	<%
		if(request.getParameter("msg") != null){
	%>
			<%=request.getParameter("msg")%>
	<%
		}
	%>
	
	<!----------------------------------------과목 목록 시작------------------------------------------------>
	<!-- rowPerPage 선택 -->
	<div>
	<form action="<%=request.getContextPath()%>/subject/subjectList.jsp">
		<select><!-- 선택사항에 따라 select 속성 주기 -->
			<%
				if(rowPerPage == 10){
			%>
					<option value="" disabled>==선택==</option>
					<option value="10" selected>10</option>
					<option value="30">30</option>
					<option value="50">50</option>
			<%
				}
				if(rowPerPage == 30){
			%>
					<option value="" disabled>==선택==</option>
					<option value="10">10</option>
					<option value="30" selected>30</option>
					<option value="50">50</option>
			<%
				}
				if(rowPerPage == 50){
			%>
					<option value="" disabled>==선택==</option>
					<option value="10">10</option>
					<option value="30">30</option>
					<option value="50" selected>50</option>
			<%
				}
			%>	
		</select>
		<button type="submit">확인</button>
	</form>
	</div>
	
	<!-- 과목추가 버튼 -->
	<div>
		<a href="<%=request.getContextPath()%>/subject/addSubject.jsp">과목추가</a>
	</div>
	
	<!-- 과목목록 -->
	<div>
	<table>
		<tr>
			<th>번호</th>
			<th>과목</th>
			<th>시수</th>
			<th>수정일</th>
			<th>작성일</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(Subject s : list){
		%>
				<tr>
					<td><%=(Integer)s.getSubjectNo()%></td>
					<td><%=(String)s.getSubjectName()%></td>
					<td><%=(Integer)s.getSubjectTime()%></td>
					<td><%=(String)s.getUpdatedate()%></td>
					<td><%=(String)s.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/subject/modifySubject.jsp?subjectNo=<%=s.getSubjectNo()%>">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/subject/removeSubjectAction.jsp?subjectNo=<%=s.getSubjectNo()%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
	</div>
	
	<!-- 페이지네이션 -->
	<div>
	
	</div>
	<!----------------------------------------과목 목록 끝------------------------------------------------>
</body>
</html>