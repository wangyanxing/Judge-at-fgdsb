package judge;
import java.util.*;
import java.lang.*;
import java.io.*;
import tests.*;

public class src {
void segregate(int[] arr) {
    int l = 0, r = arr.length - 1;
    while(l < r) {
        while(arr[l] % 2 == 0 && l < r) ++l;
        while(arr[r] % 2 != 0 && l < r) --r;
        if(l < r) {
            int t = arr[l];
            arr[l] = arr[r];
            arr[r] = t;
            l++;
            r--;
        }
    }
}

public static void main (String[] args) throws java.lang.Exception {

    src s = new src();

    long startTime = System.currentTimeMillis();

    for(int i = 0; i < segregate_even_odd.num_test; ++i) {
        s.segregate(segregate_even_odd.in_0[i]);
        int[] answer = segregate_even_odd.in_0[i];
        if(!segregate_even_odd.test(i)) {
            System.out.printf("%d / %d;", i+1, segregate_even_odd.num_test);
            String outs = common.to_string(segregate_even_odd.in_org_0[i]);
            System.out.print(outs + ";");
            System.out.print(common.to_string(answer) + ";");
            System.out.println(common.to_string(segregate_even_odd.out[i]));
            return;
        }
    }
    long estimatedTime = System.currentTimeMillis() - startTime;
    System.out.print("Accepted;");
    System.out.println(estimatedTime);
}
}
