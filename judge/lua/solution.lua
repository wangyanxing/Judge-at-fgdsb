-- Definition for a binary tree node
-- TreeNode = {
--     new = function(v)
--         return {val = v, left = nil, right = nil}
--     end
-- }

function most_right(root)
	if root == nil then return nil end
	ret = root
	while ret.right ~= nil do
		ret = ret.right
	end
	return ret
end

-- @param root, TreeNode
-- @return TreeNode
function bst_to_list(root)
    if root == nil then return nil end
    
    local lefts = bst_to_list(root.left)
    local cur = root
    local left_end = most_right(lefts)
    
    if left_end ~= nil then
    	left_end.right = cur
    	cur.left = left_end
    end
    
    cur.right = bst_to_list(root.right)
    
    if cur.right ~= nil then
        cur.right.left = cur
    end
    
    if lefts == nil then
    	return cur
    else
    	return lefts
    end    	
end