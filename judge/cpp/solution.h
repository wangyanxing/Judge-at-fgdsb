/*
struct TreeNode {
    TreeNode(int v = 0) :val(v){}
    int val{ 0 };
    TreeNode* left{ nullptr };
    TreeNode* right{ nullptr };
};
*/

vector<vector<int>> vertical_traversal(TreeNode* root) {
    vector<vector<int>> ret;
    vector<int> sln;
    /*
    function<void(TreeNode*, int&, int&, int)> minmax =
            [&](TreeNode* node, int& min, int& max, int d){
        if(!node) return;
        min = std::min(min, d);
        max = std::max(max, d);
        minmax(node->left,min,max,d-1);
        minmax(node->right,min,max,d+1);
    };
    
    function<void(TreeNode*, int, int)> print = [&](TreeNode* node, int d, int cur) {
        if(!node) return;
        if(d == cur) {
            sln.push_back(node->val);
        }
        print(node->left, d, cur-1);
        print(node->right, d, cur+1);
    };
    
    int min_hd = INT_MAX, max_hd = INT_MIN;
    minmax(root,min_hd,max_hd,0);
    cout << min_hd << "," << max_hd << endl;
    
    for(int i = min_hd; i <= max_hd; ++i) {
        print(root, i, 0);
        ret.push_back(sln);
        sln.clear();
    }
    cout << ret << endl;
    return ret;
    */
    unordered_map<int,vector<int>> result;
    
    function<void(TreeNode*, int&, int&, int)> minmax =
    [&](TreeNode* node, int& min, int& max, int d){
        if(!node) return;
        result[d].push_back(node->val);
        
        min = std::min(min, d);
        max = std::max(max, d);
        
        minmax(node->left,min,max,d-1);
        minmax(node->right,min,max,d+1);
    };
    
    int min_hd = INT_MAX, max_hd = INT_MIN;
    minmax(root,min_hd,max_hd,0);
    
    for(int i = min_hd; i <= max_hd; ++i) {
        for(auto n : result[i]) sln.push_back(n);
        ret.push_back(sln);
        sln.clear();
    }
    return ret;
}