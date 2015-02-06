require './common'

class Test_self_exclusive_prod < TestBase
	def initialize(name)
		super(name)
	end

	def product(arr)
		prod = arr.inject{|prod, x| prod * x }
		ret = Array.new(arr.length, prod)
		(0...arr.length).each do |i|
			ret[i] /= arr[i]
		end
		ret
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		200.times do
			size = Random.rand(5..10)
			ret, out = [], []
			size.times do
				ret << Random.rand(1..10)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_out << product(out)
		end
	end
end

Test_self_exclusive_prod.new 'self-exclusive-product'
