# class TreeNode
#    attr_accessor :left, :right, :val
#    def initialize(v)
#        @val, @left, @right = v, nil, nil
#    end

def _all_path(root, ret, cur)
	return if root.nil?
	cur << root.val
	if root.left.nil? && root.right.nil?
		ret << cur.dup
		cur.pop
		return
	end
	_all_path(root.left, ret, cur)
	_all_path(root.right, ret, cur)
	cur.pop
end

# @param root, TreeNode
# @return TreeNode
def all_path(root)
    ret = []
	_all_path(root, ret, [])
    ret
end