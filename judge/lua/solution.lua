-- Definition for an iterator
--
-- Iterator = class()
-- 
-- function Iterator:has_next()
-- end
-- 
-- function Iterator:get_next()
-- end

ZigzagIterator = class()

function ZigzagIterator: ctor(i0, i1)
    self.its = {i0,i1}
    if i0:has_next() then 
        self.pointer = 1
    else 
        self.pointer = 2 
    end
end

function ZigzagIterator: has_next()
    return self.its[self.pointer]:has_next()
end

function ZigzagIterator: get_next()
    local ret, old = self.its[self.pointer]:get_next(), self.pointer;
    while true do
        self.pointer = self.pointer + 1
        if self.pointer > 2 then self.pointer = 1 end
        if self.its[self.pointer]:has_next() or self.pointer == old then break end
    end
    return ret
end