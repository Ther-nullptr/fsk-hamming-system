package empty

import chisel3._
import chisel3.util._


class HammingEncoder4to7 extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(4.W))
    val send_enable = Input(Bool())
    val output = Output(UInt(8.W))
  })

  // Calculate parity bits
  val p1 = io.input(3) ^ io.input(2) ^ io.input(0)
  val p2 = io.input(2) ^ io.input(1) ^ io.input(0)
  val p3 = io.input(3) ^ io.input(2) ^ io.input(1)

  // Output the encoded 7-bit data
  io.output := Cat(Seq(io.send_enable, p3, p2, p1, io.input(3), io.input(2), io.input(1), io.input(0)))
}

object HammingCodeEncoderMain extends App {
  println("Generating the hardware")
  emitVerilog(new HammingEncoder4to7(), Array("--target-dir", "generated"))
}
