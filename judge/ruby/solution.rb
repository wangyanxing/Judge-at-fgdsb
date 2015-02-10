def smallest_character(str, c)
    l, r, ret = 0, str.length - 1, str[0]
    while l <= r
        m = l + (r-l) / 2
        if(str[m] > c)
            ret, r = str[m], m - 1
        else
            l = m + 1
        end
    end
    ret
end