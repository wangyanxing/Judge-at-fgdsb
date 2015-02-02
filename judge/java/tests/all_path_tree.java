package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class all_path_tree {
    public static int num_test = 100;
    public static TreeNode[] in_0;
    public static TreeNode[] in_org_0;
    public static int[][][] out;


    public static void load_test() {
        File fil = new File("judge/tests/all-path-tree.txt");
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
            out = common.read_int_matrix_arr(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();
        Solution s = new Solution();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            List<List<Integer>> answer = s.all_path(in_0[i]);
            if(!common.compare_arr_arraylist(out[i], answer)) {
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(all_path_tree.in_org_0[i]);
                System.out.print(outs + ";");
                System.out.print(common.to_string(answer) + ";");
                System.out.println(common.to_string(out[i]));
                return;
            }
        }

        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.print("Accepted;");
        System.out.println(estimatedTime);
    }
}
