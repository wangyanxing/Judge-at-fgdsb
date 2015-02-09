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
    function<void(TreeNode*, int&, int&, int)> minmax =
            [&](TreeNode* node, int& min, int& max, int d){
        if(!node) return;
        min = std::min(min, d);
        max = std::max(max, d);
        minmax(node->left,min,max,d-1);
        minmax(node->right,min,max,d+1);
    };
    
    function<void(TreeNode*, int, int, vector<int>&)> print =
        [&](TreeNode* node, int d, int cur, vector<int>& sln) {
        if(!node) return;
        if(d == cur) sln.push_back(node->val);
        print(node->left, d, cur-1, sln);
        print(node->right, d, cur+1, sln);
    };
    
    int min_hd = INT_MAX, max_hd = INT_MIN;
    minmax(root,min_hd,max_hd,0);
    
    for(int i = min_hd; i <= max_hd; ++i) {
        vector<int> sln;
        print(root, i, 0, sln);
        ret.push_back(sln);
    }
    return ret;
}