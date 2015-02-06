require("../solution")

local num_test = 100
local in_0 = {}
local in_org_0 = {}
local out = {}

function check_dlist(arr, list)
	local cur, pre, i = list, nil, 1

	while cur ~= nil do
		if i > #arr or arr[i] ~= cur.val then
		    return false
		end
		i = i + 1
		pre = cur
		cur = cur.right
    end

	if i ~= #arr + 1 then
	    return false
	end

	cur = pre
	i = i - 1

	while cur ~= nil do
		if (i <= 0 or arr[i] ~= cur.val) then
		    return false
		end
		i = i - 1
		last = cur
		cur = cur.left
		last.left = nil
	end

	if i ~= 0 then
	    return false
	end

	return true
end

function dlist_to_string(list)
	local ret = "["
	local first = true
	while list ~= nil do
		if not first then
		    ret = ret .. ", "
		end
		ret = ret .. list.val
		list = list.right
		first = false
  end
	return ret .. "]"
end

function load_test()
    local f = io.open("./judge/tests/bst-to-dlist.txt", "r")
    in_0 = read_tree_array(f)
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
        local answer = bst_to_list(in_0[i]) 
        if not check_dlist(out[i], answer) then
            io.write(string.format("%d / %d;", i, num_test))
            io.write(to_string(in_org_0[i]))
            io.write(";")
            io.write(dlist_to_string(answer))
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
