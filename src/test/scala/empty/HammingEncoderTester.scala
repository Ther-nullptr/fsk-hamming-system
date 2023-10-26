package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class HammingEncoder4to7Tester extends AnyFlatSpec with ChiselScalatestTester {
  val testInputs = Seq(1,2,3,4,5,6,7,8,9,10)

    "HammingEncoder4to7" should "work" in {
        test(new HammingEncoder4to7).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (input <- testInputs) {
            dut.io.input.poke(input)
            dut.io.send_enable.poke(1.B)
            dut.clock.step(1)
            // println(s"result: ${dut.io.output.peek()}")
        }
      }
    }
}

object HammingEncoder4to7TesterMain extends App {
  println("Testing the HammingEncoder4to7 hardware")
}
