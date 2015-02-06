package judge;

import java.io.*;
import java.lang.*;
import java.util.*;

import datastruct.*;

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
    
    public static String to_string(TreeNodeWithParent root) {
        String ret = "";
        if (root == null) {
            ret = "# ";
            return ret;
        }
        
        ret += Integer.toString(root.val);
        ret += " ";
        
        ret += to_string(root.left);
        ret += to_string(root.right);
        return ret;
    }

    public static String to_string(TreeNode root) {
        String ret = "";
        if (root == null) {
            ret = "# ";
            return ret;
        }
        
        ret += Integer.toString(root.val);
        ret += " ";
        
        ret += to_string(root.left);
        ret += to_string(root.right);
        return ret;
    }
    
    public static String node_to_string(TreeNode n) {
        return n == null ? "null" : Integer.toString(n.val);
    }
    
    public static String node_to_string(TreeNodeWithParent n) {
        return n == null ? "null" : Integer.toString(n.val);
    }
    
    public static boolean compare_interval_list(List<Interval> a0, List<Interval> a1) {
        if(a0.size() != a1.size()) return false;
        for(int i = 0; i < a0.size(); ++i) {
            if(a0.get(i).begin != a1.get(i).begin ||
               a0.get(i).end != a1.get(i).end) return false;
        }
        return true;
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
    
    public static boolean equals(TreeNode n1, TreeNode n2) {
        if(n1 == null && n2 == null) return true;
        if(n1 == null || n2 == null) return false;
        return n1.val == n2.val;
    }
    
    public static boolean equals(TreeNodeWithParent n1, TreeNodeWithParent n2) {
        if(n1 == null && n2 == null) return true;
        if(n1 == null || n2 == null) return false;
        return n1.val == n2.val;
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
    
    public static TreeNode read_tree(BufferedReader in, int nums) throws IOException {
        if(nums == 0) {
            return null;
        }
        String cur = in.readLine();
        
        if(cur.equals("#")) {
            return null;
        }
        TreeNode root = new TreeNode(Integer.parseInt(cur));
        nums--;
        root.left = read_tree(in, nums);
        nums--;
        root.right = read_tree(in, nums);
        return root;
    }
    
    public static TreeNodeWithParent read_tree_with_p(BufferedReader in, int nums) throws IOException {
        if(nums == 0) {
            return null;
        }
        String cur = in.readLine();
        
        if(cur.equals("#")) {
            return null;
        }
        TreeNodeWithParent root = new TreeNodeWithParent(Integer.parseInt(cur));
        nums--;
        root.left = read_tree_with_p(in, nums);
        if(root.left != null) root.left.parent = root;
        nums--;
        root.right = read_tree_with_p(in, nums);
        if(root.right != null) root.right.parent = root;
        return root;
    }
    
    public static TreeNode[] read_tree_array(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        TreeNode[] ret = new TreeNode[number];
        for(int i = 0; i < number; ++i) {
            int num = Integer.parseInt(in.readLine());
            ret[i] = read_tree(in, num);
        }
        return ret;
    }
    
    public static TreeNode[][] read_tree_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        TreeNode[][] ret = new TreeNode[number][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_tree_array(in);
        }
        return ret;
    }
    
    public static TreeNodeWithParent[] read_tree_with_p_array(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        TreeNodeWithParent[] ret = new TreeNodeWithParent[number];
        for(int i = 0; i < number; ++i) {
            int num = Integer.parseInt(in.readLine());
            ret[i] = read_tree_with_p(in, num);
        }
        return ret;
    }
    
    public static TreeNodeWithParent[][] read_tree_with_p_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        TreeNodeWithParent[][] ret = new TreeNodeWithParent[number][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_tree_with_p_array(in);
        }
        return ret;
    }
    
    public static Interval[] read_interval_array(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        Interval[] ret = new Interval[number];
        for(int i = 0; i < number; ++i) {
            ret[i] = new Interval();
            ret[i].begin = Integer.parseInt(in.readLine());
            ret[i].end = Integer.parseInt(in.readLine());
        }
        return ret;
    }
    
    public static ArrayList<Interval> read_interval_arraylist(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        ArrayList<Interval> ret = new ArrayList<Interval>();
        for(int i = 0; i < number; ++i) {
            int begin = Integer.parseInt(in.readLine());
            int end = Integer.parseInt(in.readLine());
            ret.add(new Interval(begin, end));
        }
        return ret;
    }
    
    public static Interval[][] read_interval_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        Interval[][] ret = new Interval[number][];
        for(int i = 0; i < number; ++i) {
            ret[i] = read_interval_array(in);
        }
        return ret;
    }
    
    public static ArrayList<ArrayList<Interval>> read_interval_al_matrix(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        ArrayList<ArrayList<Interval>> ret = new ArrayList<ArrayList<Interval>>();
        for(int i = 0; i < number; ++i) {
            ret.add(read_interval_arraylist(in));
        }
        return ret;
    }
    
    public static ArrayList<ArrayList<ArrayList<Interval>>> read_interval_al_matrix_arr(BufferedReader in) throws IOException {
        String s = in.readLine();
        int number = Integer.parseInt(s);
        
        ArrayList<ArrayList<ArrayList<Interval>>> ret = new ArrayList<ArrayList<ArrayList<Interval>>>();
        for(int i = 0; i < number; ++i) {
            ret.add(read_interval_al_matrix(in));
        }
        return ret;
    }
    
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

    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    private static PrintStream old_stream = new PrintStream(System.out);
    
    public static void capture_stdout() {
        try {
            System.setOut(new PrintStream(new FileOutputStream("judge/stdout.txt", false)));
        } catch (FileNotFoundException fnfEx) {
            System.out.println("Error in IO Redirection");
        } catch (Exception ex) {
            System.out.println("Redirecting output & exceptions to file");
            ex.printStackTrace();
        }
    }
    
    public static void release_stdout() {
        System.setOut(old_stream);
    }
}
