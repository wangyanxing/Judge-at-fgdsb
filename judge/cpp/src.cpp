#include "common.h"

void wiggle_sort(vector<int>& arr) {
}

int main() {
    const int num_test = 3;
    vector<vector<int>> in_0 = {{1, 2, 3},{1, 3, 5, 7, 9},{9, 7, 4, 8, 1}};
    vector<vector<int>> in_org_0 = {{1, 2, 3},{1, 3, 5, 7, 9},{9, 7, 4, 8, 1}};
    vector<vector<int>> out = {{1, 3, 2},{1, 5, 3, 9, 7},{7, 9, 4, 8, 1}};

    for(int i = 0; i < num_test; ++i) {
        wiggle_sort(in_0[i]);
        auto answer = in_0[i];
        if(!test_wiggle(in_0[i])) {
            cout << i+1 << "/" << num_test << ";";            cout << in_org_0[i] << ";";
            cout << answer << ";";
            cout << out[i] << endl;
            return 0;
        }
    }
    cout << "Accepted" << endl;
    return 0;
}
