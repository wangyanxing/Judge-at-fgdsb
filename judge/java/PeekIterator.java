package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; /*
public class Iterator {
    public int get_next();
    public boolean has_next();
}
*/

public class PeekIterator {
    public PeekIterator(Iterator it) {
    }
    
    public int peek() {
        return 1;
    }
    
    public boolean has_next() {
        return false;
    }
    
    public int get_next() {
        return 2;
    }
}