require './common'
require '../ruby/common'

class Test_lca_2 < TestBase
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

	def lca(root, m, n)
		return nil if root.nil?
		return root if root.val == m || root.val == n

		l = lca root.left, m, n
		r = lca root.right, m, n

		return root if l and r
		return l if l
		return r
	end

	def add_test(nums)
		t = gen_bst nums
		@test_in[0] << t

		m = rand(nums)
		@test_in[1] << m

		n = rand(nums)
		@test_in[2] << n

		@test_out << lca(t, m, n)
	end

	def gen_tests

		@test_in, @test_out = [[], [], []], []

		20.times do
			add_test rand(5...10)
		end

		50.times do
			add_test rand(50...100)
		end

		50.times do
			add_test rand(500...800)
		end
	end
end

Test_lca_2.new 'lca-2'