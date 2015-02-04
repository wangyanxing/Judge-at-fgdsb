require './common'

class Test_isomorphic_str < TestBase
	def initialize(name)
		super(name)
	end

	def is_isomorphic(a, b)
		return false if a.length != b.length
		mp_a, mp_b = {}, {}
		(0...a.length).each do |i|
			if !mp_a.has_key? a[i]
				mp_a[a[i]] = b[i]
			else
				return false if mp_a[a[i]] != b[i]
				mp_a[a[i]] = b[i]
			end

			if !mp_b.has_key? b[i]
				mp_b[b[i]] = a[i]
			else
				return false if mp_b[b[i]] != a[i]
			end
		end
		true
	end

	def add_test(s0, s1)
		@test_in[0] << s0
		@test_in[1] << s1
		@test_out << is_isomorphic(s0,s1)
	end

	def gen_tests
		@test_in, @test_out = [[],[]], []

		add_test 'foo','app'
		add_test 'foo','bar'
		add_test 'turtle','tletur'
		add_test 'ab','ca'
		add_test 'fg','dsb'

		tin = [[],[]]
		ret = []
		while tin[0].length < 20
			size = rand(5...10)
			r0 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			r1 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			if is_isomorphic(r0,r1)
				tin[0] << r0
				tin[1] << r1
				ret << true
			end
		end

		@test_in[0] += tin[0]
		@test_in[1] += tin[1]
		@test_out += ret

		tin = [[],[]]
		ret = []
		while tin[0].length < 80
			size = rand(10...20)
			r0 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			r1 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			if is_isomorphic(r0,r1)
				tin[0] << r0
				tin[1] << r1
				ret << true
			end
		end

		@test_in[0] += tin[0]
		@test_in[1] += tin[1]
		@test_out += ret

		tin = [[],[]]
		ret = []
		while tin[0].length < 30
			size = rand(50...80)
			r0 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			r1 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			if !is_isomorphic(r0,r1)
				tin[0] << r0
				tin[1] << r1
				ret << false
			end
		end

		@test_in[0] += tin[0]
		@test_in[1] += tin[1]
		@test_out += ret

		tin = [[],[]]
		ret = []
		while tin[0].length < 500
			size = rand(200...300)
			r0 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			r1 = (0...size).map { ('a'..'z').to_a[rand(26)] }.join
			if !is_isomorphic(r0,r1)
				tin[0] << r0
				tin[1] << r1
				ret << false
			end
		end

		@test_in[0] += tin[0]
		@test_in[1] += tin[1]
		@test_out += ret

	end
end

Test_isomorphic_str.new 'isomorphic-strings'