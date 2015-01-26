require './common'

class Test_two_dif < TestBase
	def initialize(name)
		super(name)
	end

	def two_dif(arr, target)
		if arr.length < 2 then return [-1, -1] end
		arr.sort!
		p1, p2 = 0, 1
		while p1 < arr.length && p2 < arr.length
			if arr[p2] - arr[p1] < target
				p2 += 1
			elsif arr[p2] - arr[p1] > target
				p1 += 1
			else
				return [p1, p2]
			end
			if p2 == p1 then p2 = p1 + 1 end
		end
		[-1, -1]
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []

		5.times do
			size = Random.rand(5..15)
			ret = []
			size.times do
				ret << Random.rand(-30..30)
			end
			ret = ret & ret
			size = ret.length

			id0, id1 = Random.rand(size),Random.rand(size)
			while id0 == id1
				id1 = Random.rand(size)
			end
			if id0 > id1
				id0,id1 = id1,id0
			end

			@test_in[0] << ret
			@test_in[1] << (ret[id0] - ret[id1]).abs
			@test_out << [id0, id1]
		end

		35.times do
			size = Random.rand(100..200)
			ret = []
			size.times do
				ret << Random.rand(-500..500)
			end
			ret = ret & ret
			size = ret.length

			id0,id1 = Random.rand(size),Random.rand(size)
			while id0 == id1
				id1 = Random.rand(size)
			end
			if id0 > id1
				id0,id1 = id1,id0
			end

			@test_in[0] << ret
			@test_in[1] << (ret[id0] - ret[id1]).abs
			@test_out << [id0, id1]
		end

		10.times do
			size = Random.rand(50..100)
			ret = []
			size.times do
				ret << Random.rand(-500..500)
			end
			ret = ret & ret

			while true
				t = Random.rand(-800..800)
				r = two_dif(ret, t)
				if r == [-1, -1]
					@test_in[1] << t
					break
				end
			end

			@test_in[0] << ret
			@test_out << [-1, -1]
		end

	end
end

Test_two_dif.new 'two-difference'

