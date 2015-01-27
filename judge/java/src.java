package judge;
import java.util.*;
import java.lang.*;
import java.io.*;
import tests.*;

public class src {
int second_largest(int[] arr) {
    if(arr.length < 2) return 0;
    int second_max = arr[0], max_val = arr[0];
    for(int i = 1; i < arr.length; ++i) {
        if(arr[i] > max_val) {
            second_max = max_val;
            max_val = arr[i];
        } else if(arr[i] > second_max && arr[i] != max_val) {
            second_max = arr[i];
        }
    }
    return second_max == max_val ? 0 : second_max;
}

public static void main (String[] args) throws java.lang.Exception {

    src s = new src();

    long startTime = System.currentTimeMillis();

    for(int i = 0; i < second_largest_number.num_test; ++i) {
        int answer = s.second_largest(second_largest_number.in_0[i]);
        if(answer != second_largest_number.out[i]) {
            System.out.printf("%d / %d;", i+1, second_largest_number.num_test);
            String outs = common.to_string(second_largest_number.in_org_0[i]);
            System.out.print(outs + ";");
            System.out.print(common.to_string(answer) + ";");
            System.out.println(common.to_string(second_largest_number.out[i]));
            return;
        }
    }
    long estimatedTime = System.currentTimeMillis() - startTime;
    System.out.print("Accepted;");
    System.out.println(estimatedTime);
}
}
