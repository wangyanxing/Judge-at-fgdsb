require './common'

class Test_kth_element < TestBase
	def initialize(name)
		super(name)
	end

	def add_test(arr, k)
		@test_in[0] << arr
		@test_in[1] << k
		@test_out << arr.sort[k]
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []

		10.times do
			size = Random.rand(1..20)
			cur = []
			size.times do
				cur << Random.rand(20)
			end
			k = Random.rand(size)
			add_test(cur, k)
		end

		20.times do
			size = Random.rand(50..100)
			cur = []
			size.times do
				cur << Random.rand(-100..100)
			end
			k = Random.rand(size)
			add_test(cur, k)
		end

		30.times do
			size = Random.rand(100..200)
			cur = []
			size.times do
				cur << Random.rand(-500..500)
			end
			k = Random.rand(size)
			add_test(cur, k)
		end

	end
end

Test_kth_element.new 'find-kth-smallest-element'