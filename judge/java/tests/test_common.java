package tests;

import java.util.*;
import java.lang.*;
import datastruct.*;

public class test_common {
    
    public static int[][] copy(int[][] input) {
        int[][] target = new int[input.length][];
        for (int i=0; i <input.length; i++) {
            target[i] = Arrays.copyOf(input[i], input[i].length);
        }
        return target;
    }
    
    public static boolean[][] copy(boolean[][] input) {
        boolean[][] target = new boolean[input.length][];
        for (int i=0; i <input.length; i++) {
            target[i] = Arrays.copyOf(input[i], input[i].length);
        }
        return target;
    }
    
    public static int[][][] copy(int[][][] input) {
        int[][][] target = new int[input.length][][];
        for (int i=0; i <input.length; i++) {
            target[i] = copy(input[i]);
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
    
    public static TreeNode copy(TreeNode input) {
        if(input == null) return null;
        TreeNode r = new TreeNode(input.val);
        r.left = copy(input.left);
        r.right = copy(input.right);
        return r;
    }
    
    public static TreeNode[] copy(TreeNode[] input) {
        TreeNode[] target = new TreeNode[input.length];
        for (int i=0; i <input.length; i++) {
            target[i] = copy(input[i]);
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
    
    public static Interval[] copy(Interval[] input) {
        Interval[] target = new Interval[input.length];
        for (int i=0; i <input.length; i++) {
            target[i] = new Interval(input[i].begin, input[i].end);
        }
        return target;
    }
    
    public static ArrayList<Interval> copy_al(ArrayList<Interval> input) {
        ArrayList<Interval> target = new ArrayList<Interval>();
        for (int i=0; i <input.size(); i++) {
            target.add(new Interval(input.get(i).begin, input.get(i).end));
        }
        return target;
    }
    
    public static Interval[][] copy(Interval[][] input) {
        Interval[][] target = new Interval[input.length][];
        for (int i=0; i <input.length; i++) {
            target[i] = copy(input[i]);
        }
        return target;
    }
    
    public static ArrayList<ArrayList<Interval>> copy_al_mat(ArrayList<ArrayList<Interval>> input) {
        ArrayList<ArrayList<Interval>> target = new ArrayList<ArrayList<Interval>>();
        for (int i=0; i <input.size(); i++) {
            target.add(copy_al(input.get(i)));
        }
        return target;
    }
}
