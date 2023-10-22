package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CommunicationSystemTester extends AnyFlatSpec with ChiselScalatestTester {
  val testInputs = Seq(5)
  "CommunicationSystem" should "work" in {
      test(new CommunicationSystem).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      for (input <- testInputs) {
          dut.io.input.poke(input)
          dut.clock.step(1)
          // println(s"result: ${dut.io.output.peek()}")
      }
      dut.clock.step(200)
    }
  }
}

object CommunicationSystemTesterMain extends App {
  println("Testing the CommunicationSystem hardware")
}
