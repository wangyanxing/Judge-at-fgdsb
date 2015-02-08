excluded = %w(build_all.rb common.rb)

Dir.entries('.').select do |f|
	next if File.directory?(f) or File.extname(f) != '.rb' or excluded.include? f
	puts "running: #{f}"
	require "./#{f}"
end