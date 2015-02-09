# class TreeNode
#    attr_accessor :left, :right, :val
#    def initialize(v)
#        @val, @left, @right = v, nil, nil
#    end

# @param root, TreeNode
# @return array of integers
def vertical_traversal(root)
    def minmax(node, min_max, d)
      return if node.nil?
      min_max[0],min_max[1] = [min_max[0],d].min, [min_max[1],d].max
      minmax(node.left, min_max, d - 1)
      minmax(node.right, min_max, d + 1)
      min_max
    end

    def solve(node, d, cur, sln)
      return if node.nil?
      sln << node.val if d == cur
      solve(node.left, d, cur - 1, sln)
      solve(node.right, d, cur + 1, sln)
    end

    min_hd, max_hd = minmax(root, [1000000, -1000000], 0)

    ret = []
    (min_hd..max_hd).each do |i|
      sln = []
      solve(root, i, 0, sln)
      ret << sln.dup
    end
    ret
  end