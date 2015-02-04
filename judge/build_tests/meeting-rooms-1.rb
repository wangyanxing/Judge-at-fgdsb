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

	def gen_random(max, nums, length)
		ret = []
		candidates = (0...max).to_a
		while ret.length < nums
			start = candidates.sample()
			over = rand(length)
			if ret.include? [start, start + over]
				next
			end
			ret << [start, start + over]
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
		add_test([[1,4],[5,6]])

		10.times do
			add_test(gen_random(10, rand(5...10), 1..5))
		end

		50.times do
			add_test(gen_random(200, rand(100...150), 1..10))
		end

		30.times do
			add_test(gen_random(5000, rand(100...300), 1..20))
		end

		30.times do
			add_test(gen_random(1000, rand(800...1000), 1..5))
		end

	end
end

Test_meeting_rooms_1.new 'meeting-rooms-1'