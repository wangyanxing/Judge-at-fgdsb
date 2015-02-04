package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class three_increasing_elements {
    public static int num_test = 120;
    public static int[][] in_0;
    public static int[][] in_org_0;
    public static int[][] out;
public static boolean test(int[] answer, int i) {
    if(out[i].length != answer.length) return false;
    if(out[i][0] == -1 && out[i][1] == -1 && out[i][2] == -1) {
        return answer[0] == -1 && answer[1] == -1 && answer[2] == -1;
    } else {
        if(answer[0] == -1 || answer[1] == -1 || answer[2] == -1) {
            return false;
        } else {
            return (in_org_0[i][answer[0]] < in_org_0[i][answer[1]] && in_org_0[i][answer[1]] < in_org_0[i][answer[2]]) && (answer[0] < answer[1] && answer[1] < answer[2]);
        }
    }
}

    public static void load_test() {
        File fil = new File("judge/tests/three-increasing-elements.txt");
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
            int[] answer = s.three_increasing_nums(in_0[i]);
            if(!three_increasing_elements.test(answer,i)) {
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(three_increasing_elements.in_org_0[i]);
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
