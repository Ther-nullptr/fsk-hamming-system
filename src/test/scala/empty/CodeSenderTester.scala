package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CodeSenderTester extends AnyFlatSpec with ChiselScalatestTester {
  val testInputs = Seq(135)

    "CodeSender" should "work" in {
        test(new CodeSender).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (input <- testInputs) {
            // print the input with binary format
            dut.io.input.poke(input)
            dut.clock.step(30)
        }
      }
    }
}

object CodeSenderTesterMain extends App {
  println("Testing the CodeSender hardware")
}
