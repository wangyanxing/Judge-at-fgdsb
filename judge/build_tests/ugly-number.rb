require './common'

class Test_ugly_number < TestBase
	def initialize(name)
		super(name)
	end

	def kth_ugly_number(k)
		i2, i3, i5 = 0, 0 ,0
		next_mul2, next_mul3, next_mul5 = 2, 3, 5
		ret = 1
		ugly = Array.new(k)
		ugly[0] = 1

		(1...k).each do |i|
			ret = [next_mul2, next_mul3, next_mul5].min
			ugly[i] = ret
			if ret == next_mul2
				i2 += 1
				next_mul2 = ugly[i2] * 2
			end
			if ret == next_mul3
				i3 += 1
				next_mul3 = ugly[i3] * 3
			end
			if ret == next_mul5
				i5 += 1
				next_mul5 = ugly[i5] * 5
			end
		end
		ret
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		(1..500).each do |k|
			@test_in[0] << k
			@test_out << kth_ugly_number(k)
		end

	end
end

Test_ugly_number.new 'ugly-number'