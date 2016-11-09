package com.sqe.gom.app;

import java.io.File;
import java.io.InputStream;

import com.sqe.gom.exception.FileIOException;
import com.sqe.gom.exception.FileNotFoundException;
import com.sqe.gom.exception.FilePathException;

/**
 * @description Interface for managing files uploaded to GOM.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 10:34:35 PM
 * @version 3.0
 */
public interface FileManager {
	/**
     * Get a reference to a specific file in a upload file area.
     * 
     * This method always returns a valid file or will throw an exception
     * If the specificed path doesn't exist, is a directory, or can't be read.
     * 
     * @param path  The relative path to the desired resource within the upload path area.
     */
	File getFile(String path)throws FileNotFoundException, FilePathException;

	/**
     * Get list of directories from a upload path area.
     * 
     * This method will return an array of all dirs in the upload file path, otherwise it will throw an exception.
     * 
     * @param path  The path we are working on.
     */
	File[] getDirectories(String dir)throws FileNotFoundException, FilePathException;

	/**
     * Save a file to uploads path area
     * 
     * @param path The relative path to the desired location within the upload path area where the file should be saved.
     * @param contentType  Content type of the file.
     * @param is  InputStream to read the file from.
     */
	void saveFile(String path, InputStream is)throws FileNotFoundException, FilePathException, FileIOException;

	/**
     * Create an empty subDirectory in the path uploads area.
     *
     * @param path The relative path to the desired location within the upload path area where the directory should be created.
     */
	void createDirectory(String path)throws FileNotFoundException, FilePathException, FileIOException;

	/**
     * Delete file or directory from path uploads area.
     * 
     * @param path The relative path to the file within the uploads area that should be deleted.
     */
	void deleteFile(String path)throws FileNotFoundException, FilePathException, FileIOException;

	/**
     * Delete all files associated with a given path, including the root folder.
     *
     * @param path The path to delete all files from.
     */
	void deleteAllFiles(String path);
	
	/**
	 * check upload file type is allow or forbid
	 * 
	 * @param path   The name of upload file.
	 * @return  true or false
	 */
	boolean isAllow(String path);
	
	/**
	 * get root path
	 * 
	 * @return path of this string
	 */
	String getRootPath();
}
