package com.sqe.gom.exception;

/**
 * @description Thrown from the FileManager if there is some kind of IO exception while working on a file, such as during a save or delete.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 10:34:35 PM
 * @version 3.0
 */
public class FileIOException extends GomException {
	private static final long serialVersionUID = 3926042360968338342L;

	public FileIOException(String s) {
		super(s);
	}

	public FileIOException(String s, Throwable t) {
		super(s, t);
	}

	public FileIOException(Throwable t) {
		super(t);
	}
}
