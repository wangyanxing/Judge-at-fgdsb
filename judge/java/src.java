package judge;
import java.util.*;
import java.lang.*;
import java.io.*;

public class src {
int plus_num(int a, int b) {
    return a+b;
}

public static void main (String[] args) throws java.lang.Exception {
    final int num_test = 5;
    src s = new src();
    int[] in_0 = {1,1,2,100,100};
    int[] in_1 = {0,1,1,13,200};
    int[] in_org_0 = {1,1,2,100,100};
    int[] in_org_1 = {0,1,1,13,200};
    int[] out = {1,2,3,113,300};

    for(int i = 0; i < num_test; ++i) {
        int answer = s.plus_num(in_0[i],in_1[i]);
        if(answer != out[i]) {
            System.out.printf("%d / %d;", i+1, num_test);
            String outs = common.to_string(in_org_0[i]) + ", " + common.to_string(in_org_1[i]);
            System.out.print(outs + ";");
            System.out.print(common.to_string(answer) + ";");
            System.out.println(common.to_string(out[i]));
            return;
        }
    }
    System.out.println("Accepted");
}
}
