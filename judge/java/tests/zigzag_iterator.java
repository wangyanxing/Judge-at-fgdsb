package tests;
import java.util.*;
import java.lang.*;
import java.io.*;
import judge.*;
import datastruct.*;

class _ZigzagIterator {
    public _ZigzagIterator(Iterator i0, Iterator i1) {
        _its[0] = i0;
        _its[1] = i1;
        _pointer = i0.hasNext() ? 0 : 1;
    }
    public boolean has_next() {
        return _its[_pointer].hasNext();
    }
    public int get_next() {
        Integer ret = (Integer)_its[_pointer].next(), old = _pointer;
        do {
            if(++_pointer >= 2) _pointer = 0;
        } while(!_its[_pointer].hasNext() && _pointer != old);
        return ret;
    }
    Iterator[] _its = new ArrayIterator[2];
    int _pointer;
}

public class zigzag_iterator {
    public static int num_test = 55;
    public static Integer[][] in_0;
    public static Integer[][] in_org_0;
    public static Integer[][] in_1;
    public static Integer[][] in_org_1;


    public static void load_test() {
        File fil = new File("judge/tests/zigzag-iterator.txt");
        FileReader inputFil = null;
        try {
            inputFil = new FileReader(fil);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader in = new BufferedReader(inputFil);
        try {
            in_0 = common.read_integer_matrix(in);
            in_org_0 = test_common.copy(in_0);
            in_1 = common.read_integer_matrix(in);
            in_org_1 = test_common.copy(in_1);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void judge() {
        load_test();
        common.capture_stdout();

        long startTime = System.currentTimeMillis();

        for(int i = 0; i < num_test; ++i) {
            System.out.printf("Testing case #%d\n", i+1);
            
            Iterator i0 = new ArrayIterator<Integer>(in_0[i]);
            Iterator i1 = new ArrayIterator<Integer>(in_1[i]);
            ZigzagIterator pi = new ZigzagIterator(i0, i1);
            ArrayList<Integer> w = new ArrayList<Integer>();
            while(pi.has_next()) w.add(pi.get_next());
            
            Iterator _i0 = new ArrayIterator<Integer>(in_0[i]);
            Iterator _i1 = new ArrayIterator<Integer>(in_1[i]);
            _ZigzagIterator wi = new _ZigzagIterator(_i0, _i1);
            ArrayList<Integer> ow = new ArrayList<Integer>();
            while(wi.has_next()) ow.add(wi.get_next());
            
            if(!common.compare_arraylist(ow, w)) {
                common.release_stdout();
                
                System.out.printf("%d / %d;", i+1, num_test);
                String outs = common.to_string(zigzag_iterator.in_org_0[i]) + ", " + common.to_string(zigzag_iterator.in_org_1[i]);
                System.out.print(outs + ";");
                System.out.print(common.to_string(w) + ";");
                System.out.println(common.to_string(ow));
                return;
            }
        }

        common.release_stdout();
        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.print("Accepted;");
        System.out.println(estimatedTime);
    }
}
