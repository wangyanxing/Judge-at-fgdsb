require("../solution")

local num_test = 120
local in_0 = {}
local in_org_0 = {}
local in_1 = {}
local in_org_1 = {}
local out = {}


function load_test()
    local f = io.open("./judge/tests/kth-smallest-bst.txt", "r")
    in_0 = read_tree_array(f)
    in_org_0 = copy(in_0)
    in_1 = read_num_array(f)
    in_org_1 = copy(in_1)
    out = read_tree_array(f)
    f:close()
end

function judge()
    load_test()

    local start = os.clock()
    for i = 1, num_test do
        local answer = kth_smallest(in_0[i], in_1[i]) 
        if not node_equals(out[i], answer) then
            io.write(string.format("%d / %d;", i, num_test))
            io.write(to_string(in_org_0[i]))
            io.write(", ")
            io.write(to_string(in_org_1[i]))
            io.write(";")
            io.write(node_to_string(answer))
            io.write(";")
            io.write(node_to_string(out[i]))
            io.write("\n")
            return
        end
    end

    local elapsed = math.floor((os.clock() - start) * 1000)
	print("Accepted;" .. elapsed)
end
