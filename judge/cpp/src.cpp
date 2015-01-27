#include <vector>
#include <string>
#include <algorithm>
#include <cstdlib>
using namespace std;

#include "common.h"
#include "tests/segregate-even-odd.h"

void segregate(vector<int>& arr) {
    int l = 0, r = arr.size() - 1;
    while(l < r) {
        while(arr[l] % 2 == 0 && l < r) ++l;
        while(arr[r] % 2 != 0 && l < r) --r;
        if(l < r) swap(arr[l++], arr[r--]);
    }
}

int main() {

    cout.setf(ios::boolalpha);

    auto start = chrono::steady_clock::now();

    for(int i = 0; i < num_test; ++i) {
        segregate(in_0[i]);
        auto answer = in_0[i];
        if(!test(i)) {
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << ";";
            cout << answer << ";";
            cout << out[i] << endl;
            return 0;
        }
    }
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;
    return 0;
}
