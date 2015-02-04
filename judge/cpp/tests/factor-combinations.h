const int num_test = 2000;
vector<int> in_0;
vector<int> in_org_0;
vector<vector<vector<int>>> out;


void load_test() {
    ifstream in("judge/tests/factor-combinations.txt");
    read_array(in, in_0);
    in_org_0 = clone(in_0);
    read_matrix_arr(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);
    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        auto answer = factors_combinations(in_0[i]);
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
