require './common'

class Test_inverse_pairs < TestBase
	def initialize(name)
		super(name)
	end

	def num_inverse_pairs(arr)
		ret = 0
		arr.each_with_index do |num, i|
			((i+1)...arr.length).each do |j|
				if num > arr[j]
					ret += 1
				end
			end
		end
		ret
	end

	def add_test(arr)
		@test_in[0] << arr
		@test_out << num_inverse_pairs(arr)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		10.times do
			size = Random.rand(2..20)
			cur = []
			size.times do
				cur << Random.rand(20)
			end
			add_test(cur)
		end

		20.times do
			size = Random.rand(50..100)
			cur = []
			size.times do
				cur << Random.rand(-100..100)
			end
			add_test(cur)
		end

		30.times do
			size = Random.rand(100..200)
			cur = []
			size.times do
				cur << Random.rand(-500..500)
			end
			add_test(cur)
		end
	end
end

Test_inverse_pairs.new 'inverse-pairs'