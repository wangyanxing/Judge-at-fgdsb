# class TreeNode
#    attr_accessor :left, :right, :val
#    def initialize(v)
#        @val, @left, @right = v, nil, nil
#    end

# @param root, TreeNode
# @param m,n, integer
# @return TreeNode
def lca(root, m, n)
    return nil if root.nil?
	return root if root.val == m || root.val == n

	l = lca root.left, m, n
	r = lca root.right, m, n

	return root if l and r
	return l if l
	return r
end