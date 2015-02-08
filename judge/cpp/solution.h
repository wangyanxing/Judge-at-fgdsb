/*
struct TreeNode {
    TreeNode(int v = 0) :val(v){}
    int val{ 0 };
    TreeNode* left{ nullptr };
    TreeNode* right{ nullptr };
};
*/
vector<vector<int>> all_path(TreeNode* root) {
    vector<vector<int>> ret;
    
    function<void(TreeNode*, vector<int>&)> dfs = [&](TreeNode* node, vector<int>& cur) {
        if(!node) return;
        cur.push_back(node->val);
        if(!node->left && !node->right) {
            ret.push_back(cur);
        } else {
            dfs(node->left,cur);
            dfs(node->right,cur);
        }
        cur.pop_back();
    };
    
    vector<int> cur;
    dfs(root,cur);
    return ret;
}