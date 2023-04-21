import spinal.core._
import spinal.lib._

/**
 * 打包模块 加头/尾
 *
 * 封包方式为 包头(1) + 包身(8) + 包尾(1)
 *
 * stream位宽：256 -> 320 */
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
    val PType = in Vec(Bits(4 bits), 4)
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
    PHead(i) := (io.PType(i) ## io.PVaildNum(i) ## io.P16Or32Bits(i) ## io.PExtTriCnt(i)).resizeLeft(32)
  }
  for (i <- 0 until (4)) {
    PTail(i) := io.PExtTrigger(i) ## io.PExtPhase(i)
  }

}

/**
 * AD采集数据通过降采样方案产生4种不同采样率数据汇聚到FIFO，
 *
 * FIFO每8点拼接为1小包
 *
 * 封包数据规则为 ：
 *
 * 根据数据有效位来标记封包后的数据有效长度 其他无效数据为缓冲数据解包后丢弃
 * */
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
  val BData = Vec(Reg(Bits(32 bits)), 4)
  val Pdata = Vec((Flow(Bits(256 bits))), 4)

  //每种采样率使用特定的行缓冲器
  val ADBuffer0 = History(BData(0), 8, BValid(0), B(0, 32 bits))
  val ADBuffer1 = History(BData(1), 8, BValid(1), B(0, 32 bits))
  val ADBuffer2 = History(BData(2), 8, BValid(2), B(0, 32 bits))
  val ADBuffer3 = History(BData(3), 8, BValid(3), B(0, 32 bits))
  // 行缓冲器转为Vec 方便后续处理
  val ADBuffer = Vec(ADBuffer0, ADBuffer1, ADBuffer2, ADBuffer3)

  //初始化
  for (i <- 0 until (4)) {
    xCnt(i).init(0)
  }

  for (i <- 0 until (4)) {
    Pdata(i).setIdle()
  }
  //行缓冲器移位使能信号
  for (i <- 0 until 4) {
    BValid(i) := io.source(i).valid
  }
  //行缓冲器移位数据
  for (i <- 0 until (4)) {
    BData(i) := io.source(i).payload
  }

  //计算每个行缓冲器的有效数据个数
  for (i <- 0 until (4)) {
    when((xCnt(i) >= io.PValidNum(i) + 1) && io.source(i).valid === False) {
      xCnt(i) := 0
    } elsewhen (xCnt(i) >= io.PValidNum(i) + 1) {
      xCnt(i) := 1
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

/** 仲裁不同采样率Fifo模块
 *
 * 仲裁机制为 roundRobin
 *
 * 仲裁完成后将stream数据进行位宽转换
 *
 * Stream: 4 Mux 1 数据位宽：320-> 32 */
class DiffFsArbiter() extends Component {
  val io = new Bundle {
    val source = Vec(slave(Stream(Bits(320 bits))), 4)
    val Sink = master(Stream(Bits(32 bits)))
  }

  noIoPrefix()

  val FiFO = Vec(Stream(Bits(320 bits)), 4).addAttribute("ram_style ","distributed")

  val Stream0 = Stream(Bits(320 bits))

  for (i <- 0 until 4) {
    io.source(i).queue(16) >> FiFO(i)
  }

  StreamArbiterFactory.roundRobin.noLock.on(FiFO) >-> Stream0

  StreamWidthAdapter(Stream0, io.Sink)

}


case class SelfCnt() extends Component {
  val io = new Bundle {
    val Sink = Vec(master(Flow(Bits(32 bits))), 4)
  }

  val Cnt = CounterFreeRun(40000)

  val TestCnt = Vec(Reg(UInt(32 bits)), 4)

  noIoPrefix()

  io.Sink.foreach(_.valid := False)
  io.Sink.foreach(_.payload := 0)
  TestCnt.foreach(_.init(0))

  when(Cnt.value === 10000) {
    io.Sink(0).valid := True
    io.Sink(0).payload := TestCnt(0).asBits
    TestCnt(0) := TestCnt(0) + 1
  } elsewhen (Cnt.value === 20000) {
    io.Sink(1).valid := True
    io.Sink(1).payload := TestCnt(1).asBits
    TestCnt(1) := TestCnt(1) + 1
  } elsewhen (Cnt.value === 30000) {
    io.Sink(2).valid := True
    io.Sink(2).payload := TestCnt(2).asBits
    TestCnt(2) := TestCnt(2) + 1
  } elsewhen (Cnt.value === 40000) {
    io.Sink(3).valid := True
    io.Sink(3).payload := TestCnt(3).asBits
    TestCnt(3) := TestCnt(3) + 1
  }

}


/** AD采集 筛选不同采样率数据 相同采样率数据封包 */
class ADPackArbiter() extends Component {
  val io = new Bundle {
    //    val source = Vec(slave(Flow(Bits(32 bits))), 4)
    val sink = master(Stream(Bits(32 bits)))

    val PVaildNum = in Vec(UInt(6 bits), 4)
    //包数据为32bits or 16Bits
    val P16Or32Bits = in Vec(Bits(2 bits), 4)
    //包外触发标志
    val PExtTrigger = in Vec(Bool(), 4)
    //包外触发相位
    val PExtPhase = in Vec(UInt(31 bits), 4)
    //包类型 根据不同采样率划分
    val PType = in Vec(Bits(4 bits), 4)
    //包外触发点位置
    val PExtTriCnt = in Vec(UInt(5 bits), 4)

  }

  noIoPrefix()

  val ADFsData = new ADDiffFsData()
  val PKHTData = new PkgHeadTail()
  val ArbiterData = new DiffFsArbiter()
  val iSelfCnt = new SelfCnt()

  io.PVaildNum <> ADFsData.io.PValidNum
  io.PVaildNum <> PKHTData.io.PVaildNum
  io.P16Or32Bits <> PKHTData.io.P16Or32Bits
  io.PExtTrigger <> PKHTData.io.PExtTrigger
  io.PExtPhase <> PKHTData.io.PExtPhase
  io.PType <> PKHTData.io.PType
  io.PExtTriCnt <> PKHTData.io.PExtTriCnt

  for (i <- 0 until (4)) {
    iSelfCnt.io.Sink(i) >-> ADFsData.io.source(i)
  }
  for (i <- 0 until (4)) {
    ADFsData.io.sink(i) >-> PKHTData.io.in8(i)
  }
  for (i <- 0 until (4)) {
    PKHTData.io.Out10(i) >-> ArbiterData.io.source(i)
  }
  ArbiterData.io.Sink >-> io.sink
}


object DiffFsTop extends App {
  SpinalVerilog(new ADPackArbiter())
}

object SelfCntTop extends App {
  SpinalVerilog(new SelfCnt())
}


