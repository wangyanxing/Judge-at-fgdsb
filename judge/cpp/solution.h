int max_sum_rect(vector<vector<int>>& mat) {
    if(mat.empty() || mat[0].empty()) return 0;
    int n = (int)mat.size(), m = (int)mat[0].size();
    vector<vector<int>> col_sum = mat;
    
    for (int i = 1 ; i < n ; ++i)
        for (int j = 0 ; j < m ; ++j)
            col_sum[i][j] += col_sum[i-1][j];
    
    int ret = 0;
    for (int row = 0 ; row < n ; ++row) {
        for (int t = 0 ; t <= row ; ++t) {
            int min_left = 0, row_sum[m];
            for (int i = 0 ; i < m ; ++i) {
                int col = t == 0 ? col_sum[row][i] : col_sum[row][i] - col_sum[t-1][i];
                row_sum[i] = i == 0? col : col + row_sum[i-1];
                ret = max(ret, row_sum[i] - min_left);
                min_left = min(min_left, row_sum[i]);
            }
        }
    }
    return ret;
}