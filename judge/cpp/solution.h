bool solve(vector<vector<int>> & edges, int n, int parent,  unordered_set<int> & visited, unordered_set<int> & path) {
    if(path.count(n)) return false;
    path.insert(n);
    visited.insert(n);
    for(int i = 0; i < edges[n].size(); i++) {
        
        if(parent != edges[n][i] && !solve(edges, edges[n][i], n, visited, path)) {
            return false;
        }
    }
    path.erase(n);
    return true;
}

bool valid_tree(vector<vector<int>>& edges, int n) {
    vector<vector<int>> neighbors(n);
    for(int i = 0; i < edges.size(); i++) {
        neighbors[edges[i][0]].push_back(edges[i][1]);
        neighbors[edges[i][1]].push_back(edges[i][0]);
    }
    
    unordered_set<int> visited;
    unordered_set<int> path;

    if(!solve(neighbors, 0, -1, visited, path)) return false;

    for(int i = 0; i < n; i++) {
        if(!visited.count(i)) return false;
    }
    
    return true;    
}