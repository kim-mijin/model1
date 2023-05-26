<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//요청값(currentPage, rowPerPage)
	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("currentPage") + " <--teacherList param currentPage");
	System.out.println(request.getParameter("rowPerPage") + " <--teacherList param rowPerPage");
	
	int currentPage = 1;
	int rowPerPage = 10;
	if(request.getParameter("currentPage") != null || request.getParameter("rowPerPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	System.out.println(currentPage + " <--teacherList currentPage");
	System.out.println(currentPage + " <--teacherList rowPerPage");
	int beginRow = (currentPage-1)*rowPerPage;
	
	TeacherDao tDao = new TeacherDao();
	ArrayList<HashMap<String, Object>> list = tDao.selectTeacherListByPage(beginRow, rowPerPage); //list불러오는 메서드
	
	//페이지네이션
	//페이징에 필요한 변수: totalRow, lastPage, pagePerPage, startPage, endPage
	int totalRow = tDao.selectTeacherCnt();
	System.out.println(totalRow + " <--teacherList totalRow");
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0){ //총행의 수가 rowPerPage로 나누어 떨어지지 않으면 마지막 페이지는 +1
		lastPage = lastPage + 1;
	}
	System.out.println(lastPage + " <--teacherList lastPage");
	int pagePerPage = 10;
	int startPage = ((currentPage-1)/pagePerPage)*pagePerPage + 1;
	int endPage = startPage + pagePerPage - 1;
	if(endPage > lastPage){
		endPage = lastPage;
	}
	System.out.println(startPage + " <--teacherList startPage");
	System.out.println(endPage + " <--teacherList endPage");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>teacher list</title>
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
	<h1>강사목록</h1>
	
	<!-- 리다이렉션 메시지 -->
	<%
		if(request.getParameter("msg") != null){
	%>
			<div class="alert alert-primary"><%=request.getParameter("msg")%></div>
	<%
		}
	%>
	
	<!-- rowPerPage 선택 -->
	<div class="d-flex flex-row-reverse">
	<div class="p-2">
	<form action="<%=request.getContextPath()%>/teacher/teacherList.jsp">
		<input type="hidden" name="currentPage" value=<%=currentPage%>><!-- 현재페이지값 함께 넘기기 -->
		<select name="rowPerPage"><!-- 선택사항에 따라 select 속성 주기 -->
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
		<button class="btn btn-sm btn-primary" type="submit">확인</button>
	</form>
	</div>
	
	<!-- 강사추가 버튼 -->
	<div class="p-2">
		<a class="btn btn-primary" href="<%=request.getContextPath()%>/teacher/addTeacher.jsp">강사추가</a>
	</div>
	</div>
	
	<!-- 강사목록 -->
	<table class="table table-bordered table-hover">
		<thead>
			<tr>
				<th>강사번호</th>
				<th>강사ID</th>
				<th>강사이름</th>
				<th>담당과목</th>
			</tr>
		</thead>
		<%
			for(HashMap<String, Object> m : list){
		%>
				<tr>
					<td><%=(Integer)m.get("teacherNo")%></td>
					<td><%=(String)m.get("teacherId")%></td>
					<td><!-- 강사상세페이지로 연결 -->
						<a href="<%=request.getContextPath()%>/teacher/teacherOne.jsp?teacherNo=<%=m.get("teacherNo")%>"><%=(String)m.get("teacherName")%></a>
					</td>
					<td><%=(String)m.get("subjectName")%></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이지네이션(처음-이전-현제페이지-다음-마지막) -->
	<div class="d-flex justify-content-center">
	<ul class="pagination">
		<!-- 처음버튼 -->
		<li class="page-item">
			<a class="page-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음</a>
		</li>
		<!-- 이전버튼 -->
		<%
			if(startPage == 1){ //페이지블럭의 startPage가 1이면 비활성화
		%>
				<li class="page-item disabled">
					<a class="page-link" href="#">이전</a>
				</li>
		<%
			} else {
		%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=startPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
				</li>
		<%
			}
		%>
		<!-- 현재페이지버튼 -->
		<%
			for(int i=startPage; i<=endPage; i+=1){ //startPage~endPage까지 페이지번호 출력
				if(i == currentPage){ //현재페이지에서는 표시하기
		%>
					<li class="page-item active">
						<a class="page-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>"><%=i%></a>
					</li>
		<%
				} else {
		%>
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=i%>&rowPerPage=<%=rowPerPage%>"><%=i%></a>
					</li>
		<%
				}
			}
		%>
		
		<!-- 다음버튼 -->
		<%
			if(endPage == lastPage){ //마지막페이지가 있는 페이지블럭에서는 비활성화
		%>
				<li class="page-item disabled">
					<a class="page-link" href="#">다음</a>
				</li>
		<%
			} else {
		%>
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=endPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
				</li>
		<%
			}
		%>
		<!-- 마지막버튼 -->
		<li class="page-item">
			<a class="page-link" href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">마지막</a>
		</li>
	</ul>
	</div>
	<!-- -------------------------------------------강사목록끝----------------------------------------- -->
</div>
</body>
</html>