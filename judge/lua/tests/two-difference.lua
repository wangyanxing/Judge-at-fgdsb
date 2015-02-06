require("../solution")

local num_test = 90
local in_0 = {}
local in_org_0 = {}
local in_1 = {}
local in_org_1 = {}
local out = {}

function test(answer, i)
    if out[i].length ~= answer.length then
        return false
    end
    if out[i][1] == -1 and out[i][2] == -1 then
        return answer[1] == -1 and answer[2] == -1
    else
        if answer[1] == -1 or answer[2] == -1 then
            return false
        else
            return math.abs(in_0[i][answer[1]] - in_0[i][answer[2]]) == in_1[i]
        end
    end
end

function load_test()
    local f = io.open("./judge/tests/two-difference.txt", "r")
    in_0 = read_num_matrix(f)
    in_org_0 = copy(in_0)
    in_1 = read_num_array(f)
    in_org_1 = copy(in_1)
    out = read_num_matrix(f)
    f:close()
end

function judge()
    load_test()
    capture_stdout()

    local start = os.clock()
    for i = 1, num_test do
        print("Testing case #" .. i)
        local answer = two_dif(in_0[i], in_1[i]) 
        if not test(answer, i) then
            io.write(string.format("%d / %d;", i, num_test))
            io.write(to_string(in_org_0[i]))
            io.write(", ")
            io.write(to_string(in_org_1[i]))
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
