class SegmentTree {
public:
    struct Node {
        Node* left{ nullptr };
        Node* right{ nullptr };
        int begin{ 0 };
        int end{ 0 };
        int cover{ 0 };
        
        bool is_leaf() { return begin == end; }
        
        Node(int l, int r) :begin(l), end(r), cover(r-l+1) {}
        ~Node() {
            if(left) delete left;
            if(right) delete right;
        }
    };
    
    SegmentTree(int range) : _range(range) {
        _root = build(0, range - 1);
    }
    
    ~SegmentTree() {
        delete _root;
    }
    
    void remove_leaf(int val) {
        if(!find_leaf(val)) return;
        remove_impl(_root, val);
    }
    
    bool find_leaf(int val) {
        Node* cur = _root;
        while(cur) {
            if(cur->begin == val && cur->end == val) return true;
            int mid = cur->begin + (cur->end - cur->begin) / 2;
            
            if(val <= mid) {
                cur = cur->left;
            } else {
                cur = cur->right;
            }
        }
        return false;
    }
    
    int get_kth(int k) {
        Node* cur = _root;
        while(cur) {
            if(k == 0 && cur->is_leaf()) return cur->begin;
            
            int left_cover = cur->left ? cur->left->cover : 0;
            if(k < left_cover) {
                cur = cur->left;
            } else {
                k -= left_cover;
                cur = cur->right;
            }
        }
        return -1;
    }
    
private:
    Node* build(int left, int right) {
        if(left > right) return nullptr;
        auto ret = new Node(left, right);
        if(left == right) return ret;
        
        int mid = left + (right - left) / 2;
        ret->left = build(left, mid);
        ret->right = build(mid+1, right);
        
        return ret;
    }
    
    void remove_impl(Node* root, int val) {
        if(!root) return;
        --root->cover;
        
        if(root->left && root->left->begin == val && root->left->end == val) {
            delete root->left;
            root->left = nullptr;
        } else if(root->right && root->right->begin == val && root->right->end == val) {
            delete root->right;
            root->right = nullptr;
        }
        int mid = root->begin + (root->end - root->begin) / 2;
        if(val <= mid) {
            remove_impl(root->left, val);
        } else {
            remove_impl(root->right, val);
        }
    }
    
    Node* _root{ nullptr };
    int _range{ 0 };
};

vector<int> recover(const vector<int>& arr) {
    SegmentTree st((int)arr.size());
    
    vector<int> ret;
    for (auto n : arr) {
        int kth = st.get_kth(n);
        ret.push_back(kth + 1);
        st.remove_leaf(kth);
    }    
    return ret;
}