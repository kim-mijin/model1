<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	TeacherDao tDao = new TeacherDao();
	//post방식 인코딩
	request.setCharacterEncoding("utf-8");
	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("teacherId") + " <--addTeacherAction param teacherId");
	System.out.println(request.getParameter("teacherName") + " <--addTeacherAction param teacherName");
	System.out.println(request.getParameter("teacherHistory") + " <--addTeacherAction param teacherHistory");
	
	//요청값 유효성 검사: 요청값이 null이거나 공백이면 추가폼으로 리다이렉션
	String msg = null;
	if(request.getParameter("teacherId") == null || request.getParameter("teacherName") == null || request.getParameter("teacherHistory") == null
		|| request.getParameter("teacherId").equals("") || request.getParameter("teacherName").equals("") || request.getParameter("teacherHistory").equals("")){
		msg = URLEncoder.encode("강사 정보를 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/addTeacher.jsp?msg="+msg);
		return;
	}
	
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	//Teacher클래스로 묶기
	Teacher teacher = new Teacher();
	teacher.setTeacherId(teacherId);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);
	int row = tDao.insertTeacher(teacher);
	
	//DB에 추가가 끝나면 teacherList로 리다이렉션
	if(row == 1){ //수정 성공시
		msg = URLEncoder.encode("강사가 추가되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
	} else { //수정 실패시
		msg = URLEncoder.encode("강사 추가에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
	}
	
%>