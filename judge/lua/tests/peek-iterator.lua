require("../solution")

local num_test = 50
local in_0 = {}
local in_org_0 = {}
local out = {}


function load_test()
    local f = io.open("./judge/tests/peek-iterator.txt", "r")
    in_0 = read_num_matrix(f)
    in_org_0 = copy(in_0)
    out = read_bool_array(f)
    f:close()
end

function judge()
    load_test()
    capture_stdout()

    local start = os.clock()
    for i = 1, num_test do
        print("Testing case #" .. i)

        local it = Iterator.new(in_0[i])
        local pi = PeekIterator.new(it)

        for j = 1, #in_0[i] do
            local num = in_0[i][j]
            local has_next_wrong, peek_wrong, get_next_wrong = false, false, false

            if not pi:has_next() then has_next_wrong = true end
            if pi:peek() ~= num then peek_wrong = true end
            nxt = pi:get_next()
            if nxt ~= num then get_next_wrong = true end

            if has_next_wrong or peek_wrong or get_next_wrong then
                local msg = ''
                if has_next_wrong then msg = msg .. 'has_next() == false, ' end
                if peek_wrong then msg = msg .. 'peek() == ' .. pi:peek() .. ', ' end
                if get_next_wrong then msg = msg .. 'get_next() == ' .. nxt .. ', ' end

                local expmsg = ''
                if has_next_wrong then expmsg = expmsg .. 'has_next() == true, ' end
                if peek_wrong then expmsg = expmsg .. 'peek() == ' .. num .. ', ' end
                if get_next_wrong then expmsg = expmsg .. 'get_next() == ' .. num .. ', ' end

                io.write(string.format("%d / %d;", i, num_test))
                io.write(to_string(in_org_0[i]) .. ', current element: ' .. num)
                io.write(";")
                io.write(string.sub(msg, 1, -3))
                io.write(";")
                io.write(string.sub(expmsg, 1, -3))
                io.write("\n")
                return
            end
        end
    end

    release_stdout()
    local elapsed = math.floor((os.clock() - start) * 1000)
	print("Accepted;" .. elapsed)
end
