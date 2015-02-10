function smallest_character(str, c)
    for i = 1, #str do
        local ch = str:sub(i,i)
        if ch > c then return ch end
    end
    return str:sub(1,1)
end