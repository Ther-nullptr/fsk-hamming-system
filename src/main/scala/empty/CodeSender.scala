package empty

import chisel3._
import chisel3.util._

class CodeSender extends Module {
  val io = IO(new Bundle {
    val input = Input(UInt(8.W))
    val output = Output(Bool())
  })

  val clk_cnt = RegInit(0.U(3.W))

  when(clk_cnt < 7.U) {
    clk_cnt := clk_cnt + 1.U // clk_count is a register, so do not use RegNext, directly use := instead
  }.otherwise {
    clk_cnt := 0.U
    io.output := RegNext(false.B)
  }
  io.output := RegNext(io.input(7.U - clk_cnt))
}

object CodeSenderSystem extends App {
  println("Generating the hardware")
  emitVerilog(new CodeSender(), Array("--target-dir", "generated"))
}