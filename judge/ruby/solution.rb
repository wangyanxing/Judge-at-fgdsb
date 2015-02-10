def smallest_character(str, c)
    for pos in 0...str.length
        return str[pos] if str[pos] > c
    end
    str[0]
end