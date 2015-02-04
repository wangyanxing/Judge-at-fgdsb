def most_right(root)
	return nil if root.nil?
	ret = root
	while !ret.right.nil?
		ret = ret.right
	end
	ret
end

def bst_to_list(root)
    return nil if root.nil?
    lefts = bst_to_list(root.left)
    cur = root
    left_end = most_right(lefts)
    if !left_end.nil?
    	left_end.right = cur
    	cur.left = left_end
    end
    cur.right = bst_to_list(root.right)
    if !cur.right.nil?
        cur.right.left = cur
    end
    if lefts.nil?
    	return cur
    else
    	return lefts
    end
end