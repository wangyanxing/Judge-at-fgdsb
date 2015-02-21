package judge
import scala.collection.Iterator
import scala.collection.mutable.ListBuffer

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
}