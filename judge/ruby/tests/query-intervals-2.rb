@num_test = 30
@in_0 = []
@in_org_0 = []
@in_1 = []
@in_org_1 = []
@out = []


def load_test
    f = File.new("judge/tests/query-intervals-2.txt")
    @in_0 = read_interval_matrix(f)
    @in_org_0 = @in_0.dup
    @in_1 = read_int_array(f)
    @in_org_1 = @in_0.dup
    @out = read_interval_matrix_arr(f)
    f.close
end

def judge
    load_test

    start_time = Time.now

    (0...@num_test).each do |i|
        inte = Intervals.new(@in_0[i])
        inte.preprocess
        (0...@in_1[i]).each do |j|
            answer = inte.query(j)
            if answer != @out[i][j]
                print "#{i+1} / #{@num_test};"
                print @in_org_0[i].to_s + ', ' + j.to_s
                print ';'
                print answer.to_s
                print ';'
                print @out[i][j].to_s
                puts
                return
            end
        end
    end

    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
