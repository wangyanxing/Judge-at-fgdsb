vector<int> longest_seq(const vector<vector<int>>& mat) {
    if(mat.empty() || mat[0].empty()) return {};
    int m = (int)mat.size(), n = (int)mat[0].size();
    
    vector<vector<int>> mem(m, vector<int>(n,0));
    
    function<int(int,int)> dfs = [&](int i, int j) {
        if(mem[i][j] != 0) return mem[i][j];
        vector<pair<int,int>> dirs = {{-1,0},{1,0},{0,-1},{0,1}};
        for(auto& d : dirs) {
            int newi = i + d.first, newj = j + d.second;
            if(newi < 0 || newj < 0 || newi >= m || newj >= n) continue;
            if(mat[newi][newj] == mat[i][j] + 1) {
                int new_val = dfs(newi, newj);
                mem[i][j] = max(mem[i][j], new_val);
            }
        }
        return ++mem[i][j];
    };
    int max_start = 0, max_path = 0;
    for (int i = 0; i < m; i++)
        for(int j = 0; j < n; j++) {
            int path = dfs(i,j);
            if(path > max_path) {
                max_start = mat[i][j];
                max_path = path;
            }
        }
    
    vector<int> ret(max_path);
    iota(ret.begin(), ret.end(), max_start);
    return ret;
}