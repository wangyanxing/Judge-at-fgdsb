package judge
import scala.collection.Iterator
import scala.collection.mutable.ArrayBuffer
import sys.process._

object common {
	def read_int_array(it : Iterator[String]): Array[Int] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Int]()
		for( i <- 0 until number ) {
			ret += it.next.toInt
		}
		ret.toArray
	}

	def read_int_matrix(it : Iterator[String]): Array[Array[Int]] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Array[Int]]()
		for( i <- 0 until number ) {
			ret += read_int_array(it)
		}
		ret.toArray
	}

	def read_int_matrix_arr(it : Iterator[String]): Array[Array[Array[Int]]] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Array[Array[Int]]]()
		for( i <- 0 until number ) {
			ret += read_int_matrix(it)
		}
		ret.toArray
	}

	def read_double_array(it : Iterator[String]): Array[Double] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Double]()
		for( i <- 0 until number ) {
			ret += it.next.toDouble
		}
		ret.toArray
	}

	def read_double_matrix(it : Iterator[String]): Array[Array[Double]] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Array[Double]]()
		for( i <- 0 until number ) {
			ret += read_double_array(it)
		}
		ret.toArray
	}

	def read_double_matrix_arr(it : Iterator[String]): Array[Array[Array[Double]]] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Array[Array[Double]]]()
		for( i <- 0 until number ) {
			ret += read_double_matrix(it)
		}
		ret.toArray
	}

	def read_string_array(it : Iterator[String]): Array[String] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[String]()
		for( i <- 0 until number ) {
			ret += it.next
		}
		ret.toArray
	}

	def read_string_matrix(it : Iterator[String]): Array[Array[String]] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Array[String]]()
		for( i <- 0 until number ) {
			ret += read_string_array(it)
		}
		ret.toArray
	}

	def read_string_matrix_arr(it : Iterator[String]): Array[Array[Array[String]]] = {
		val number = it.next.toInt
		var ret = new ArrayBuffer[Array[Array[String]]]()
		for( i <- 0 until number ) {
			ret += read_string_matrix(it)
		}
		ret.toArray
	}

	////////////////////////////////////////////////////////////////////////////////////////////////

	val old_stream = new java.io.PrintStream(Console.out);

	def capture_stdout() = {		
		Console.setOut(new java.io.PrintStream(new java.io.FileOutputStream("judge/stdout.txt", false)));
	}

	def release_stdout() = {
		Console.setOut(old_stream);
	}
}

