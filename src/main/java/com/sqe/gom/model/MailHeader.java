/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.model;

import java.io.File;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * @description helper for mail header.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 10:34:35 PM
 * @version 3.0
 */
public class MailHeader implements Serializable {
	private static final long serialVersionUID = -7800783302787356797L;
	
	private String from;
	private String[] to;
	private String subject;
	private String replyTo;
	private String[] cc;
	private String[] bcc;
	private String[] attachment;
	private Map<String,File> inline = new HashMap<String, File>();

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String[] getTo() {
		return to;
	}

	public void setTo(String[] to) {
		this.to = to;
	}

	public String getReplyTo() {
		return replyTo;
	}

	public void setReplyTo(String replyTo) {
		this.replyTo = replyTo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String[] getCc() {
		return cc;
	}

	public void setCc(String[] cc) {
		this.cc = cc;
	}

	public String[] getBcc() {
		return bcc;
	}

	public void setBcc(String[] bcc) {
		this.bcc = bcc;
	}

	public String[] getAttachment() {
		return attachment;
	}

	public void setAttachment(String[] attachment) {
		this.attachment = attachment;
	}

	public Map<String, File> getInline() {
		return inline;
	}

	public void setInline(Map<String, File> inline) {
		this.inline = inline;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(getFrom()).append(getSubject()).toHashCode();
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj instanceof GomUser != true)
			return false;
		MailHeader other = (MailHeader) obj;
		return new EqualsBuilder().append(getFrom(), other.getFrom()).append(getSubject(), other.getSubject()).isEquals();
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append(this.from);
		sb.append(",").append(this.to);
		sb.append(",").append(this.subject);
		sb.append(",").append(this.replyTo);
		sb.append(",").append(this.replyTo);
		sb.append(",").append(this.cc);
		sb.append(",").append(this.bcc);
		sb.append(",").append(this.attachment);
		sb.append(",").append(this.inline);
		sb.append("}");
		return sb.toString();
	}
}
