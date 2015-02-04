-- Definition for an interval
-- Interval = {
--     new = function(b, e)
--         return {begin_t = b, end_t = e}
--     end
-- }

Intervals = {
    -- @param intervals, table of Intervals
    preprocess = function(self, intervals)
        self.intervals = intervals
    end,

    -- @param time, integer
    -- @return table of Intervals
    query = function(self, time)
        return {self.intervals[1]}
    end
}
