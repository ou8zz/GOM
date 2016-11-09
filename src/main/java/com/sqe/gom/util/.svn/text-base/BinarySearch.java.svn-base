package com.sqe.gom.util;

import com.sqe.gom.exception.GomException;

public class BinarySearch {
	/**
     * description : 二分查找
     * 
     * ①找出位于数组中间的值，并存放在一个变量中（为了下面的说明，变量暂时命名为temp）；
     * ②需要找到的key和temp进行比较；
     * ③如果key值大于temp，则把数组中间位置作为下一次计算的起点；重复① ②
     * ④如果key值小于temp，则把数组中间位置作为下一次计算的终点；重复① ② ③
     * ⑤如果key值等于temp，则返回数组下标，完成查找。
     *
     * @param array 需要查找的有序数组
     * @param from 起始下标
     * @param to 终止下标
     * @param key 需要查找的关键字
     * @return 则返回数组下标，完成查找
     * @throws Exception
     */
    public static <E extends Comparable<E>> int binarySearch(E[] array, int from, int to, E key) throws GomException {
        if(from < 0 || to < 0) {throw new IllegalArgumentException("params from & length must larger than 0 .");}
        if(from < to) {
            int middle = (from >>> 1) + (to >>> 1); // 右移即除2
            E temp = array[middle];
            if (temp.compareTo(key) > 0) {
                to = middle - 1;
            } else if (temp.compareTo(key) < 0) {
                from = middle + 1;
            } else {
                return middle;
            }
        } else return -1;
        return binarySearch(array, from, to, key);
    }
}
