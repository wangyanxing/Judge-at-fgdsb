vector<int> product(vector<int>& a) {
    vector<int> ret(a.size());
    for(int prod = 1, i = 0; i < a.size(); ++i) {
        prod *= a[i];
        ret[i] = prod;
    }
    for(int prod = 1, i = (int)a.size() - 1; i >= 0; --i) {
        ret[i] = (i > 0 ? ret[i-1] : 1) * prod;
        prod *= a[i];
    }
    return ret;
}