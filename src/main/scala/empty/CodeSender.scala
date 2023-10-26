package empty

import chisel3._
import chisel3.util._

class CodeSender extends Module {
  val io = IO(new Bundle {
    val input = Input(UInt(8.W))
    val output = Output(Bool())
  })

  val clk_cnt = RegInit(0.U(4.W))

  when(clk_cnt <= 7.U) {
    clk_cnt := clk_cnt + 1.U // clk_count is a register, so do not use RegNext, directly use := instead
    io.output := RegNext(io.input(7.U - clk_cnt))
  }.elsewhen (clk_cnt === 8.U) {
    clk_cnt := RegNext(9.U)
    io.output := RegNext(io.input(0.U))
  }.otherwise {
    clk_cnt := RegNext(9.U)
    io.output := RegNext(0.U)
  }
  // io.output := RegNext(io.input(7.U - clk_cnt))
}

object CodeSenderSystem extends App {
  println("Generating the hardware")
  emitVerilog(new CodeSender(), Array("--target-dir", "generated"))
}