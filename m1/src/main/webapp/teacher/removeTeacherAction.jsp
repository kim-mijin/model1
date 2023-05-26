<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//삭제시 필요한 변수: teacher_no
	TeacherDao tDao = new TeacherDao();
	//post방식 인코딩
	request.setCharacterEncoding("utf-8");

	//요청값이 잘 넘어오는지 확인하기
	System.out.println(request.getParameter("teacherNo") + " <--removeTeacherAction param teacherNo");

	//요청값 유효성 검사: null이거나 공백이면 teacherList로 리다이렉션
	String msg = null;
	if(request.getParameter("teacherNo") == null || request.getParameter("teacherNo").equals("")){
			msg = URLEncoder.encode("삭제할 강사를 알 수 없습니다", "utf-8");
			response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
			return;
	}
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	int row = tDao.deleteTeacher(teacherNo);
	
	//삭제 종료시 teacherList로 리다이렉션
	if(row == 1){ //수정 성공시
		msg = URLEncoder.encode("강사가 삭제되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
	} else { //수정 실패시
		msg = URLEncoder.encode("강사 삭제에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp?msg="+msg);
	}
%>