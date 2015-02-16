require '../ruby/common'

class Integer
	N_BYTES = [42].pack('i').size
	N_BITS = N_BYTES * 16
	MAX = 2 ** (N_BITS - 2) - 1
	MIN = -MAX - 1
end

module Utils
	def gen_bst(nodes)
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

		arr = (0...nodes).to_a.shuffle
		root = TreeNode.new(arr[0])
		(1...nodes).each do |i|
			add_bst(root, arr[i])
		end
		[root, arr.sort]
	end

	def gen_tree(nodes)
		def add_node(node, val)
			return if node.nil?

			if rand(2) == 1
				if node.left.nil?
					node.left = TreeNode.new(val)
					return true
				else
					return add_node(node.left, val)
				end
			else
				if node.right.nil?
					node.right = TreeNode.new(val)
					return true
				else
					return add_node(node.right, val)
				end
			end
			false
		end

		arr = (0...nodes).to_a.shuffle
		root = TreeNode.new(arr[0])
		(1...nodes).each do |i|
			add_node(root, arr[i])
		end
		root
	end

	def gen_matrix(n, m, range)
		ret = []
		n.times do
			ret << []
			m.times do
				ret[-1] << rand(range)
			end
		end
		ret
	end

	def gen_array(size, range)
		(0...size).map { rand(range) }
	end
end