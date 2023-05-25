<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//삭제시 필요한 변수: subject_no
	SubjectDao subjectDao = new SubjectDao();
	//post방식 인코딩
	request.setCharacterEncoding("utf-8");

	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("subjectNo") + " <--removeSubjectAction param subjectNo");

	//요청값 유효성 검사: null이거나 공백이면 subjectList로 리다이렉션
	String msg = null;
	if(request.getParameter("subjectNo") == null || request.getParameter("subjectNo").equals("")){
			msg = URLEncoder.encode("삭제할 과목을 알 수 없습니다", "utf-8");
			response.sendRedirect(request.getContextPath()+"/subject/modifySubject.jsp?msg="+msg);
			return;
	}
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	int row = subjectDao.deleteSubject(subjectNo);
	
	//삭제 종료시 subjectList로 리다이렉션
	if(row == 1){ //수정 성공시
		msg = URLEncoder.encode("과목이 삭제되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
	} else { //수정 실패시
		msg = URLEncoder.encode("과목이 삭제에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
	}
%>
