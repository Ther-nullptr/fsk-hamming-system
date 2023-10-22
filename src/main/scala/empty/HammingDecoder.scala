package empty

import chisel3._
import chisel3.util._


class HammingDecoder7to4 extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(8.W))
    val output = Output(UInt(4.W))
  })

  val error_code = Wire(Vec(3, UInt(1.W)))

  error_code(0) := io.input(0) ^ io.input(2) ^ io.input(3) ^ io.input(4)
  error_code(1) := io.input(0) ^ io.input(1) ^ io.input(2) ^ io.input(5)
  error_code(2) := io.input(1) ^ io.input(2) ^ io.input(3) ^ io.input(6)

  when (error_code.asUInt === "b110".U)
  {
    io.output := Cat(Seq(io.input(3), io.input(2), io.input(1), ~io.input(0)))
  }
  .elsewhen (error_code.asUInt === "b011".U)
  {
    io.output := Cat(Seq(io.input(3), io.input(2), ~io.input(1), io.input(0)))
  }
  .elsewhen (error_code.asUInt === "b111".U)
  {
    io.output := Cat(Seq(io.input(3), ~io.input(2), io.input(1), io.input(0)))
  }
  .elsewhen (error_code.asUInt === "b101".U)
  {
    io.output := Cat(Seq(~io.input(3), io.input(2), io.input(1), io.input(0)))
  }
  .otherwise
  {
    io.output := Cat(Seq(io.input(3), io.input(2), io.input(1), io.input(0)))
  }
}

object HammingCodeDecoderMain extends App {
  println("Generating the hardware")
  emitVerilog(new HammingDecoder7to4(), Array("--target-dir", "generated"))
}
