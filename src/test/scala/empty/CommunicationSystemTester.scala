package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CommunicationSystemTester extends AnyFlatSpec with ChiselScalatestTester {
  val testInputs = Seq(5)
  "CommunicationSystem" should "work" in {
      test(new CommunicationSystem).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.input.poke(5)
      dut.clock.step(10)
      dut.io.input.poke(0)
      dut.clock.step(200)
    }
  }
}

object CommunicationSystemTesterMain extends App {
  println("Testing the CommunicationSystem hardware")
}
