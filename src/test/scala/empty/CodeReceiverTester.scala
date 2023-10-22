package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CodeReceiverTester extends AnyFlatSpec with ChiselScalatestTester {
  val testInputs = Seq(1,0,0,1,0,1,0,1,0,0,1,0,0,1,0,1,0,1,0,0)

    "CodeReceiver" should "work" in {
        test(new CodeReceiver).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        for (input <- testInputs) {
            // print the input with binary format
            dut.io.input.poke(input)
            dut.clock.step(1)
            println(s"result: ${dut.io.output.peek()}")
        }
      }
    }
}

object CodeReceiverTesterMain extends App {
  println("Testing the CodeReceiver hardware")
}
