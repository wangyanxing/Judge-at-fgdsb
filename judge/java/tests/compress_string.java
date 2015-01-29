package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;

public class compress_string {
    public static int num_test = 105;
    public static String[] in_0;
    public static String[] in_org_0;
    public static String[] out;


    public static void load_test() {
        File fil = new File("judge/tests/compress-string.txt");
        FileReader inputFil = null;
        try {
            inputFil = new FileReader(fil);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader in = new BufferedReader(inputFil);
        try {
            in_0 = common.read_string_array(in);
            in_org_0 = test_common.copy(in_0);
            out = common.read_string_array(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();
        Solution s = new Solution();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            String answer = s.compress(in_0[i]);
            if(!out[i].equals(answer)) {
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(compress_string.in_org_0[i]);
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
