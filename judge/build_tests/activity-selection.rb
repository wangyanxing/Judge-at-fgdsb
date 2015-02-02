require './common'
#require '../ruby/common'

class Test_act_sel < TestBase
	def initialize(name)
		super(name)
	end

	def max_intervals(intervals)
		sorted = intervals.sort {|a,b| a[1] <=> b[1]}
		ans, cursor = 0, sorted[0][0]
		sorted.each do |i|
			if i[0] >= cursor
				ans, cursor = ans + 1, i[1]
			end
		end
		ans
	end

	def gen_random(max, nums)
		ret = []
		candidates = (0...max).to_a
		while ret.length < nums
			int = candidates.sample(2)
			if int[0] > int[1]
				int[0], int[1] = int[1], int[0]
			end
			if ret.include? int
				next
			end
			ret << int
		end
		ret
	end

	def add_test(data)
		@test_in[0] << data
		@test_out << max_intervals(data)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		add_test([[0,2], [3,5], [1,4]])

		10.times do
			add_test(gen_random(10, rand(5...10)))
		end

		50.times do
			add_test(gen_random(200, rand(100...150)))
		end

		30.times do
			add_test(gen_random(1000, rand(800...1000)))
		end
	end
end

Test_act_sel.new 'activity-selection'