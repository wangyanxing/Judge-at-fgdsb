const int num_test = 100;
vector<vector<int>> in_0;
vector<vector<int>> in_org_0;
vector<vector<int>> in_1;
vector<vector<int>> in_org_1;
vector<vector<int>> out;


void load_test() {
    ifstream in("judge/tests/intersection-of-two-sorted-arrays.txt");
    read_matrix(in, in_0);
    in_org_0 = clone(in_0);
    read_matrix(in, in_1);
    in_org_1 = clone(in_1);
    read_matrix(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);

    capture_stdout();

    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        printf("Testing case #%d\n", i+1);
        auto answer = intersection(in_0[i], in_1[i]);
        if(answer != out[i]) {
            release_stdout();
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << + ", " << in_org_1[i] << ";";
            cout << answer << ";";
            cout << out[i] << endl;
            return;
        }
    }
    release_stdout();
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
