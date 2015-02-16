package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public List<Integer> longest_subarray(int[] arr) {
        int sum = 0, length = 0, begin = -1;
        HashMap<Integer,Integer> record = new HashMap<Integer,Integer>();
        record.put(0,-1);
        for(int i = 0; i < arr.length; ++i) {
            sum += arr[i];
            if(record.containsKey(sum)) {
                int first = record.get(sum);
                if(i - first > length) {
                    length = i - first;
                    begin = first + 1;
                }
            } else {
                record.put(sum,i);
            }
        }
        List<Integer> ret = new ArrayList<Integer>();
        if(begin >= 0) {
            for(int i = 0; i < length; ++i) {
                ret.add(arr[i + begin]);
            }
        }
        return ret;
    }
}