package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class meeting_rooms_1 {
    public static int num_test = 91;
    public static Interval[][] in_0;
    public static Interval[][] in_org_0;
    public static boolean[] out;


    public static void load_test() {
        File fil = new File("judge/tests/meeting-rooms-1.txt");
        FileReader inputFil = null;
        try {
            inputFil = new FileReader(fil);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader in = new BufferedReader(inputFil);
        try {
            in_0 = common.read_interval_matrix(in);
            in_org_0 = test_common.copy(in_0);
            out = common.read_bool_array(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();
        Solution s = new Solution();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            boolean answer = s.attend_all(in_0[i]);
            if(answer != out[i]) {
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(meeting_rooms_1.in_org_0[i]);
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
