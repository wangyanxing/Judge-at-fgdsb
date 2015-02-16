require './common'

class Test_second_largest_num < TestBase
	def initialize(name)
		super(name)
	end

	def second_largest(arr)
		return 0 if arr.length < 2
		second_max, max_val = Integer::MIN, arr[0]
		(1...arr.length).each do |i|
			if arr[i] > max_val
				second_max = max_val
				max_val = arr[i]
			elsif arr[i] > second_max && arr[i] != max_val
				second_max = arr[i]
			end
		end
		if second_max == max_val or second_max == Integer::MIN
			0
		else
			second_max
		end
	end

	def add_test(arr)
		@test_in[0] << arr
		@test_out << second_largest(arr)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		add_test([1])
		add_test([1,1])
		add_test([1,2])
		add_test([3,1,2])
		add_test([1,1,1,1,1,1])

		10.times do
			size = Random.rand(2..20)
			cur = []
			size.times do
				cur << Random.rand(1..20)
			end
			add_test(cur)
		end

		20.times do
			size = Random.rand(50..100)
			cur = []
			size.times do
				cur << Random.rand(1..500)
			end
			add_test(cur)
		end

		40.times do
			size = Random.rand(100..200)
			cur = []
			size.times do
				cur << Random.rand(1..500)
			end
			add_test(cur)
		end
	end
end

Test_second_largest_num.new 'second-largest-number'