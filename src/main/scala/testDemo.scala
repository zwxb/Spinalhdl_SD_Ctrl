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

/** IIR 直接I型 并行计算 */
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

/** IIR 直接I型 串行计算 */
case class SerilIIRV1(Qi: Int) extends Component {
  val io = new Bundle {
    val input = slave(Flow(SInt(Qi bits)))
    val output = master(Flow(SInt(48 bits)))
  }

  val Xpara = List(0, 1, 4, 6, 6, 4, 1, 0)
  val Ypara = List(0, 8565, -16122, 17472, -11694, 4811, -1123, 114)

  val xMultiValid = Reg(Bool()) init (False)
  val yMulitValid = Reg(Bool()) init (False)

  val xAddrValid = Reg(Bool()) init (False)
  val yAddrValid = Reg(Bool()) init (False)
  val Yout = Reg(SInt(48 bits)) init (0)

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

  val XBuffer = History((io.input.payload), 8, (xAddrValid), S(0, 16 bits))
  val YBuffer = History((Yout), 8, yAddrValid, S(0, 48 bits))


  noIoPrefix()

  XMultBuffer.map(_ := 0)
  YMultBuffer.map(_ := 0)

  for (i <- 0 until 8) {
    X(i) := Xpara(i)
    Y(i) := Ypara(i)
  }

  io.output.valid := RegNext(yAddrValid)
  io.output.payload := (Yout).resize(48 bits)

  when(io.input.valid === True) {
    xCnt := 0
  } elsewhen (xMultiValid === True) {
    xCnt := xCnt + 1
  }

  xMultiValid.setWhen(io.input.valid).clearWhen(xCnt === 7)
  xAddrValid.setWhen(xCnt === 7).clearWhen(xCnt =/= 7)

  when(xAddrValid === True) {
    yCnt := 0
  } elsewhen (yMulitValid === True) {
    yCnt := yCnt + 1
  }

  yMulitValid.setWhen(xAddrValid).clearWhen(yCnt === 7)
  yAddrValid.setWhen(yCnt === 7).clearWhen(yCnt =/= 7)

  i := xCnt.resize(3)
  j := yCnt.resize(3)

  when(xMultiValid === True) {
    XMultBuffer(i) := (XBuffer(i) * X(i))
  }

  when(xAddrValid === True) {
    XAdder := XMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))
  }

  when(yMulitValid === True) {
    YMultBuffer(j) := (YBuffer(j) * Y(j)) (63 downto 16)
  }

  when(yAddrValid === True) {
    YAdder := YMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))
    Yout := YAdder + XAdder
  }


}

/** IIR 直接II型 串行计算 */
//case class SerilIIRV2(Qi: Int) extends Component {
//  val io = new Bundle {
//    val input = slave(Flow(SInt(Qi bits)))
//    val output = master(Flow(SInt(48 bits)))
//  }
//
//  val Xpara = List(0, 1, 4, 6, 6, 4, 1, 0)
//  val Ypara = List(2048, -8565, 16122, -17472, 11694, -4811, 1123, -114)
//
//  val xMultiValid = Reg(Bool()) init (False)
//  val yMulitValid = Reg(Bool()) init (False)
//
//  val xAddrValid = Reg(Bool()) init (False)
//  val yAddrValid = Reg(Bool()) init (False)
//
//  val X = Vec(Reg(SInt(Qi bits)), 8)
//  val Y = Vec(Reg(SInt(Qi bits)), 8)
//
//  val xCnt = Reg(UInt(4 bits)) init (0)
//  val yCnt = Reg(UInt(4 bits)) init (0)
//
//  val i = UInt(3 bits)
//  val j = UInt(3 bits)
//
//  val XAdder = Reg((SInt(48 bits))) init (0)
//  val YAdder = Reg((SInt(64 bits))) init (0)
//
//  val XMultBuffer = Vec((SInt(48 bits)), 8)
//  val YMultBuffer = Vec(SInt(64 bits), 8)
//
//  val YBuffer = History((XAdder), 8, xAddrValid, S(0, 48 bits))
//
//
//  noIoPrefix()
//
//  XMultBuffer.map(_ := 0)
//  YMultBuffer.map(_ := 0)
//
//  for (i <- 0 until 8) {
//    X(i) := Xpara(i)
//    Y(i) := Ypara(i)
//  }
//
//  io.output.valid := RegNext(yAddrValid)
//  io.output.payload := (YAdder >> 11).resize(48 bits)
//
//  when(io.input.valid === True) {
//    xCnt := 0
//  } elsewhen (xMultiValid === True) {
//    xCnt := xCnt + 1
//  }
//
//  xMultiValid.setWhen(io.input.valid).clearWhen(xCnt === 7)
//  xAddrValid.setWhen(xCnt === 7).clearWhen(xCnt =/= 7)
//
//  when(xAddrValid === True) {
//    yCnt := 0
//  } elsewhen (yMulitValid === True) {
//    yCnt := yCnt + 1
//  }
//
//  yMulitValid.setWhen(xAddrValid).clearWhen(yCnt === 7)
//  yAddrValid.setWhen(yCnt === 7).clearWhen(yCnt =/= 7)
//
//  i := xCnt.resize(3)
//  j := yCnt.resize(3)
//
//  when(xMultiValid === True) {
//    when(i === 0) {
//      XMultBuffer(i) := io.input.payload.resize(32) * X(i)
//    } otherwise {
//      XMultBuffer(i) := YBuffer(i) * X(i)
//    }
//  }
//
//  when(xAddrValid === True) {
//    XAdder := XMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))
//  }
//
//  when(yMulitValid === True) {
//    YMultBuffer(j) := YBuffer(j) * Y(j)
//  }
//
//  when(yAddrValid === True) {
//    YAdder := YMultBuffer.reduceBalancedTree(_ + _, (s, l) => RegNext(s))
//  }
//
//
//}


object IIR_Top extends App {
  SpinalVerilog(new SerilIIRV1(16))
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