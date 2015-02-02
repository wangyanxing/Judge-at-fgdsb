require './common'

class Test_valid_tree < TestBase
	def initialize(name)
		super(name)
	end

	def gen_valid_tree(nodes)
		ret = []
		last_level,used_nodes = [0], 1

		while used_nodes < nodes
			level_end = rand((last_level[-1] + 1)..(last_level[-1] + nodes - used_nodes))
			cur_range = (last_level[-1] + 1)..level_end
			cur_level = cur_range.to_a
			cur_level.each do |n|
				ret << [n, last_level.sample]
			end
			used_nodes += cur_level.length
			last_level = cur_level
		end
		ret
	end

	def gen_invalid_tree(nodes)
		ret = gen_valid_tree nodes
		if rand(2) == 0
			to_del = rand(1..3)
			to_del.times do
				ret.delete_at rand(ret.length)
			end
		else
			to_add = rand(1..3)
			while to_add > 0
				nodea, nodeb = rand(nodes),rand(nodes)
				if nodea == nodeb || ret.include?([nodea,nodeb]) || ret.include?([nodeb,nodea])
					next
				end
				ret << [nodea,nodeb]
				to_add -= 1
			end
		end
		ret
	end

	def add_test(data, n, ret)
		@test_in[0] << data
		@test_in[1] << n
		@test_out << ret
	end

	def gen_tests
		@test_in, @test_out = [[], []], []

		add_test([[0,1], [0,2], [2,3], [2,4]], 5, true)
		add_test([], 1, true)
		add_test([[0,1], [1,2], [0,2], [2,3], [2,4]], 5, false)
		add_test([[0,1], [2,3]], 4, false)
		add_test([[0,1], [0,2], [0,3], [0,4]], 5, true)
		add_test([[0,1], [1,2], [0,2], [0,3], [0,4]], 5, false)
		add_test([[0,1]], 5, false)

		10.times do
			nodes = rand(5..10)
			add_test(gen_valid_tree(nodes), nodes, true)
		end

		10.times do
			nodes = rand(5..10)
			add_test(gen_invalid_tree(nodes), nodes, false)
		end

		30.times do
			nodes = rand(100..300)
			add_test(gen_valid_tree(nodes), nodes, true)
		end

		30.times do
			nodes = rand(100..300)
			add_test(gen_invalid_tree(nodes), nodes, false)
		end

		5.times do
			nodes = rand(500..1000)
			add_test(gen_invalid_tree(nodes), nodes, false)
		end
	end
end

Test_valid_tree.new 'valid-tree'