#include "common.h"

/*
    hello world
*/

int plus_num(int a, int b) {
    return a + b;
}

int main() {
    const int num_test = 5;
    vector<int> in_0 = {1,1,2,100,100};
    vector<int> in_1 = {0,1,1,13,200};
    vector<int> in_org_0 = {1,1,2,100,100};
    vector<int> in_org_1 = {0,1,1,13,200};
    vector<int> out = {1,2,3,113,300};

    for(int i = 0; i < num_test; ++i) {
        auto answer = plus_num(in_0[i],in_1[i]);
        if(answer != out[i]) {
            cout << i+1 << "/" << num_test << ";";            cout << in_org_0[i] << + ", " << in_org_1[i] << ";";
            cout << answer << ";";
            cout << out[i] << endl;
            return 0;
        }
    }
    cout << "Accepted" << endl;
    return 0;
}
