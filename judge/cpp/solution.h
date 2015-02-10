char smallest_character(string& str, char c) {
    int l = 0, r = str.length() - 1;
    char ret = str[0];
    while(l <= r) {
        int m = l + (r-l) / 2;
        if(str[m] > c) {
            ret = str[m];
            r = m - 1;
        } else {
            l = m + 1;
        }
    }
    return ret;
}