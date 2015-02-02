package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; /*
public class TreeNode {
    public int val;
    public TreeNode left, right;
    public TreeNode(int x) { val = x; }
}
*/
public class Solution {
    List<List<Integer>> ret;
    
    public void solve(TreeNode root, ArrayList<Integer> cur) {
        if(root == null) return;
        cur.add(root.val);
        if(root.left == null && root.right == null) {
			ret.add(new ArrayList<Integer>(cur));
			cur.remove(Integer.valueOf(root.val));
			return;
        }
        solve(root.left, cur);
        solve(root.right, cur);

        cur.remove(Integer.valueOf(root.val));
    }
    
    public List<List<Integer>> all_path(TreeNode root) {
        ret = new ArrayList<List<Integer>>();
        //ArrayList<Integer> cur = new ArrayList<Integer>();
        solve(root, new ArrayList<Integer>());
        return ret;
    }
}