/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.web.validation;

import com.sqe.gom.model.Meeting;
import com.sqe.gom.util.RegexUtil;

/**
 * @description 会议验证类
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Oct 23, 2012 9:44:00 PM
 * @version 3.0
 */
public class MeetingValidator {
	public boolean validate(Meeting m) {
		if(RegexUtil.isEmpty(m.getId())) {
			if (RegexUtil.isEmpty(m.getNumber())) {
				return false;
			}
			if (RegexUtil.isEmpty(m.getTitle())) {
				return false;
			}
			if (RegexUtil.isEmpty(m.getLocale())) {
				return false;
			}
			if (RegexUtil.isEmpty(m.getTime())) {
				return false;
			}
			if (RegexUtil.isEmpty(m.getHost())) {
				return false;
			}
			if (RegexUtil.isEmpty(m.getNotes())) {
				return false;
			}
			if (RegexUtil.isEmpty(m.getExplain())) {
				return false;
			}
			if (RegexUtil.isEmpty(m.getParticipants())) {
				return false;
			}
		} else {
			if (RegexUtil.isEmpty(m.getParticipants())) {
				return false;
			}
			if(RegexUtil.notEmpty(m.getIsTrace())) {
				if (RegexUtil.isEmpty(m.getTraceDate())) {
					return false;
				}
			} else {
				if (RegexUtil.isEmpty(m.getEndDate())) {
					return false;
				}
			}
		}
		return true;
	}
}
