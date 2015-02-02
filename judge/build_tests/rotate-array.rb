require './common'

class Test_rotate_array < TestBase
	def initialize(name)
		super(name)
	end

	def rotate_array(arr, k)
		k %= arr.length
		return arr if k == 0
		ret = arr[(arr.length - k)...arr.length]
		ret += arr[0...(arr.length - k)]
		ret
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []

		10.times do
			size = Random.rand(5..10)
			ret, out = [], []
			size.times do
				ret << Random.rand(1..20)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_in[1] << rand(2 * size)
			@test_out << rotate_array(out, @test_in[1][-1])
		end

		30.times do
			size = Random.rand(100..300)
			ret, out = [], []
			size.times do
				ret << Random.rand(-100..100)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_in[1] << rand(2 * size)
			@test_out << rotate_array(out, @test_in[1][-1])
		end

		20.times do
			size = Random.rand(500..1000)
			ret, out = [], []
			size.times do
				ret << Random.rand(-10000..10000)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_in[1] << rand(2 * size)
			@test_out << rotate_array(out, @test_in[1][-1])
		end

	end
end

Test_rotate_array.new 'rotate-array'
