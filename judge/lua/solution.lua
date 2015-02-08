-- Definition for a binary tree node
-- TreeNode = {
--     new = function(v)
--         return {val = v, left = nil, right = nil}
--     end
-- }

function dfs(ret, node, cur)
    if not node then
        return
    end
    
    cur[#cur + 1] = node.val
    
    if not node.left and not node.right then
        ret[#ret + 1] = copy(cur)
    else
        dfs(ret, node.left, cur)
        dfs(ret, node.right, cur)
    end
    
    table.remove(cur, #cur)
end

-- @param root, TreeNode
-- @return table of table of integers
function all_path(root)
    local ret = {}
    dfs(ret, root, {})
    return ret
end