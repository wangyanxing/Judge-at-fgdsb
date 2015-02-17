@num_test = 50
@in_0 = []
@in_org_0 = []
@out = []


def load_test
    f = File.new("judge/tests/peek-iterator.txt")
    @in_0 = read_int_matrix(f)
    @in_org_0 = @in_0.dup
    @out = read_bool_array(f)
    f.close
end

def judge
    load_test
    capture_stdout

    start_time = Time.now

    (0...@num_test).each do |i|
       puts 'Testing case #' + (i+1).to_s
       
       it = Iterator.new(@in_0[i])
       pi = PeekIterator.new(it)
       
       @in_0[i].each do |num|
           has_next_wrong, peek_wrong, get_next_wrong = false, false, false
           
           has_next_wrong = true if !pi.has_next
           peek_wrong = true if pi.peek != num
           nxt = pi.get_next
           get_next_wrong = true if nxt != num
           
           if has_next_wrong || peek_wrong || get_next_wrong
               release_stdout
               
               msg = ''
               msg += 'has_next() == false, ' if has_next_wrong
               msg += 'peek() == ' + pi.peek.to_s + ', ' if peek_wrong
               msg += 'get_next() == ' + nxt.to_s + ', ' if get_next_wrong
               
               expmsg = ''
               expmsg += 'has_next() == true, ' if has_next_wrong
               expmsg += 'peek() == ' + num.to_s + ', ' if peek_wrong
               expmsg += 'get_next() == ' + num.to_s + ', ' if get_next_wrong
               
               print "#{i+1} / #{@num_test};"
               print @in_org_0[i].to_s + ', current element: ' + num.to_s
               print ';'
               print msg[0..-3]
               print ';'
               print expmsg[0..-3]
               puts
               return
           end
       end
    end

    release_stdout
    runtime = (Time.now - start_time) * 1000.0
    puts('Accepted;' + runtime.to_i.to_s)
end
