package empty

import chisel3._
import chisel3.util._

class FSKEncoder extends Module {
  val io = IO(new Bundle {
    val input = Input(Bool())
    val output = Output(Bool())
  })

  val carrier2 = RegInit(0.U(1.W))
  val carrier16 = RegInit(0.U(1.W))
  val cnt_carrier2 = RegInit(0.U(4.W))
  val cnt_carrier16 = RegInit(0.U(4.W))

  cnt_carrier2 := cnt_carrier2 + 1.U
  cnt_carrier16 := cnt_carrier16 + 1.U
  when(cnt_carrier2 === 1.U) {
    carrier2 := ~carrier2
    cnt_carrier2 := 0.U
  }
  when(cnt_carrier16 === 15.U) {
    carrier16 := ~carrier16
    cnt_carrier16 := 0.U
  }

  io.output := Mux(io.input, carrier2, carrier16)
}

object FSKEncoderMain extends App {
  println("Generating the hardware")
  emitVerilog(new FSKEncoder(), Array("--target-dir", "generated"))
}
