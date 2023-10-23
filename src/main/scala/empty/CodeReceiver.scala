package empty

import chisel3._
import chisel3.util._

// receive from high to low

// class CodeReceiver extends Module {
//   val io = IO(new Bundle {
//     val input  = Input(UInt(1.W))
//     val output = Output(UInt(8.W))
//   })
   
//   val countReg = RegInit(0.U(3.W))
//   val collectorReg = RegInit(0.U(8.W))

//   when(countReg.asUInt < 7.U)
//   {
//     countReg := (countReg + 1.U)
//     io.output := 0.U
//     collectorReg := Cat(collectorReg(6, 0), io.input)
//   }
//   .otherwise
//   {
//     io.output := Cat(collectorReg(6, 0), io.input)
//     countReg := 0.U
//   }
// }

import chisel3._

class CodeReceiver extends Module {
  val io = IO(new Bundle {
    val input  = Input(Bool())
    val output = Output(UInt(8.W))
  })

  val countReg  = RegInit(0.U(3.W))
  val dataReg   = RegInit(0.U(8.W))
  val dataFull  = RegInit(false.B)
  when(dataFull) {
      io.output := dataReg
      countReg := 0.U
      when(io.input) {
        dataFull := false.B
      }
    }.otherwise {
      countReg := countReg + 1.U
      when(countReg < 7.U) {
        dataReg := Cat(dataReg(6, 0), io.input)
        dataFull := false.B
        io.output := 0.U
      }.otherwise {
        countReg := 0.U
        io.output := dataReg
        dataFull := true.B
      }
    }
}


object CodeReceiverMain extends App {
  println("Generating the hardware")
  emitVerilog(new CodeReceiver(), Array("--target-dir", "generated"))
}