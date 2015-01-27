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
    
    public static String to_string(boolean num) {
        return num ? "true" : "false";
    }
    
    public static String to_string(List<Integer> num) {
        String ret = "[";
        for(int i = 0; i < num.size(); ++i) {
            if(i != 0) ret += ", ";
            ret += Integer.toString(num.get(i));
        }
        ret += "]";
        return ret;
    }
    
    public static boolean compare_arr_arraylist(int[] array, List<Integer> al) {
        ArrayList<Integer> list = new ArrayList<Integer>(array.length);
        for (int i = 0; i < array.length; i++)
            list.add(Integer.valueOf(array[i]));
        return al.equals(list);
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
    
    
    public static int[][] copy(int[][] input) {
        int[][] target = new int[input.length][];
        for (int i=0; i <input.length; i++) {
            target[i] = Arrays.copyOf(input[i], input[i].length);
        }
        return target;
    }
    
    public static int[] copy(int[] input) {
        int[] target = new int[input.length];
        for (int i=0; i <input.length; i++) {
            target[i] = input[i];
        }
        return target;
    }
    
    public static boolean equals(int[] a0, int[] a1) {
        if(a0.length != a1.length) return false;
        for (int i=0; i <a0.length; i++) {
            if(a0[i] != a1[i]) return false;
        }
        return true;
    }
    
    public static boolean test_anagram(int[] a0, int[] a1) {
        if(a0.length != a1.length) return false;
        int[] t0 = copy(a0);
        int[] t1 = copy(a1);
        Arrays.sort(t0);
        Arrays.sort(t1);
        return equals(t0, t1);
    }
}
