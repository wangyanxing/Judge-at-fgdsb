require("../solution")

local num_test = 100
local in_0 = {}
local in_org_0 = {}
local out = {}

function test_wiggle(arr)
    if #arr == 0 then return true end
    local test_flag = true
    for i = 1, #arr - 1 do
        if test_flag then
        	if arr[i] > arr[i+1] then
            	return false
            end
        else
        	if arr[i] < arr[i+1] then
            	return false
            end
        end
        test_flag = not test_flag
    end
    return true
end

function load_test()
    local f = io.open("./judge/tests/wiggle-sort.txt", "r")
    in_0 = read_num_matrix(f)
    in_org_0 = copy(in_0)
    out = read_num_matrix(f)
    f:close()
end

function judge()
    load_test()
    capture_stdout()

    local start = os.clock()
    for i = 1, num_test do
        print("Testing case #" .. i)
        local answer = wiggle_sort(in_0[i]) 
        answer = in_0[i]
        if not test_wiggle(in_0[i]) then
            io.write(string.format("%d / %d;", i, num_test))
            io.write(to_string(in_org_0[i]))
            io.write(";")
            io.write(to_string(answer))
            io.write(";")
            io.write(to_string(out[i]))
            io.write("\n")
            return
        end
    end

    release_stdout()
    local elapsed = math.floor((os.clock() - start) * 1000)
	print("Accepted;" .. elapsed)
end
