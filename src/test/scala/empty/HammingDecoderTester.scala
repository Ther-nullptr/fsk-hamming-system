package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class HammingDecoder7to4Tester extends AnyFlatSpec with ChiselScalatestTester {
  val testInputs = Seq(99,197,167,233,139,45,79,177,211,117)

    "HammingDecoder7to4" should "work" in {
        test(new HammingDecoder7to4).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (input <- testInputs) {
            // print the input with binary format
            dut.io.input.poke(input)
            dut.clock.step(1)
            println(s"input: ${input.toBinaryString}, result: ${dut.io.output.peek()}")
        }
      }
    }
}

object HammingDecoder7to4TesterMain extends App {
  println("Testing the HammingDecoder7to4 hardware")
}
