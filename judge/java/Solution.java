package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public boolean subarray_sum(int[] num, int target) {
        Map<Integer, Integer> map = new HashMap<Integer,Integer>();
        map.put(0, -1);
        for(int i = 0, sum = 0; i < num.length; ++i){
            sum += num[i];
            if(!map.containsKey(sum)){
                map.put(sum, i);
            }
            if(map.containsKey(sum - target)){
                return true;
            }
        }
        return false;
    }
}