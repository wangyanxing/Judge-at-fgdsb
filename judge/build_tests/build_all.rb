files = Dir.entries('.').select {|f| !File.directory?(f) && File.extname(f)=='.rb' && f != 'build_all.rb' && f != 'common.rb'}
files.each do |f|
	puts "running: #{f}"
	require "./#{f}"
end