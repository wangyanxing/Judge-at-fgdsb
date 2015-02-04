#=begin
str =
'-- Definition for a binary tree node
TreeNode = {
	new = function(v)
		return {val = v, left = nil, right = nil}
	end
}
'
p str

exit
#=end
files = Dir.entries('.').select {|f| !File.directory?(f) && File.extname(f)=='.rb' && f != 'build_all.rb' && f != 'common.rb'}
files.each do |f|
	puts "running: #{f}"
	require "./#{f}"
end