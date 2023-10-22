package empty

import chisel3._
import chisel3.util._
import scala.util.Random

class RandomChanger extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(8.W))
    val output = Output(UInt(8.W))
  })

  def randomBitFlip(input: UInt, bit: Int): UInt = {
    val mask = WireDefault((1 << bit).U(7.W))
    val bitToFlip = input & mask
    val flipped = bitToFlip ^ mask
    input & ~mask | flipped
  }

   val randomNumber = Random.nextInt(8) % 7
   io.output := randomBitFlip(io.input, randomNumber)
}

object RandomChangerMain extends App {
  println("Generating the hardware")
  emitVerilog(new RandomChanger(), Array("--target-dir", "generated"))
}
