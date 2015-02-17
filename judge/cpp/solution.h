/*
class Iterator {
public:
    int get_next();
    bool has_next();
};
*/

class PeekIterator {
public:
    PeekIterator(Iterator& it): _it(it) {}
    
    int peek() {
        if(_peeks.empty()) {
            int cur = _it.get_next();
            _peeks.push_back(cur);
            return cur;
        } else {
            return _peeks.back();
        }
    }
    
    bool has_next() {
        return _it.has_next() || !_peeks.empty();
    }
    
    int get_next() {
        if(_peeks.empty()) {
            return _it.get_next();
        } else {
            int ret = _peeks.back();
            _peeks.pop_back();
            return ret;
        }
    }
private:
    vector<int> _peeks;
    Iterator _it;
};