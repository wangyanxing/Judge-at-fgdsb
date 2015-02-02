require './common'
require '../ruby/common'

class Test_bst_to_dlist < TestBase
	def initialize(name)
		super(name)
	end

	def add_bst(node, val)
		return if node.nil?

		if val == node.val
			return false
		elsif val < node.val
			if node.left.nil?
				node.left = TreeNode.new(val)
				return true
			else
					return add_bst(node.left, val)
			end
		elsif val > node.val
			if node.right.nil?
				node.right = TreeNode.new(val)
				return true
			else
				return add_bst(node.right, val)
			end
		end
		false
	end

	def gen_bst(nodes)
		arr = (0...nodes).to_a.shuffle
		root = TreeNode.new(arr[0])
		(1...nodes).each do |i|
			add_bst(root, arr[i])
		end
		return [root, arr.sort]
	end

	def most_right(root)
		return nil if root.nil?
		ret = root
		while !ret.right.nil?
			ret = ret.right
		end
		ret
	end

	def bst_to_list(root)
		return nil if root.nil?
		lefts = bst_to_list(root.left)
		cur = TreeNode.new(root.val)

		left_end = most_right(lefts)

		if !left_end.nil?
			left_end.right = cur
		end

		cur.right = bst_to_list(root.right)

		if lefts.nil?
			return cur
		else
			return lefts
		end
	end

	def gen_tests

		@test_in, @test_out = [[]], []

		20.times do
			t, arr = gen_bst rand(5...10)
			@test_in[0] << t
			@test_out << arr
		end

		50.times do
			t, arr = gen_bst rand(50...100)
			@test_in[0] << t
			@test_out << arr
		end

		30.times do
			t, arr = gen_bst rand(500...800)
			@test_in[0] << t
			@test_out << arr
		end

		@extra_test_code_cpp ='
bool check_dlist(vector<int>& arr, TreeNode*& list) {
    TreeNode *cur = list, *pre = nullptr;
    int i = 0;
    while(cur) {
        if(i >= arr.size() || arr[i] != cur->val) return false;
        ++i;
        pre = cur;
        cur = cur->right;
    }
    if(i != arr.size()) return false;
    cur = pre;
    --i;
    while(cur) {
        if(i < 0 || arr[i] != cur->val) return false;
        --i;
        auto last = cur;
        cur = cur->left;
        last->left = nullptr;
    }
    if(i != -1) return false;
    return true;
}

string dlist_to_string(TreeNode* list) {
    string ret = "[";
    bool first = true;
    while(list) {
        if(!first) ret += ", ";
        ret += to_string(list->val);
        list = list->right;
        first = false;
    }
    ret += "]";
    return ret;
}'

		@extra_test_code_java = '
    public static boolean check_dlist(int[] arr, TreeNode list) {
        TreeNode cur = list;
        TreeNode pre = null;
        int i = 0;
        while(cur != null) {
            if(i >= arr.length || arr[i] != cur.val) return false;
            ++i;
            pre = cur;
            cur = cur.right;
        }
        if(i != arr.length) return false;
        cur = pre;
        --i;
        while(cur != null) {
            if(i < 0 || arr[i] != cur.val) return false;
            --i;
            TreeNode last = cur;
            cur = cur.left;
            last.left = null;
        }
        if(i != -1) return false;
        return true;
    }

    public static String dlist_to_string(TreeNode list) {
        String ret = "[";
        boolean first = true;
        while(list != null) {
            if(!first) ret += ", ";
            ret += Integer.toString(list.val);
            list = list.right;
            first = false;
        }
        ret += "]";
        return ret;
    }
'

		@extra_test_code_ruby = '
def check_dlist(arr, list)
	cur, pre, i = list, nil, 0

	while(!cur.nil?)
		return false if i >= arr.length || arr[i] != cur.val
		i += 1
		pre = cur
		cur = cur.right
	end
	return false if i != arr.length
	cur = pre
	i -= 1
	while(!cur.nil?)
		return false if i < 0 || arr[i] != cur.val
		i -= 1
		last = cur
		cur = cur.left
		last.left = nil
	end
	return false if i != -1
	true
end

def dlist_to_string(list)
	ret = \'[\'
	first = true
	while(!list.nil?)
		ret += \', \' if !first
		ret += list.val.to_s
		list = list.right
		first = false
	end
	ret + \']\'
end
'
		@extra_test_code_python = '
def check_dlist(arr, list):
	cur, pre, i = list, None, 0

	while(cur != None):
		if (i >= len(arr) or arr[i] != cur.val): return False
		i += 1
		pre = cur
		cur = cur.right

	if i != len(arr): return False
	cur = pre
	i -= 1
	while(cur != None):
		if (i < 0 or arr[i] != cur.val): return False
		i -= 1
		last = cur
		cur = cur.left
		last.left = None

	if i != -1: return False
	return True

def dlist_to_string(list):
	ret = "["
	first = True
	while(list != None):
		if not first: ret += ", "
		ret += str(list.val)
		list = list.right
		first = False
	return ret + "]"
'
	end
end

Test_bst_to_dlist.new 'bst-to-dlist'