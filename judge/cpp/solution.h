bool subarray_sum(vector<int>& arr, int t) {
    int sum = arr[0], start = 0, i;
    for (i = 1; i <= arr.size(); i++) {
        while (sum > t && start < i-1) sum -= arr[start++];
        if (sum == t) return true;
        if (i < arr.size()) sum += arr[i];
    }
    return false;
}