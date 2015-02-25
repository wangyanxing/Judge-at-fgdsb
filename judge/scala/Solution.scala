package judge; object Solution {
	def wiggle_sort(arr: Array[Int]): Array[Int] = {
	    val n = arr.length;
        if(n == 0) return Array();
        var s = arr.clone();
        
        var flag = true;
        var current = s(0);
        for (i <- 0 until n-1) {
            if ((flag && current > s(i+1)) || (!flag && current < s(i+1))) {
                s(i) = s(i+1);
            } else {
                s(i) = current;
                current = s(i+1);
            }
            flag = !flag;
        }
        s(n-1) = current;
        s;
	}
}