

def test_wiggle(arr)
    return true if arr.nil? || arr.length == 0
    test_flag = true
    (0...arr.length-1).each do |i|
        if test_flag
            return false if arr[i] > arr[i+1]
        else
            return false if arr[i] < arr[i+1]
        end
        test_flag = !test_flag;
    end
    true
end

