require './common'

class Test_pow_of_4 < TestBase
	def initialize(name)
		super(name)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		int_max, cur = 2147483647, 1

		while cur <= int_max
			@test_in[0] << cur
			@test_out << true
			cur *= 4
		end

		50.times do
			var = Random.rand(300)
			if !@test_in[0].include? var
				@test_in[0] << var
				@test_out << false
			end
		end

		200.times do
			var = Random.rand(2147483647)
			if !@test_in[0].include? var
				@test_in[0] << var
				@test_out << false
			end
		end

	end
end

Test_pow_of_4.new 'power-of-4'