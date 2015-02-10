package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public char smallest_character(String str, char c) {
        for(int i = 0; i < str.length(); ++i) {
            if (str.charAt(i) > c) return str.charAt(i);
        }
        return str.charAt(0);
    }
}