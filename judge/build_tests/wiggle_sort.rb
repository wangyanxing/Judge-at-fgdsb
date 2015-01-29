require './common'

class Test_wiggle_sort < TestBase
	def initialize(name)
		super(name)
	end

	def wiggle_sort(arr)
		return if arr.empty?
		flag = true
		current = arr[0]
		(0...arr.length-1).each do |i|
			if (flag && current > arr[i+1]) || (!flag && current < arr[i+1])
				arr[i] = arr[i+1]
			else
				arr[i] = current
				current = arr[i+1]
			end
			flag = !flag
		end
		arr[-1] = current
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		5.times do
			size = Random.rand(5..10)
			ret, out = [], []
			size.times do
				ret << Random.rand(1..20)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_out << out
			wiggle_sort(@test_out[-1])
		end

		15.times do
			size = Random.rand(10..50)
			ret, out = [], []
			size.times do
				ret << Random.rand(-100..100)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_out << out
			wiggle_sort(@test_out[-1])
		end

		30.times do
			size = Random.rand(50..100)
			ret, out = [], []
			size.times do
				ret << Random.rand(-10000..10000)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_out << out
			wiggle_sort(@test_out[-1])
		end

		@extra_test_code_ruby = '
def test_wiggle(arr)
    return true if arr.nil? || arr.length == 0
    test_flag = true
    (0...arr.length-1).each do |i|
        if test_flag
            return false if arr[i] > arr[i+1]
        else
            return false if arr[i] < arr[i+1]
        end
        test_flag = !test_flag;
    end
    true
end'
	end
end

Test_wiggle_sort.new 'wiggle-sort'
