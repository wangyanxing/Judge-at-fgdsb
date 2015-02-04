require("../solution")

local num_test = 120
local in_0 = {}
local in_org_0 = {}
local out = {}
function test(answer, i)
    if #out[i] ~= #answer then return false end

    if out[i][1] == -1 and out[i][2] == -1 and out[i][3] == -1 then
        return answer[1] == -1 and answer[2] == -1 and answer[3] == -1
    else
				out[i][1], out[i][2], out[i][3] = out[i][1]+1, out[i][2]+1, out[i][3]+1
        if answer[1] == -1 or answer[2] == -1 or answer[3] == -1 then
            return false
        else
            return (in_org_0[i][answer[1]] < in_org_0[i][answer[2]] and in_org_0[i][answer[2]] < in_org_0[i][answer[3]]) and (answer[1] < answer[2] and answer[2] < answer[3])
		end
	end
end

function load_test()
    local f = io.open("./judge/tests/three-increasing-elements.txt", "r")
    in_0 = read_num_matrix(f)
    in_org_0 = copy(in_0)
    out = read_num_matrix(f)
    f:close()
end

function judge()
    load_test()

    local start = os.clock()
    for i = 1, num_test do
        local answer = three_increasing_nums(in_0[i]) 
        if not test(answer, i) then
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
