package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class TeacherDao {
	//강사목록
	/*
	 	//과목이 없는 강사목록도 출력해야 하므로 teacher와 teacher_subject는 left outer join을 한다
		SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, nvl(GROUP_CONCAT(s.subject_name SEPARATOR' / '),'') subjectName
		FROM teacher t LEFT OUTER JOIN teacher_subject ts
							ON t.teacher_no = ts.teacher_no
						LEFT OUTER JOIN subject s
							ON ts.subject_no = s.subject_no
		GROUP BY t.teacher_no, t.teacher_id, t.teacher_name;
		LIMIT ?, ?

	 */
	
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception{
		DBUtil dbUtil = new DBUtil(); //DB연결
		Connection conn = dbUtil.getConnection(); //conn받아오기
		//PreparedStatement 
		String sql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, nvl(GROUP_CONCAT(s.subject_name SEPARATOR' / '),'') subjectName "
						+ "FROM teacher t LEFT OUTER JOIN teacher_subject ts ON t.teacher_no = ts.teacher_no "
						+ "LEFT OUTER JOIN subject s ON ts.subject_no = s.subject_no "
						+ "GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt + " <--TeacherDao stmt");
		ResultSet rs = stmt.executeQuery();
		//ResultSet->ArrayList list
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			/*
			 subject_no를 받아오는 경우에 nvl(subject_no, '')를 쓰면 공백은 문자열이 되어 int로 받을 수 없게 됨
				nvl(GROUP_CONCAT(CAST(ts.subject_no AS CHAR) SEPARATOR' / '),' ') -> subject_no를 문자로 바꾸고 구분자를 넣음
			 */
			m.put("teacherNo", rs.getInt("teacherNo"));
			m.put("teacherId", rs.getString("teacherId"));
			m.put("teacherName", rs.getString("teacherName"));
			m.put("subjectName", rs.getString("subjectName"));
			list.add(m);
		}
		System.out.println(list.size() + " <--TeacherDao list.size()");
		return list;
	}
	
	//강사 총 행의 수
	public int selectTeacherCnt() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//PreparedStatement
		String sql = "SELECT COUNT(*) FROM teacher";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		//ResultSet->int
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
	
	//강사추가
	public int insertTeacher(Teacher teacher) throws Exception {
		//입력값 유효성 검사
		if(teacher == null || teacher.getTeacherId() == null || teacher.getTeacherName() == null
				|| teacher.getTeacherId().equals("") || teacher.getTeacherName().equals("")) {
			System.out.println("입력값 오류 TeacherDao insertTeacher");
			return 0;
		}
		
		DBUtil dbUtil = new DBUtil(); //메서드를 사용하기 위해 객체생성
		Connection conn = dbUtil.getConnection(); 
		String sql = "INSERT INTO teacher(teacher_id, teacher_name, teacher_history, updatedate, createdate) "
						+ "VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, teacher.getTeacherId());
		stmt.setString(2, teacher.getTeacherName());
		stmt.setString(3, teacher.getTeacherHistory());
		System.out.println(stmt + " <--TeacherDao insertTeacher stmt");
		int row = stmt.executeUpdate();
		return row;
	}
	
	//강사 1명 상세내용
	/*
	 	만약 강사 상세보기에 과목도 추가하는 경우 -> 인라인뷰로 넣는다
		SELECT teacherNo, teacherId, teacherName, teacherHistory, subjectName, tt.createdate, tt.updatedate 
		FROM 
		(SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, t.teacher_history teacherHistory, nvl(GROUP_CONCAT(s.subject_name SEPARATOR' / '),'') subjectName, t.updatedate updatedate, t.createdate createdate
		FROM teacher t LEFT OUTER JOIN teacher_subject ts
			ON t.teacher_no = ts.teacher_no
			LEFT OUTER JOIN subject s 
			ON ts.subject_no = s.subject_no
		GROUP BY t.teacher_no, t.teacher_id, t.teacher_name) tt
		WHERE teacherNo = 5
	 */
	public Teacher selectTeacherOne(int teacherNo) throws Exception{
		//DB접속
		DBUtil dbUtil = new DBUtil(); 
		Connection conn = dbUtil.getConnection(); 
		//쿼리실행
		String sql = "SELECT teacher_no teacherNo, teacher_id teacherId, teacher_name teacherName, teacher_history teacherHistory, "
					+ "updatedate, createdate FROM teacher WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		ResultSet rs = stmt.executeQuery();
		
		//ResultSet -> Teacher
		Teacher teacher = null;
		while(rs.next()) {
			teacher = new Teacher();
			teacher.setTeacherNo(rs.getInt("teacherNo"));
			teacher.setTeacherId(rs.getString("teacherId"));
			teacher.setTeacherName(rs.getString("teacherName"));
			teacher.setTeacherHistory(rs.getString("teacherHistory"));
			teacher.setUpdatedate(rs.getString("updatedate"));
			teacher.setCreatedate(rs.getString("createdate"));
		}
		return teacher;
	}
	
	//강사수정
	public int updateTeacher(Teacher teacher) throws Exception {
		//입력값 유효성 검사
		if(teacher == null) {
			System.out.println("입력값이 없습니다 TeacherDao updateTeacher");
			return 0;
		}
		//DB접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리실행
		String sql = "UPDATE teacher "
				+ "SET teacher_id = ?, teacher_name = ?, teacher_history = ?, updatedate = NOW() "
				+ "WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, teacher.getTeacherId());
		stmt.setString(2, teacher.getTeacherName());
		stmt.setString(3, teacher.getTeacherHistory());
		stmt.setInt(4, teacher.getTeacherNo());
		System.out.println(stmt + " <--TeacherDao updateTeacher stmt");
		int row = stmt.executeUpdate();
		return row;
	}
	
	//강사삭제
	public int deleteTeacher(int teacherNo) throws Exception {
		//DB접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		//쿼리실행
		String sql = "DELETE FROM teacher WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		int row = stmt.executeUpdate();
		return row;
	}
}
