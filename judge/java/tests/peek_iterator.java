package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

public class peek_iterator {
    public static int num_test = 50;
    public static int[][] in_0;
    public static int[][] in_org_0;
    public static boolean[] out;


    public static void load_test() {
        File fil = new File("judge/tests/peek-iterator.txt");
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
            out = common.read_bool_array(in);
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
            
            Iterator it = Arrays.asList(in_0[i]).iterator();
            PeekIterator pi = new PeekIterator(it);
            
            for(int j = 0; j < in_0[i].length; ++j) {
                int num = in_0[i][j];
                boolean has_next_wrong = false, peek_wrong = false, get_next_wrong = false;
                
                if(!pi.has_next()) has_next_wrong = true;
                if(pi.peek() != num) peek_wrong = true;
                int nxt = pi.get_next();
                if(nxt != num) get_next_wrong = true;
                
                if(has_next_wrong || peek_wrong || get_next_wrong) {
                    common.release_stdout();
                    
                    String msg = "";
                    if(has_next_wrong) msg += "has_next() == false, ";
                    if(peek_wrong) msg += "peek() == " + Integer.toString(pi.peek()) + ", ";
                    if(get_next_wrong) msg += "get_next() == " + Integer.toString(nxt) + ", ";
                    
                    System.out.printf("%d / %d;", i+1, num_test);
                    String outs = common.to_string(peek_iterator.in_org_0[i]);
                    System.out.print(outs + ";");
                    System.out.print(msg + ";");
                    System.out.println("");
                    return;
                }
            }
        }

        common.release_stdout();
        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.print("Accepted;");
        System.out.println(estimatedTime);
    }
}
