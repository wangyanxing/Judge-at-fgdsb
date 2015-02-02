# class TreeNode:
#     def initialize(self, v=0):
#         self.val, self.left, self.right = v, None, None
import copy

def _all_path(root, ret, cur):
    if root == None: return

    cur.append(root.val)

    if root.left == None and root.right == None:
        ret.append(copy.deepcopy(cur))
        cur.pop()
        return

    _all_path(root.left, ret, cur)
    _all_path(root.right, ret, cur)
    cur.pop()
    
# @param root, TreeNode
# @return TreeNode
def all_path(root):
    ret = []
    _all_path(root, ret, [])
    return ret