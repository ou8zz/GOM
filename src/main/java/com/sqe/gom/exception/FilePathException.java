package com.sqe.gom.exception;

/**
 * @description Thrown from the FileManager if a file path is considered invalid
 *              for some reason, like it represents a directory instead of a file.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 10:34:35 PM
 * @version 3.0
 */
public class FilePathException extends GomException {
	private static final long serialVersionUID = 1684271108739150532L;

	public FilePathException(String s) {
		super(s);
	}

	public FilePathException(String s, Throwable t) {
		super(s, t);
	}

	public FilePathException(Throwable t) {
		super(t);
	}
}
