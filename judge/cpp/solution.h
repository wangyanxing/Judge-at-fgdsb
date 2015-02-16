bool search_matrix(vector<vector<int>>& mat, int target) {
    if (target < mat[0][0] || target > mat.back().back()) return false;
    int row = 0, col = mat[0].size()-1;
    while (row <= mat.size()-1 && col >= 0) {
        if (mat[row][col] < target) 
            row++;
        else if (mat[row][col] > target)
            col--;
        else
            return true;
    }
    return false;
}