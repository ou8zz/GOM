/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

/**
 * @description create page HTML TAG
 * @author <a href="mailto:janwer.zhang@gmail.com">Janwer zhang</a>
 * @date Dec 22, 2010, 5:20:40 PM
 * @version 1.0
 */
public class PageTag {
	public static String getPageTag(Page p, int currentIndex, String linkUrl) {
		StringBuilder buf = new StringBuilder();
		buf.append("<div class='pagination'>共<b>" + p.getTotalCount() + "</b>条");
		if (p.getPageCount() == 0)
			buf.append("<span>没有可显示的条目</span></div>");
		else {
			// first page tag
			buf.append(getPreviousTag(currentIndex, p.getPageCount(), linkUrl));
			// middle content tag 中间标签
			String currentPage = "<span class='current'>" + currentIndex + "</span>";

			if(p.getPageCount() > 1 && p.getPageCount() <= 5) {
				// middle page 中间页
				for(int i = 2; i < p.getPageCount(); i++) {
					if(currentIndex == i) buf.append(currentPage);
					else buf.append("<a href='" + linkUrl + i + "'>" + i + "</a>");
				}
			} else if(p.getPageCount() > 5) {
				int j = p.getPageCount() - 1;
				int i = currentIndex + 1;
				if (currentIndex < p.getPageCount() - 2) {
					buf.append(currentPage).append("<a href='" + linkUrl + i + "'>" + i+ "</a>").append("<span class='gap'>&hellip;</span>");
					buf.append("<a href='" + linkUrl + j + "'>" + j + "</a>");
				} else{
					int k = currentIndex - 1;
					buf.append("<a href='" + linkUrl + "2'>2</a>").append("<span class='gap'>&hellip;</span>");
					if(currentIndex == j)
						buf.append("<a href='" + linkUrl + k + "'>" + k + "</a>").append(currentPage);
					else if(currentIndex == p.getPageCount())
						buf.append("<a href='" + linkUrl + (k - 1) + "'>"+ (k - 1) + "</a>").append("<a href='" + linkUrl + k + "'>" + k + "</a>");
					else buf.append(currentPage).append("<a href='" + linkUrl + i + "'>" + i + "</a>");
				}
			}
			
			// last page tag and HTML end of page tag
			buf.append(getNextTag(currentIndex, p.getPageCount(), linkUrl)).append("</div>");
		}
		
		return buf.toString();
	}

	/**
	 * get previous HTML TAG
	 * 
	 * @param currentPage
	 *            The index number of current page
	 * @param url
	 *            The link information
	 * @return previous HTML TAG
	 */
	private static String getPreviousTag(int currentPage, int totalPage, String url) {
		if (currentPage == 1)
			return "<span class='disabled prev_page'>&laquo;上一页</span>";
		else {
			int i = currentPage - 1;
			String link = url + i;
			String previous = "<a href='" + link + "' class='prev_page' rel='prev'>&laquo; 上一页</a>";
			if (currentPage > 2 && currentPage < totalPage - 2)
				previous += "<a href='" + link + "'>" + i + "</a>";
			else
				previous += "<a href='" + url + "1' rel='start'>1</a>";
			return previous;
		}
	}

	/**
	 * get next HTML TAG
	 * 
	 * @param currentPage
	 *            The index number of current page
	 * @param totalPage
	 *            The user comments number
	 * @param url
	 *            The link information
	 * @return next HTML TAG
	 */
	private static String getNextTag(int currentPage, int totalPage, String url) {
		if(currentPage == 1 && totalPage < 2 ) 
			return "<span class='disabled next_page'>下一页 &raquo;</span>";
		else if(currentPage == totalPage && currentPage > 1)
			return "<span class='current'>" + currentPage + "</span><span class='disabled next_page'>下一页 &raquo;</span>";
		else{
			int i = currentPage + 1;
			return "<a href='" + url + totalPage + "' rel='end'>" + totalPage + "</a><a href='" + url + i + "' class='next_page' rel='next'>下一页 &raquo;</a>";
		}
	}
}
