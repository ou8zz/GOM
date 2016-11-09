package com.sqe.gom.web.core;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.reflect.TypeToken;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.model.Logs;
import com.sqe.gom.util.DateUtil;
import com.sqe.gom.util.JsonUtils;

/**
 * @description File download handler controller
 * @author <a href="mailto:sqe_ole@sqeservice.com">ole</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
@Controller
public class DownloadController {
	private Log log = LogFactory.getLog(DownloadController.class);
	private InputStream inStream;
	private PrintWriter out;
	private Map<String, Object> m = new HashMap<String, Object>();
	
	/**
	 * 直接将表单属性设置为 method="post" action="download.htm" 即可使用其功能
	 * 
	 * @param fileName
	 *            将下载好的数据保存在数据库的文件名设置为fileName
	 * @param res
	 *            返回AJAX类型的上传结果，如result=SUCCESS，则表成功将返回UUID名和原来的文件名，
	 *            反之UNSUPPORT表不支持此文件类型，PARAM_EMPTY文件档为空或未选择文件
	 */
	@RequestMapping(method = {}, value = "/download.htm")
	public void processDownload(@RequestParam("fileName") String fileName,HttpServletRequest req, HttpServletResponse res) {
		// 设置输出的格式
        res.reset();
        res.setContentType("text/html;charset=UTF-8");
        res.addHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        String path = checkName(fileName);	//检查文件名后判断路径
		try {
			// 读到流中
			inStream = new FileInputStream(req.getSession().getServletContext().getRealPath("/uploads/"+path));// 文件的存放路径
			
	        // 循环取出流中的数据
	        byte[] b = new byte[100];
	        int len;
	        while ((len = inStream.read(b)) > 0)
	        	res.getOutputStream().write(b, 0, len);
	        inStream.close();
	        
	        Logs lf = new Logs();
			lf.setLogger("文件下载");
			lf.setDated(new Date());
			lf.setMessage(DateUtil.forMatDate() + " 下载文件："+fileName+"成功！");
			log.debug(JsonUtils.toJson(lf));
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
			log.error("/download.htm, error:　该文件没有添加附件如何做", e1);
		} catch (IOException e) {
            e.printStackTrace();
            log.error("/download.htm　IOException　have error!", e);
        } 
	}
	
	/**
	 * 查询是否有该文件
	 * @param fileName
	 * @param req
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/find_file.htm")
	public void findFile(@RequestParam("fileName") String fileName,HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		String path = checkName(fileName);//检查文件名后判断路径
		try {
			out = res.getWriter();
			File f = new File(req.getSession().getServletContext().getRealPath("/uploads/"+path));
			if(f.exists()) m.put("result", HandlerState.SUCCESS);
			else m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType(),JsonUtils.SHORT_DATE_PATTERN,true));
		} catch (IOException e) {
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String,Object>>() {}.getType()));
			log.error("find_file.htm have error!" + e);
		}finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * //检查文件名后判断路径
	 * @param fileName
	 * @return
	 */
	private String checkName(String fileName) {
		String ext = "";
		int pos;
		if ((pos = fileName.lastIndexOf('.')) != -1)
			ext = fileName.substring(pos).trim().toLowerCase();
		String path;
		if (ext.equals(".jpg") || ext.equals(".png")|| ext.equals(".gif")) path = "images/" + fileName;
		else if (ext.equals(".doc") || ext.equals(".pdf") || ext.equals(".xls")) path = "doc/" + fileName;
		else if (ext.equals(".swf") || ext.equals(".flv")) path = "swf/" + fileName;
		else path = "other/" + fileName;
		return path;
	}
}
