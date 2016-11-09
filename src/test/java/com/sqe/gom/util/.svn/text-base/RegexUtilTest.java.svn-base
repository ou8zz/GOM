/**
 * SQE SERVICE INC. All right reserved.
 */
package com.sqe.gom.util;

import static org.junit.Assert.*;
import org.junit.Test;

/**
 * @description RegexUtil test case
 * @author <a href="mailto:sqe_james@126.com">James</a>
 * @date Jul 29, 2011  10:14:05 PM
 * @version 3.0
 */
public class RegexUtilTest {
	@Test
	public void testEncodingEmail() {
		// test mailto: escaping
		String test = "test <a href='mailto:this@email.com'>email</a> string";
		String expect = "test <a href='mailto:%74%68%69%73%40%65%6d%61%69%6c%2e%63%6f%6d'>email</a> string";
		String result = RegexUtil.encodeEmail(test);
		// System.out.println(result);
		assertEquals(expect, result);
	}

	@Test
	public void testObfuscateEmail() {
		// test "plaintext" escaping
		String test = "this@email.com";
		String expect = "this-AT-email-DOT-com";
		String result = RegexUtil.encodeEmail(test);
		assertEquals(expect, result);
	}

	@Test
	public void testHexEmail() {
		// test hex & obfuscate together
		String test = "test <a href='mailto:this@email.com'>this@email.com</a> string, and this@email.com";
		String expect = "test <a href='mailto:%74%68%69%73%40%65%6d%61%69%6c%2e%63%6f%6d'>this-AT-email-DOT-com</a> string, and this-AT-email-DOT-com";
		String result = RegexUtil.encodeEmail(test);
		// System.out.println(result);
		assertEquals(expect, result);
	}
	
	@Test
	public void testEncodeToutf8() {
		String test = "janwer.zhang@gmail.com";
		String expect = "%6a%61%6e%77%65%72%2e%7a%68%61%6e%67%40%67%6d%61%69%6c%2e%63%6f%6d";
		String result = RegexUtil.encode(test);
		assertEquals(expect,result);
	}
	
	@Test
	public void testVerify() {
		String test = "2";
		String test1 = "2.1";
		System.out.println(test1.split("\\.")[0]);
		String test2 = "sqe_james@gmail.com";
		String test3 = "sqe_james";
		String regex1 ="^[\\w\\-]+(\\.[\\w\\-]+)*@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
		String regex2 = "\\d*";
		String regex3 = "^[a-zA-Z_\\-]+([\\w\\-]+)*";
		assertTrue(RegexUtil.verify(regex1, test2));
		assertTrue(RegexUtil.verify(regex2, test));
		assertFalse(RegexUtil.verify(regex2, test1));
		assertTrue(RegexUtil.verify(regex3,test3));
		assertFalse(RegexUtil.verify(regex3,test1));
		assertFalse(RegexUtil.verify(regex3,test2));
	}
}
