def compress(string):
	if len(string) == 0: return ''
	ret, cur, count, id = '', string[0], 1, 1
	while id <= len(string):
		if id < len(string) and string[id] == cur:
			count += 1
		else:
			ret += cur + str(count)
			if id < len(string): cur = string[id]
			count = 1
		id += 1
	if len(ret) < len(string):
		return ret
	else:
		return string