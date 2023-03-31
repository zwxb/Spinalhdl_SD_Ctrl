import spinal.core._
import spinal.lib._

/** 打包模块 加头/尾  stream位宽：256 -> 320 */
class PkgHeadTail() extends Component {
  val io = new Bundle {

    val in8 = Vec(slave(Stream(Bits(256 bits))), 4)
    val Out10 = Vec(master(Stream(Bits(320 bits))), 4)

    //包有效数据位宽
    val PVaildNum = in Vec(UInt(6 bits), 4)
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

  val PHead = Vec(Reg(Bits(32 bits)), 4)
  val PTail = Vec(Reg(Bits(32 bits)), 4)


  for (i <- 0 until (4)) {
    io.in8(i).ready <> io.Out10(i).ready
    io.Out10(i).valid <> io.in8(i).valid
    io.Out10(i).payload := PHead(i) ## io.in8(i).payload ## PTail(i)
  }
  for (i <- 0 until (4)) {
    PHead(i) := (io.PVaildNum(i) ## io.P16Or32Bits(i) ## io.PType(i) ## io.PExtTriCnt(i)).resize(32)
  }
  for (i <- 0 until (4)) {
    PTail(i) := io.PExtTrigger(i) ## io.PExtPhase(i)
  }

}

/** 4种不同采样率数据汇聚到FIFO，FIFO每8点拼接为1小包 */
class ADDiffFsData() extends Component {
  val io = new Bundle {
    val source = Vec(slave(Flow(Bits(32 bits))), 4)
    val sink = Vec(master(Stream(Bits(256 bits))), 4)
    val PValidNum = in Vec(UInt(6 bits), 4)
  }

  noIoPrefix()

  val FIFO = Vec((Stream(Bits(256 bits))), 4)
  val xCnt = Vec(Reg(UInt(6 bits)), 4)
  val BValid = Vec(Reg(Bool()), 4)
  val Pdata = Vec((Flow(Bits(256 bits))), 4)

  val ADBuffer0 = History(io.source(0).payload, 8, BValid(0), B(0, 32 bits))
  val ADBuffer1 = History(io.source(1).payload, 8, BValid(1), B(0, 32 bits))
  val ADBuffer2 = History(io.source(2).payload, 8, BValid(2), B(0, 32 bits))
  val ADBuffer3 = History(io.source(3).payload, 8, BValid(3), B(0, 32 bits))

  val ADBuffer = Vec(ADBuffer0, ADBuffer1, ADBuffer2, ADBuffer3)

  //初始化
  //  xCnt.map(_ := 0)

  for (i <- 0 until (4)) {
    Pdata(i).setIdle()
  }

  for (i <- 0 until 4) {
    BValid(i) := io.source(i).valid
  }

  for (i <- 0 until (4)) {
    when(xCnt(i) >= io.PValidNum(i) + 1) {
      xCnt(i) := 0
    } elsewhen (io.source(i).valid === True) {
      xCnt(i) := xCnt(i) + 1
    }
  }

  for (i <- 0 until (4)) {
    when(io.PValidNum(i) === 0) {
      Pdata(i).valid := False
    } otherwise {
      Pdata(i).valid.setWhen(xCnt(i) === io.PValidNum(i) + 1).clearWhen(xCnt(i) =/= io.PValidNum(i) + 1)
    }
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


class ADPackArbiter() extends Component {
  val io = new Bundle {
    val source = Vec(slave(Flow(Bits(32 bits))), 4)
    val sink = master(Stream(Bits(32 bits)))

    val PVaildNum = in Vec(UInt(6 bits), 4)
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

  val ADFsData = new ADDiffFsData()
  val PKHTData = new PkgHeadTail()
  val ArbiterData = new Arbiter()

  io.PVaildNum <> ADFsData.io.PValidNum
  io.PVaildNum <> PKHTData.io.PVaildNum
  io.P16Or32Bits <> PKHTData.io.P16Or32Bits
  io.PExtTrigger <> PKHTData.io.PExtTrigger
  io.PExtPhase <> PKHTData.io.PExtPhase
  io.PType <> PKHTData.io.PType
  io.PExtTriCnt <> PKHTData.io.PExtTriCnt

  for(i<-0 until(4)){
    io.source(i) >-> ADFsData.io.source(i)
  }
  for(i<-0 until(4)){
    ADFsData.io.sink(i) >-> PKHTData.io.in8(i)
  }
  for(i<-0 until(4)){
    PKHTData.io.Out10(i) >-> ArbiterData.io.source(i)
  }
  ArbiterData.io.Sink >-> io.sink
}


object DiffFsTop extends App {
  SpinalVerilog(new ADPackArbiter())
}



