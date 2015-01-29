
def read_int_array(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << file.readline.to_i
    end
    ret
end

def read_int_matrix(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_int_array(file)
    end
    ret
end

def read_int_matrix_arr(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_int_matrix(file)
    end
    ret
end

def read_bool_array(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        n = true
        n = false if file.readline.to_i == 0
        ret << n
    end
    ret
end

def read_bool_matrix(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_bool_array(file)
    end
    ret
end

def read_bool_matrix_arr(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_bool_matrix(file)
    end
    ret
end

def read_double_array(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << file.readline.to_d
    end
    ret
end

def read_double_matrix(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_double_array(file)
    end
    ret
end

def read_double_matrix_arr(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_double_matrix(file)
    end
    ret
end

def read_string_array(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << file.readline.chomp
    end
    ret
end

def read_string_matrix(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_string_array(file)
    end
    ret
end

def read_string_matrix_arr(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_string_matrix(file)
    end
    ret
end