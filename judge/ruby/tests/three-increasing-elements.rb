@num_test = 120
@in_0 = []
@in_org_0 = []
@out = []

def test(answer, i)
    if @out[i].length != answer.length
        return false
    end
    if @out[i][0] == -1 && @out[i][1] == -1 && @out[i][2] == -1
        return answer[0] == -1 && answer[1] == -1 && answer[2] == -1
    else
        if answer[0] == -1 || answer[1] == -1 || answer[2] == -1
            return false
        else
            return (@in_org_0[i][answer[0]] < @in_org_0[i][answer[1]] && @in_org_0[i][answer[1]] < @in_org_0[i][answer[2]]) && (answer[0] < answer[1] && answer[1] < answer[2]);
        end
    end
end

def load_test
    f = File.new("judge/tests/three-increasing-elements.txt")
    @in_0 = read_int_matrix(f)
    @in_org_0 = @in_0.dup
    @out = read_int_matrix(f)
    f.close
end

def judge
    load_test
    capture_stdout

    start_time = Time.now

    (0...@num_test).each do |i|
       puts 'Testing case #' + (i+1).to_s
        answer = three_increasing_nums(@in_0[i]) 
        if (!test(answer, i))
            release_stdout
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

    release_stdout
    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
