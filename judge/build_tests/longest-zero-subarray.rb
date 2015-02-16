require './common'

class Test_longest_zero_subarray < TestBase
	def initialize(name)
		super(name)
	end

	def longest_subarray(arr)
		sum, length, begin_id, record = 0, 0, -1, {0 => -1}
		arr.each_with_index do |num,i|
			sum += num
			if record.has_key? sum
				first = record[sum]
				if i - first > length
					length = i - first
					begin_id = first + 1
				end
			else
				record[sum] = i
			end
		end
		if begin_id < 0
			[]
		else
			arr.slice(begin_id, length)
		end
	end

	def add_test(arr)
		@test_in[0] << arr
		@test_out << longest_subarray(arr)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		20.times do
			size = Random.rand(2..20)
			cur = []
			size.times do
				cur << Random.rand(-10..10)
			end
			add_test(cur)
		end

		40.times do
			size = Random.rand(50..100)
			cur = []
			size.times do
				cur << Random.rand(-50..50)
			end
			add_test(cur)
		end

		50.times do
			size = Random.rand(500..1000)
			cur = []
			size.times do
				cur << Random.rand(-1000..1000)
			end
			add_test(cur)
		end

		@extra_test_code_cpp = '
void test_ret(vector<int>& arr, int answer_len) {
		if(arr.size() != answer_len) return false;
    int sum = 0;
		for(int i = 0; i < arr.size(); ++i) sum += arr[i];
		return sum == 0;
}'
		@extra_test_code_java = '
public static void test_ret(List<Integer> arr, int answer_len) {
		if(arr.size() != answer_len) return false;
    int sum = 0;
		for(int i = 0; i < arr.size(); ++i) sum += arr.get(i);
		return sum == 0;
}'

		@extra_test_code_ruby = '
def test_ret(arr, answer_len)
		return false if arr.length != answer_len
    arr.inject{|sum, x| sum + x } == 0
end'

		@extra_test_code_lua = '
function test_ret(arr, answer_len)
    if #arr ~= answer_len then return false end
    local sum = 0
    for i = 1, #arr do
        sum = sum + arr[i]
    end
    return true
end'

		@extra_test_code_python = '
def test_ret(arr, answer_len):
    if len(arr) != answer_len:
        return False
    sum = 0
    for i in range(len(arr)):
				sum += arr[i]
    return sum == 0'
	end

end

Test_longest_zero_subarray.new 'longest-zero-subarray'