
module ElevationDfs
	@mat = [
		[1, 2, 2, 3, 5],
		[3, 2, 3, 4, 4],
		[2, 4, 5, 3, 1],
		[6, 7, 1, 4, 5],
		[5, 1, 1, 2, 4]
	]

	@visited, @pac_ok, @atl_ok = {}, {}, {}
	@n = 0

	def self.search(i, j, origin)
		@pac_ok[origin] = true if j == 0 or i == 0
		@atl_ok[origin] = true if j == @n - 1 or i == @n - 1
		return if @visited.length == @n**2
		dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]
		dirs.each do |dir|
			newI, newJ = dir[0] + i, dir[1] + j

			next if newI < 0 or newI >= @n or newJ < 0 or newJ >= @n
			next if @mat[newI][newJ] > @mat[i][j] || @visited.has_key?([newI, newJ])

			@visited[[newI, newJ]] = true
			search(newI, newJ, origin)
			@visited.delete [newI,newJ]
		end
	end

	def self.get_points
		ret = []
		@n = @mat.length

		(0...@n).each do |i|
			(0...@n).each do |j|
				@visited = {}
				@visited[[i,j]] = true
				search(i,j,[i,j])
				ret << [i,j] if @pac_ok.has_key?([i,j]) and @atl_ok.has_key?([i,j])
			end
		end
		ret
	end

	puts '------------------'
	pts = get_points
	pts.each do |p|
		puts "#{p} => #{@mat[p[0]][p[1]]}"
	end
end

module ElevationDfs2
	@mat = [
			[1, 2, 2, 3, 5],
			[3, 2, 3, 4, 4],
			[2, 4, 5, 3, 1],
			[6, 7, 1, 4, 5],
			[5, 1, 1, 2, 4]
	]

	def self.search(i, j, origin, visited)
		[[0,1], [0,-1], [1,0], [-1,0]].each do |dir|
			newI, newJ = dir[0] + i, dir[1] + j

			next if newI < 0 or newI >= @mat.length or newJ < 0 or newJ >= @mat.length
			next if @mat[newI][newJ] < @mat[i][j] || visited.has_key?([newI, newJ])

			visited[[newI, newJ]] = true
			search(newI, newJ, origin, visited)
		end
	end

	def self.get_points
		n = @mat.length

		@visited_pac = {}
		(([0].product (0...n).to_a) + ((1...n).to_a.product [0])).each do |i, j|
			@visited_pac[[i,j]] = true
			search(i, j, [i,j], @visited_pac)
		end

		@visited_alt = {}
		(([n-1].product (0...n).to_a) + ((1...n).to_a.product [n-1])).each do |i, j|
			@visited_alt[[i,j]] = true
			search(i, j, [i,j], @visited_alt)
		end

		@visited_pac.keys & @visited_alt.keys
	end

	puts '------------------'
	pts = get_points
	pts.each do |p|
		puts "#{p} => #{@mat[p[0]][p[1]]}"
	end
end

exit

excluded = %w(build_all.rb common.rb utils.rb)

Dir.entries('.').select do |f|
	next if File.directory?(f) or File.extname(f) != '.rb' or excluded.include? f
	puts "running: #{f}"
	require "./#{f}"
end