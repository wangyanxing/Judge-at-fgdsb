/*
class Iterator {
public:
    int get_next();
    bool has_next();
};
*/

class ZigzagIterator {
public:
    ZigzagIterator(Iterator& a, Iterator& b) :_its{a,b} {
        _pointer = a.has_next() ? 0 : 1;
    }
    
    int get_next() {
        int ret = _its[_pointer].get_next(), old = _pointer;
        do {
            if(++_pointer >= 2) _pointer = 0;
        } while(!_its[_pointer].has_next() && _pointer != old);
        return ret;
    }
    
    bool has_next() { return _its[_pointer].has_next(); }
private:
    Iterator _its[2];
    int _pointer;
};