package com.zdql.dao.inter;

import java.util.List;

import com.zdql.bean.Page;
import com.zdql.bean.Student;

public interface StudentDaoInter extends BaseDaoInter {

	/**
	 * 获取学生信息，这里需要将学生的班级，年级等信息封装进去
	 * 
	 * @param sql
	 *            要执行的sql语句
	 * @param param
	 *            参数
	 * @return
	 */
	public List<Student> getStudentList(String sql, List<Object> param);

}
