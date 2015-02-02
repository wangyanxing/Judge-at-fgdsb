const int num_test = 120;
vector<vector<Interval>> in_0;
vector<vector<Interval>> in_org_0;
vector<int> in_1;
vector<int> in_org_1;
vector<vector<bool>> out;


void load_test() {
    ifstream in("judge/tests/query-intervals-1.txt");
    read_matrix(in, in_0);
    in_org_0 = in_0;
    read_array(in, in_1);
    in_org_1 = in_1;
    read_matrix(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);
    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        Intervals inte(in_0[i]);
        inte.preprocess();
        for(int j = 0; j < in_1[i]; ++j) {
            auto answer = inte.query(j);
            if(answer != out[i][j]) {
                cout << i+1 << "/" << num_test << ";";
                cout << in_org_0[i] << ", " << j << ";";
                cout << answer << ";";
                cout << out[i][j] << endl;
                return;
            }
        }
    }
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
