/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.AntPathRequestMatcher;
import org.springframework.security.web.util.RequestMatcher;

import com.sqe.gom.dao.ZtreeDAO;
import com.sqe.gom.model.Ztree;
import com.sqe.gom.util.RegexUtil;

/**
 * @description 自定义资源权限过滤器
 * @author Ole
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 3, 2013
 * @version 3.0
 */
public class CustomInvocationSecurityMetadataSourceService implements FilterInvocationSecurityMetadataSource {
	private RequestMatcher pathMatcher;
	private static Map<String, Collection<ConfigAttribute>> resourceMap = null;
	
	//通过构造方法注入ZtreeDAO
	public CustomInvocationSecurityMetadataSourceService(ZtreeDAO treeDao) {
		loadResourceDefine(treeDao);
	}

	@Override
	public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {
		// object 是一个被用户请求的url。
		FilterInvocation fi = ((FilterInvocation) object);
		HttpServletRequest req = fi.getRequest();
        Iterator<String> it = resourceMap.keySet().iterator();
        while (it.hasNext()) {
            String resURL = it.next();
            pathMatcher = new AntPathRequestMatcher(resURL);  
            if (pathMatcher.matches(req)) {
                Collection<ConfigAttribute> returnCollection = resourceMap.get(resURL);
                //System.out.println("url role is = " + returnCollection);
                return returnCollection;
            }  
        }
        return null;
	}

	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		return null;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return true;
	}
	
	private void loadResourceDefine(ZtreeDAO treeDao) {
		resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
		List<Ztree> trees = treeDao.getZtrees(" ORDER BY z.node", null);
		if(!trees.isEmpty()) {
			for(Ztree z : trees) {
				if(RegexUtil.notEmpty(z.getUrl())) {
					Collection<ConfigAttribute> ca = new ArrayList<ConfigAttribute>();
					ca.add(new SecurityConfig(z.getPosition()));
					ca.add(new SecurityConfig(z.getRole()));
					resourceMap.put("/app/"+z.getUrl(), ca);
				}
			}
		}
	}
}
