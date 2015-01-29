require './common'

class Test_segregate_even_odd < TestBase
	def initialize(name)
		super(name)
	end

	def segregates(arr)
		l, r = 0, arr.length - 1
		while(l < r)
			while(arr[l] % 2 == 0 && l < r)
				l += 1
			end
			while(arr[r] % 2 != 0 && l < r)
				r -= 1
			end
			if(l < r)
				arr[l], arr[r] = arr[r], arr[l]
				l += 1
				r -= 1
			end
		end
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
			segregates(@test_out[-1])
		end

		15.times do
			size = Random.rand(10..50)
			ret, out = [], []
			size.times do
				ret << Random.rand(0..200)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_out << out
			segregates(@test_out[-1])
		end

		30.times do
			size = Random.rand(50..100)
			ret, out = [], []
			size.times do
				ret << Random.rand(0..10000)
				out << ret[-1]
			end
			@test_in[0] << ret
			@test_out << out
			segregates(@test_out[-1])
		end

		@extra_test_code_ruby = '
def test(i)
	if @in_0[i].sort != @in_org_0[i].sort
		return false
	end
	flag = false
	@in_0[i].each do |num|
		if num % 2 == 0
			return false if flag
		else
			flag = true
		end
	end
	true
end'

		@extra_test_code_python = 'def test(i):
    if not test_anagram(in_0[i], in_org_0[i]): return False
    flag = False
    for i, num in enumerate(in_0[i]):
        if num % 2 == 0:
            if flag: return False
        else:
            flag = True
    return True'

		@extra_test_code_java = '		public static boolean test(int i) {
      if(!common.test_anagram(in_0[i], in_org_0[i])) return false;
		  boolean flag = false;
		  for(int j = 0; j < in_0[i].length; ++j) {
        	if (in_0[i][j] % 2 == 0) {
					  if(flag) return false;
				  } else {
					  flag = true;
				  }
			}
      return true;
    }'

		@extra_test_code_cpp = '		bool test(int i) {
      if(!test_anagram(in_0[i], in_org_0[i])) return false;
		  bool flag = false;
		  for(int j = 0; j < in_0[i].size(); ++j) {
        	if (in_0[i][j] % 2 == 0) {
					  if(flag) return false;
				  } else {
					  flag = true;
				  }
			}
      return true;
    }'
	end
end

Test_segregate_even_odd.new 'segregate-even-odd'
