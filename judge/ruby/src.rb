require './judge/ruby/common'

def plus_num(a, b)
    a+b
end

num_test = 5;
in_0 = [1,1,2,100,100]
in_1 = [0,1,1,13,200]
in_org_0 = [1,1,2,100,100]
in_org_1 = [0,1,1,13,200]
out = [1,2,3,113,300]

(0...num_test).each do |i|
    answer = plus_num(in_0[i],in_1[i])
    if answer != out[i]
        print "#{i+1} / #{num_test};"
        print in_org_0[i]
        print ', '
        print in_org_1[i]
        print ';'
        print answer
        print ';'
        print out[i]
        puts
        exit
    end
end
puts('Accepted')
