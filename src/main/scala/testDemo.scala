import spinal.lib.fsm._
import spinal.core._
import spinal.lib._
import spinal.lib.bus.avalon.{AvalonMM, AvalonMMSlaveFactory}
import spinal.lib.bus.wishbone.{Wishbone, WishboneConfig}
import spinal.lib.com.uart.{Uart, UartCtrl, UartCtrlGenerics}
import spinal.core._
import spinal.lib._

//class fir(
//           Qi: Int,
//           H: List[Int],
//           column: Int = 10000
//         ) extends Component {
//  val io = new Bundle {
//    val input = in SInt (Qi bits)
//    val output = out SInt (Qi + log2Up(H.max) + 1 bits)
//  }
//
//  noIoPrefix()
//
//  def firStage(input : SInt, H : List[Int], adder : SInt): SInt = {
//    val nextInput = Delay(input,2)
//    val thisadder = adder
//    if(H.length != 0) {
//      val mult = RegNext(H(0)*nextInput)
//      val nextAdder = RegNext(mult+thisadder)
//      val nextH = H.drop(1)
//      firStage(nextInput,nextH,nextAdder)
//    }else {
//      adder
//    }
//  }


//  def firStage(input: SInt, H: List[Int], adder: SInt, nowStage: Int = 0, column: Int, startX: Int = 0, startY: Int = 0): SInt = {
//    val nextInput = Delay(input, if (nowStage % column == 0) 3 else 2)
//    nextInput.setName("input_" + nowStage, true)
//    val thisadder = if (nowStage % column == 0) RegNext(adder) else adder
//    thisadder.setName("adder_" + nowStage, true)
//    if (nowStage != 0) {
//      PrintXDC(s"set_property LOC DSP48E2_X${startX + nowStage / column}Y${startY + nowStage % column - 1} [get_cells ${thisadder.getName()}_reg]\n")
//    }
//    if (H.length != 0) {
//      val mult = RegNext(H(0) * nextInput)
//      val nextAdder = RegNext(mult + thisadder)
//      val nextH = H.drop(1)
//      firStage(nextInput, nextH, nextAdder, nowStage + 1, column, startX, startY)
//    } else {
//      adder
//    }
//  }

//  io.output := firStage(io.input, H, S(0))
//
//}


class IIR(Qi: Int) extends Component {
  val io = new Bundle {
    val input = slave(Flow(SInt(Qi bits)))
    val output = master(Flow(SInt(40 bits)))
  }

  val Xpara = List(7, 21, 42, 56, 56, 42, 21, 7)
  val Ypara = List(512, -922, 1163, -811, 472, -122, 24, -2)

  noIoPrefix()

  val X = Vec(SInt(12 bits), 8)
  val Y = Vec(SInt(12 bits), 8)

  for (i <- 0 until 8) {
    X(i) := Xpara(i)
    Y(i) := Ypara(i)
  }

  //  X.map(_ := 17)
  //  Y.map(_ := 11)
  //  X := (0 until 8).map(idx => 17).toList
  //  Y := (0 until 8).map(idx => 17).toList

  val XAdder = (SInt(28 bits))
  val YAdder = (SInt(40 bits))
  val XBuffer = History(io.input.payload, 8, io.input.valid)
  val YBuffer = History(XAdder, 8, io.input.valid)
  val XMultBuffer = Vec(SInt(28 bits), 8)
  val YMultBuffer = Vec(SInt(40 bits), 8)

  io.output.valid := io.input.valid

  for (i <- 0 until 8) XMultBuffer(i) := RegNext(XBuffer(i) * X(i))

  XAdder := XMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))

  for (i <- 0 until 8) YMultBuffer(i) := RegNext(YBuffer(i) * Y(i))
  YAdder := YMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))

  io.output.payload := YAdder

}

object firtop extends App {
  SpinalVerilog(new IIR(8))
  //  PrintXDC("xdc", "route.xdc")
}


class SinusGenerator(resolutionWidth: Int, sampleCount: Int) extends Component {
  val io = new Bundle {
    val sin = out SInt (resolutionWidth bits)
  }

  def sinTable = (0 until sampleCount).map(sampleIndex => {
    val sinValue = Math.sin(2 * Math.PI * sampleIndex / sampleCount)
    S((sinValue * ((1 << resolutionWidth) / 2 - 1)).toInt, resolutionWidth bits)
  })

  val rom = Mem(SInt(resolutionWidth bits), initialContent = sinTable)
  val phase = CounterFreeRun(sampleCount)
  io.sin := rom.readSync(phase)
}


//class AvalonUartCtrl(uartCtrlConfig : UartCtrlGenerics, rxFifoDepth : Int) extends Component{
//  val io = new Bundle{
//    val bus = slave(AvalonMM(…))
//    val uart = master(Uart())
//  }
//  val uartCtrl = new UartCtrl(uartCtrlConfig)
//  io.uart <> uartCtrl.io.uart
//  val busCtrl = AvalonMMSlaveFactory(io.bus)
//  //Make clockDivider register
//  busCtrl.driveAndRead(uartCtrl.io.config.clockDivider, address = 0)
//  //Make frame register
//  busCtrl.driveAndRead(uartCtrl.io.config.frame, address = 4)
//  //Make writeCmd register
//  val writeFlow = busCtrl.createAndDriveFlow(Bits(uartCtrlConfig.dataWidthMax bits), address = 8)
//  writeFlow.toStream.stage() >> uartCtrl.io.write
//  //Make writeBusy register
//  busCtrl.read(uartCtrl.io.write.valid, address = 8)
//  //Make read register
//  busCtrl.readStreamNonBlocking(uartCtrl.io.read.queue(rxFifoDepth),
//    address = 12,validBitOffset = 31,payloadBitOffset = 0)
//}


//object Top {
//  def main(args: Array[String]) {
//    SpinalVerilog(new SinusGenerator(16,35))
//  }
//}