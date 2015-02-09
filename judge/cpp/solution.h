/*
struct Point {
    int x{ 0 }, y{ 0 };
};
*/
vector<Point> flowing_water(vector<vector<int>> mat) {
    set<Point> visited, leftOK, rightOK;
    int n = mat.size();
    
    function<void(int,int,Point)> search = [&](int i, int j, Point origin) {
        if (j == 0 || i == 0) leftOK.insert(origin);
        if (j == n-1 || i == n-1) rightOK.insert(origin);
        if(visited.size() == n*n) return;
        //cout <<Point(i,j)<<endl;
        vector<Point> dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}}; 
        for(auto dir : dirs) {
            Point new_pt(dir.x + i, dir.y + j);
            if (new_pt.x < 0 || new_pt.x >= n || new_pt.y < 0 || new_pt.y >= n) {
                continue;
            }
            if (mat[new_pt.x][new_pt.y] > mat[i][j] || visited.count(new_pt)) {
                continue;
            }
            visited.insert(new_pt);
            search(new_pt.x, new_pt.y, origin);
            //visited.erase({newI,newJ});
        }
    };
    
    vector<Point> ret;
    for(int i = 0; i < n; ++i) {
        for(int j = 0; j < n; ++j) {
            Point pt(i,j);
            visited = {pt};
            search(i,j,pt);
            if (leftOK.count(pt) && rightOK.count(pt))
                ret.push_back(pt);
        }
    }
    return ret;
}