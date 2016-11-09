package com.sqe.gom.app;

/**
 * @description BPM 对象的持久化，比如 User, Group等，其事务由AOP来管理，不需注解。
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011  11:42:46 PM
 * @version 3.0
 */
public interface BpmService {
	
	/**
	 * save BPM Object, e.g. User, Group
	 * 
	 * @param obj  Will been save entity.
	 * @param str  The entity class instance
	 */
	void saveObject(String obj, String str);
	
	/**
	 * get the object by Id or entity object.
	 * 
	 * @param clazz  The entity class instance
	 * @param obj    The Object by specify
	 */
	Object loadObject(String obj, String str);
	
	/**
	 * delete the entity.
	 * 
	 * @param obj  Been deleted Object.
	 * @param str  The entity class instance
	 */
	void removeObject(String obj, String str);
}
