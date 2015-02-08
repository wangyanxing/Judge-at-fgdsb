# class TreeNode
#    attr_accessor :left, :right, :val
#    def initialize(v)
#        @val, @left, @right = v, nil, nil
#    end

=begin
def dfs(ret, node, cur)
    return if node.nil?
    cur << node.val
    if not node.left and not node.right 
        ret << cur.dup
    else
        dfs ret, node.left, cur
        dfs ret, node.right, cur
    end
    cur.pop
end
=end

# @param root, TreeNode
# @return array of array of integers
def all_path(root)
    ret = []

    define_method :dfs do |node, cur|
        return if node.nil?
        cur << node.val
        if not node.left and not node.right 
            ret << cur.dup
        else
            dfs node.left, cur
            dfs node.right, cur
        end
        cur.pop
    end

    dfs(root, [])
    ret
end