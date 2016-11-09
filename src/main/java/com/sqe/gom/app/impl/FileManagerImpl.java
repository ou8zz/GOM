package com.sqe.gom.app.impl;

import java.io.File;
import java.io.FileFilter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.annotation.Resource;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import com.sqe.gom.app.FileManager;
import com.sqe.gom.dao.ConfigDAO;
import com.sqe.gom.exception.FileIOException;
import com.sqe.gom.exception.FilePathException;
import com.sqe.gom.exception.FileNotFoundException;

/**
 * @description Manages files uploaded to GOM. This base implementation writes resources to a filesystem.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 10:34:35 PM
 * @version 3.0
 */
@Service("fmgr")
public class FileManagerImpl implements FileManager {
	private static Log log = LogFactory.getLog(FileManagerImpl.class);
	private ConfigDAO configDao;
	private String rootPath;
	
	@Resource(name="configDao")
	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
		this.rootPath = configDao.getConfigValue("fileUpload.rootPath");
	}

	/**
	 * Construct the full real path to a resource in a uploads path area.
	 */
	public File getFile(String path) throws FileNotFoundException, FilePathException {
		File f = getRealFile(path);
		
		//make sure file is not a directory
		if(f.isDirectory()) throw new FilePathException("Invalid path [" + path + "], " + " path is a direcotry.");
		
		//everything looks good, return File
		return f;
	}

	@Override
	public File[] getDirectories(String dir)throws FileNotFoundException, FilePathException {
		// get a reference to the root dir, checks that dir exists & is readable
		File dirFile = getRealFile(dir);
		
		// we only want a list of directories
		File[] dirFiles = dirFile.listFiles(new FileFilter() {
			public boolean accept(File f) {
				return (f!=null) ? f.isDirectory():false;
			}
		});
		
		return dirFiles;
	}

	@Override
	public void saveFile(String path, InputStream is)throws FileNotFoundException, FilePathException, FileIOException{
		String savePath = path;
        if(path.startsWith("/")) {
            savePath = path.substring(1);
        }
        
        // make sure we are allowed to save this file
        if (!isAllow(savePath)) {
            throw new FileIOException("upload type or path occurred error.");
        }
        
        // make sure uploads area exists for this path
        File dirPath = this.getRealFile(null);
        
        // if we are saving into a subfolder, make sure it exists
        if(path.indexOf("/") != -1) {
            String subDir = path.substring(0, path.indexOf("/"));
            File subDirFile = new File(dirPath.getAbsolutePath() + File.separator + subDir);
            if(!subDirFile.exists()) {
                // directory doesn't exist yet, create it
                log.debug("Creating directory [" + subDir + "] automatically");
                subDirFile.mkdir();
            }
        }
        
        // create File that we are about to save
        File saveFile = new File(dirPath.getAbsolutePath() + File.separator + savePath);
        byte[] buffer = new byte[1024];
        int bytesRead = 0;
        OutputStream bos = null;
        try {
        	bos = new FileOutputStream(saveFile);
        	while (true) {
				if (is.available() < 1024) {
					while ((bytesRead = is.read()) != -1)
						bos.write(bytesRead);
					break;
				} else {
					is.read(buffer);
					// 直接将流写入目的地
					bos.write(buffer);
				}
			}// while
        	
            log.debug("The file has been written to [" + saveFile.getAbsolutePath() + "]");
        } catch (Exception e) {
            throw new FileIOException("ERROR uploading file", e);
        } finally {
            try {
                bos.flush();
                bos.close();
                is.close();
            } catch (Exception ignored) {}
        }
	}

	@Override
	public void createDirectory(String path)throws FileNotFoundException, FilePathException, FileIOException {
		// get path to space's uploads area
        File spaceDir = this.getRealFile(null);
        
        String savePath = path;
        if(path.startsWith("/")) {
            savePath = path.substring(1);
        }
        
        if(savePath != null && savePath.indexOf('/') != -1) {
            throw new FilePathException("Invalid path [" + path + "], " + " trying to use nested directories.");
        }
        
        // now construct path to new directory
        File dir = new File(spaceDir.getAbsolutePath() + File.separator + savePath);
        
        // check if it already exists
        if(dir.exists() && dir.isDirectory() && dir.canRead()) {
            // already exists, we don't need to do anything
            return;
        }
        
        try {
            // make sure someone isn't trying to sneek outside the uploads dir
            if(!dir.getCanonicalPath().startsWith(spaceDir.getCanonicalPath())) {
                throw new FilePathException("Invalid path [" + path + "], " + " trying to get outside uploads dir.");
            }
        } catch (IOException ex) {
            // rethrow as FilePathException
            throw new FilePathException(ex);
        }
        
        // create it
        if(!dir.mkdir()) {
            // failed for some reason
            throw new FileIOException("Failed to create directory [" + path + "], " + " probably doesn't have needed parent directories.");
        }
	}

	@Override
	public void deleteFile(String path)throws FileNotFoundException, FilePathException, FileIOException {
		// get path to delete file, checks that path exists and is readable
        File delFile = this.getRealFile(path);
        
        if(!delFile.delete()) {
            throw new FileIOException("Delete failed for [" + path + "], " + " possibly a non-empty directory?");
        }
	}

	@Override
	public void deleteAllFiles(String path) {
		try {
            // get path to root folder
            File delFile = this.getRealFile(path);
            
            // delete folder and it's contents
            deleteAllFiles(delFile);
            
        } catch (FileNotFoundException ex) {
            // if it doesn't exist then we already have no files, so we're done
            return;
        } catch (FilePathException ex) {
            // should never happen when trying to get root folder
        }
	}
	
	/**
	 * Determine if file can be saved given current WebConfig settings.
	 */
	public boolean isAllow(String path) {
		// first check, is upload type allowed?
		String allows = configDao.getConfigValue("fileUpload.typesAllows");
		String forbids = configDao.getConfigValue("fileUpload.typesForbid");
		String[] allowFiles = StringUtils.split(StringUtils.deleteWhitespace(allows), ",");
		String[] forbidFiles = StringUtils.split(StringUtils.deleteWhitespace(forbids), ",");
		if (!checkFileType(allowFiles, forbidFiles, path)) {
			log.warn("only " + allows + " types been supported");
			return false;
		}

		// second check, is save path viable?
		if (path.indexOf("/") != -1) {
			// just make sure there is only 1 directory, we don't allow multiple level directory hierarchies right now
			if (path.lastIndexOf("/") != path.indexOf("/")) {
				log.warn(path + " is bad");
				return false;
			}
		}

		return true;
	}
	
	public String getRootPath() {
		return rootPath;
	}
	
	/**
     * Super simple contentType range rule matching
     */
    private boolean matchContentType(String rangeRule, String contentType) {
        if (rangeRule.equals("*/*")) return true;
        if (rangeRule.equals(contentType)) return true;
        String ruleParts[] = rangeRule.split("/");
        String typeParts[] = contentType.split("/");
        if (ruleParts[0].equals(typeParts[0]) && ruleParts[1].equals("*")) 
            return true;
        
        return false;
    }
    
    //convenience method to delete a folder and all of it's contents.  called recursively
    private void deleteAllFiles(File dir) {
        // delete directory contents
        File[] dirFiles = dir.listFiles();
        if(dirFiles != null && dirFiles.length > 0) {
            for( File file : dirFiles ) {
                if(file.isDirectory()) {
                    // recursive call
                    deleteAllFiles(file);
                } else {
                    file.delete();
                }
            }
        }
        
        // delete directory itself
        dir.delete();
    }
    
    /**
	 * Construct the full real path to a resource in a space's uploads area.
	 */
	private File getRealFile(String path) throws FileNotFoundException, FilePathException {
		File dir = new File(rootPath);
		if(!dir.exists()) dir.mkdirs();
		
		//crop leading slash if it exists
		String relPath = path;
		if(path != null && path.startsWith("/")) relPath = path.substring(1);
		
		// we only allow a single leave of directories right now, so make sure that the path doesn't try to go multiple leaves
		if(relPath != null && (relPath.lastIndexOf('/') > relPath.indexOf('/'))) {
			throw new FilePathException("Invalid path [" + path + "], " + "try to use nested directories.");
		}
		
		//convert "/" to file system specific file separator
		if(relPath != null) relPath = relPath.replace('/', File.separatorChar);
		
		//now from the absolute path
		String filePath = dir.getAbsolutePath();
		if(relPath != null)  filePath += File.separator + relPath;
		
		// make sure path exists and is readable
		File file = new File(filePath);
		if(!file.exists()) throw new FileNotFoundException("Invalid path [" + path + "], " + " directory doesn't exist.");
		else if(!file.canRead()) throw new FilePathException("Invalid path [" + path + "], " + " cannot read from path." );
		
		try {
			//make sure someone isn't trying to sneek outside the upload dir.
			if(!file.getCanonicalPath().startsWith(dir.getCanonicalPath())) throw new FilePathException("Invalid path [" + path + "], " + " trying to get outside upload dir.");
		}catch(IOException ex) {
			//throw as FilePathException
			throw new FilePathException(ex);
		}
		return file;
	}

	
	/**
     * Return true if file is allowed to be uplaoded given specified allowed and
     * forbidden file types.
     */
    private boolean checkFileType(String[] allowFiles, String[] forbidFiles, String fileName) {
        /**
         * Atom Publushing Protocol figure out how to handle file
         * allow/forbid using contentType.
         * TEMPORARY SOLUTION: In the allow/forbid lists we will continue to
         * allow user to specify file extensions (e.g. gif, png, jpeg) but will
         * now also allow them to specify content-type rules (e.g. *.*, image/*, text/xml, etc.).
         */
        
        // if content type is invalid, reject file
        if (fileName == null || fileName.indexOf(".") == -1)
        	return false;
        
        // default to false
        boolean allowFile = false;
        
        // if this person hasn't listed any allows, then assume they want
        // to allow *all* filetypes, except those listed under forbid
        if (allowFiles == null || allowFiles.length < 1)
        	allowFile = true;
        
        // First check against what is ALLOWED
        
        // check file against allowed file extensions
        if (allowFiles != null && allowFiles.length > 0) {
            for (int y=0; y<allowFiles.length; y++) {
                // oops, this allowed rule is a content-type, skip it
                if(fileName.toLowerCase().endsWith(allowFiles[y].toLowerCase())) {
                    allowFile = true;
                    break;
                }
            }
        }
        
        String fileExt = fileName.substring(fileName.indexOf("."));
        // check file against allowed contentTypes
        if (allowFiles != null && allowFiles.length > 0) {
            for (int y=0; y<allowFiles.length; y++) {
                // oops, this allowed rule is NOT a content-type, skip it
                if (matchContentType(allowFiles[y], fileExt)) {
                    allowFile = true;
                    break;
                }
            }
        }
        
        // First check against what is FORBIDDEN
        
        // check file against forbidden file extensions, overrides any allows
        if (forbidFiles != null && forbidFiles.length > 0) {
            for (int x=0; x<forbidFiles.length; x++) {
                // oops, this forbid rule is a content-type, skip it
                if (fileName.toLowerCase().endsWith(forbidFiles[x].toLowerCase())) {
                    allowFile = false;
                    break;
                }
            }
        }
        
        
        // check file against forbidden contentTypes, overrides any allows
        if (forbidFiles != null && forbidFiles.length > 0) {
            for (int x=0; x<forbidFiles.length; x++) {
                // oops, this forbid rule is NOT a content-type, skip it
                if (matchContentType(forbidFiles[x], fileExt)) {
                    allowFile = false;
                    break;
                }
            }
        }
        
        return allowFile;
    }
}
