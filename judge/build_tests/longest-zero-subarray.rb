require './common'

class Test_longest_zero_subarray < TestBase
	def initialize(name)
		super(name)
	end

	def longest_subarray(arr)
		sum, length, begin_id, record = 0, 0, -1, {0 => -1}
		arr.each_with_index do |num,i|
			sum += num
			if record.has_key? sum
				first = record[sum]
				if i - first > length
					length = i - first
					begin_id = first + 1
				end
			else
				record[sum] = i
			end
		end
		if begin_id < 0
			[]
		else
			arr.slice(begin_id, length)
		end
	end

	def add_test(arr)
		@test_in[0] << arr
		@test_out << longest_subarray(arr)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		10.times do
			size = Random.rand(2..20)
			cur = []
			size.times do
				cur << Random.rand(-10..10)
			end
			add_test(cur)
		end

		20.times do
			size = Random.rand(50..100)
			cur = []
			size.times do
				cur << Random.rand(-50..50)
			end
			add_test(cur)
		end

		30.times do
			size = Random.rand(100..200)
			cur = []
			size.times do
				cur << Random.rand(-100..100)
			end
			add_test(cur)
		end
	end

end

Test_longest_zero_subarray.new 'longest-zero-subarray'