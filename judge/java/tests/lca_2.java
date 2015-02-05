package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class lca_2 {
    public static int num_test = 120;
    public static TreeNode[] in_0;
    public static TreeNode[] in_org_0;
    public static int[] in_1;
    public static int[] in_org_1;
    public static int[] in_2;
    public static int[] in_org_2;
    public static TreeNode[] out;


    public static void load_test() {
        File fil = new File("judge/tests/lca-2.txt");
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
            in_1 = common.read_int_array(in);
            in_org_1 = test_common.copy(in_1);
            in_2 = common.read_int_array(in);
            in_org_2 = test_common.copy(in_2);
            out = common.read_tree_array(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();
        Solution s = new Solution();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            TreeNode answer = s.lca(in_0[i], in_1[i], in_2[i]);
            if(!common.equals(out[i], answer)) {
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(lca_2.in_org_0[i]) + ", " + common.to_string(lca_2.in_org_1[i]) + ", " + common.to_string(lca_2.in_org_2[i]);
                System.out.print(outs + ";");
                System.out.print(common.node_to_string(answer) + ";");
                System.out.println(common.node_to_string(out[i]));
                return;
            }
        }

        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.print("Accepted;");
        System.out.println(estimatedTime);
    }
}
