package com.sqe.gom.web.core;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.google.gson.reflect.TypeToken;
import com.sqe.gom.app.FileManager;
import com.sqe.gom.constant.HandlerState;
import com.sqe.gom.exception.FileIOException;
import com.sqe.gom.exception.FileNotFoundException;
import com.sqe.gom.exception.FilePathException;
import com.sqe.gom.util.CutAndZoomImage;
import com.sqe.gom.util.JsonUtils;
import com.sqe.gom.util.RegexUtil;

/**
 * @description File upload handler controller
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 7, 2011 11:04:25 PM
 * @version 3.0
 */
@Controller
public class UploadController {
	private Log log = LogFactory.getLog(UploadController.class);
	private FileManager fmgr;
	private PrintWriter out;

	@Resource(name = "fmgr")
	public void setFmgr(FileManager fmgr) {
		this.fmgr = fmgr;
	}

	/**
	 * 直接将表单属性设置为 method="post" enctype="multipart/form-data"
	 * action="upload.htm" 即可使用其功能
	 * 
	 * @param file
	 *            页面中的name须为Filedata <i>e.g. &lt;input type="file"
	 *            name="Filedata" /&gt;</i> 但如果用的是uploadify组件的话，则文件名可以随意命名
	 * @param res
	 *            返回AJAX类型的上传结果，如result=SUCCESS，则表成功将返回UUID名和原来的文件名，
	 *            反之UNSUPPORT表不支持此文件类型，PARAM_EMPTY文件档为空或未选择文件
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/upload.htm")
	public void processUpload(@RequestParam("Filedata") MultipartFile file,
			HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		Map<String, Object> m = new HashMap<String, Object>();

		try {
			out = res.getWriter();
			if (file == null || file.isEmpty()) {
				m.put("result", HandlerState.PARAM_EMPTY);
			} else {
				String originalName = file.getOriginalFilename();
				log.info("upload file name: " + originalName);
				// get extend name
				String ext = "";
				int pos;
				if ((pos = originalName.lastIndexOf('.')) != -1)
					ext = originalName.substring(pos).trim().toLowerCase();
				String fileName = UUID.randomUUID().toString().replaceAll("-", "")+ ext;
				if (fmgr.isAllow(fileName)) {
					String path;
					if(ext.equals(".jpg") || ext.equals(".png")|| ext.equals(".gif")) path = "images/" + fileName;
					else if(ext.equals(".doc") || ext.equals(".docx") || ext.equals(".pdf") || ext.equals(".xls")) path = "doc/" + fileName;
					else if(ext.equals(".swf") || ext.equals(".flv")) path = "swf/" + fileName;
					else path = "other/" + fileName;

					fmgr.saveFile(path, file.getInputStream());
					m.put("result", HandlerState.SUCCESS);
					m.put("fileName", fileName);
					m.put("originalName", originalName);
				} else
					m.put("result", HandlerState.UNSUPPORT);
			}
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
		} catch (Exception e) {
			log.error("occurred an error when upload file", e);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
		} finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	/**
	 * 编辑器上传图片
	 * @param file
	 * @param res
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/kindeditor_upload.htm")
	public void kindeditorUpload(@RequestParam("files") MultipartFile file, HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		Map<String, Object> m = new HashMap<String, Object>();

		try {
			out = res.getWriter();
			if (file == null || file.isEmpty()) {
				m.put("error", 1);
				m.put("message", "错误，空的文件");
			} else if(file.getSize() > 500000) {
				m.put("error", 1);
				m.put("message", "错误，不支持超过500KB的图片上传");
			} else {
				
				String originalName = file.getOriginalFilename();
				log.info("upload file name: " + originalName);
				// get extend name
				String ext = "";
				int pos;
				if ((pos = originalName.lastIndexOf('.')) != -1)
					ext = originalName.substring(pos).trim().toLowerCase();
				if (fmgr.isAllow(originalName)) {
					String path;
					if(ext.equals(".jpg") || ext.equals(".png")|| ext.equals(".gif")) {
						path = "images/" + originalName;
						
						fmgr.saveFile(path, file.getInputStream());
						
						m.put("error", 0);
						m.put("url", "../uploads/" + path);
					}
					else {
						m.put("error", 1);
						m.put("message", "错误，只支持后缀为:jpg png gif的图片文件");
					}
				} else {
					m.put("error", 1);
					m.put("message", "上传失败，不支持的图片类型");
				}
			}
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
		} catch (Exception e) {
			log.error("kindeditor_upload.htm occurred an error when upload file", e);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
		} finally {
			m.clear();
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

	@RequestMapping(method = RequestMethod.POST, value = "/crop.htm")
	public void cropThumbnail(HttpServletRequest req, HttpServletResponse res) throws FileNotFoundException, FilePathException, FileIOException {
		res.setContentType("text/html;charset=UTF-8");
		res.setHeader("Cache-Control", "no-cache");
		Map<String, Object> m = new HashMap<String, Object>();

		String oriName = req.getParameter("oriName");
		String w = req.getParameter("w");
		String h = req.getParameter("h");
		String zw = req.getParameter("zw");
		String zh = req.getParameter("zh");
		int x = Integer.valueOf(req.getParameter("x"));
		int y = Integer.valueOf(req.getParameter("y"));
		BufferedImage in, output;
		output = null;
		String orpath = "images/";
		
		try {
			if (oriName == null || "".equals(oriName)) {
				m.put("result", HandlerState.PARAM_EMPTY);
			}else{
				out = res.getWriter();
				orpath += oriName;
				in = (BufferedImage) ImageIO.read(fmgr.getFile(orpath));
				
				//cut image
				if(RegexUtil.notEmpty(zw) && RegexUtil.notEmpty(zh)) {
					output = CutAndZoomImage.equalScale(CutAndZoomImage.cutImge(in, x, y, Integer.parseInt(zw), Integer.parseInt(zh)), Integer.parseInt(w), Integer.parseInt(h));
				}else output = CutAndZoomImage.cutImge(in, x, y, Integer.parseInt(w), Integer.parseInt(h));

				int pos;
				String ext = "";
				if ((pos = oriName.lastIndexOf('.')) != -1)
					ext = oriName.substring(pos).trim().toLowerCase();
				String fileName = UUID.randomUUID().toString().replaceAll("-", "")+ ext;
				if(RegexUtil.notEmpty(output)) {
					ImageIO.write(output, ext.equals(".png") ? "png" : "jpeg",new File(fmgr.getRootPath() + "images/" + fileName));
					output.flush();
				}
				
				m.put("result", HandlerState.SUCCESS);
				m.put("fileName", fileName);
			}
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
		} catch (Exception e) {
			log.error("occurred an error when product thumbnail", e);
			m.put("result", HandlerState.ERROR);
			out.write(JsonUtils.toJson(m, new TypeToken<Map<String, Object>>() {}.getType()));
		} finally {
			fmgr.deleteFile(orpath);
			m.clear();
			if(out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/app/download.htm")
	public void downLoadFile(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("application/x-download");
		res.addHeader("content-type","application/x-msdownload;");
		
		String fileName = req.getParameter("file");
		String displayName = req.getParameter("name");

		try {
			ServletOutputStream out = res.getOutputStream();
			FileInputStream in = null;
			int len;
			if(RegexUtil.notEmpty(fileName) || RegexUtil.notEmpty(displayName)) {
				displayName = URLEncoder.encode(displayName, "UTF-8");
				String local = req.getLocale().toString();
				if(local.equals("zh_TW") || local.equals("zh_HK")) displayName = new String(displayName.getBytes("big5"), "ISO8859-1");
				else displayName = new String(displayName.getBytes("GB2312"), "ISO8859-1");
				
				int pos;
				String ext = "";
				if((pos = fileName.lastIndexOf('.')) != -1) ext = fileName.substring(pos).trim().toLowerCase();
				if(RegexUtil.notEmpty(ext)) displayName += ext;
				
				res.addHeader("Content-Disposition","attachment;filename=" + displayName);
				File file = fmgr.getFile("doc/" + fileName);
				if(file.exists()) {
					in = new FileInputStream(file);
					byte[] buffer = new byte[1024];
					len = in.available();
					res.setContentLength(len);
					while(true) {
						if(in.available() < 1024) {
							int remain;
							while((remain=in.read()) != -1) out.write(remain);
							break;
						}else {
							in.read(buffer);
							out.write(buffer);
						}
					}//end while
				}
				in.close();
				out.flush();
				out.close();
			}
		}catch(Exception e){log.error("have an error when down file from server",e);}
		finally{ if(out != null){out.flush();out.close();}
		}
	}
}
