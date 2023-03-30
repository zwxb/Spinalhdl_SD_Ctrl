import spinal.core._
import spinal.lib._

/** 打包模块 加头/尾  stream位宽：256 -> 320 */
class PkgHeadTail() extends Component {
  val io = new Bundle {

    val in8 = Vec(slave(Stream(Bits(256 bits))), 4)
    val Out10 = Vec(master(Stream(Bits(320 bits))), 4)
    val PHead = in Vec(Bits(32 bits), 4)
    val PTail = in Vec(Bits(32 bits), 4)

    //包有效数据位宽
    val PVaildNum = in Vec(UInt(8 bits), 4)
    //包数据为32bits or 16Bits
    val P16Or32Bits = in Vec(Bits(2 bits), 4)
    //包外触发标志
    val PExtTrigger = in Vec(Bool(), 4)
    //包外触发相位
    val PExtPhase = in Vec(UInt(31 bits), 4)
    //包类型 根据不同采样率划分
    val PType = in Vec(Bits(3 bits), 4)
    //包外触发点位置
    val PExtTriCnt = in Vec(UInt(5 bits), 4)

  }

  noIoPrefix()

  for (i <- 0 until (4)) {
    io.in8(i).ready <> io.Out10(i).ready
    io.Out10(i).valid <> io.in8(i).valid
    io.Out10(i).payload := io.PHead(i) ## io.in8(i).payload ## io.PTail(i)
  }
  for (i <- 0 until (4)) {
    io.PHead(i) := io.PVaildNum(i) ## io.P16Or32Bits(i) ## io.PType(i) ## io.PExtTriCnt(i)
  }
  for (i <- 0 until (4)) {
    io.PTail(i) := io.PExtTrigger(i) ## io.PExtPhase(i)
  }

}

/** 4种不同采样率数据汇聚到FIFO种，FIFO每8点拼接为1小包 */
class ADDiffFsData() extends Component {
  val io = new Bundle {
    val source = Vec(slave(Flow(Bits(32 bits))), 4)
    val sink = Vec(master(Stream(Bits(256 bits))), 4)
    val PValidNum = in Vec(UInt(6 bits), 4)
  }

  noIoPrefix()

  val FIFO = Vec((Stream(Bits(256 bits))), 4)
  val xCnt = Vec(Reg(UInt(6 bits)), 4)
  val Pdata = Vec((Flow(Bits(256 bits))), 4)

  val ADBuffer0 = History(io.source(0).payload, 8, io.source(0).valid, B(0, 32 bits))
  val ADBuffer1 = History(io.source(1).payload, 8, io.source(1).valid, B(0, 32 bits))
  val ADBuffer2 = History(io.source(2).payload, 8, io.source(2).valid, B(0, 32 bits))
  val ADBuffer3 = History(io.source(3).payload, 8, io.source(3).valid, B(0, 32 bits))

  val ADBuffer = Vec(ADBuffer0, ADBuffer1, ADBuffer2, ADBuffer3)

  //初始化
  xCnt.map(_ := 19)

  for (i <- 0 until (4)) {
    Pdata(i).setIdle()
  }

  for (i <- 0 until (4)) {
    when(xCnt(i) === io.PValidNum(i) + 1) {
      xCnt(i) := 0
    } elsewhen (io.source(i).valid === True) {
      xCnt(i) := xCnt(i) + 1
    }
  }

  for (i <- 0 until (4)) {
    Pdata(i).valid.setWhen(xCnt(i) === io.PValidNum(i)).clearWhen(xCnt(i) =/= io.PValidNum(i))
  }

  for (i <- 0 until (4)) {
    when(Pdata(i).valid === True) {
      Pdata(i).payload := ADBuffer(i).asBits
    }
  }

  for (i <- 0 until (4)) {
    Pdata(i).toStream.queue(4) >> io.sink(i)
  }

}

/** 轮询仲裁不同采样率Fifo模块 Stream: 4 Mux 1 数据位宽：320-> 32 */
class Arbiter() extends Component {
  val io = new Bundle {
    val source = Vec(slave(Stream(Bits(320 bits))), 4)
    val Sink = master(Stream(Bits(32 bits)))
  }

  noIoPrefix()

  val FiFO = Vec(Stream(Bits(320 bits)), 4)

  for (i <- 0 until 4) {
    io.source(i).queue(4) >> FiFO(i)
  }
  val Stream0 = StreamArbiterFactory.roundRobin.onArgs(FiFO(3), FiFO(2), FiFO(1), FiFO(0))
  StreamWidthAdapter(Stream0, io.Sink)
}


object DiffFsTop extends App {
  SpinalVerilog(new Arbiter())
}