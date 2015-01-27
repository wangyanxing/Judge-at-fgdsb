#include <vector>
#include <string>
#include <algorithm>
#include <cstdlib>
using namespace std;

#include "common.h"
#include "tests/second-largest-number.h"

int second_largest(const vector<int>& arr) {
    if(arr.size() < 2) return 0;
    int second_max = arr[0], max_val = arr[0];
    for(size_t i = 1; i < arr.size(); ++i) {
        if(arr[i] > max_val) {
            second_max = max_val;
            max_val = arr[i];
        } else if(arr[i] > second_max && arr[i] != max_val) {
            second_max = arr[i];
        }
    }
    return second_max == max_val ? 0 : second_max;
}

int main() {

    cout.setf(ios::boolalpha);

    auto start = chrono::steady_clock::now();

    for(int i = 0; i < num_test; ++i) {
        auto answer = second_largest(in_0[i]);
        if(answer != out[i]) {
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
