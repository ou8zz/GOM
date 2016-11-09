/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.dao;

import java.util.List;

import com.sqe.gom.constant.ProcessStatus;
import com.sqe.gom.model.Departure;
import com.sqe.gom.model.Trace;
import com.sqe.gom.util.Page;

/**
 * @description trace of process entity.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jan 27, 2012  12:59:37 PM
 * @version 3.0
 */
public interface DepartureDAO extends GenericDAO<Departure> {
	/**
	 * get information for departure
	 * 
	 * @param userId  The identify of user
	 * @param state  The state of departure process
	 * @param onlyCrit Only select some property for this entity.
	 * @return entity of departure
	 */
	Departure getDeparture(Integer processId, Integer userId, ProcessStatus state, boolean onlyCrit);
	
	/**
	 * get trace by processId, ProcessType and relation entity ID
	 * 
	 * @param departureId  The identify of relation entity
	 * @param processId  The identify of process defind.
	 * @param type  The type of process.
	 * @return  result of query trace.
	 */
	Trace getTraceByProcess(Integer departureId, String nodeCode, Integer nodeOrder);
	
	/**
	 * get all will been check departure process for entry user
	 * 
	 * @param trace  The state of login user trace
	 * @param order  The list of order
	 * @param criteria  The query criteria for list of departure
	 * @param page The page information of departure.
	 * @return  list of departure
	 */
	List<Departure> getDepartures(Trace trace, String order, String criteria, Page page);
	
	/**
	 * remove trace by leave id and trace position
	 * @param lid   The identify of Leave entity
	 * @param position  The trace position
	 */
	void removeDeparture(Integer lid, Integer position);
	
	/**
	 * 更新离职信息
	 * @param dep
	 * @return
	 */
	int updateDeparture(Departure dep);
	
	/**
	 * update trace by point trace id and position
	 * @param traceId  The trace identify
	 * @param position  The trace collections position
	 * @return  update number
	 */
	int updateLastTracePosition(int traceId, int position);
}
