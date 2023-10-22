package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RandomChangerTester extends AnyFlatSpec with ChiselScalatestTester {
  val testInputs = Seq(1,2,3,4,5,6,7,8,9,10)

    "RandomChanger" should "work" in {
        test(new RandomChanger).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (input <- testInputs) {
            // print the input with binary format
            println(s"input: ${input.toBinaryString}")
            dut.io.input.poke(input)
            dut.clock.step(1)
            println(s"result: ${dut.io.output.peek()}")
        }
      }
    }
}

object RandomChangerTesterMain extends App {
  println("Testing the RandomChanger hardware")
}
