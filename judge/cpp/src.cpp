#include "common.h"
#include "tests/fence-painter.h"

int num_colors(int n, int k) {
    if(n <= 0 || k <= 0) return 0;
    int prev_prev = k, prev = k * k;
    for (int i = 0; i < n - 1; ++i) {
        int old_dif = prev;
        prev = (k - 1) * (prev_prev + prev);
        prev_prev = old_dif;
    }
    return prev_prev;
}

int main() {

    auto start = chrono::steady_clock::now();

    for(int i = 0; i < num_test; ++i) {
        auto answer = num_colors(in_0[i],in_1[i]);
        if(answer != out[i]) {
            cout << i+1 << "/" << num_test << ";";
            cout << in_org_0[i] << + ", " << in_org_1[i] << ";";
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
