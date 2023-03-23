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

/** IIR 并行计算 */
class ParallIIR(Qi: Int) extends Component {
  val io = new Bundle {
    val input = slave(Flow(SInt(Qi bits)))
    val output = master(Flow(SInt(48 bits)))
  }

  val Xpara = List(7, 21, 42, 56, 56, 42, 21, 7)
  val Ypara = List(512, -922, 1163, -811, 472, -122, 24, -2)
  val X = Vec(SInt(Qi bits), 8)
  val Y = Vec(SInt(Qi bits), 8)
  val XAdder = (SInt(32 bits))
  val YAdder = (SInt(48 bits))
  val XBuffer = History(io.input.payload, 8, io.input.valid)
  val YBuffer = History(XAdder, 8, io.input.valid)
  val XMultBuffer = Vec(SInt(32 bits), 8)
  val YMultBuffer = Vec(SInt(48 bits), 8)


  noIoPrefix()

  for (i <- 0 until 8) {
    X(i) := Xpara(i)
    Y(i) := Ypara(i)
  }

  io.output.valid := io.input.valid

  for (i <- 0 until 8) XMultBuffer(i) := RegNext(XBuffer(i) * X(i))
  XAdder := XMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))

  for (i <- 0 until 8) YMultBuffer(i) := RegNext(YBuffer(i) * Y(i))
  YAdder := YMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))

  io.output.payload := YAdder

}

/** IIR 串行计算 */
case class SerilIIR(Qi: Int) extends Component {
  val io = new Bundle {
    val input = slave(Flow(SInt(Qi bits)))
    val output = master(Flow(SInt(48 bits)))
  }

  val Xpara = List(7, 21, 42, 56, 56, 42, 21, 7)
  val Ypara = List(512, -922, 1163, -811, 472, -122, 24, -2)

  val xMultiValid = Reg(Bool()) init (False)
  val yMulitValid = Reg(Bool()) init (False)

  val xAddrValid = Reg(Bool()) init (False)
  val yAddrValid = Reg(Bool()) init (False)

  val X = Vec(Reg(SInt(Qi bits)), 8)
  val Y = Vec(Reg(SInt(Qi bits)), 8)

  val xCnt = Reg(UInt(4 bits)) init (0)
  val yCnt = Reg(UInt(4 bits)) init (0)

  val i = UInt(3 bits)
  val j = UInt(3 bits)

  val XAdder = Reg((SInt(32 bits))) init (0)
  val YAdder = Reg((SInt(48 bits))) init (0)

  val XMultBuffer = Vec((SInt(32 bits)), 8)
  val YMultBuffer = Vec(SInt(48 bits), 8)

  val XBuffer = History((io.input.payload), 8, (xAddrValid))
  val YBuffer = History((XAdder), 8, yAddrValid)

  noIoPrefix()

  for (i <- 0 until 8) {
    X(i) := Xpara(i)
    Y(i) := Ypara(i)
  }
  for (i <- 0 until 8) {
//    XBuffer(i) := 0
//    YBuffer(i) := 0
    XMultBuffer(i) := 0
    YMultBuffer(i) := 0
  }


  io.output.valid := RegNext(yAddrValid)
  io.output.payload := YAdder

  when(io.input.valid === True) {
    xCnt := 0
  } elsewhen (xMultiValid === True) {
    xCnt := xCnt + 1
  }

  when(io.input.valid === True) {
    xMultiValid := True
  } elsewhen (xCnt === 7) {
    xMultiValid := False
  }

  when(xCnt === 7) {
    xAddrValid := True
  } otherwise {
    xAddrValid := False
  }

  when(xAddrValid === True) {
    yCnt := 0
  } elsewhen (yMulitValid === True) {
    yCnt := yCnt + 1
  }

  when(xAddrValid === True) {
    yMulitValid := True
  } elsewhen (yCnt === 7) {
    yMulitValid := False
  }

  when(yCnt === 7) {
    yAddrValid := True
  } otherwise {
    yAddrValid := False
  }

  i := xCnt.resize(3)
  j := yCnt.resize(3)

  when(xMultiValid === True) {
    XMultBuffer(i) := XBuffer(i) * X(i)
  }

  when(xAddrValid === True) {
    XAdder := XMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))
  }

  when(yMulitValid === True) {
    YMultBuffer(j) := (YBuffer(j) * Y(j))
  }

  when(yAddrValid === True) {
    YAdder := YMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))
  }


}


object firtop extends App {
  SpinalVerilog(new SerilIIR(16))
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