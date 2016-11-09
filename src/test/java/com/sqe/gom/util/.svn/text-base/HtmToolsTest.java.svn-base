package com.sqe.gom.util;

import static org.junit.Assert.*;
import org.junit.Test;

public class HtmToolsTest {
	@Test
	public void testExtractHTML() {
        String test = "<a>keep me</a>";
        String expect = "<a></a>";
        String result = HtmTools.extractHTML(test);
        assertEquals(expect, result);
    }
    
	@Test
    public void testRemoveHTML() {
        String test = "<br><br><p>a <b>bold</b> sentence with a <a href=\"http://example.com\">link</a></p>";
        String expect = "a bold sentence with a link";
        String result = HtmTools.removeHTML(test, false);
        assertEquals(expect, result);
    }
    
	@Test
    public void testTruncateNicely1() {
        String test = "blah blah blah blah blah";
        String expect = "blah blah blah";
        String result = HtmTools.truncateNicely(test, 11, 15, "");
        assertEquals(expect, result);
    }
    
	@Test
    public void testTruncateNicely2() {
        String test = "<p><b>blah1 blah2</b> <i>blah3 blah4 blah5</i></p>";
        String expect = "<p><b>blah1 blah2</b> <i>blah3</i></p>";
        String result = HtmTools.truncateNicely(test, 15, 20, "");
        //System.out.println(result);
        assertEquals(expect, result);
    }
}
