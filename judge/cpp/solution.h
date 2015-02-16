int min_coins(vector<int>& coins, int target) {
    vector<int> dp(target+1,0);
    int minVal;
    for(int i = 1; i <= target; i++){
        minVal = i;
        for (int j = 0; j < coins.size(); j++)
            if(coins[j] <= i)
                minVal = min(dp[i-coins[j]]+1,minVal);
            else
                break;
        dp[i] = minVal;
    }
    return dp[target];
}