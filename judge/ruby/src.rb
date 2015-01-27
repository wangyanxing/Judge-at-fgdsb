require './judge/ruby/common'
require './judge/ruby/tests/second-largest-number'

def second_largest(arr)
    return 0 if arr.length < 2
	second_max, max_val = arr[0], arr[0]
	(1...arr.length).each do |i|
		if arr[i] > max_val
			second_max = max_val
			max_val = arr[i]
		elsif arr[i] > second_max && arr[i] != max_val
			second_max = arr[i]
		end
	end
	if second_max == max_val
		0
	else
		second_max
	end
end


start_time = Time.now

(0...T_num_test).each do |i|
    answer = second_largest(T_in_0[i])
    if answer != T_out[i]
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
