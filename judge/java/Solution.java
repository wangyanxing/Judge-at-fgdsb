package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public char smallest_character(String str, char c) {
        int s = 0, e = str.length();
        while(s<e){
            int mid=(s+e)/2;
            if(str.charAt(mid) <= c)
                s=mid+1;
            else
                e=mid;
        }
        return e==str.length() ? str.charAt(0) : str.charAt(e);
    }
}