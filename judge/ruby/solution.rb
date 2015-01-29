def compress(str)
	return '' if str.nil? || str.length == 0
	ret, cur, count, id = '', str[0], 1, 1
	while id <= str.length
		if id < str.length && str[id] == cur
			count += 1
		else
			ret += cur + count.to_s
			cur = str[id] if id < str.length
			count = 1
		end
		id += 1
	end
	if ret.length < str.length
		return ret
	else
		return str
	end
end