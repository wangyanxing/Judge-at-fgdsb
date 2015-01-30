def num_colors(n, k)
	return 0 if n <= 0 || k <= 0
	prev_prev, prev = k, k * k
	(n - 1).times do
		prev, prev_prev = (k - 1) * (prev_prev + prev), prev
	end
	prev_prev
end