function smallest_character(str, c)
    local l, r, ret = 1, #str, str:sub(1,1)
    while l <= r do
        local m = math.floor(l + (r - l) / 2)
        local mid = str:sub(m, m)
        if mid > c then
            ret,r = mid,m - 1
        else
            l = m + 1
        end
    end
    return ret
end