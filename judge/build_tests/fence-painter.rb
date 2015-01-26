require './common'

class Test_fence_painter < TestBase
	def initialize(name)
		super(name)
	end

	def num_colors(n, k)
		return 0 if (n <= 0 || k <= 0)
		prev_prev, prev = k, k * k
		(n - 1).times do
			old_dif = prev
			prev = (k - 1) * (prev_prev + prev)
			prev_prev = old_dif
		end
		prev_prev
	end

	def add_test(n, k)
		@test_in[0] << n
		@test_in[1] << k
		@test_out << num_colors(n, k)
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []

		(1..10).each do |n|
			(1..8).each do |k|
				add_test(n, k)
			end
		end
	end
end

Test_fence_painter.new 'fence-painter'