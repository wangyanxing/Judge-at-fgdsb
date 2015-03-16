package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public boolean happy(int number) {
        int m = 0;
        int digit = 0;
        HashSet<Integer> cycle = new HashSet<Integer>();
        while(number != 1 && cycle.add(number)){
            m = 0;
            while(number > 0){
               digit = (int)(number % 10);
               m += digit*digit;
               number /= 10;
            }
            number = m;
       }
       return number == 1;
    }
}