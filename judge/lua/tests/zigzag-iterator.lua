require("../solution")

local num_test = 55
local in_0 = {}
local in_org_0 = {}
local in_1 = {}
local in_org_1 = {}
local out = {}

------------------------------------------------------------------------------------------
local ZigzagIterator_ref = class()

function ZigzagIterator_ref: ctor(i0, i1)
    self.its = {i0,i1}
    if i0:has_next() then 
        self.pointer = 1
    else 
        self.pointer = 2 
    end
end

function ZigzagIterator_ref: has_next()
    return self.its[self.pointer]:has_next()
end

function ZigzagIterator_ref: get_next()
    local ret, old = self.its[self.pointer]:get_next(), self.pointer;
    while true do
        self.pointer = self.pointer + 1
        if self.pointer > 2 then self.pointer = 1 end
        if self.its[self.pointer]:has_next() or self.pointer == old then break end
    end
    return ret
end
------------------------------------------------------------------------------------------

function load_test()
    local f = io.open("./judge/tests/zigzag-iterator.txt", "r")
    in_0 = read_num_matrix(f)
    in_org_0 = copy(in_0)
    in_1 = read_num_matrix(f)
    in_org_1 = copy(in_1)
    out = read_bool_array(f)
    f:close()
end

function judge()
    load_test()
    capture_stdout()

    local start = os.clock()
    for i = 1, num_test do
        print("Testing case #" .. i)

        local pi = ZigzagIterator.new(Iterator.new(in_0[i]), Iterator.new(in_1[i]))
        local w = {}
        while pi:has_next() do w[#w+1] = pi:get_next() end
        
        local wi = ZigzagIterator_ref.new(Iterator.new(in_0[i]), Iterator.new(in_1[i]))
        local wo = {}
        while wi:has_next() do wo[#wo+1] = wi:get_next() end


        if not arr_equals(w ,wo) then
            io.write(string.format("%d / %d;", i, num_test))
            io.write(to_string(in_org_0[i]))
            io.write(", ")
            io.write(to_string(in_org_1[i]))
            io.write(";")
            io.write(to_string(w))
            io.write(";")
            io.write(to_string(wo))
            io.write("\n")
            return
        end
    end

    release_stdout()
    local elapsed = math.floor((os.clock() - start) * 1000)
	print("Accepted;" .. elapsed)
end
