const int num_test = 100;
vector<TreeNode*> in_0;
vector<TreeNode*> in_org_0;
vector<vector<int>> out;

bool check_dlist(vector<int>& arr, TreeNode*& list) {
    TreeNode *cur = list, *pre = nullptr;
    int i = 0;
    while(cur) {
        if(i >= arr.size() || arr[i] != cur->val) return false;
        ++i;
        pre = cur;
        cur = cur->right;
    }
    if(i != arr.size()) return false;
    cur = pre;
    --i;
    while(cur) {
        if(i < 0 || arr[i] != cur->val) return false;
        --i;
        auto last = cur;
        cur = cur->left;
        last->left = nullptr;
    }
    if(i != -1) return false;
    return true;
}

string dlist_to_string(TreeNode* list) {
    string ret = "[";
    bool first = true;
    while(list) {
        if(!first) ret += ", ";
        ret += to_string(list->val);
        list = list->right;
        first = false;
    }
    ret += "]";
    return ret;
}

void load_test() {
    ifstream in("judge/tests/bst-to-dlist.txt");
    read_array(in, in_0);
    in_org_0 = clone(in_0);
    read_matrix(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);
    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        auto answer = bst_to_list(in_0[i]);
        if(!check_dlist(out[i], answer)) {
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << ";";
            cout << dlist_to_string(answer) << ";";
            cout << out[i] << endl;
            return;
        }
    }
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
