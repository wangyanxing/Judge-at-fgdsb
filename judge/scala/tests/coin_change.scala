package test
import scala.io.Source
import judge.common
import judge.Solution

object coin_change {
    val num_test = 302;
    var in_0 = List[List[Int]]();
    var in_1 = List[Int]();
    var out = List[]();


    def load_test() = {
        val in = Source.fromFile("./judge/tests/coin-change.txt").getLines;
        in_0 = common.read_int_matrix(in);
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
            val answer = Solution.min_coins(in_0(i), in_1(i));
            if() {
                common.release_stdout();
                printf("%d / %d;", i+1, num_test);
                var outs = common.to_string(coin_change.in_0(i)) + ", " + common.to_string(coin_change.in_1(i));
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
