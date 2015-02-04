@num_test = 100
@in_0 = []
@in_org_0 = []
@out = []

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
end

def load_test
    f = File.new("judge/tests/segregate-even-odd.txt")
    @in_0 = read_int_matrix(f)
    @in_org_0 = @in_0.dup
    @out = read_int_matrix(f)
    f.close
end

def judge
    load_test

    start_time = Time.now

    (0...@num_test).each do |i|
        answer = segregate(@in_0[i]) 
        answer = @in_0[i]
        if (!test(i))
            print "#{i+1} / #{@num_test};"
            print @in_org_0[i].to_s
            print ';'
            print answer.to_s
            print ';'
            print @out[i].to_s
            puts
            return
        end
    end

    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
