/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.app;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.model.Motto;

/**
 * @description 
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Dec 28, 2011
 * @version 3.0
 */
@Transactional
public interface MottoService {
	/**
	 * 获得格言
	 * @return
	 */
	@PreAuthorize("hasRole('User') or hasRole('Admin')")
	Motto getMotto();
	
	/**
	 * 编辑格言
	 * @param m
	 */
	@PreAuthorize("hasRole('Admin')")
	void saveMotto(Motto m);
}
