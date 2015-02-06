@num_test = 100
@in_0 = []
@in_org_0 = []
@out = []

def check_dlist(arr, list)
	cur, pre, i = list, nil, 0

	while(!cur.nil?)
		return false if i >= arr.length || arr[i] != cur.val
		i += 1
		pre = cur
		cur = cur.right
	end
	return false if i != arr.length
	cur = pre
	i -= 1
	while(!cur.nil?)
		return false if i < 0 || arr[i] != cur.val
		i -= 1
		last = cur
		cur = cur.left
		last.left = nil
	end
	return false if i != -1
	true
end

def dlist_to_string(list)
	ret = '['
	first = true
	while(!list.nil?)
		ret += ', ' if !first
		ret += list.val.to_s
		list = list.right
		first = false
	end
	ret + ']'
end

def load_test
    f = File.new("judge/tests/bst-to-dlist.txt")
    @in_0 = read_tree_array(f)
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
        answer = bst_to_list(@in_0[i]) 
        if (!check_dlist(@out[i], answer))
            release_stdout
            print "#{i+1} / #{@num_test};"
            print @in_org_0[i].to_s
            print ';'
            print dlist_to_string(answer)
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
