bool subarray_sum(vector<int>& arr, int t) {
    unordered_map<int,int> map = {{0,-1}};
    for(int i = 0, sum = 0; i < arr.size(); ++i){
        sum += arr[i];
        if(!map.count(sum)) map[sum] = i;
        if(map.count(sum - t)) return true;
    }
    return false;
}