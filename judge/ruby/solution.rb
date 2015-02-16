# @param arr, array of integers
# @return array of integers
def longest_subarray(arr)
    sum, len, beg, record = 0, 0, -1, {0 => -1}
    arr.each_with_index do |num, i|
        sum += num
        if record.has_key? sum
            first = record[sum]
            if i - first > len
                len = i - first;
                beg = first + 1;
            end
        else    
            record[sum] = i
        end
    end
    return [] if beg < 0
    arr.slice(beg, len)
end