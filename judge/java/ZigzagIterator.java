package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; /*
public class Iterator {
    public int get_next();
    public boolean has_next();
}
*/

public class ZigzagIterator {
    public ZigzagIterator(Iterator i0, Iterator i1) {
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