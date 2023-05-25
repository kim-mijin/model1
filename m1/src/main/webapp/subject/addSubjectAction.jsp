<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	SubjectDao subjectDao = new SubjectDao();
	//post방식 인코딩
	request.setCharacterEncoding("utf-8");
	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("subjectName") + " <--addSubjectAction param subjectName");
	System.out.println(request.getParameter("subjectTime") + " <--addSubjectAction param subjectTime");
	
	//요청값 유효성 검사: 요청값이 null이거나 공백이면 추가폼으로 리다이렉션
	String msg = null;
	if(request.getParameter("subjectName") == null || request.getParameter("subjectTime") == null
		|| request.getParameter("subjectName").equals("") || request.getParameter("subjectTime").equals("")){
		msg = URLEncoder.encode("과목과 시수를 입력해주세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/addSubject.jsp?msg="+msg);
		return;
	}
	
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	System.out.println(subjectName + " <--addSubjectAction subjectName");
	System.out.println(subjectTime + " <--addSubjectAction subjectTime");
	
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	int row = subjectDao.insertSubject(subject); //int값 반환
	
	//DB에 추가가 끝나면 subjectList로 리다이렉션
	if(row == 1){ //수정 성공시
		msg = URLEncoder.encode("과목이 추가되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
	} else { //수정 실패시
		msg = URLEncoder.encode("과목이 추가에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
	}
	
%>
