const int num_test = 90;
vector<vector<int>> in_0;
vector<vector<int>> in_org_0;
vector<int> in_1;
vector<int> in_org_1;
vector<vector<int>> out;
bool test(vector<int>& answer, int i) {
    if(out[i].size() != answer.size()) return false;
    if(out[i][0] == -1 && out[i][1] == -1) {
        return answer == out[i];
    } else {
        if(answer[0] == -1 || answer[1] == -1) {
            return false;
        } else {
            return abs(in_0[i][answer[0]] - in_0[i][answer[1]]) == in_1[i];
        }
    }
}
		

void load_test() {
    ifstream in("judge/tests/two-difference.txt");
    read_matrix(in, in_0);
    in_org_0 = clone(in_0);
    read_array(in, in_1);
    in_org_1 = clone(in_1);
    read_matrix(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);
    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        auto answer = two_dif(in_0[i], in_1[i]);
        if(!test(answer, i)) {
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << + ", " << in_org_1[i] << ";";
            cout << answer << ";";
            cout << out[i] << endl;
            return;
        }
    }
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
