@num_test = 120
@in_0 = []
@in_org_0 = []
@out = []


def load_test
    f = File.new("judge/tests/tree-vertical-traversal.txt")
    @in_0 = read_tree_array(f)
    @in_org_0 = @in_0.dup
    @out = read_int_matrix_arr(f)
    f.close
end

def judge
    load_test
    capture_stdout

    start_time = Time.now

    (0...@num_test).each do |i|
       puts 'Testing case #' + (i+1).to_s
        answer = vertical_traversal(@in_0[i]) 
        if answer != @out[i]
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
