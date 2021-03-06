require("../solution")

local num_test = 110
local in_0 = {}
local in_org_0 = {}
local out = {}

function test_ret(arr, answer_len)
    if #arr ~= answer_len then return false end
    local sum = 0
    for i = 1, #arr do
        sum = sum + arr[i]
    end
    return true
end

function load_test()
    local f = io.open("./judge/tests/longest-zero-subarray.txt", "r")
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
        local answer = longest_subarray(in_0[i]) 
        if not test_ret(answer, #out[i]) then
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
