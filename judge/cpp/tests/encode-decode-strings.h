const int num_test = 100;
vector<vector<string>> in_0;
vector<vector<string>> in_org_0;
vector<vector<string>> out;


void load_test() {
    ifstream in("judge/tests/encode-decode-strings.txt");
    read_matrix(in, in_0);
    in_org_0 = clone(in_0);
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
        auto answer = decode(encode(in_0[i]));
        if(answer != in_org_0[i]) {
            release_stdout();
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << ";";
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
