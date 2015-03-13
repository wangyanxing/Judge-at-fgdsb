package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public boolean subarray_sum(int[] array, int t) {
        int sum = array[0], last = 0;
        for(int i = 1; i < array.length; ++i) {
            while(sum > t) sum -= array[last++];
            
            if(sum == t) return true;
            else sum += array[i];
        }
        return sum == t;
    }
}