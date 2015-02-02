package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class query_intervals_2 {
    public static int num_test = 30;
    public static ArrayList<ArrayList<Interval>> in_0;
    public static ArrayList<ArrayList<Interval>> in_org_0;
    public static int[] in_1;
    public static int[] in_org_1;
    public static ArrayList<ArrayList<ArrayList<Interval>>> out;


    public static void load_test() {
        File fil = new File("judge/tests/query-intervals-2.txt");
        FileReader inputFil = null;
        try {
            inputFil = new FileReader(fil);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader in = new BufferedReader(inputFil);
        try {
            in_0 = common.read_interval_al_matrix(in);
            in_org_0 = test_common.copy_al_mat(in_0);
            in_1 = common.read_int_array(in);
            in_org_1 = test_common.copy(in_1);
            out = common.read_interval_al_matrix_arr(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            Intervals inte = new Intervals(in_0.get(i));
            inte.preprocess();
            for(int j = 0; j < in_1[i]; ++j) {
                List<Interval> answer = inte.query(j);
                if(!common.compare_interval_list(answer,out.get(i).get(j))) {
                    System.out.printf("%d / %d;", i+1, num_test);
                    String outs = query_intervals_2.in_org_0.get(i).toString();
                    outs += ", " + Integer.toString(j);
                    System.out.print(outs + ";");
                    System.out.print(common.to_string(answer) + ";");
                    System.out.println(out.get(i).get(j).toString());
                    return;
                }
            }
        }

        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.print("Accepted;");
        System.out.println(estimatedTime);
    }
}
