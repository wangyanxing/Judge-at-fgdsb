/*
struct Point {
    int x{ 0 }, y{ 0 };
};
*/
void search(Point pt, unordered_map<Point, bool>& visited, vector<vector<int>> mat) {
    vector<Point> dirs = {{0,1}, {0,-1}, {1,0}, {-1,0}};
    for(auto dir : dirs) {
        Point newp = { dir.x + pt.x, dir.y + pt.y };
        if( newp.x < 0 || newp.x >= mat.size() || newp.y < 0 || newp.y >= mat.size() ) {
            continue;
        }
        if( mat[newp.x][newp.y] < mat[pt.x][pt.y] || visited.count(newp) ) {
            continue;
        }
        visited[newp] = true;
        search(newp, visited, mat);
    }
}

vector<Point> flowing_water(vector<vector<int>> mat) {
    int n = mat.size();
    
    unordered_map<Point, bool> visited_pac;
    
    for(int i = 0; i < n; ++i) {
        visited_pac[{0,i}] = true;
        search({0,i}, visited_pac, mat);
    }
    
    for(int i = 0; i < n; ++i) {
        visited_pac[{i,0}] = true;
        search({i,0}, visited_pac, mat);
    }
    
    unordered_map<Point, bool> visited_alt;
    
    for(int i = 0; i < n; ++i) {
        visited_alt[{n-1,i}] = true;
        search({n-1,i}, visited_alt, mat);
    }
    
    for(int i = 0; i < n; ++i) {
        visited_alt[{i,n-1}] = true;
        search({i,n-1}, visited_alt, mat);
    }
    
    vector<Point> ret;
    for(auto p : visited_alt) {
        if(visited_pac.count(p.first)) {
            ret.push_back(p.first);
        }
    }
    
    sort(ret.begin(), ret.end());
    return ret;
}
