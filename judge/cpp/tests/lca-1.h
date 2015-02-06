const int num_test = 120;
vector<TreeNode*> in_0;
vector<TreeNode*> in_org_0;
vector<int> in_1;
vector<int> in_org_1;
vector<int> in_2;
vector<int> in_org_2;
vector<TreeNode*> out;


void load_test() {
    ifstream in("judge/tests/lca-1.txt");
    read_array(in, in_0);
    in_org_0 = clone(in_0);
    read_array(in, in_1);
    in_org_1 = clone(in_1);
    read_array(in, in_2);
    in_org_2 = clone(in_2);
    read_array(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);

    capture_stdout();

    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        printf("Testing case #%d\n", i+1);
        auto answer = lca(in_0[i], in_1[i], in_2[i]);
        if(!equals(out[i], answer)) {
            release_stdout();
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << + ", " << in_org_1[i] << + ", " << in_org_2[i] << ";";
            cout << node_to_string(answer) << ";";
            cout << node_to_string(out[i]) << endl;
            return;
        }
    }
    release_stdout();
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
