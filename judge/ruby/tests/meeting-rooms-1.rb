@num_test = 91
@in_0 = []
@in_org_0 = []
@out = []


def load_test
    f = File.new("judge/tests/meeting-rooms-1.txt")
    @in_0 = read_interval_matrix(f)
    @in_org_0 = @in_0.dup
    @out = read_bool_array(f)
    f.close
end

def judge
    load_test

    start_time = Time.now

    (0...@num_test).each do |i|
        answer = attend_all(@in_0[i]) 
        if answer != @out[i]
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
