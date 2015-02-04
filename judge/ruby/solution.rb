# class Interval
#     attr_accessor :begin_t, :end_t
#     def initialize(b = 0, e = 0)
#         @begin_t, @end_t = b, e
#     end
# end
        
class Intervals
    # @param intervals, Intervals array
    def initialize(intervals)
        @intervals = intervals
    end

    def preprocess()
        @intervals.sort! {|a, b|
			if(a.begin_t == b.begin_t)
				a.end_t <=> b.end_t
			else
				a.begin_t <=> b.begin_t
			end
		}
    end

    # @param time, integer
    # @return Intervals array
    def query(time)
        ret = []
        @intervals.each do |i|
			if time >= i.begin_t && time <= i.end_t
				ret << i
			end
		end
		ret
    end
end