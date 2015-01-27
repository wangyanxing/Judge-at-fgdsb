require './judge/ruby/common'
require './judge/ruby/tests/segregate-even-odd'

def segregate(arr)
	l, r = 0, arr.length - 1
	while(l < r)
		while(arr[l] % 2 == 0 && l < r)
			l += 1
		end
		while(arr[r] % 2 != 0 && l < r)
			r -= 1
		end
		if(l < r)
			arr[l], arr[r] = arr[r], arr[l]
			l += 1
			r -= 1
		end
	end
end


start_time = Time.now

(0...T_num_test).each do |i|
    answer = segregate(T_in_0[i])
    answer = T_in_0[i];
    if !test(i)
        print "#{i+1} / #{T_num_test};"
        print T_in_org_0[i]
        print ';'
        print answer
        print ';'
        print T_out[i]
        puts
        exit
    end
end
runtime = (Time.now - start_time) * 1000.0
puts('Accepted;' + runtime.to_i.to_s)
