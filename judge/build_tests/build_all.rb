#=begin
str =
'Intervals = {
	intervals = nil,

	-- @param intervals, table of Intervals
	preprocess = function(self, intervals)
		self.intervals = intervals
	end

	-- @param time, integer
    -- @return boolean
    query = function(self, time)
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