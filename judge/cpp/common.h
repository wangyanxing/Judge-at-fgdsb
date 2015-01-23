#pragma once

#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <utility>
#include <stack>
#include <deque>
#include <list>
#include <set>
#include <map>
#include <unordered_set>
#include <unordered_map>
#include <assert.h>
#include <strstream>
#include <queue>
#include <numeric>
#include <iomanip>
#include <fstream>

using namespace std;

struct TreeNode {
    TreeNode(int v = 0) :val(v){}
    int val{ 0 };
    TreeNode* left{ nullptr };
    TreeNode* right{ nullptr };
};

struct ListNode {
    ListNode(int v = 0) :val(v){}
    int val{ 0 };
    ListNode* next{ nullptr };
};

struct DoublyListNode {
    DoublyListNode(int v = 0) :val(v){}
    int val{ 0 };
    DoublyListNode* next{ nullptr };
    DoublyListNode* prev{ nullptr };
};

struct UndirectedGraphNode {
    int label;
    vector<UndirectedGraphNode *> neighbors;
    UndirectedGraphNode(int x) : label(x) {};
};

template<typename T>
ostream& operator<< (ostream& out, const vector<T>& v) {
    out << "[ ";
    size_t last = v.size() - 1;
    for(size_t i = 0; i < v.size(); ++i) {
        out << v[i];
        if (i != last) out << ", ";
    }
    out << " ]";
    return out;
}

bool test_wiggle(vector<int>& arr) {
    if(arr.empty()) return true;
    bool test_flag = true;
    for(size_t i = 0; i < arr.size()-1; ++i) {
        if(test_flag) {
            if(arr[i] > arr[i+1]) return false;
        } else {
            if(arr[i] < arr[i+1]) return false;
        }
        test_flag = !test_flag;
    }
    return true;
}
