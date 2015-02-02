package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public int[] product(int[] a) {
        int[] ret = new int[a.length];
        for(int prod = 1, i = 0; i < a.length; ++i) {
            prod *= a[i];
            ret[i] = prod;
        }
        for(int prod = 1, i = a.length - 1; i >= 0; --i) {
            ret[i] = (i > 0 ? ret[i-1] : 1) * prod;
            prod *= a[i];
        }
        return ret;
    }
}