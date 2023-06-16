import spinal.core._
import spinal.lib._
import spinal.lib.com.uart.Uart

/**
 * 打包模块 加头/尾
 *
 * 封包方式为 包头(1) + 包身(8) + 包尾(1)
 *
 * stream位宽：256 -> 320 */
case class PkgHeadTail(FsNum: Int) extends Component {
  val io = new Bundle {

    val in8 = Vec(slave(Stream(Bits(256 bits))), FsNum)
    val Out10 = Vec(master(Stream(Bits(320 bits))), FsNum)

    //包有效数据位宽
    val PVaildNum = in Vec(UInt(6 bits), FsNum)
    //包数据为32bits or 16Bits
    val P16Or32Bits = in Vec(Bits(2 bits), FsNum)
    //包外触发标志
    val PExtTrigger = in Vec(Bool(), FsNum)
    //包外触发相位
    val PExtPhase = in Vec(UInt(31 bits), FsNum)
    //包类型 根据不同采样率划分
    val PType = in Vec(Bits(4 bits), FsNum)
    //包外触发点位置
    val PExtTriCnt = in Vec(UInt(5 bits), FsNum)

  }

  noIoPrefix()

  val PHead = Vec(Reg(Bits(32 bits)), FsNum)
  val PTail = Vec(Reg(Bits(32 bits)), FsNum)


  for (i <- 0 until (FsNum)) {
    io.in8(i).ready <> io.Out10(i).ready
    io.Out10(i).valid <> io.in8(i).valid
    io.Out10(i).payload := PHead(i) ## io.in8(i).payload ## PTail(i)
  }
  for (i <- 0 until (FsNum)) {
    PHead(i) := (io.PType(i) ## io.PVaildNum(i) ## io.P16Or32Bits(i) ## io.PExtTriCnt(i)).resizeLeft(32)
  }
  /*后续增加外触发再小包中的位置信息 为通道在小包中的第几点信息*/
  //
  //
  for (i <- 0 until (FsNum)) {
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
case class ADDiffFsData(FsNum: Int) extends Component {
  val io = new Bundle {
    val source = Vec(slave(Flow(Bits(32 bits))), FsNum)
    val sink = Vec(master(Stream(Bits(256 bits))), FsNum)
    val PValidNum = in Vec(UInt(6 bits), FsNum)
  }

  noIoPrefix()

  val FIFO = Vec((Stream(Bits(256 bits))), FsNum)
  val xCnt = Vec(Reg(UInt(6 bits)), FsNum)
  val BValid = Vec(Reg(Bool()), FsNum)
  val BData = Vec(Reg(Bits(32 bits)), FsNum)
  val Pdata = Vec((Flow(Bits(256 bits))), FsNum)

  //每种采样率使用特定的行缓冲器
  val ADBuffer0 = History(BData(0), 8, BValid(0), B(0, 32 bits))
  val ADBuffer1 = History(BData(1), 8, BValid(1), B(0, 32 bits))
  val ADBuffer2 = History(BData(2), 8, BValid(2), B(0, 32 bits))
  //  val ADBuffer3 = History(BData(3), 8, BValid(3), B(0, 32 bits))
  // 行缓冲器转为Vec 方便后续处理
  val ADBuffer = Vec(ADBuffer0, ADBuffer1, ADBuffer2)

  //初始化
  for (i <- 0 until (FsNum)) {
    xCnt(i).init(0)
  }

  for (i <- 0 until (FsNum)) {
    Pdata(i).setIdle()
  }
  //行缓冲器移位使能信号
  for (i <- 0 until FsNum) {
    BValid(i) := io.source(i).valid
  }
  //行缓冲器移位数据
  for (i <- 0 until (FsNum)) {
    BData(i) := io.source(i).payload
  }

  //计算每个行缓冲器的有效数据个数
  for (i <- 0 until (FsNum)) {
    when((xCnt(i) >= io.PValidNum(i) + 1) && io.source(i).valid === False) {
      xCnt(i) := 0
    } elsewhen (xCnt(i) >= io.PValidNum(i) + 1) {
      xCnt(i) := 1
    } elsewhen (io.source(i).valid === True) {
      xCnt(i) := xCnt(i) + 1
    }
  }

  for (i <- 0 until (FsNum)) {
    when(io.PValidNum(i) === 0) {
      Pdata(i).valid := False
    } otherwise {
      Pdata(i).valid.setWhen(xCnt(i) === io.PValidNum(i) + 1).clearWhen(xCnt(i) =/= io.PValidNum(i) + 1)
    }
  }

  for (i <- 0 until (FsNum)) {
    when(Pdata(i).valid === True) {
      Pdata(i).payload := ADBuffer(i).asBits
    }
  }

  for (i <- 0 until (FsNum)) {
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
class DiffFsArbiter(FsNum: Int) extends Component {
  val io = new Bundle {
    val source = Vec(slave(Stream(Bits(320 bits))), FsNum)
    val Sink = master(Stream(Bits(32 bits)))
  }

  noIoPrefix()

  val FiFO = Vec(Stream(Bits(320 bits)), FsNum).addAttribute("ram_style ", "distributed")

  val Stream0 = Stream(Bits(320 bits))

  for (i <- 0 until FsNum) {
    io.source(i).queue(16) >> FiFO(i)
  }

  StreamArbiterFactory.roundRobin.noLock.on(FiFO) >-> Stream0

  StreamWidthAdapter(Stream0, io.Sink)

}


case class SelfCnt(FsNum: Int) extends Component {
  val io = new Bundle {
    val Sink = Vec(master(Flow(Bits(32 bits))), FsNum)
  }

  val Cnt = CounterFreeRun(1000000)

  val TestCnt = Vec(Reg(UInt(32 bits)), FsNum)

  noIoPrefix()

  io.Sink.foreach(_.valid := False)
  io.Sink.foreach(_.payload := 0)
  TestCnt.foreach(_.init(0))

  when(Cnt.value === 250000) {
    io.Sink(0).valid := True
    io.Sink(0).payload := TestCnt(0).asBits
    TestCnt(0) := TestCnt(0) + 1
  } elsewhen (Cnt.value === 500000) {
    io.Sink(1).valid := True
    io.Sink(1).payload := TestCnt(1).asBits
    TestCnt(1) := TestCnt(1) + 1
  } elsewhen (Cnt.value === 750000) {
    io.Sink(2).valid := True
    io.Sink(2).payload := TestCnt(2).asBits
    TestCnt(2) := TestCnt(2) + 1
  } otherwise {
    io.Sink.foreach(_.valid := False)
  }
}


/** AD采集 筛选不同采样率数据 相同采样率数据封包 */
class ADPackArbiter(FsNum: Int) extends Component {
  val io = new Bundle {

    //    val sink = master(Stream(Bits(32 bits)))
    val UartIo = master(Uart())
    val UartClk = in Bool()
    val UartRst = in Bool()

    val PVaildNum = in Vec(UInt(6 bits), FsNum)
    //包数据为32bits or 16Bits
    val P16Or32Bits = in Vec(Bits(2 bits), FsNum)
    //包外触发标志
    val PExtTrigger = in Vec(Bool(), FsNum)
    //包外触发相位
    val PExtPhase = in Vec(UInt(31 bits), FsNum)
    //包类型 根据不同采样率划分
    val PType = in Vec(Bits(4 bits), FsNum)
    //包外触发点位置
    val PExtTriCnt = in Vec(UInt(5 bits), FsNum)

  }

  noIoPrefix()

  val coreClockDomain = ClockDomain(io.UartClk, io.UartRst)

  val ClkArea = new ClockingArea(coreClockDomain) {
    val ADFsData = new ADDiffFsData(FsNum)
    val PKHTData = new PkgHeadTail(FsNum)
    val ArbiterData = new DiffFsArbiter(FsNum)
    val iSelfCnt = new SelfCnt(3)
    val iMuartTx = new MuartTx()

    io.UartIo <> iMuartTx.io.UartIo
    io.PVaildNum <> ADFsData.io.PValidNum
    io.PVaildNum <> PKHTData.io.PVaildNum
    io.P16Or32Bits <> PKHTData.io.P16Or32Bits
    io.PExtTrigger <> PKHTData.io.PExtTrigger
    io.PExtPhase <> PKHTData.io.PExtPhase
    io.PType <> PKHTData.io.PType
    io.PExtTriCnt <> PKHTData.io.PExtTriCnt

    iMuartTx.io.UartClock := io.UartClk
    iMuartTx.io.UartReset := io.UartRst


    for (i <- 0 until (FsNum)) {
      iSelfCnt.io.Sink(i) >-> ADFsData.io.source(i)
    }
    for (i <- 0 until (FsNum)) {
      ADFsData.io.sink(i) >-> PKHTData.io.in8(i)
    }
    for (i <- 0 until (FsNum)) {
      PKHTData.io.Out10(i) >-> ArbiterData.io.source(i)
    }
    StreamWidthAdapter(ArbiterData.io.Sink, iMuartTx.io.TxData)
  }

}

case class TestADPackArbiter(FsNum: Int) extends Component {
  val io = new Bundle {
    val Clk50M = in Bool()
    val Clk50MRst = in Bool()
    val UartIo = master(Uart())
    val UartClk = in Bool()
    //    val UartRst = in Bool()

    val PVaildNum = in Vec(UInt(6 bits), FsNum)
    //包数据为32bits or 16Bits
    val P16Or32Bits = in Vec(Bits(2 bits), FsNum)
    //包外触发标志
    val PExtTrigger = in Vec(Bool(), FsNum)
    //包外触发相位
    val PExtPhase = in Vec(UInt(31 bits), FsNum)
    //包类型 根据不同采样率划分
    val PType = in Vec(Bits(4 bits), FsNum)
    //包外触发点位置
    val PExtTriCnt = in Vec(UInt(5 bits), FsNum)

  }
  noIoPrefix()

  val iADPackArbiter = new ADPackArbiter(FsNum)

  val Clk100M = ClockDomain(io.Clk50M, io.Clk50MRst, frequency = FixedFrequency(50 MHz))

  val clk100MArea = new ClockingArea(Clk100M) {
    val UartRest = Reg(Bool())
    val RstTimeOut = Timeout(1 ms)

    when(RstTimeOut) {
      UartRest := False
    } otherwise {
      UartRest := True
    }
  }
  iADPackArbiter.io.UartRst := clk100MArea.UartRest
  iADPackArbiter.io.UartClk := io.UartClk
  iADPackArbiter.io.UartIo <> io.UartIo
  iADPackArbiter.io.PVaildNum <> io.PVaildNum
  iADPackArbiter.io.P16Or32Bits <> io.P16Or32Bits
  iADPackArbiter.io.PExtTrigger <> io.PExtTrigger
  iADPackArbiter.io.PExtPhase <> io.PExtPhase
  iADPackArbiter.io.PType <> io.PType
  iADPackArbiter.io.PExtTriCnt <> io.PExtTriCnt

}


object DiffFsTop extends App {
  SpinalVerilog(new ADPackArbiter(3))
}

object SelfCntTop extends App {
  SpinalVerilog(new SelfCnt(3))
}


object TestADPackArbiter1 extends App {
  SpinalVerilog(new TestADPackArbiter(3))
}






