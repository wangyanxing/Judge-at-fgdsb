require './judge/ruby/common'

def wiggle_sort(arr)
    return if arr.empty?
    flag = true
    current = arr[0]
    (0...arr.length-1).each do |i|
        if (flag && current > arr[i+1]) || (!flag && current < arr[i+1])
            arr[i] = arr[i+1]
        else
            arr[i] = current
            current = arr[i+1]
        end
        flag = !flag
    end
    arr[-1] = current
end

num_test = 3;
in_0 = [[1, 2, 3],[1, 3, 5, 7, 9],[9, 7, 4, 8, 1]]
in_org_0 = [[1, 2, 3],[1, 3, 5, 7, 9],[9, 7, 4, 8, 1]]
out = [[1, 3, 2],[1, 5, 3, 9, 7],[7, 9, 4, 8, 1]]

(0...num_test).each do |i|
    answer = wiggle_sort(in_0[i])
    answer = in_0[i];
    if !test_wiggle(in_0[i])
        print "#{i+1} / #{num_test};"
        print in_org_0[i]
        print ';'
        print answer
        print ';'
        print out[i]
        puts
        exit
    end
end
puts('Accepted')
