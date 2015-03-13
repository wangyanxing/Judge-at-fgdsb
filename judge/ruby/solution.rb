# @param arr, array of integers
# @param t, integer
def subarray_sum(arr, t)
    sum, last = arr[0], 0
    (1...arr.length).each do |i|
        while sum > t 
            sum -= arr[last]
            last += 1
        end
        return true if sum == t
        sum += arr[i]
    end
    sum == t
end