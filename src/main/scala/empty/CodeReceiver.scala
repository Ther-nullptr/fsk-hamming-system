package empty

import chisel3._
import chisel3.util._

class CodeReceiver extends Module {
  val io = IO(new Bundle {
    val input = Input(Bool())
    val output = Output(UInt(8.W))
  })

  val countReg = RegInit(0.U(3.W))
  val dataReg = RegInit(0.U(8.W))
  val dataRegBuffer = RegInit(0.U(8.W))
  val dataFull = RegInit(true.B)

  when(dataFull) {
    io.output := dataRegBuffer // maintain the current state
    when(io.input) {
      dataFull := false.B
      dataReg := 0.U
    }
  }.otherwise {
    countReg := countReg + 1.U
    when(countReg < 7.U) {
      dataReg := Cat(dataReg(6, 0), io.input)
      dataFull := false.B
      io.output := dataRegBuffer
    }.otherwise {
      countReg := 0.U // the data is full
      io.output := dataReg
      dataRegBuffer := dataReg
      when(io.input) {
        dataFull := false.B
        dataReg := 0.U
      }.otherwise {
        dataFull := true.B // maintain the current state
      }
    }
  }
}

object CodeReceiverMain extends App {
  println("Generating the hardware")
  emitVerilog(new CodeReceiver(), Array("--target-dir", "generated"))
}