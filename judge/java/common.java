package judge;

import java.util.*;
import java.lang.*;

public class common {
    public static <T> String to_string(T[] arr) {
        String ret = "[";
        for (int i = 0; i < arr.length; ++i){
            if(i != 0) ret += ", ";
            ret += arr[i].toString();
        }
        ret += "]";
        return ret;
    }
    
    public static String to_string(int[] arr) {
        return Arrays.toString(arr);
    }
    
    public static String to_string(int[][] arr) {
        String ret = "[";
        for(int[] a : arr)
            ret += "  " + Arrays.toString(a);
        ret += "]";
        return ret;
    }
    
    public static String to_string(double[] arr) {
        return Arrays.toString(arr);
    }
    
    public static String to_string(int num) {
        return Integer.toString(num);
    }
    
    public static String to_string(double num) {
        return Double.toString(num);
    }
    
    public static String to_string(String num) {
        return num;
    }
    
    public static boolean test_wiggle(int[] arr) {
        if(arr.length == 0) return true;
        boolean test_flag = true;
        for(int i = 0; i < arr.length-1; ++i) {
            if(test_flag) {
                if(arr[i] > arr[i+1]) return false;
            } else {
                if(arr[i] < arr[i+1]) return false;
            }
            test_flag = !test_flag;
        }
        return true;
    }
}
