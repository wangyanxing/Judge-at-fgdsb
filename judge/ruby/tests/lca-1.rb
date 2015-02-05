@num_test = 120
@in_0 = []
@in_org_0 = []
@in_1 = []
@in_org_1 = []
@in_2 = []
@in_org_2 = []
@out = []


def load_test
    f = File.new("judge/tests/lca-1.txt")
    @in_0 = read_tree_array(f)
    @in_org_0 = @in_0.dup
    @in_1 = read_int_array(f)
    @in_org_1 = @in_1.dup
    @in_2 = read_int_array(f)
    @in_org_2 = @in_2.dup
    @out = read_tree_array(f)
    f.close
end

def judge
    load_test

    start_time = Time.now

    (0...@num_test).each do |i|
        answer = lca(@in_0[i], @in_1[i], @in_2[i]) 
        if (!node_equals(@out[i], answer))
            print "#{i+1} / #{@num_test};"
            print @in_org_0[i].to_s
            print ', '
            print @in_org_1[i].to_s
            print ', '
            print @in_org_2[i].to_s
            print ';'
            print node_to_string(answer)
            print ';'
            print node_to_string(@out[i])
            puts
            return
        end
    end

    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
