require './common'
require '../ruby/common'

class Test_kth_bst < TestBase
	def initialize(name)
		super(name)
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

	def add_test(nums)
		t, arr = gen_bst nums
		@test_in[0] << t

		k = rand(0..(arr.length + 10))
		@test_in[1] << k

		if k >= 1 && k <= arr.length
			@test_out << TreeNode.new(arr[k-1])
		else
			@test_out << nil
		end
	end

	def gen_tests

		@test_in, @test_out = [[], []], []

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

Test_kth_bst.new 'kth-smallest-bst'