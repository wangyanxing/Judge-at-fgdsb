package judge
import test.a_plus_b

//scalac -cp judge/scala -d judge/scala/bin judge/scala/Solution.scala judge/scala/src.scala judge/scala/tests/a_plus_b.scala
//scala -cp judge/scala/bin judge.src 

object src {
  def main(args: Array[String]) {
    a_plus_b.judge
  }
}
