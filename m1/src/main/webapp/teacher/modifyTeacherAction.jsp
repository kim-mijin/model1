<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//수정시 필요한 변수: Teacher객체
	TeacherDao tDao = new TeacherDao();
	//post방식 인코딩
	request.setCharacterEncoding("utf-8");

	//요청값이 잘 넘어오는지 확인하기(수정할 수 있는 값들 확인)
	System.out.println(request.getParameter("teacherId") + " <--modifyTeacherAction param teacherId");
	System.out.println(request.getParameter("teacherName") + " <--modifyTeacherAction param teacherName");
	System.out.println(request.getParameter("teacherHistory") + " <--modifyTeacherAction param teacherHistory");
	
	//수정할 수 없는 subjectNo는 먼저 변수에 저장하기
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo + " <--modifyTeacherAction teacherNo");
	
	//요청값 유효성 검사: null이거나 공백이면 수정폼으로 리다이렉션
	String msg = null;
	if(request.getParameter("teacherId") == null || request.getParameter("teacherName") == null
			|| request.getParameter("teacherHistory") == null || request.getParameter("teacherId").equals("")
			|| request.getParameter("teacherName").equals("") || request.getParameter("teacherHistory").equals("")){
			msg = URLEncoder.encode("수정할 내용을 입력해주세요", "utf-8");
			response.sendRedirect(request.getContextPath()+"/subject/modifyTeacher.jsp?teacherNo="+teacherNo+"&msg="+msg);
			return;
	}
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	
	//Teacher타입으로 변수들을 묶는다
	Teacher teacher = new Teacher();
	teacher.setTeacherNo(teacherNo);
	teacher.setTeacherId(teacherId);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);
	int row = tDao.updateTeacher(teacher);
	
	//수정 종료시 subjectList로 리다이렉션
	if(row == 1){ //수정 성공시
		msg = URLEncoder.encode("강사 상세내용이 수정되었습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherOne.jsp?teacherNo="+teacherNo+"&msg="+msg);
	} else { //수정 실패시
		msg = URLEncoder.encode("강사 상세내용 수정에 실패하였습니다", "utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/teacherOne.jsp?teacherNo="+teacherNo+"&msg="+msg);
	}
%>
