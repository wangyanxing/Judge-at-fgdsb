const int num_test = 50;
vector<vector<int>> in_0;
vector<vector<int>> in_org_0;
vector<bool> out;

void load_test() {
    ifstream in("judge/tests/peek-iterator.txt");
    read_matrix(in, in_0);
    in_org_0 = clone(in_0);
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
        
        Iterator it(in_0[i]);
        PeekIterator pi(it);
        
        for(auto num : in_0[i]) {
            bool has_next_wrong = false, peek_wrong = false, get_next_wrong = false;
            
            if(!pi.has_next()) has_next_wrong = true;
            if(pi.peek() != num) peek_wrong = true;
            int nxt = pi.get_next();
            if(nxt != num) get_next_wrong = true;
            
            if(has_next_wrong || peek_wrong || get_next_wrong) {
                release_stdout();
                
                string msg;
                if(has_next_wrong) msg += "has_next() == false, ";
                if(peek_wrong) msg += "peek() == " + to_string(pi.peek()) + ", ";
                if(get_next_wrong) msg += "get_next() == " + to_string(nxt) + ", ";
                msg.pop_back();msg.pop_back();
                
                string expmsg;
                if(has_next_wrong) expmsg += "has_next() == true, ";
                if(peek_wrong) expmsg += "peek() == " + to_string(num) + ", ";
                if(get_next_wrong) expmsg += "get_next() == " + to_string(num) + ", ";
                expmsg.pop_back();expmsg.pop_back();
                
                cout << i+1 << "/" << num_test << ";";
                cout << in_org_0[i] << ", current number: " << num << ";";
                cout << msg << ";" << expmsg << endl;
                return;
            }
        }
    }
    release_stdout();
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
}
