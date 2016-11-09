package com.sqe.gom.app;

import java.io.File;
import java.io.InputStream;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Ignore;
import org.junit.Test;
import com.sqe.gom.BaseTest;
import static org.junit.Assert.*;

/**
 * @description Test File Management business layer operations.
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Aug 16, 2011 10:34:35 PM
 * @version 3.0
 */
@Ignore
public class FileManagerTest extends BaseTest{
	private static Log log = LogFactory.getLog(FileManagerTest.class);
	private FileManager fmgr;
	private static final String path = "images";
	
	@Resource(name="fmgr")
	public void setFmgr(FileManager fmgr) {
		this.fmgr = fmgr;
	}
    
    /**
     * Test simple file save/delete.
     */
    @Test
    public void testFileCRUD() throws Exception {
        // we should be starting with 0 files
        assertEquals(0, fmgr.getDirectories(null).length);
        
        // store a file
        InputStream is = getClass().getResourceAsStream("/logo.jpg");
        fmgr.saveFile(path + "/logo.jpg", is);
        
        // make sure file was stored successfully
        assertEquals("logo.jpg", fmgr.getFile("images/logo.jpg").getName());
        assertEquals(1, fmgr.getDirectories(null).length);
        
        // delete file
        fmgr.deleteFile("images/logo.jpg");
        fmgr.deleteFile(path);
        
        // make sure delete was successful
        assertEquals(0, fmgr.getDirectories(null).length);
    }
    
    /**
     * Test simple directory create/delete.
     */
    @Test
    public void testDirectoryCRUD() throws Exception {
        // we should be starting with 0 directories
        assertEquals(0, fmgr.getDirectories(null).length);
        
        // create a directory
        fmgr.createDirectory("bucket0");
        
        // make sure directory was created
        File[] dirs = fmgr.getDirectories(null);
        assertNotNull(dirs);
        assertEquals(1, dirs.length);
        assertEquals("bucket0", dirs[0].getName());
        
        // cleanup
        fmgr.deleteFile("bucket0");
        
        // make sure delete was successful
        assertEquals(0, fmgr.getDirectories(null).length);
    }
    
    /**
     * Test save/delete of files in a directory.
     */
    @Test
    public void testFilesInDirectoriesCRUD() throws Exception {
        // we should be starting with 0 directories
        assertEquals(0, fmgr.getDirectories(null).length);
        
        // create a directory
        fmgr.createDirectory("bucket1");
        
        // make sure directory was created
        File[] dirs = fmgr.getDirectories(null);
        assertNotNull(dirs);
        assertEquals(1, dirs.length);
        assertEquals("bucket1", dirs[0].getName());
        
        // store a file into a subdirectory
        InputStream is = getClass().getResourceAsStream("/logo.jpg");
        fmgr.saveFile("bucket1/123.jpg", is);
        
        // make sure file was stored successfully
        assertEquals("123.jpg", fmgr.getFile("bucket1/123.jpg").getName());
        assertEquals(1, fmgr.getDirectories(null).length);
        
        // cleanup
        fmgr.deleteFile("bucket1/123.jpg");
        fmgr.deleteFile("bucket1");
        
        // we should be back to 0 directories
        assertEquals(0, fmgr.getDirectories(null).length);
    }
    
    /**
     * Test FileManager.saveFile() checks.
     *
     * This should test all conditions where a save should fail.
     */
    @Test
    public void testCanSave() throws Exception {
        Exception exception = null;
        InputStream is = null;
        
        try {
            // path check should fail
            fmgr.saveFile("some/path/foo.ppt", is);
        } catch (Exception ex) {
        	log.error(ex);
            exception = ex;
        }
        assertNotNull(exception);
        exception = null;

        try {
            // forbidden types check should fail
            fmgr.saveFile("test.exe", is);
        } catch (Exception ex) {
        	log.error(ex);
            exception = ex;
        }
        assertNotNull(exception);
        exception = null;
    }
}
