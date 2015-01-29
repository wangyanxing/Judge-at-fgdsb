package judge;import java.util.*;import java.lang.*;import java.io.*; public class Solution {
    public String compress(String str) {
        String ret = "";
        if(str.isEmpty()) return ret;
       
        char cur = str.charAt(0);
        int count = 1, id = 1;
        while(id <= str.length()) {
            if(id < str.length() && str.charAt(id) == cur) {
                count++;
            } else {
                ret += cur;
                ret += Integer.toString(count);
                if(id < str.length()) cur = str.charAt(id);
                count = 1;
            }
            id++;
        }
        return ret.length() < str.length() ? ret : str;
    }

}