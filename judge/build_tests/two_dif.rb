require './common'

class Test_two_dif < TestBase
	def initialize(name)
		super(name)
	end

	def two_dif(arr, target)
		if arr.length < 2 then return [-1, -1] end
		p1, p2 = 0, 1
		while p1 < arr.length && p2 < arr.length
			if arr[p2] - arr[p1] < target
				p2 += 1
			elsif arr[p2] - arr[p1] > target
				p1 += 1
			else
				return [p1, p2]
			end
			if p2 == p1 then p2 = p1 + 1 end
		end
		[-1, -1]
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []

		5.times do
			size = Random.rand(5..15)
			ret = []
			size.times do
				ret << Random.rand(-30..30)
			end
			ret = ret & ret
			ret.sort!
			size = ret.length

			id0, id1 = Random.rand(size),Random.rand(size)
			while id0 == id1
				id1 = Random.rand(size)
			end
			if id0 > id1
				id0,id1 = id1,id0
			end

			@test_in[0] << ret
			@test_in[1] << (ret[id0] - ret[id1]).abs
			@test_out << [id0, id1]
		end

		35.times do
			size = Random.rand(100..200)
			ret = []
			size.times do
				ret << Random.rand(-500..500)
			end
			ret = ret & ret
			ret.sort!
			size = ret.length

			id0,id1 = Random.rand(size),Random.rand(size)
			while id0 == id1
				id1 = Random.rand(size)
			end
			if id0 > id1
				id0,id1 = id1,id0
			end

			@test_in[0] << ret
			@test_in[1] << (ret[id0] - ret[id1]).abs
			@test_out << [id0, id1]
		end

		10.times do
			size = Random.rand(50..100)
			ret = []
			size.times do
				ret << Random.rand(-500..500)
			end
			ret = ret & ret
			ret.sort!

			while true
				t = Random.rand(-800..800)
				r = two_dif(ret, t)
				if r == [-1, -1]
					@test_in[1] << t
					break
				end
			end

			@test_in[0] << ret
			@test_out << [-1, -1]
		end

		@extra_test_code_java = '    public static boolean test(int[] answer, int i) {
        if(out[i].length != answer.length) return false;
        if(out[i][0] == -1 && out[i][1] == -1) {
            return answer[0] == -1 && answer[1] == -1;
        } else {
            if(answer[0] == -1 || answer[1] == -1) {
                return false;
            } else {
                return Math.abs(in_0[i][answer[0]] - in_0[i][answer[1]]) == in_1[i];
            }
        }
    }'

		@extra_test_code_python = 'def test(answer, i):
    if len(out[i]) != len(answer): return False
    if out[i][0] == -1 and out[i][1] == -1:
        return answer[0] == -1 and answer[1] == -1
    else:
        if answer[0] == -1 or answer[1] == -1:
            return False
        else:
            return abs(in_0[i][answer[0]] - in_0[i][answer[1]]) == in_1[i]
		'


		@extra_test_code_ruby = '
def test(answer, i)
    if @out[i].length != answer.length
        return false
    end
    if @out[i][0] == -1 && @out[i][1] == -1
        return answer[0] == -1 && answer[1] == -1
    else
        if answer[0] == -1 || answer[1] == -1
            return false
        else
            return (@in_0[i][answer[0]] - @in_0[i][answer[1]]).abs == @in_1[i]
        end
    end
end'

		@extra_test_code_cpp = 'bool test(vector<int>& answer, int i) {
    if(out[i].size() != answer.size()) return false;
    if(out[i][0] == -1 && out[i][1] == -1) {
        return answer == out[i];
    } else {
        if(answer[0] == -1 || answer[1] == -1) {
            return false;
        } else {
            return abs(in_0[i][answer[0]] - in_0[i][answer[1]]) == in_1[i];
        }
    }
}
		'
	end
end

Test_two_dif.new 'two-difference'

