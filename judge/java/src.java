package judge;
import java.util.*;
import java.lang.*;
import java.io.*;
import tests.*;

public class src {
int num_colors(int n, int k) {
    if(n <= 0 || k <= 0) return 0;
    int prev_prev = k, prev = k * k;
    for (int i = 0; i < n - 1; ++i) {
        int old_dif = prev;
        prev = (k - 1) * (prev_prev + prev);
        prev_prev = old_dif;
    }
    return prev_prev;
}

public static void main (String[] args) throws java.lang.Exception {

    src s = new src();

    long startTime = System.currentTimeMillis();

    for(int i = 0; i < fence_painter.num_test; ++i) {
        int answer = s.num_colors(fence_painter.in_0[i],fence_painter.in_1[i]);
        if(answer != fence_painter.out[i]) {
            System.out.printf("%d / %d;", i+1, fence_painter.num_test);
            String outs = common.to_string(fence_painter.in_org_0[i]) + ", " + common.to_string(fence_painter.in_org_1[i]);
            System.out.print(outs + ";");
            System.out.print(common.to_string(answer) + ";");
            System.out.println(common.to_string(fence_painter.out[i]));
            return;
        }
    }
    long estimatedTime = System.currentTimeMillis() - startTime;
    System.out.print("Accepted;");
    System.out.println(estimatedTime);
}
}
