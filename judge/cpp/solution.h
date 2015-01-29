string compress(string& str) {
    string ret;
    if(str.empty()) return ret;
   
    char cur = str[0];
    int count = 1, id = 1;
    while(id <= str.length()) {
        if(id < str.length() && str[id] == cur) {
            count++;
        } else {
            ret.push_back(cur);
            ret += to_string(count);
            if(id < str.length()) cur = str[id];
            count = 1;
        }
        id++;
    }
    return ret.length() < str.length() ? ret : str;
}
