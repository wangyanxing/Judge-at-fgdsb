package tests;

import java.util.*;
import java.lang.*;

public class test_common {
    
    public static int[][] copy(int[][] input) {
        int[][] target = new int[input.length][];
        for (int i=0; i <input.length; i++) {
            target[i] = Arrays.copyOf(input[i], input[i].length);
        }
        return target;
    }
    
    public static String[][] copy(String[][] input) {
        String[][] target = new String[input.length][];
        for (int i=0; i <input.length; i++) {
            target[i] = copy(input[i]);
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
    
    public static String[] copy(String[] input) {
        String[] target = new String[input.length];
        for (int i=0; i <input.length; i++) {
            target[i] = new String(input[i]);
        }
        return target;
    }
}
