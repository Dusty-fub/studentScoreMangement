package com.zdql.service;

import java.sql.Connection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.zdql.bean.Clazz;
import com.zdql.bean.Course;
import com.zdql.bean.CourseItem;
import com.zdql.bean.Grade;
import com.zdql.bean.Page;
import com.zdql.bean.Student;
import com.zdql.dao.impl.BaseDaoImpl;
import com.zdql.dao.impl.ClazzDaoImpl;
import com.zdql.dao.inter.BaseDaoInter;
import com.zdql.dao.inter.ClazzDaoInter;
import com.zdql.tools.MysqlTool;
import com.zdql.tools.StringTool;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * 课程服务层
 *
 */
public class CourseService {

	BaseDaoInter dao = new BaseDaoImpl();

	/**
	 * 获取所有课程
	 * 
	 * @return
	 */
	public String getCourseList(String gradeid, String classId) {
		List<Object> list;
		if (StringTool.isEmpty(gradeid) && StringTool.isEmpty(classId)) {
			list = dao.getList(Course.class, "SELECT * FROM course");
		} else if (StringTool.isEmpty(classId)) {
			list = dao.getList(Course.class,
					"SELECT c.* FROM course c, grade_course gc WHERE c.id=gc.courseid AND gc.gradeid=?",
					new Object[] { Integer.parseInt(gradeid) });
		} else {
			list = dao.getList(Course.class, "SELECT ngc.* FROM "
					+ "(SELECT c.* FROM course c, grade_course gc WHERE c.id=gc.courseid AND gc.gradeid=?) ngc "
					+ "LEFT JOIN (SELECT cct.courseid FROM clazz_course_teacher cct WHERE cct.gradeid =? AND cct.clazzid=?) ncct "
					+ "ON ngc.id = ncct.courseid " + "WHERE ncct.courseid is NULL",
					new Object[] { Integer.parseInt(gradeid), Integer.parseInt(gradeid), Integer.parseInt(classId) });

		}

		String result = JSONArray.fromObject(list).toString();

		return result;
	}

	/**
	 * 添加课程
	 * 
	 * @param course
	 */
	public void addCourse(Course course) {
		dao.insert("INSERT INTO course(name) value(?)", new Object[] { course.getName() });
	}

	/**
	 * 删除课程
	 * 
	 * @param courseid
	 * @throws Exception
	 */
	public void deleteClazz(int courseid) throws Exception {
		// 获取连接
		Connection conn = MysqlTool.getConnection();
		try {
			// 开启事务
			MysqlTool.startTransaction();
			// 删除成绩表
			dao.deleteTransaction(conn, "DELETE FROM escore WHERE courseid=?", new Object[] { courseid });
			// 删除班级的课程和老师的关联
			dao.deleteTransaction(conn, "DELETE FROM clazz_course_teacher WHERE courseid=?", new Object[] { courseid });
			// 删除年级与课程关联
			dao.deleteTransaction(conn, "DELETE FROM grade_course WHERE courseid=?", new Object[] { courseid });
			// 最后删除课程
			dao.deleteTransaction(conn, "DELETE FROM course WHERE id=?", new Object[] { courseid });

			// 提交事务
			MysqlTool.commit();
		} catch (Exception e) {
			// 回滚事务
			MysqlTool.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			MysqlTool.closeConnection();
		}
	}

}
