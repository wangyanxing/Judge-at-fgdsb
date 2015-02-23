void wiggle_sort(vector<int>& s) {
    int n = (int)s.size();
    if(n == 0) return;
    
    bool flag = true;
    int current = s[0];
    for (int i = 0; i < n-1; i++) {
        if ((flag && current > s[i+1]) || (!flag && current < s[i+1])) {
            s[i] = s[i+1];
        } else {
            s[i] = current;
            current = s[i+1];
        }
        flag = !flag;
    }
    s[n-1] = current;
}