require './judge/ruby/common'
require './judge/ruby/tests/fence-painter'

def num_colors(n, k)
	return 0 if n <= 0 || k <= 0
	prev_prev, prev = k, k * k
	(n - 1).times do
		prev, prev_prev = (k - 1) * (prev_prev + prev), prev
	end
	prev_prev
end


start_time = Time.now

(0...T_num_test).each do |i|
    answer = num_colors(T_in_0[i],T_in_1[i])
    if answer != T_out[i]
        print "#{i+1} / #{T_num_test};"
        print T_in_org_0[i]
        print ', '
        print T_in_org_1[i]
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
