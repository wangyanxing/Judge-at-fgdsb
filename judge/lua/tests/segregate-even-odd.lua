require("../solution")

local num_test = 100
local in_0 = {}
local in_org_0 = {}
local out = {}

function test(i)
    if not test_anagram(in_0[i], in_org_0[i]) then
    	return false
    end
    local flag = false
    for j = 1, #in_0[i] do
    	local num = in_0[i][j]
        if num % 2 == 0 then
            if flag then return false end
        else
            flag = true
        end
    end
    return true
end

function load_test()
    local f = io.open("./judge/tests/segregate-even-odd.txt", "r")
    in_0 = read_num_matrix(f)
    in_org_0 = copy(in_0)
    out = read_num_matrix(f)
    f:close()
end

function judge()
    load_test()

    local start = os.clock()
    for i = 1, num_test do
        local answer = segregate(in_0[i]) 
        answer = in_0[i]
        if not test(i) then
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

    local elapsed = math.floor((os.clock() - start) * 1000)
	print("Accepted;" .. elapsed)
end
