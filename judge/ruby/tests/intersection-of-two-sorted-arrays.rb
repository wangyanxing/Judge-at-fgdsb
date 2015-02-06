@num_test = 100
@in_0 = []
@in_org_0 = []
@in_1 = []
@in_org_1 = []
@out = []


def load_test
    f = File.new("judge/tests/intersection-of-two-sorted-arrays.txt")
    @in_0 = read_int_matrix(f)
    @in_org_0 = @in_0.dup
    @in_1 = read_int_matrix(f)
    @in_org_1 = @in_1.dup
    @out = read_int_matrix(f)
    f.close
end

def judge
    load_test
    capture_stdout

    start_time = Time.now

    (0...@num_test).each do |i|
       puts 'Testing case #' + (i+1).to_s
        answer = intersection(@in_0[i], @in_1[i]) 
        if answer != @out[i]
            release_stdout
            print "#{i+1} / #{@num_test};"
            print @in_org_0[i].to_s
            print ', '
            print @in_org_1[i].to_s
            print ';'
            print answer.to_s
            print ';'
            print @out[i].to_s
            puts
            return
        end
    end

    release_stdout
    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
