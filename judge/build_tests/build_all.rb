=begin
str =
'# class TreeNode:
#     def initialize(self, v=0):
#         self.val, self.left, self.right = v, None, None

# @param root, TreeNode
# @return TreeNode
def bst_to_list(root):
'
p str

exit
=end
files = Dir.entries('.').select {|f| !File.directory?(f) && File.extname(f)=='.rb' && f != 'build_all.rb' && f != 'common.rb'}
files.each do |f|
	puts "running: #{f}"
	require "./#{f}"
end