package judge;
import java.util.*;
import java.lang.*;
import java.io.*;

public class src {
void wiggle_sort(int[] arr) {
    arr[0] = 100;
}

public static void main (String[] args) throws java.lang.Exception {
    final int num_test = 3;
    src s = new src();
    int[][] in_0 = {{1, 2, 3},{1, 3, 5, 7, 9},{9, 7, 4, 8, 1}};
    int[][] in_org_0 = {{1, 2, 3},{1, 3, 5, 7, 9},{9, 7, 4, 8, 1}};
    int[][] out = {{1, 3, 2},{1, 5, 3, 9, 7},{7, 9, 4, 8, 1}};

    for(int i = 0; i < num_test; ++i) {
        s.wiggle_sort(in_0[i]);
        int[] answer = in_0[i];
        if(!common.test_wiggle(in_0[i])) {
            System.out.printf("%d / %d;", i+1, num_test);
            String outs = common.to_string(in_org_0[i]);
            System.out.print(outs + ";");
            System.out.print(common.to_string(answer) + ";");
            System.out.println(common.to_string(out[i]));
            return;
        }
    }
    System.out.println("Accepted");
}
}
