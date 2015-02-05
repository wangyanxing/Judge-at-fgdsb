#=begin
str =
'struct TreeNodeWithParent {
    TreeNodeWithParent(int v = 0) :val(v){}
    int val{ 0 };
    TreeNodeWithParent* left{ nullptr };
    TreeNodeWithParent* right{ nullptr };
    TreeNodeWithParent* parent{ nullptr };
};'
p str

exit
#=end
files = Dir.entries('.').select {|f| !File.directory?(f) && File.extname(f)=='.rb' && f != 'build_all.rb' && f != 'common.rb'}
files.each do |f|
	puts "running: #{f}"
	require "./#{f}"
end