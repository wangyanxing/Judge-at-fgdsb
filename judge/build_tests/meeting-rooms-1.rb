require './common'
#require '../ruby/common'

class Test_meeting_rooms_1 < TestBase
	def initialize(name)
		super(name)
	end

	def attend_all(intervals)
		sorted = intervals.sort {|a,b| a[0] <=> b[0]}
		(1...sorted.length).each do |i|
			return false if sorted[i][0] < sorted[i-1][1]
		end
		true
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
		@test_out << attend_all(data)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		add_test([[1,4],[4,5],[3,4],[2,3]])

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

Test_meeting_rooms_1.new 'meeting-rooms-1'