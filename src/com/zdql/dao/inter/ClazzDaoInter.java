package com.zdql.dao.inter;

import java.util.List;

import com.zdql.bean.Clazz;
import com.zdql.bean.Page;

public interface ClazzDaoInter extends BaseDaoInter {

	/**
	 * 获取班级详细信息
	 * 
	 * @param gradeid
	 *            年级ID
	 * @param page
	 *            分页参数
	 * @return
	 */
	public List<Clazz> getClazzDetailList(String gradeid, Page page);

}
