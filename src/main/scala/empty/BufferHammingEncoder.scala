package empty

import chisel3._
import chisel3.util._

class BufferHammingEncoder extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(1.W))     // 输入 1 位数据
    val output = Output(UInt(8.W)) // 输出 8 位数据
  })
  
  val hammingEncoder = Module(new HammingEncoder4to7)
  val fourBitBuffer = Module(new FourBitBuffer)

  fourBitBuffer.io.input := io.input
  hammingEncoder.io.input := fourBitBuffer.io.output
  io.output := hammingEncoder.io.output
}