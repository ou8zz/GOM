/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao.impl;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.sqe.gom.util.Page;

/**
 * @description  This base class is prepared for subclass to do CRUD easily
 * @see com.sqe.gom.dao.GenericDAO
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 27, 2011  6:59:56 PM
 * @version 3.0
 */
public abstract class GenericHibernateDAO<T>{
	protected static final Object[] EMPTY_OBJECT_ARRAY = new Object[] {};

	protected Log log = LogFactory.getLog(getClass());

	private final Class<T> clazz;

	protected HibernateTemplate hibernateTemplate;

	/**
	 * Inject domain's class type in constructor.
	 * 
	 * @param clazz  Domain's class.
	 */
	public GenericHibernateDAO(Class<T> clazz) {
		this.clazz = clazz;
	}

	@Autowired
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	public T query(Serializable id) {
		@SuppressWarnings("unchecked")
		T t = (T) hibernateTemplate.get(clazz, id);
		if (t == null) {
			log.warn("Object not found");
			return null;
		}
		// it is strange that load() method return a lazy-loading proxy object
		// and it may cause LazyInitializationException!
		return t;
	}

	/**
	 * Default implementation of creating new domain object.
	 */
	public void create(T t) {
		hibernateTemplate.save(t);
	}

	/**
	 * Default implementation of deleting new domain object.
	 */
	public void delete(T t) {
		hibernateTemplate.delete(t);
	}
	
	/**
	 * Delete domain by entity ID
	 * 
	 * @param id <li>entity ID</li>
	 */
	public void delete(Long id) {
		hibernateTemplate.delete(hibernateTemplate.get(clazz, id));
	}
	
	/**
	 * Delete domain by entity ID
	 * 
	 * @param id <li>entity ID</li>
	 */
	public void delete(Integer id) {
		hibernateTemplate.delete(hibernateTemplate.get(clazz, id));
	}

	/**
	 * Default implementation of updating domain object.
	 */
	public void update(T t) {
		hibernateTemplate.update(t);
	}

	/**
	 * Do an update hql query, return the affected rows.
	 * 
	 * @param updateHql Update HQL.
	 * @param values Parameters or null if none.
	 * @return The affected rows.
	 */
	protected int executeUpdate(final String updateHql, final Object[] values) {
		HibernateCallback updateCallback = new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query query = session.createQuery(updateHql);
				if (values != null) {
					for (int i = 0; i < values.length; i++)
						query.setParameter(i, values[i]);
				}
				return new Integer(query.executeUpdate());
			}
		};
		return ((Integer) hibernateTemplate.execute(updateCallback)).intValue();
	}

	/**
	 * Prepared for sub-class for convenience. Query for list and also return
	 * total results' number.
	 * 
	 * @param selectCount
	 *            HQL for "select count(*) from ..." and should return a Long.
	 * @param select
	 *            HQL for "select * from ..." and should return object list.
	 * @param values
	 *            For prepared statements.
	 * @param page
	 *            Page object for store page information.
	 */
	protected List<?> queryForList(final String selectCount, final String select, final Object[] values, final Page page) {
		Long count = (Long) queryForObject(selectCount, values);
		page.setTotalCount(count.intValue());
		if(page.isEmpty())
			return Collections.EMPTY_LIST;
		return queryForList(select, values, page);
	}

	/**
	 * Prepared for sub-class for convenience. Query for list but do not return
	 * total results' number.
	 * 
	 * @param select
	 *            HQL for "select * from ..." and should return object list.
	 * @param values
	 *            For prepared statements.
	 * @param page
	 *            Page object for store page information.
	 */
	protected List<?> queryForList(final String select, final Object[] values, final Page page) {
		// select:
		HibernateCallback selectCallback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				Query query = session.createQuery(select).setCacheable(true);
				if (values != null) {
					for (int i = 0; i < values.length; i++)
						query.setParameter(i, values[i]);
				}
				return query.setFirstResult(page.getFirstResult()).setMaxResults(page.getPageSize()).list();
			}
		};
		return hibernateTemplate.executeFind(selectCallback);
	}
	
	/**
	 * query all list by condition
	 * 
	 * @param select     query condition
	 * @param values     for prepared statements
	 * @return           all result list
	 */
	protected List<?> queryForList(final String select, final Object[] values) {
		// select:
		HibernateCallback selectCallback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				Query query = session.createQuery(select).setCacheable(true);
				if (values != null) {
					for (int i = 0; i < values.length; i++)
						query.setParameter(i, values[i]);
				}
				return query.list();
			}
		};
		return hibernateTemplate.executeFind(selectCallback);
	}

	/**
	 * 调用存储过程
	 * @param callName   call name
	 * @param values     for prepared statements
	 * @param sqlString  sql
	 * @param turnString truncate table
	 * @return
	 */
	protected List<?> queryForProcedure(final String callName, final Object[] values, final String sqlString, final String trunString) {
		// call:
		HibernateCallback selectProcedure = new HibernateCallback() {
			public Object doInHibernate(Session session) throws SQLException {
				SQLQuery query = (SQLQuery) session.createSQLQuery(callName).setCacheable(false);
				if (values != null) {
					for (int i = 0; i < values.length; i++) 
						query.setParameter(i, values[i]);
				}
				query.list();
				
				//select: 
				query = (SQLQuery) session.createSQLQuery(sqlString);
				List<?> list = query.list();
				
				//truncate
				session.createSQLQuery(trunString).executeUpdate();
				return list;
			}
		};
		return (List<?>) hibernateTemplate.execute(selectProcedure);
	}
	
	/**
	 * Prepared for sub-class for convenience. Query for unique result.
	 * 
	 * @param select
	 *            HQL for "select * from ..." and should return unique object.
	 * @param values
	 *            For prepared statements.
	 */
	protected Object queryForObject(final String select, final Object[] values) {
		HibernateCallback selectCallback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				Query query = session.createQuery(select).setCacheable(true);
				if (values != null) {
					for (int i = 0; i < values.length; i++)
						query.setParameter(i, values[i]);
				}
				return query.uniqueResult();
			}
		};
		return hibernateTemplate.execute(selectCallback);
	}
	
	/**
	 * Prepared for sub-class for convenience. Delete query result.
	 * 
	 * @param select
	 *            HQL for "select * from ..." and should return unique object.
	 * @param values
	 *            For prepared statements.
	 */
	protected Object deleteForObject(final String select, final Object[] values) {
		HibernateCallback selectCallback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				Query query = session.createQuery(select);
				if (values != null) {
					for (int i = 0; i < values.length; i++)
						query.setParameter(i, values[i]);
				}
				return query.executeUpdate();
			}
		};
		return hibernateTemplate.execute(selectCallback);
	}

	protected Object queryForObject(final DetachedCriteria dc) {
		HibernateCallback callback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				return dc.getExecutableCriteria(session).uniqueResult();
			}
		};
		return hibernateTemplate.execute(callback);
	}

	/**
	 * Prepared for sub-class for convenience.
	 */
	protected List<?> queryForList(final DetachedCriteria dc, final Page page) {
		HibernateCallback callback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				Criteria c = dc.getExecutableCriteria(session);
				if (page == null)
					return c.list();
				return PaginationCriteria.query(c, page);
			}
		};
		return hibernateTemplate.executeFind(callback);
	}
	
	protected List<?> queryForListByTotal(final String select, final Object[] values,final int total) {
		// select:
		HibernateCallback selectCallback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				Query query = session.createQuery(select);
				if (values != null) {
					for (int i = 0; i < values.length; i++)
						query.setParameter(i, values[i]);
				}
				return query.setCacheable(true).setFirstResult(0).setMaxResults(total).list();
			}
		};
		return hibernateTemplate.executeFind(selectCallback);
	}

	/**
	 * Prepared for sub-class for convenience.
	 */
	protected Object uniqueResult(final DetachedCriteria dc) {
		HibernateCallback callback = new HibernateCallback() {
			public Object doInHibernate(Session session) {
				return dc.getExecutableCriteria(session).uniqueResult();
			}
		};
		return hibernateTemplate.execute(callback);
	}

}

/**
 * A PaginationCriteria can execute both "select count(*)" and "select * from"
 * queries, and set Page object automatically. This class uses reflect to remove
 * and restore "order by" conditions.
 * 
 * @author Janwer
 */
class PaginationCriteria {

	private static Log log = LogFactory.getLog(PaginationCriteria.class);

	private static Field orderEntriesField = getField(Criteria.class,"orderEntries");

	@SuppressWarnings("rawtypes")
	public static List<?> query(Criteria c, Page page) {
		// first we must detect if any Order defined:
		// Hibernate code: private List orderEntries = new ArrayList();
		List<?> _old_orderEntries = (List) getFieldValue(orderEntriesField, c);
		boolean restore = false;
		if (_old_orderEntries.size() > 0) {
			restore = true;
			setFieldValue(orderEntriesField, c, new ArrayList());
		}
		c.setProjection(Projections.rowCount());
		int rowCount = ((Integer) c.uniqueResult()).intValue();
		page.setTotalCount(rowCount);
		if (rowCount == 0) {
			// no need to execute query:
			return Collections.EMPTY_LIST;
		}
		// query:
		if (restore) {
			// restore order conditions:
			setFieldValue(orderEntriesField, c, _old_orderEntries);
		}
		return c.setCacheable(true).setFirstResult(page.getFirstResult()).setMaxResults(
				page.getPageSize()).setFetchSize(page.getPageSize()).list();
	}

	private static Field getField(Class<?> clazz, String fieldName) {
		try {
			return clazz.getDeclaredField(fieldName);
		} catch (Exception e) {
			log.warn("Class.getDeclaredField(String) failed.", e);
			throw new RuntimeException(e);
		}
	}

	private static Object getFieldValue(Field field, Object obj) {
		field.setAccessible(true);
		try {
			return field.get(obj);
		} catch (Exception e) {
			log.warn("Field.get(Object) failed.", e);
			throw new RuntimeException(e);
		}
	}

	private static void setFieldValue(Field field, Object target, Object value) {
		field.setAccessible(true);
		try {
			field.set(target, value);
		} catch (Exception e) {
			log.warn("Field.set(Object, Object) failed.", e);
			throw new RuntimeException(e);
		}
	}
}