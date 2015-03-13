-- @param arr, table of integers
-- @param t, integer
function subarray_sum(arr, t)
    sum, last = arr[1], 1
    for i = 2, #arr do
        while sum > t do
            sum = sum - arr[last]
            last = last + 1
        end
        if sum == t then return true end
        sum = sum + arr[i]
    end
    return sum == t
end