package empty

import chisel3._
import chisel3.util._

class FourBitBuffer extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(1.W))     // 输入 1 位数据
    val output = Output(UInt(4.W)) // 输出 4 位数据
  })

  // 寄存器用于缓存输入位
  val bufferReg = RegInit(0.U(4.W))
  val countReg = RegInit(0.U(3.W)) // 计数寄存器，用于跟踪已经输入的位数

  // 将输入位存储到缓存寄存器中，并移位
    when(io.input === 1.U) {
        bufferReg := Cat(bufferReg(2, 0), 1.U)
        countReg := countReg + 1.U
    }.otherwise {
        bufferReg := Cat(bufferReg(2, 0), 0.U)
        countReg := countReg + 1.U
    }


  // 当已经输入了 4 位数据时，输出缓存数据，并清零寄存器
  when(countReg === 4.U) {
    io.output := bufferReg
    bufferReg := 0.U
    countReg := 0.U
  }.otherwise {
    io.output := 0.U
  }
}

object BitBufferMain extends App {
  println("Generating the hardware")
  emitVerilog(new FourBitBuffer(), Array("--target-dir", "generated"))
}

