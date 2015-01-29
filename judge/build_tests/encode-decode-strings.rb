require './common'

class Test_decode_encode_strings < TestBase
	def initialize(name)
		super(name)
	end

	def add_test arr
		@test_in[0] << arr
		@test_out << arr
	end

	def gen_tests
		@test_in, @test_out = [[]], []

		add_test ['fg', 'dsb']
		add_test ['fg', '101']
		add_test ['fg', 'dsb', '#hello>?', '10101']
		add_test ['fg', 'is', 'a', 'big', 'sha', 'B']

		words = ('a'..'z').to_a
		words += ('A'..'Z').to_a
		words += ('0'..'9').to_a
		words += [')','(','*','&','^','%','$','#','@','~',')','<','>','?',',','.','/',';',',','|','+','-','=','_']

		while @test_in[0].length < 100
			cur = []
			size_cur = rand(3..20)
			while cur.length < size_cur
				cur << (0...size_cur).map { words[rand(words.length)] }.join
			end
			add_test(cur)
		end

	end
end

Test_decode_encode_strings.new 'encode-decode-strings'