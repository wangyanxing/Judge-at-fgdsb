-- Definition for an iterator
--
-- Iterator = class()
-- 
-- function Iterator:has_next()
-- end
-- 
-- function Iterator:get_next()
-- end

PeekIterator = class()

function PeekIterator: ctor(it)
	self.it = it
    self.peeks = nil
end

function PeekIterator: peek()
	if self.peeks == nil then
        self.peeks = self.it:get_next()
    end
    return self.peeks
end

function PeekIterator: has_next()
	return self.it:has_next() or self.peeks
end

function PeekIterator: get_next()
	if self.peeks == nil then
        return self.it:get_next()
    else
        ret = self.peeks
        self.peeks = nil
        return ret
    end
end
