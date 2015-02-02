/*
struct TreeNode {
    TreeNode(int v = 0) :val(v){}
    int val{ 0 };
    TreeNode* left{ nullptr };
    TreeNode* right{ nullptr };
};
*/

void solve(vector<vector<int>>& ret, TreeNode* root, vector<int>& cur) {
    if(!root) return;
    cur.push_back(root->val);
    if(!root->left && !root->right) {
        ret.push_back(cur);
        cur.pop_back();
		return;
    }
    solve(ret, root->left, cur);
    solve(ret, root->right, cur);
    cur.pop_back();
}

vector<vector<int>> all_path(TreeNode* root) {
    vector<vector<int>> ret;
    vector<int> cur;
    solve(ret, root, cur);
    return ret;
}
