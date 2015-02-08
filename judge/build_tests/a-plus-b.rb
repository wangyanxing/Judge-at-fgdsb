require './common'

class Test_a_plus_b < TestBase
	def initialize(name)
		super(name)
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []

		10.times do
			a, b = Random.rand(100),Random.rand(100)
			@test_in[0] << a
			@test_in[1] << b
			@test_out << a + b
		end

		15.times do
			a, b = Random.rand(100000),Random.rand(100000)
			@test_in[0] << a
			@test_in[1] << b
			@test_out << a + b
		end

		25.times do
			a, b = Random.rand(10000000),Random.rand(10000000)
			@test_in[0] << a
			@test_in[1] << b
			@test_out << a + b
		end
	end
end

Test_a_plus_b.new 'a-plus-b'

