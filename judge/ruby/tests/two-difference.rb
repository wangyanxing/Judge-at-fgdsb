@num_test = 50
@in_0 = []
@in_org_0 = []
@in_1 = []
@in_org_1 = []
@out = []

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
end

def load_test
    f = File.new("judge/tests/two-difference.txt")
    @in_0 = read_int_matrix(f)
    @in_org_0 = @in_0.dup
    @in_1 = read_int_array(f)
    @in_org_1 = @in_1.dup
    @out = read_int_matrix(f)
    f.close
end

def judge
    load_test

    start_time = Time.now

    (0...@num_test).each do |i|
        answer = two_dif(@in_0[i], @in_1[i]) 
        if (!test(answer, i))
            print "#{i+1} / #{@num_test};"
            print @in_org_0[i]
            print ', '
            print @in_org_1[i]
            print ';'
            print answer
            print ';'
            print @out[i]
            puts
            return
        end
    end

    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
