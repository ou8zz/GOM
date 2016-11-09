/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

import java.awt.Canvas;
import java.awt.Graphics;
import java.awt.image.AreaAveragingScaleFilter;
import java.awt.image.BufferedImage;
import java.awt.image.FilteredImageSource;

/**
 * @description cut or zoom image
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Feb 5, 2012 4:17:44 PM
 * @version 3.0
 */
public class CutAndZoomImage {
	/**
	 * 计算缩放比例
	 * 
	 * @param buffer  图像源
	 * @param w  缩放后的图片的宽度
	 * @param h  缩放后的图片的高度
	 * @return 返回缩放后的图片的缓存
	 */
	public static BufferedImage equalScale(BufferedImage buffer, int w, int h) {
		int sh = buffer.getHeight();
		int sw = buffer.getWidth();
		if (sh <= h && sw <= w)return buffer;
		
		double scaleH = (double)h/(double)sh;
		double scaleW = (double)w/(double)sw;
		int finalH = (int)(sh*scaleH);
		int finalW = (int)(sw*scaleW);
		
		return zoomImage(buffer, finalW, finalH);
	}

	/***
	 * 缩放图像
	 * 
	 * @param buffer 图片缓存
	 * @param width  缩放后的宽度
	 * @param height 缩放后的高度
	 * @return 返回缩放后的 图片缓存
	 */
	public static BufferedImage zoomImage(BufferedImage buffer, int width, int height) {
		try {
			if(buffer == null) return buffer;
			AreaAveragingScaleFilter areaAveragingScaleFilter = new AreaAveragingScaleFilter(width, height);
			FilteredImageSource filteredImageSource = new FilteredImageSource(buffer.getSource(), areaAveragingScaleFilter);
			BufferedImage result = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
			Graphics g = result.getGraphics();
			Canvas canvas = new Canvas();
			g.drawImage(canvas.createImage(filteredImageSource), 0, 0, null);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 剪裁图像
	 * 
	 * @param in  待裁剪图像源
	 * @param x  图像x坐标
	 * @param y  图像y坐标
	 * @param w  裁剪后宽度
	 * @param h  裁剪后高度
	 */
	public static BufferedImage cutImge(BufferedImage in, int x, int y, int w, int h) {
		h = Math.min(Integer.valueOf(h), in.getHeight());
		w = Math.min(Integer.valueOf(w), in.getWidth());
		y = Math.min(Math.max(0, y), in.getHeight() - h);
		x = Math.min(Math.max(0, x), in.getWidth() - w);
		return in.getSubimage(x, y, w, h);
	}
}