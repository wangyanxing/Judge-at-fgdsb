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
	return 0 if second_max == max_val
	second_max
end