require './common'
#require '../ruby/common'

class Test_meeting_rooms_2 < TestBase
	def initialize(name)
		super(name)
	end

	def min_rooms(meetings)
		times = []
		meetings.each do |m|
			times << m[0]
			times << -m[1]
		end
		times.sort! {|a,b|
			if a.abs == b.abs
				a <=> b
			else
				a.abs <=> b.abs
			end
		}
		ret, cur = 0, 0
		times.each do |t|
			if t >= 0
				cur += 1
				ret = [ret, cur].max
			else
				cur -= 1
			end
		end
		ret
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
		@test_out << min_rooms(data)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		add_test([[1,4], [2,3], [3,4], [4,5]])

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

Test_meeting_rooms_2.new 'meeting-rooms-2'