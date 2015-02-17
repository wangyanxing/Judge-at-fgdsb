package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; /*
public class Iterator {
    public int get_next();
    public boolean has_next();
}
*/

public class PeekIterator {
    public PeekIterator(Iterator it) {
        this.it = it;
        this.peeks = new ArrayList<Integer>();
    }
    
    public int peek() {
        if(peeks.isEmpty()) {
            Integer cur = (Integer)it.next();
            peeks.add(cur);
            return cur;
        } else {
            return peeks.get(peeks.size() - 1);
        }
    }
    
    public boolean has_next() {
        return it.hasNext() || !peeks.isEmpty();
    }
    
    public int get_next() {
        if(peeks.isEmpty()) {
            return (Integer)it.next();
        } else {
            Integer ret = peeks.get(peeks.size() - 1);
            peeks.remove(peeks.size() - 1);
            return ret;
        }
    }
    
    private ArrayList<Integer> peeks;
    private Iterator it;
}