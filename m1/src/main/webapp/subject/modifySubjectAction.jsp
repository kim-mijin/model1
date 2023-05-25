<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//수정시 필요한 변수: Subject객체(no, name, time만)
	SubjectDao subjectDao = new SubjectDao();
	//post방식 인코딩
	request.setCharacterEncoding("utf-8");

	//요청값이 잘 넘어오는지 확인하기(수정할 수 있는 값들 확인)
	System.out.println(request.getParameter("subjectName") + " <--modifySubjectAction param subjectName");
	System.out.println(request.getParameter("subjectTime") + " <--modifySubjectAction param subjectTime");
	//수정할 수 없는 subjectNo는 먼저 변수에 저장하기
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo + " <--modifySubjectAction subjectNo");
	
	//요청값 유효성 검사: null이거나 공백이면 수정폼으로 리다이렉션
	String msg = null;
	if(request.getParameter("subjectName") == null || request.getParameter("subjectTime") == null
			|| request.getParameter("subjectName").equals("") || request.getParameter("subjectTime").equals("")){
			msg = URLEncoder.encode("수정할 과목과 시수를 입력해주세요", "utf-8");
			response.sendRedirect(request.getContextPath()+"/subject/modifySubject.jsp?subjectNo="+subjectNo+"&msg="+msg);
			return;
	}
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	//Subject타입으로 변수들을 묶는다
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	int row = subjectDao.insertSubject(subject);
	
	//수정 종료시 subjectList로 리다이렉션
	if(row == 1){ //수정 성공시
		msg = URLEncoder.encode("과목이 수정되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
	} else { //수정 실패시
		msg = URLEncoder.encode("과목이 수정에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
	}
%>
