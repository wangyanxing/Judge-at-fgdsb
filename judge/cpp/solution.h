bool subarray_sum(vector<int>& arr, int t) {
    int curr_sum = arr[0], start = 0, i;
   
    for (i = 1; i <= arr.size(); i++) {
        while (curr_sum > t && start < i-1) {
            curr_sum = curr_sum - arr[start];
            start++;
        }
        
        if (curr_sum == t) return true;
        if (i < arr.size()) curr_sum = curr_sum + arr[i];
    }
    return false;
}