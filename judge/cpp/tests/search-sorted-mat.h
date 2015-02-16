const int num_test = 90;
vector<vector<vector<int>>> in_0;
vector<vector<vector<int>>> in_org_0;
vector<int> in_1;
vector<int> in_org_1;
vector<bool> out;


void load_test() {
    ifstream in("judge/tests/search-sorted-mat.txt");
    read_matrix_arr(in, in_0);
    in_org_0 = clone(in_0);
    read_array(in, in_1);
    in_org_1 = clone(in_1);
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
        auto answer = search_matrix(in_0[i], in_1[i]);
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
