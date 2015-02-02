require './common'
require '../ruby/common'

class Test_all_path_tree < TestBase
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
		return root
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

	def _all_path(root, ret, cur)
		if root.nil?
			return
		end

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

	def all_path(root)
		ret = []
		_all_path(root, ret, [])
		ret
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		10.times do
			t = gen_bst rand(3...10)
			@test_in[0] << t
			@test_out << all_path(t)
		end

		60.times do
			t = gen_bst rand(50...100)
			@test_in[0] << t
			@test_out << all_path(t)
		end

		30.times do
			t = gen_bst rand(500...800)
			@test_in[0] << t
			@test_out << all_path(t)
		end
	end
end

Test_all_path_tree.new 'all-path-tree'