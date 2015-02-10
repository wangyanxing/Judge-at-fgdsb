int num_islands(vector<vector<int>>& mat) {
  function<void(int,int)> dfs = [&](int i, int j) {
    int m = mat.size(), n = mat[0].size();
    vector<pair<int,int>> dirs = {{0,1}, {0,-1}, {1,0}, {-1,0}};
    for(auto& d : dirs) {
      int newi = i + d.first, newj = j + d.second;
      if (newi < 0 || newj < 0 || newi >= m || newj >= n) continue;
      if (mat[newi][newj] != 1) continue;
      mat[newi][newj] = mat[i][j];
      dfs(newi,newj);
    }
  };
  int count = 2;
  for(int i = 0; i < mat.size(); ++i) {
    for(int j = 0; j < mat[0].size(); ++j) {
      if(mat[i][j] == 1) {
        mat[i][j] = count++;
        dfs(i,j);
      }
    }
  }
  return count - 2;
}