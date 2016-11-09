package com.sqe.gom.security;

import java.util.ArrayList;
import java.util.Collection;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

import com.sqe.gom.dao.UserDAO;
import com.sqe.gom.model.GomGroup;
import com.sqe.gom.model.GomUser;

/**
 * @description 
 * Implementing your own UserService is necessary if 
 * 1. you want to return customized UserDetails objects (which you can access later via the SecurityContextHolder)
 * 2. the receival of the User objects and authorities is too complex and/or cannot be defined with easy queries at the jdbc-user-service
 * 
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Mar 17, 2013  10:58:01 PM
 * @version 3.0
 */
public class UserDetailService implements UserDetailsService {
	private static final Logger logger = Logger.getLogger(UserDetailService.class);
	private UserDAO userDao;
	
	@Resource(name="userDao")
	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		if(logger.isDebugEnabled()) {  
            logger.debug("loadUserByUsername(String) - start user=" + username);
           }
		GomUser user = userDao.checkUser(username, null, true);
		Collection<GrantedAuthority> auths = new ArrayList<GrantedAuthority>(); 
		
		if(user ==null){
			String message = "user " + username + " not exist, please check again!";  
            logger.error(message);
            throw new UsernameNotFoundException(message);  
        }else {
        	for(GomGroup item : user.getGroups()){  
        		GrantedAuthority granted = new SimpleGrantedAuthority(item.getEname());  
                if(logger.isDebugEnabled()){  
                    logger.debug("user: ["+ user.getEname()+"]have roles: ["+item.getEname()+"], also in spring security is access");
                    }
                auths.add(granted);  
            }
        }
		GomUserDetails gud = new GomUserDetails(user, auths);
		return gud;
	}

}
