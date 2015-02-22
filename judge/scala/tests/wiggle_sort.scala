package test
import scala.io.Source
import judge.common
import judge.Solution

object wiggle_sort {
    val num_test = 100;
    var in_0 = List[List[Int]]();
    var out = List[List[Int]]();

    def test_wiggle(arr: List[Int]): Boolean = {
		    return false
	  }

    def load_test() = {
        val in = Source.fromFile("./judge/tests/wiggle-sort.txt").getLines;
        in_0 = common.read_int_matrix(in);
        out = common.read_int_matrix(in);
    }

    def judge(): Int = {
        load_test();
        common.capture_stdout();

        val startTime = System.currentTimeMillis();
        var i = 0;

        while(i < num_test) {
            printf("Testing case #%d\n", i+1);
            val answer = Solution.wiggle_sort(in_0(i));
            if(!test_wiggle(answer)) {
                common.release_stdout();
                printf("%d / %d;", i+1, num_test);
                var outs = wiggle_sort.in_0(i).toString;
                print(outs + ";");
                print(answer.toString + ";");
                println(out(i).toString);
                return 1;
            }
            i += 1;
        }

        common.release_stdout();
        val estimatedTime = System.currentTimeMillis - startTime;
        print("Accepted;");
        println(estimatedTime);
        return 0;
    }
}
