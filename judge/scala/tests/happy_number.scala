package test
import scala.io.Source
import judge.common
import judge.Solution

object happy_number {
    val num_test = 2725;
    var in_0 = List[Int]();
    var out = List[Boolean]();


    def load_test() = {
        val in = Source.fromFile("./judge/tests/happy-number.txt").getLines;
        in_0 = common.read_int_array(in);
        out = common.read_bool_array(in);
    }

    def judge(): Int = {
        load_test();
        common.capture_stdout();

        val startTime = System.currentTimeMillis();
        var i = 0;

        while(i < num_test) {
            printf("Testing case #%d\n", i+1);
            val answer = Solution.happy(in_0(i));
            if() {
                common.release_stdout();
                printf("%d / %d;", i+1, num_test);
                var outs = common.to_string(happy_number.in_0(i));
                print(outs + ";");
                print(common.to_string(answer) + ";");
                println(common.to_string(out(i)));
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
