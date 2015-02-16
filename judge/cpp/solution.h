int count_changes(vector<int>& coins, int target) {
    vector<int> table(target+1, 0);
    table[0] = 1;
   
    for(int i=0; i<coins.size(); i++)
        for(int j=coins[i]; j<=target; j++)
            table[j] += table[j-coins[i]];
   
    return table[target];
}