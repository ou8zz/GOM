/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.security;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;

import com.sqe.gom.app.UserService;
import com.sqe.gom.app.ZtreeService;
import com.sqe.gom.constant.SessionAttr;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.util.RegexUtil;
import com.sqe.gom.vo.UserGroup;

/**
 * @description	登出注销操作
 * @author OLE
 * @author <a href="mailto:sqe_ole@sqeservice.com">OLE</a>
 * @date Apr 6, 2013
 * @version 3.0
 */
public class LogoutHandle extends SecurityContextLogoutHandler {

	private UserService userService;
	private ZtreeService ztreeService;
	private ConfigDAO configDao;
	
	
	@Resource(name="userService")
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Resource(name="ztreeService")
	public void setZtreeService(ZtreeService ztreeService) {
		this.ztreeService = ztreeService;
	}

	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}

	@Override
	public void logout(HttpServletRequest req, HttpServletResponse res, Authentication authentication) {
		String report = req.getParameter("report");
		UserGroup ug = (UserGroup) req.getSession().getAttribute(SessionAttr.USER_TAKEN.name());
		if(RegexUtil.notEmpty(ug)) {
			userService.loginOut(ug, report);			//登出操作
			req.getSession().removeAttribute(SessionAttr.USER_TAKEN.name());	//清空SESSION
			removeCookies(req, res);											//清空Cookie
			ztreeService.removeTreeMap(ug.getEname());							//清空用户ZtreeMap
			try {
				delAllFile(configDao.getConfig("fileUpload.rootPath").getValue() + "temp/");//清空临时文件目录
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		super.logout(req, res, authentication);
	}
	
	//删除目录下所有文件
	private void delAllFile(String filepath) throws IOException {
		File f = new File(filepath);// 定义文件路径
		if (f.exists() && f.isDirectory()) {// 判断是文件还是目录
			if (f.listFiles().length == 0) {// 若目录下没有文件则直接删除
				//f.delete();
			} else {// 若有则把文件放进数组，并判断是否有下级目录
				File delFile[] = f.listFiles();
				int i = f.listFiles().length;
				for (int j = 0; j < i; j++) {
					if (delFile[j].isDirectory()) {
						delAllFile(delFile[j].getAbsolutePath());// 递归调用del方法并取得子目录路径
					}
					delFile[j].delete();// 删除文件
				}
			}
		}
	}
	
	//移除所有cookie
	private void removeCookies(HttpServletRequest req, HttpServletResponse res) {
		Cookie[] cookies = req.getCookies();
		if(RegexUtil.notEmpty(cookies) && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				cookie.setMaxAge(0);
				res.addCookie(cookie);
			}
		}
	}
}
