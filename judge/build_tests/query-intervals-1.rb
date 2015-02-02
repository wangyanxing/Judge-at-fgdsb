require './common'
#require '../ruby/common'

class Test_query_intervals_1 < TestBase
	def initialize(name)
		@manual_test = true
		super(name)
	end

	def query(intervals, time)
		intervals.each do |i|
			return true if time >= i[0] && time <= i[1]
		end
		false
	end

	def gen_random(max, nums, max_len)
		ret = []
		candidates = (0...max).to_a
		while ret.length < nums
			int = candidates.sample(2)
			if (int[0] - int[1]).abs > max_len
				next
			end
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

	def add_test(max, nums, max_len)
		@test_in[0] << gen_random(max, nums, max_len)
		@test_in[1] << max

		out = []
		(0...max).each do |i|
			out << query(@test_in[0][-1], i)
		end
		@test_out << out
	end

	def gen_tests
		@test_in, @test_out = [[], []], []

		20.times do
			add_test(20, rand(5...10), 5)
		end

		30.times do
			add_test(500, rand(120...170), 30)
		end

		50.times do
			add_test(500, rand(100...200), 20)
		end

		20.times do
			add_test(500, rand(300...500), 20)
		end
	end
end

Test_query_intervals_1.new 'query-intervals-1'