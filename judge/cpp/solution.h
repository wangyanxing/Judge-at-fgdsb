int max_values(vector<int>& nums) {
    if(nums.empty()) return 0;
    int prev_prev = 0, prev = nums[0];   
    for(int i = 1; i < nums.size(); ++i) {
        int old_prev = prev;
        prev = max(prev, max(nums[i] + prev_prev, prev));
        prev_prev = old_prev;
    }   
    return prev;
}