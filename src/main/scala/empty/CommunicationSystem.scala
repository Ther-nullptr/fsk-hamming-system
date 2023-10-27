package empty

import chisel3._
import chisel3.util._

// send from high to low

class CommunicationSystem extends Module {
  val io = IO(new Bundle {
    val input  = Input(UInt(4.W))
    val output = Output(UInt(4.W))
  })

  val hammingEncoder = Module(new HammingEncoder4to7)
  // val randomChanger = Module(new RandomChanger)
  val codeSender = Module(new CodeSender)
  val fskEncoder = Module(new FSKEncoder)
  val fskDecoder = Module(new FSKDecoder)
  val codeReceiver = Module(new CodeReceiver)
  val hammingDecoder = Module(new HammingDecoder7to4)

  hammingEncoder.io.input := io.input
  // hammingEncoder.io.send_enable := io.send_enable
  // randomChanger.io.input := hammingEncoder.io.output
  // codeSender.io.input := randomChanger.io.output
  codeSender.io.input := hammingEncoder.io.output
  fskEncoder.io.input := codeSender.io.output
  fskDecoder.io.input := fskEncoder.io.output
  codeReceiver.io.input := fskDecoder.io.input // fskDecoder.io.output
  hammingDecoder.io.input := codeReceiver.io.output
  io.output := hammingDecoder.io.output
}

object CommunicationSystem extends App {
  println("Generating the hardware")
  emitVerilog(new CommunicationSystem(), Array("--target-dir", "generated"))
}