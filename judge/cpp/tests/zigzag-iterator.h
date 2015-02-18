const int num_test = 55;
vector<vector<int>> in_0;
vector<vector<int>> in_org_0;
vector<vector<int>> in_1;
vector<vector<int>> in_org_1;

// right solution
class _ZigzagIterator {
public:
    _ZigzagIterator(Iterator& a, Iterator& b) :_its{a,b} {
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

void load_test() {
    ifstream in("judge/tests/zigzag-iterator.txt");
    read_matrix(in, in_0);
    in_org_0 = clone(in_0);
    read_matrix(in, in_1);
    in_org_1 = clone(in_1);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);
    capture_stdout();
    load_test();
    
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        printf("Testing case #%d\n", i+1);
        
        Iterator i0(in_0[i]), i1(in_1[i]);
        ZigzagIterator pi(i0, i1);
        vector<int> w;
        while(pi.has_next()) w.push_back(pi.get_next());
        
        Iterator _i0(in_0[i]), _i1(in_1[i]);
        _ZigzagIterator wi(_i0, _i1);
        vector<int> ow;
        while(wi.has_next()) ow.push_back(wi.get_next());
        
        if(ow != w) {
            release_stdout();
            
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << ", " << in_org_1[i] << ";";
            cout << w << ";" << ow << endl;
            return;
        }
    }
    release_stdout();
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
