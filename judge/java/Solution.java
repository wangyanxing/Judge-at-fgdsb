package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public int min_coins(int[] coins, int target) {
        int[] dp = new int[target+1];
        for(int i = 0; i < dp.length; ++i) dp[i] = 0;
        
        int minVal = 0;
        for(int i = 1; i <= target; i++){
            minVal = i;
            for (int j = 0; j < coins.length; j++)
                if(coins[j] <= i)
                    minVal = Math.min(dp[i-coins[j]]+1,minVal);
                else
                    break;
            dp[i] = minVal;
        }
        return dp[target];
    }
}