const int num_test = 80;
vector<vector<int>> in_0;
vector<vector<int>> in_org_0;
vector<int> out;


void load_test() {
    ifstream in("judge/tests/inverse-pairs.txt");
    read_matrix(in, in_0);
    in_org_0 = clone(in_0);
    read_array(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);
    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        auto answer = num_inverse_pairs(in_0[i]);
        if(answer != out[i]) {
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << ";";
            cout << answer << ";";
            cout << out[i] << endl;
            return;
        }
    }
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
