package com.sqe.gom.util;

import java.util.ArrayList;
import java.util.List;
import static org.junit.Assert.*;
import org.junit.Test;
import com.sqe.gom.exception.GomException;

public class BinarySearchTest {
	@Test
	public void searchDate() throws GomException {
		List<String> array = new ArrayList<String>();
		String key = "2011-01-25";
		array.add("2012-01-01");
		array.add("2012-01-02");
		array.add("2012-01-03");
		array.add("2012-04-05");
		array.add("2012-04-06");
		array.add("2012-04-07");
		array.add("2012-05-01");
		array.add("2012-05-02");
		array.add("2012-05-03");
		array.add("2012-09-28");
		array.add("2012-10-02");
		array.add("2012-10-03");
		array.add("2012-10-05");
		array.add("2012-10-07");
		array.add("2012-12-23");
		array.add("2012-12-24");
		array.add("2012-12-25");
		array.add("2012-12-26");
		array.add("2012-12-27");
		
		
		int tag = BinarySearch.binarySearch(array.toArray(new String[0]), 0, array.size(), key);
		assertEquals(array.get(tag), key);
	}
}
