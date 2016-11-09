/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.security;

import java.util.Collection;
import java.util.Iterator;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

/**
 * @description 资源url访问决策
 * @author Ole
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 3, 2013
 * @version 3.0
 */
public class GomAccessDecisionManager implements AccessDecisionManager {

	@Override
	public void decide(Authentication authentication, Object object, Collection<ConfigAttribute> configAttributes)
			throws AccessDeniedException, InsufficientAuthenticationException {
		
		if (configAttributes == null) {
            return;
        }
		return;
		/*
		 * 
		 
		//user role
        Collection<? extends GrantedAuthority> as= authentication.getAuthorities();
        System.out.println("user role is = " + as);
        
        //url role
        Iterator<ConfigAttribute> ite = configAttributes.iterator();
        
        int i = 0, j = 0;
        while (ite.hasNext()) {
            ConfigAttribute ca = ite.next();
            String needRole = ((SecurityConfig) ca).getAttribute();
            System.out.println("need role: "+needRole);
            System.out.println("URL:"+object);
            // ga 为用户所被赋予的权限。 needRole 为访问相应的资源应该具有的权限。
            for (GrantedAuthority ga : as) {
                if (needRole.trim().equals(ga.getAuthority().trim())) {
                	i++;
                	return;
                }
            }
            j++;
        }
        //if(i == j) return;
        throw new AccessDeniedException("Access refused to !");*/
	}

	@Override
	public boolean supports(ConfigAttribute attribute) {
		return true;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return true;
	}

}
