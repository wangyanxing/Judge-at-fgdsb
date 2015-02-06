const int num_test = 120;
vector<vector<int>> in_0;
vector<vector<int>> in_org_0;
vector<vector<int>> out;
bool test(vector<int>& answer, int i) {
    if(out[i].size() != answer.size()) return false;
    if(out[i][0] == -1 && out[i][1] == -1 && out[i][2] == -1) {
        return answer == out[i];
    } else {
        if(answer[0] == -1 || answer[1] == -1 || answer[2] == -1) {
            return false;
        } else {
            return (in_org_0[i][answer[0]] < in_org_0[i][answer[1]] && in_org_0[i][answer[1]] < in_org_0[i][answer[2]]) && (answer[0] < answer[1] && answer[1] < answer[2]);
        }
    }
}

void load_test() {
    ifstream in("judge/tests/three-increasing-elements.txt");
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
        auto answer = three_increasing_nums(in_0[i]);
        if(!test(answer,i)) {
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
