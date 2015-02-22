package test
import scala.io.Source
import judge.common
import judge.Solution

object a_plus_b {
    val num_test = 50;
    var in_0 = List[Int]();
    var in_1 = List[Int]();
    var out = List[Int]();


    def load_test() = {
        val in = Source.fromFile("judge/tests/a-plus-b.txt").getLines;
        in_0 = common.read_int_array(in);
        in_1 = common.read_int_array(in);
        out = common.read_int_array(in);
    }

    def judge(): Int = {
        load_test();
        common.capture_stdout();

        val startTime = System.currentTimeMillis();
        var i = 0;

        while(i < num_test) {
            printf("Testing case #%d\n", i+1);
            val answer = Solution.plus_num(in_0(i), in_1(i));
            if(answer != out(i)) {
                common.release_stdout();
                printf("%d / %d;", i+1, num_test);
                var outs = a_plus_b.in_0(i).toString + ", " + a_plus_b.in_1(i).toString;
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
