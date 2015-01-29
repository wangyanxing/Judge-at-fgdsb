require './common'

class Test_factor_comb < TestBase
	def initialize(name)
		super(name)
	end

	def factors_comb(ret, num, cur)
		last = 2
		last = cur[-1] if !cur.empty?
		(last...num).each do |f|
			if(num % f == 0)
				factors_comb(ret, num / f, cur + [f])
			end
		end
		if !cur.empty? && num >= last
			ret << cur + [num]
		end
	end

	def combs(num)
		ret = []
		factors_comb(ret, num, [])
		return ret
	end

	def add_test(num)
		@test_in[0] << num
		@test_out << combs(num)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		(1..30).each do |n|
			add_test n
		end
	end
end

Test_factor_comb.new 'factor-combinations'