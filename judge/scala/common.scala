package judge
import scala.collection.Iterator
import scala.collection.mutable.ListBuffer
import sys.process._

object common {
	def read_int_array(it : Iterator[String]): List[Int] = {
		val number = it.next.toInt
		var ret = new ListBuffer[Int]()
		for( i <- 0 until number ) {
			ret += it.next.toInt
		}
		ret.toList
	}

	def read_int_matrix(it : Iterator[String]): List[List[Int]] = {
		val number = it.next.toInt
		var ret = new ListBuffer[List[Int]]()
		for( i <- 0 until number ) {
			ret += read_int_array(it)
		}
		ret.toList
	}

	def read_int_matrix_arr(it : Iterator[String]): List[List[List[Int]]] = {
		val number = it.next.toInt
		var ret = new ListBuffer[List[List[Int]]]()
		for( i <- 0 until number ) {
			ret += read_int_matrix(it)
		}
		ret.toList
	}

	def read_double_List(it : Iterator[String]): List[Double] = {
		val number = it.next.toInt
		var ret = new ListBuffer[Double]()
		for( i <- 0 until number ) {
			ret += it.next.toDouble
		}
		ret.toList
	}

	def read_double_matrix(it : Iterator[String]): List[List[Double]] = {
		val number = it.next.toInt
		var ret = new ListBuffer[List[Double]]()
		for( i <- 0 until number ) {
			ret += read_double_List(it)
		}
		ret.toList
	}

	def read_double_matrix_arr(it : Iterator[String]): List[List[List[Double]]] = {
		val number = it.next.toInt
		var ret = new ListBuffer[List[List[Double]]]()
		for( i <- 0 until number ) {
			ret += read_double_matrix(it)
		}
		ret.toList
	}

	def read_string_List(it : Iterator[String]): List[String] = {
		val number = it.next.toInt
		var ret = new ListBuffer[String]()
		for( i <- 0 until number ) {
			ret += it.next
		}
		ret.toList
	}

	def read_string_matrix(it : Iterator[String]): List[List[String]] = {
		val number = it.next.toInt
		var ret = new ListBuffer[List[String]]()
		for( i <- 0 until number ) {
			ret += read_string_List(it)
		}
		ret.toList
	}

	def read_string_matrix_arr(it : Iterator[String]): List[List[List[String]]] = {
		val number = it.next.toInt
		var ret = new ListBuffer[List[List[String]]]()
		for( i <- 0 until number ) {
			ret += read_string_matrix(it)
		}
		ret.toList
	}

	////////////////////////////////////////////////////////////////////////////////////////////////

	def to_string(a:List[_]) = { "[" + a.mkString(", ") + "]" }
	def to_string(a:Vector[_]) = { "[" + a.mkString(", ") + "]" }
	def to_string(a:Array[_]) = { "[" + a.mkString(", ") + "]" }
	def to_string(a:Int) = { a.toString }	
	def to_string(a:Double) = { a.toString }	
	def to_string(a:String) = { a }

	////////////////////////////////////////////////////////////////////////////////////////////////

	val old_stream = new java.io.PrintStream(Console.out);

	def capture_stdout() = {		
		Console.setOut(new java.io.PrintStream(new java.io.FileOutputStream("judge/stdout.txt", false)));
	}

	def release_stdout() = {
		Console.setOut(old_stream);
	}
}

