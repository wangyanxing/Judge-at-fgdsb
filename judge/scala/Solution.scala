package judge; object Solution {
	def wiggle_sort(arr: List[Int]): List[Int] = {
      def solve(as: List[Int], bs: List[Int], flag: Boolean, current: Int): List[Int] = as match {
        case h1 :: h2 :: t =>
          if ((flag && current > h2) || (!flag && current < h2)) solve(h2 :: t, h2 :: bs, !flag, current)
          else solve(h2 :: t, current :: bs, !flag, h2)
        case h1 :: Nil => current :: bs
        case Nil => bs
      }
      if(arr.isEmpty) List()
      else solve(arr, Nil, true, arr.head).reverse
    }
}