@num_test = 55
@in_0 = []
@in_org_0 = []
@in_1 = []
@in_org_1 = []
@out = []

class ZigzagIterator_ref
    def initialize(i0, i1)
        @its, @pointer = [i0,i1], i0.has_next() ? 0 : 1
    end
    
    def has_next()
        @its[@pointer].has_next()
    end
    
    def get_next()
        ret, old = @its[@pointer].get_next(), @pointer;
        loop do
            @pointer = (@pointer + 1) % 2
            break if @its[@pointer].has_next() or @pointer == old
        end
        ret
    end
end

def load_test
    f = File.new("judge/tests/zigzag-iterator.txt")
    @in_0 = read_int_matrix(f)
    @in_org_0 = @in_0.dup
    @in_1 = read_int_matrix(f)
    @in_org_1 = @in_1.dup
    @out = read_bool_array(f)
    f.close
end

def judge
    load_test
    capture_stdout

    start_time = Time.now

    (0...@num_test).each do |i|
       puts 'Testing case #' + (i+1).to_s
       
       pi = ZigzagIterator.new(Iterator.new(@in_0[i]), Iterator.new(@in_1[i]))
       w = []
       while pi.has_next
           w << pi.get_next
       end
       
       wi = ZigzagIterator_ref.new(Iterator.new(@in_0[i]), Iterator.new(@in_1[i]))
       wo = []
       while wi.has_next
           wo << wi.get_next
       end
       
       if w != wo
           release_stdout
           print "#{i+1} / #{@num_test};"
           print @in_org_0[i].to_s
           print ', '
           print @in_org_1[i].to_s
           print ';'
           print w.to_s
           print ';'
           print wo.to_s
           puts
           return
       end
    end

    release_stdout
    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
