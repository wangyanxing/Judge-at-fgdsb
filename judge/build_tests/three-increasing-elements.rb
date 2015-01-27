require './common'

class Test_three_increasing_nums < TestBase
	def initialize(name)
		super(name)
	end

	def three_nums(nums)
		for i in 0...nums.length do
			for j in i+1...nums.length do
				for k in j+1...nums.length do
					if nums[i] < nums[j] && nums[j] < nums[k]
						return [i,j,k]
					end
				end
			end
		end
		[-1,-1,-1]
	end

	def add_test(arr)
		@test_in[0] << arr
		@test_out << three_nums(arr)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		10.times do
			size = Random.rand(2..20)
			cur = []
			size.times do
				cur << Random.rand(20)
			end
			add_test(cur)
		end

		20.times do
			size = Random.rand(50..100)
			cur = []
			size.times do
				cur << Random.rand(-100..100)
			end
			add_test(cur)
		end

		30.times do
			size = Random.rand(100..200)
			cur = []
			size.times do
				cur << Random.rand(-500..500)
			end
			add_test(cur)
		end

		@extra_test_code_cpp = 'bool test(vector<int>& answer, int i) {
    if(out[i].size() != answer.size()) return false;
    if(out[i][0] == -1 && out[i][1] == -1 && out[i][2] == -1) {
        return answer == out[i];
    } else {
        if(answer[0] == -1 || answer[1] == -1 || answer[2] == -1) {
            return false;
        } else {
            return (in_org_0[i][answer[0]] < in_org_0[i][answer[1]] && in_org_0[i][answer[1]] < in_org_0[i][answer[2]]) && (answer[0] < answer[1] && answer[1] < answer[2]);
        }
    }
}'

		@extra_test_code_java = 'public static boolean test(int[] answer, int i) {
    if(out[i].length != answer.length) return false;
    if(out[i][0] == -1 && out[i][1] == -1 && out[i][2] == -1) {
        return answer[0] == -1 && answer[1] == -1 && answer[2] == -1;
    } else {
        if(answer[0] == -1 || answer[1] == -1 || answer[2] == -1) {
            return false;
        } else {
            return (in_org_0[i][answer[0]] < in_org_0[i][answer[1]] && in_org_0[i][answer[1]] < in_org_0[i][answer[2]]) && (answer[0] < answer[1] && answer[1] < answer[2]);
        }
    }
}'

		@extra_test_code_python = 'def test(answer, i):
    if len(out[i]) != len(answer): return False
    if out[i][0] == -1 and out[i][1] == -1 and out[i][2] == -1:
        return answer[0] == -1 and answer[1] == -1 and answer[2] == -1
    else:
        if answer[0] == -1 or answer[1] == -1 or answer[2] == -1:
            return False
        else:
            return (in_org_0[i][answer[0]] < in_org_0[i][answer[1]] and in_org_0[i][answer[1]] < in_org_0[i][answer[2]]) and (answer[0] < answer[1] and answer[1] < answer[2])
		'


		@extra_test_code_ruby = 'def test(answer, i)
    if T_out[i].length != answer.length
        return false
    end
    if T_out[i][0] == -1 && T_out[i][1] == -1 && T_out[i][2] == -1
        return answer[0] == -1 && answer[1] == -1 && answer[2] == -1
    else
        if answer[0] == -1 || answer[1] == -1 || answer[2] == -1
            return false
        else
            return (T_in_org_0[i][answer[0]] < T_in_org_0[i][answer[1]] && T_in_org_0[i][answer[1]] < T_in_org_0[i][answer[2]]) && (answer[0] < answer[1] && answer[1] < answer[2]);
        end
    end
end'
	end

end

Test_three_increasing_nums.new 'three-increasing-elements'