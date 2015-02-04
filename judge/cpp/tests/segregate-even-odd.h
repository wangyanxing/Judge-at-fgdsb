const int num_test = 100;
vector<vector<int>> in_0;
vector<vector<int>> in_org_0;
vector<vector<int>> out;
		bool test(int i) {
      if(!test_anagram(in_0[i], in_org_0[i])) return false;
		  bool flag = false;
		  for(int j = 0; j < in_0[i].size(); ++j) {
        	if (in_0[i][j] % 2 == 0) {
					  if(flag) return false;
				  } else {
					  flag = true;
				  }
			}
      return true;
    }

void load_test() {
    ifstream in("judge/tests/segregate-even-odd.txt");
    read_matrix(in, in_0);
    in_org_0 = clone(in_0);
    read_matrix(in, out);
    in.close();
}

void judge() {
    cout.setf(ios::boolalpha);
    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        segregate(in_0[i]);
        auto answer = in_0[i];
        if(!test(i)) {
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
