require './common'

class Test_compress_string < TestBase
	def initialize(name)
		super(name)
	end

	def str_compress(str)
		return '' if str.nil? || str.length == 0

		ret, cur, count, id = '', str[0], 1, 1
		while id <= str.length
			if id < str.length && str[id] == cur
				count += 1
			else
				ret += cur + count.to_s
				cur = str[id] if id < str.length
				count = 1
			end
			id += 1
		end
		if ret.length < str.length
			return ret
		else
			return str
		end
	end

	def add_test(str)
		@test_in[0] << str
		@test_out << str_compress(str)
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		words = ('a'..'z').to_a
		words += ('A'..'Z').to_a

		add_test 'a'
		add_test 'aabcccccaaa'
		add_test 'fffggdddsssbbbb'
		add_test 'fgdsb'
		add_test 'fgddsb'

		20.times do
			size_cur = rand(3..20)
			str = words.sample
			last_char = str[0]
			while str.length < size_cur
				if rand(2) == 0
					str += last_char
				else
					str += words.sample
					last_char = str[-1]
				end
			end
			add_test str
		end

		50.times do
			size_cur = rand(20..50)
			str = words.sample
			last_char = str[0]
			while str.length < size_cur
				if rand(2) == 0
					str += last_char
				else
					str += words.sample
					last_char = str[-1]
				end
			end
			add_test str
		end

		30.times do
			size_cur = rand(50..200)
			str = words.sample
			last_char = str[0]
			while str.length < size_cur
				if rand(2) == 0
					str += last_char
				else
					str += words.sample
					last_char = str[-1]
				end
			end
			add_test str
		end
	end
end

Test_compress_string.new 'compress-string'