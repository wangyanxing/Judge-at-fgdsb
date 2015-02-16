package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class coin_change {
    public static int num_test = 5;
    public static int[][] in_0;
    public static int[][] in_org_0;
    public static int[] in_1;
    public static int[] in_org_1;
    public static int[] out;


    public static void load_test() {
        File fil = new File("judge/tests/coin-change.txt");
        FileReader inputFil = null;
        try {
            inputFil = new FileReader(fil);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader in = new BufferedReader(inputFil);
        try {
            in_0 = common.read_int_matrix(in);
            in_org_0 = test_common.copy(in_0);
            in_1 = common.read_int_array(in);
            in_org_1 = test_common.copy(in_1);
            out = common.read_int_array(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();
        common.capture_stdout();
        Solution s = new Solution();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            System.out.printf("Testing case #%d\n", i+1);
            int answer = s.min_coins(in_0[i], in_1[i]);
            if(answer != out[i]) {
                common.release_stdout();
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(coin_change.in_org_0[i]) + ", " + common.to_string(coin_change.in_org_1[i]);
                System.out.print(outs + ";");
                System.out.print(common.to_string(answer) + ";");
                System.out.println(common.to_string(out[i]));
                return;
            }
        }

        common.release_stdout();
        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.print("Accepted;");
        System.out.println(estimatedTime);
    }
}
