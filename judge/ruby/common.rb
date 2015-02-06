
class Interval
    attr_accessor :begin_t, :end_t
    
    def initialize(b = 0, e = 0)
        @begin_t, @end_t = b, e
    end
    
    def to_s
        "[#{@begin_t}, #{@end_t}]"
    end
    
    def inspect
        "[#{@begin_t}, #{@end_t}]"
    end

    
    def == (rhs)
        self.begin_t == rhs.begin_t && self.end_t == rhs.end_t
    end
end

class TreeNode
    attr_accessor :left, :right, :val
    def initialize(v)
        @val, @left, @right = v, nil, nil
    end

    def to_s
        serial(self)
    end

    def inspect
        to_s
    end

    def serial(root)
        if  root.nil?
            return '# '
        end
        ret = root.val.to_s
        ret += ' '

        ret += serial(root.left)
        ret += serial(root.right)
        ret
    end
end

class ListNode
    attr_accessor :next_node, :val
    def initialize(v)
        @val, @next_node = v, nil
    end
end

##################################################

def save_tree(root, arr)
    if root.nil?
        arr << '#'
        return
    end
    arr << "#{root.val}"
    save_tree root.left, arr
    save_tree root.right, arr
end

def load_tree(arr, id = 0)
    if id >= arr.length || arr[id] == '#'
        return [nil, id+1]
    end
    root = TreeNode.new(arr[id].to_i)
    ret_l = load_tree(arr, id+1)
    ret_r = load_tree(arr, ret_l[1])
    root.left = ret_l[0]
    root.right = ret_r[0]
    [root, ret_r[1]]
end

def node_equals(n1, n2)
    return true if n1.nil? && n2.nil?
    return false if n1.nil? || n2.nil?
    n1.val == n2.val
end

def node_to_string(n)
    return 'nil' if n.nil?
    n.val.to_s
end

##################################################

def read_tree(file, nums)
    return nil if nums == 0
    cur = file.readline.chomp
    return nil if(cur == "#")

    root = TreeNode.new(cur.to_i)
    nums -= 1
    root.left = read_tree(file, nums)
    nums -= 1
    root.right = read_tree(file, nums)
    root
end

def read_tree_array(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_tree(file, file.readline.to_i)
    end
    ret
end

def read_tree_matrix(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_tree_array(file)
    end
    ret
end

def read_interval_array(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        i = Interval.new
        i.begin_t = file.readline.to_i
        i.end_t = file.readline.to_i
        ret << i
    end
    ret
end

def read_interval_matrix(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_interval_array(file)
    end
    ret
end

def read_interval_matrix_arr(file)
    nums = file.readline.to_i
    ret = []
    (0...nums).each do
        ret << read_interval_matrix(file)
    end
    ret
end

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

##################################################
OrigStdOut = STDOUT.clone

def capture_stdout()
    STDOUT.reopen(File.open('judge/stdout.txt', 'w'))
end

def release_stdout()
    STDOUT.reopen(OrigStdOut)
end
