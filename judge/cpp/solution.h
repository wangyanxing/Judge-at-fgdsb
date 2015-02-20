vector<int> longest_subarray(vector<int>& arr) {
    cout << arr << endl;
    int sum = 0, length = 0, begin = -1;
    unordered_map<int, int> record = {{0,-1}};
    for(int i = 0; i < arr.size(); ++i) {
        sum += arr[i];
        if(record.count(sum)) {
            auto first = record[sum];
            if(i - first > length) {
                length = i - first;
                begin = first + 1;
            }
        } else {
            record[sum] = i;
        }
    }
    if(begin < 0) return {};
    else return vector<int>(arr.begin()+begin, arr.begin()+begin+length);
}