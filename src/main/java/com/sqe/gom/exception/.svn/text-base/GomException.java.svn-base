package com.sqe.gom.exception;

import java.io.PrintStream;
import java.io.PrintWriter;

/**
 * @description Base GOM exception class.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 17, 2011 10:55:57 PM
 * @version 3.0
 */
public class GomException extends Exception {
	private static final long serialVersionUID = -7207356554866972832L;
	
	private final Throwable rootCause;

	/**
	 * Construct emtpy exception object.
	 */
	public GomException() {
		super();
		rootCause = null;
	}

	/**
	 * Construct GomException with message string.
	 * 
	 * @param s
	 *            Error message string.
	 */
	public GomException(String s) {
		super(s);
		rootCause = null;
	}

	/**
	 * Construct GomException, wrapping existing throwable.
	 * 
	 * @param s Error message
	 * @param t Existing connection to wrap.
	 */
	public GomException(String s, Throwable t) {
		super(s);
		rootCause = t;
	}

	/**
	 * Construct GomException, wrapping existing throwable.
	 * 
	 * @param t  Existing exception to be wrapped.
	 */
	public GomException(Throwable t) {
		rootCause = t;
	}

	/**
	 * Get root cause object, or null if none.
	 * 
	 * @return Root cause or null if none.
	 */
	public Throwable getRootCause() {
		return rootCause;
	}

	/**
	 * Get root cause message.
	 * 
	 * @return Root cause message.
	 */
	public String getRootCauseMessage() {
		String rcmessage = null;
		if (getRootCause() != null) {
			if (getRootCause().getCause() != null) {
				rcmessage = getRootCause().getCause().getMessage();
			}
			rcmessage = (rcmessage == null) ? getRootCause().getMessage() : rcmessage;
			rcmessage = (rcmessage == null) ? super.getMessage() : rcmessage;
			rcmessage = (rcmessage == null) ? "NONE" : rcmessage;
		}
		return rcmessage;
	}

	/**
	 * Print stack trace for exception and for root cause exception if there is one.
	 * 
	 * @see java.lang.Throwable#printStackTrace()
	 */
	public void printStackTrace() {
		super.printStackTrace();
		if (rootCause != null) {
			System.out.println("--- GOM ROOT CAUSE ---");
			rootCause.printStackTrace();
		}
	}

	/**
	 * Print stack trace for exception and for root cause exception if there is one.
	 * 
	 * @param s Stream to print to.
	 */
	public void printStackTrace(PrintStream s) {
		super.printStackTrace(s);
		if (rootCause != null) {
			s.println("--- GOM ROOT CAUSE ---");
			rootCause.printStackTrace(s);
		}
	}

	/**
	 * Print stack trace for exception and for root cause exception if there is one.
	 * 
	 * @param s Writer to write to.
	 */
	public void printStackTrace(PrintWriter s) {
		super.printStackTrace(s);
		if (null != rootCause) {
			s.println("--- GOM ROOT CAUSE ---");
			rootCause.printStackTrace(s);
		}
	}
}
