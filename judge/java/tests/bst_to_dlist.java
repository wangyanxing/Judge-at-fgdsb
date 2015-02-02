package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class bst_to_dlist {
    public static int num_test = 100;
    public static TreeNode[] in_0;
    public static TreeNode[] in_org_0;
    public static int[][] out;

    public static boolean check_dlist(int[] arr, TreeNode list) {
        TreeNode cur = list;
        TreeNode pre = null;
        int i = 0;
        while(cur != null) {
            if(i >= arr.length || arr[i] != cur.val) return false;
            ++i;
            pre = cur;
            cur = cur.right;
        }
        if(i != arr.length) return false;
        cur = pre;
        --i;
        while(cur != null) {
            if(i < 0 || arr[i] != cur.val) return false;
            --i;
            TreeNode last = cur;
            cur = cur.left;
            last.left = null;
        }
        if(i != -1) return false;
        return true;
    }

    public static String dlist_to_string(TreeNode list) {
        String ret = "[";
        boolean first = true;
        while(list != null) {
            if(!first) ret += ", ";
            ret += Integer.toString(list.val);
            list = list.right;
            first = false;
        }
        ret += "]";
        return ret;
    }

    public static void load_test() {
        File fil = new File("judge/tests/bst-to-dlist.txt");
        FileReader inputFil = null;
        try {
            inputFil = new FileReader(fil);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader in = new BufferedReader(inputFil);
        try {
            in_0 = common.read_tree_array(in);
            in_org_0 = test_common.copy(in_0);
            out = common.read_int_matrix(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();
        Solution s = new Solution();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            TreeNode answer = s.bst_to_list(in_0[i]);
            if(!check_dlist(out[i], answer)) {
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(bst_to_dlist.in_org_0[i]);
                System.out.print(outs + ";");
                System.out.print(dlist_to_string(answer) + ";");
                System.out.println(common.to_string(out[i]));
                return;
            }
        }

        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.print("Accepted;");
        System.out.println(estimatedTime);
    }
}
