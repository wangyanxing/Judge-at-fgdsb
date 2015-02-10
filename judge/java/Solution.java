package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public char smallest_character(String str, char c) {
        int l = 0, r = str.length() - 1;
        char ret = str.charAt(0);
        while(l <= r) {
            int m = l + (r-l) / 2;
            if(str.charAt(m) > c) {
                ret = str.charAt(m);
                r = m - 1;
            } else {
                l = m + 1;
            }
        }
        return ret;
    }
}