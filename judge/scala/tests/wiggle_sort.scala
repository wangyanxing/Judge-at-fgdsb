package test
import scala.io.Source
import judge.common
import judge.Solution

object wiggle_sort {
    val num_test = 100;
    var in_0 = List[List[Int]]();
    var out = List[List[Int]]();

    def test_wiggle(arr: List[Int], len: Int): Boolean = {
			def solve(as: List[Int], flag: Boolean): Boolean = as match {
				case h1::h2::t =>
					if((flag && h1 > h2) || (!flag && h1 < h2)) false
					else solve(h2::t, !flag)
				case _ => true
			}
			if (arr.length != len) false
			else solve(arr, true)
		}

    def load_test() = {
        val in = Source.fromFile("./judge/tests/wiggle-sort.txt").getLines;
        in_0 = common.read_int_matrix(in);
        out = common.read_int_matrix(in);
    }

    def judge(): Int = {
        load_test();
        common.capture_stdout();

        def do_judge(i0: List[List[Int]], ot: List[List[Int]], count: Int):Boolean = {
            if(i0 == Nil) return true;
            val answer = Solution.wiggle_sort(i0.head);
            if(!test_wiggle(answer, ot.head.length)) {
                common.release_stdout();
                printf("%d / %d;", count, num_test);
                print(common.to_string(i0.head) + ";");
                print(common.to_string(answer) + ";");
                println(common.to_string(ot.head));
                return false;
            } else {
                return do_judge(i0.tail, ot.tail, count+1);
            }
        }

        val startTime = System.currentTimeMillis();
        
        if(do_judge(in_0, out, 1)) {
            common.release_stdout();
            val estimatedTime = System.currentTimeMillis - startTime;
            print("Accepted;");
            println(estimatedTime);
        }
        return 0;
    }
}
