require './common'

class Test_intersection_two_sorted_arr < TestBase
	def initialize(name)
		super(name)
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []


		10.times do
			size_a = Random.rand(5..20)
			size_b = Random.rand(5..20)

			a,b = [],[]

			size_a.times do
				a << Random.rand(20)
			end

			size_b.times do
				b << Random.rand(20)
			end

			a.sort!
			b.sort!

			@test_in[0] << a
			@test_in[1] << b
			@test_out << (a & b)
		end

		50.times do
			size_a = Random.rand(20..100)
			size_b = Random.rand(20..100)

			a,b = [],[]

			size_a.times do
				a << Random.rand(200)
			end

			size_b.times do
				b << Random.rand(200)
			end

			a.sort!
			b.sort!

			@test_in[0] << a
			@test_in[1] << b
			@test_out << (a & b)
		end

		40.times do
			size_a = Random.rand(500..700)
			size_b = Random.rand(500..700)

			a,b = [],[]

			size_a.times do
				a << Random.rand(700)
			end

			size_b.times do
				b << Random.rand(700)
			end

			a.sort!
			b.sort!

			@test_in[0] << a
			@test_in[1] << b
			@test_out << (a & b)
		end

	end
end

Test_intersection_two_sorted_arr.new 'intersection-of-two-sorted-arrays'