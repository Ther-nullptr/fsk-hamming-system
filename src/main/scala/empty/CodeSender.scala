package empty

import chisel3._
import chisel3.util._


class CodeSender extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(8.W))
    val output = Output(UInt(1.W))
  })

  val countReg = RegInit(0.U(3.W))

  when(countReg.asUInt < 7.U)
  {
    countReg := (countReg + 1.U)
  }
  .otherwise
  {
    countReg := 0.U
  }
  
  io.output := io.input(countReg.asUInt)
}

object CodeSenderMain extends App {
  println("Generating the hardware")
  emitVerilog(new CodeSender(), Array("--target-dir", "generated"))
}