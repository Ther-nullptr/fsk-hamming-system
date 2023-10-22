package empty

import chisel3._
import chisel3.util._

// receive from high to low

class CodeReceiver extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(1.W))
    val output = Output(UInt(8.W))
  })
   
  val countReg = RegInit(0.U(3.W))
  val collectorReg = RegInit(0.U(8.W))

  when(countReg.asUInt < 7.U)
  {
    countReg := (countReg + 1.U)
    collectorReg := Cat(collectorReg(6, 0), io.input)
    io.output := 0.U
  }
  .otherwise
  {
    io.output := collectorReg
    countReg := 0.U
  }
}

object CodeReceiverMain extends App {
  println("Generating the hardware")
  emitVerilog(new CodeReceiver(), Array("--target-dir", "generated"))
}