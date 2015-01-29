package judge;

import java.io.*;
import java.lang.*;
import java.util.*;

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
        for(int i = 0; i < arr.length; ++i) {
            if(i != 0) ret += ", ";
            ret += Arrays.toString(arr[i]);
        }
        ret += "]";
        return ret;
    }
    
    public static String to_string(double[] arr) {
        return Arrays.toString(arr);
    }
    
    public static String to_string(String[] arr) {
        return Arrays.toString(arr);
    }
    
    public static String to_string(int num) {
        return Integer.toString(num);
    }
    
    public static String to_string(double num) {
        return Double.toString(num);
    }
    
    public static String to_string(Object obj) {
        return obj.toString();
    }
    
    public static String to_string(boolean num) {
        return num ? "true" : "false";
    }
    
    public static boolean compare_arr_arraylist(int[] array, List<Integer> al) {
        for(int i = 0; i < array.length; ++i) {
            if(array[i] != al.get(i)) return false;
        }
        return true;
    }
    
    public static boolean compare_arr_arraylist(int[][] array, List<List<Integer>> al) {
        if(array.length != al.size()) return false;
        for(int i = 0; i < array.length; ++i) {
            if(!compare_arr_arraylist(array[i], al.get(i))) {
                return false;
            }
        }
        return true;
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
    
    public static boolean equals(String[] a0, String[] a1) {
        if(a0.length != a1.length) return false;
        for (int i=0; i <a0.length; i++) {
            if(!a0[i].equals(a1[i])) return false;
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
    
    /////////////////////////////////////////////////////////////////////////////////////////////
    
    public static boolean[] read_bool_array(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        boolean[] ret = new boolean[number];
        for(int i = 0; i < number; ++i) {
            s = in.readLine();
            ret[i] = Integer.parseInt(s) == 1 ? true : false;
        }
        return ret;
    }
    
    public static boolean[][] read_bool_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        boolean[][] ret = new boolean[number][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_bool_array(in);
        }
        return ret;
    }
    
    public static boolean[][][] read_bool_matrix_arr(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        boolean[][][] ret = new boolean[number][][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_bool_matrix(in);
        }
        return ret;
    }
    
    public static int[] read_int_array(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        int[] ret = new int[number];
        for(int i = 0; i < number; ++i) {
            s = in.readLine();
            ret[i] = Integer.parseInt(s);
        }
        return ret;
    }
    
    public static int[][] read_int_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        int[][] ret = new int[number][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_int_array(in);
        }
        return ret;
    }
    
    public static int[][][] read_int_matrix_arr(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        int[][][] ret = new int[number][][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_int_matrix(in);
        }
        return ret;
    }
    
    public static double[] read_double_array(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        double[] ret = new double[number];
        for(int i = 0; i < number; ++i) {
            s = in.readLine();
            ret[i] = Double.parseDouble(s);
        }
        return ret;
    }
    
    public static double[][] read_double_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        double[][] ret = new double[number][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_double_array(in);
        }
        return ret;
    }
    
    public static double[][][] read_double_matrix_arr(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        double[][][] ret = new double[number][][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_double_matrix(in);
        }
        return ret;
    }
    
    public static String[] read_string_array(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        String[] ret = new String[number];
        for(int i = 0; i < number; ++i) {
            ret[i] = in.readLine();
        }
        return ret;
    }
    
    public static String[][] read_string_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        String[][] ret = new String[number][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_string_array(in);
        }
        return ret;
    }
    
    public static String[][][] read_string_matrix_arr(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        String[][][] ret = new String[number][][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_string_matrix(in);
        }
        return ret;
    }

}
