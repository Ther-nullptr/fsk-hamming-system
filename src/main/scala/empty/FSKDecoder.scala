package empty

import chisel3._
import chisel3.util._

class FSKDecoder extends Module {
  val io = IO(new Bundle {
    val input = Input(Bool())
    val output = Output(Bool())
  })

  val prev = RegInit(0.U(1.W))
  val in_cnt = RegInit(0.U(9.W))
  val clk_cnt = RegInit(0.U(12.W))

  when(prev === 0.U && io.input === 1.U) {
    in_cnt := in_cnt + 1.U
  }
  when(clk_cnt >= 32.U) {
    when(in_cnt < 8.U) {
      io.output := 0.U
    }.otherwise {
      io.output := 1.U
    }
    clk_cnt := 0.U
    in_cnt := 0.U
  }.otherwise {
    clk_cnt := clk_cnt + 1.U
    io.output := RegNext(io.output)
  }
  prev := io.input
}

object FSKDecoderMain extends App {
  println("Generating the hardware")
  emitVerilog(new FSKDecoder(), Array("--target-dir", "generated"))
}
