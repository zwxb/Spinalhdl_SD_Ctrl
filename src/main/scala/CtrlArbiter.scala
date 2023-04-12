import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

/**
 * 位宽转换模块
 *
 * MCASP接收的数据位宽为32bits，后续处理的位宽为320bits
 *
 * 位宽转换:32bits -> 320 bits
 * */
case class Width32to320(SlotNum: Int) extends Component {
  val io = new Bundle {
    val Source = Vec(slave(Stream(Bits(32 bits))), SlotNum)
    val Sink = Vec(master(Stream(Bits(320 bits))), SlotNum)
  }
  val FIFO = Vec(Stream(Bits(32 bits)), SlotNum)

  for (i <- 0 until (SlotNum)) {
    io.Source(i).queue(16) >> FIFO(i)
  }

  for (i <- 0 until (SlotNum)) {
    StreamWidthAdapter(FIFO(i), io.Sink(i))
  }

}

/**
 * 通道间不同采样率小包的解析模块
 *
 * MCASP接收后的数据解析
 *
 * 根据数据包头信息PType 将数据分类到4种不同FIFO
 *
 * 根据数据包头信息PVaildNum 将无效数据丢弃
 *
 * */
case class SmallUnpack(SlotNum: Int) extends Component {
  val io = new Bundle {
    val Source = Vec(slave(Stream(Bits(320 bits))), SlotNum)
    val Sink = Vec(Vec(master(Stream(Bits(32 bits))), 4), SlotNum)
  }

  noIoPrefix()

  val FIFO1 = Vec(Stream(Bits(320 bits)), SlotNum)
  val FIFO1Fork = Vec(Vec(Stream(Bits(320 bits)), 4), SlotNum)
  val FIFO1ForkThrow = Vec(Vec(Stream(Bits(320 bits)), 4), SlotNum)
  val FIFO1End = Vec(Vec(Stream(Bits(320 bits)), 4), SlotNum)
  val FIFO2 = Vec(Vec(Stream(Bits(32 bits)), 4), SlotNum)
  val PType = Vec(Vec(Reg(UInt(4 bits)), 4), SlotNum)
  val PValidNum = Vec(Vec(Reg(UInt(4 bits)), 4), SlotNum)
  val PCnt = Vec(Vec(Reg(UInt(6 bits)), 4), SlotNum)
  val IsBlack = Vec(Vec(Bool(), 4), SlotNum)

  PValidNum.foreach(_.init(0))
  PType.foreach(_.init(0))
  PCnt.foreach(_.init(0))

  for (i <- 0 until (SlotNum)) {
    io.Source(i).queue(4) >> FIFO1(i)
  }

  //将数据复制4份，将每份中的相同类型的数据汇总
  for (i <- 0 until (SlotNum)) {
    FIFO1Fork(i) <> StreamFork(FIFO1(i), 4, true)
  }

  //获取当前数据包类型
  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      when(FIFO1Fork(j)(i).fire === True) {
        PType(j)(i) := FIFO1Fork(j)(i).payload.subdivideIn(32 bits)(9)(31 downto 28).asUInt
      }
    }
  }

  //根据数据包类型判断是否与当前FIFO类型匹配，不匹配舍弃
  //实际是将不同类型数据包进行分类，将同类型数据包存入到相同FIFO中
  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      FIFO1Fork(j)(i).queue(4).throwWhen(i =/= PType(j)(i)) >-> FIFO1ForkThrow(j)(i)
    }
  }


  //获取同种类型数据包种的数据有效个数
  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      when(FIFO1ForkThrow(j)(i).fire === True) {
        PCnt(j)(i) := 0
        PValidNum(j)(i) := FIFO1ForkThrow(j)(i).payload.subdivideIn(32 bits)(9)(15 downto (12)).asUInt
      }
    }
  }

  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      FIFO1ForkThrow(j)(i).queue(4) >> FIFO1End(j)(i)
    }
  }


  //转换数据位宽 320 bits -> 32 bits
  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      StreamWidthAdapter(FIFO1End(j)(i), FIFO2(j)(i))
    }
  }


  //有效数据计数
  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      when(FIFO2(j)(i).fire === True) {
        PCnt(j)(i) := PCnt(j)(i) + 1
      }
    }
  }

  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      IsBlack(j)(i) := (PCnt(j)(i) === 9) || (PCnt(j)(i) === 0) || (PCnt(j)(i) > PValidNum(j)(i)) && (FIFO2(j)(i).valid
        === True)
    }
  }
  //丢弃无效数据
  for (j <- 0 until (SlotNum)) {
    for (i <- 0 until (4)) {
      FIFO2(j)(i).throwWhen(IsBlack(j)(i)) >> io.Sink(j)(i)
    }
  }

}

/**
 * 相同采样率模块进行顺序轮询仲裁模块
 *
 * 分类将会产生四种采样率的FIFO，且每个MCASP对应4种FIFO
 *
 * 仲裁所有MCASP对应的相同采样率的FIFO
 *
 * 仲裁方法按照sequentialOrder来实现 目前重构了该函数加入FIFO端口开关
 * */
case class SameFsArbiter(SlotNum: Int) extends Component {
  val io = new Bundle {
    val Soure = Vec(slave(Stream(Bits(32 bits))), SlotNum)
    val Sink = master(Stream(Bits(32 bits)))
    val SinkEn = in Bits (SlotNum bits)
  }

  noIoPrefix()

  val FIFO = Vec(Stream(Bits(32 bits)), SlotNum)

  for (i <- 0 until SlotNum) {
    io.Soure(i).queue(4) >> FIFO(i)
  }

  //重新构建sequentialOrder函数
  //重新构建的函数 加入FIFO的使能开关 关闭后的FIFO将不再进行仲裁
  //关闭后的顺序仍然按照FIFO定义后的顺序
  val arbiter = StreamArbiterFactory()
  arbiter.arbitrationLogic = core => {
    new Area {

      import core._

      val ValidMask = Bits(SlotNum bits)

      val State = (Bool())

      ValidMask := SameFsArbiter.this.io.SinkEn.pull()

      val counter = Counter(core.portCount)

      State := False

      for (i <- 0 to core.portCount - 1) {
        maskProposal(i) := False
      }

      when(ValidMask(counter.value)) {
        State := True
        when(core.io.output.fire) {
          counter.increment()
        }
      } otherwise {
        counter.increment()
        State := False
      }
      maskProposal(counter.value) := State
    }
  }

  val Stream0 = arbiter.on(FIFO)

  Stream0 >-> io.Sink

}

/**
 * 大包封包模块
 *
 * 同种采样率数据进行封包处理
 *
 * 头 长度固定 32个点
 *
 * 尾 长度固定 32个点
 *
 * 身 长度可调点数
 *
 * 同时包尾包含了当前传输包种的外触发点位置和外触发相位
 * */
case class BigPack() extends Component {
  val io = new Bundle {
    val Source = slave(Stream(Bits(32 bits)))
    val PLength = in Bits (32 bits)
    //    val PTrigger = in Bits (4 bits)
    val Sink = master(Stream(Bits(32 bits)))
  }

  val FIFO = Stream(Bits(32 bits))

  val PHead = Vec(Bits(32 bits), 32)

  val PTail = Vec(Bits(32 bits), 32)

  io.Source.ready := True
  io.Sink.valid := False
  io.Sink.payload := 0


  for (i <- 1 until (31)) {
    PHead(i) := 0
  }
  for (i <- 1 until (31)) {
    PTail(i) := 0
  }

  PHead(0) := B"32'xAABBCCDD"
  PHead(31) := B"32'x12345678"

  PTail(0) := B"32'x87654321"
  PTail(31) := B"32'xDDCCBBAA"

  //  io.Source.queue(16) >> FIFO

  val PackTxFsm = new StateMachine {

    val HeadCnt = Reg(UInt(6 bits)) init (0)
    val BodyCnt = Reg(UInt(32 bits)) init (0)
    val TailCnt = Reg(UInt(6 bits)) init (0)


    val SIdle: State = new State with EntryPoint {
      whenIsActive {
        HeadCnt := 0
        BodyCnt := 0
        TailCnt := 0
        goto(STxHead)
      }
    }
    val STxHead: State = new State() {
      whenIsActive {
        when(io.Sink.ready === True && HeadCnt < 32) {
          io.Sink.valid := True
          io.Sink.payload := PHead(HeadCnt.resize(5))
          HeadCnt := HeadCnt + 1
        }
        when(HeadCnt === 32) {
          goto(STxBody)
        }
      }
    }
    val STxBody: State = new State() {
      whenIsActive {
        when(io.Sink.ready === True && io.Source.valid === True && BodyCnt < io.PLength.asUInt) {
          io.Sink.valid := io.Source.valid
          io.Sink.payload := io.Source.payload
          BodyCnt := BodyCnt + 1
        }
        when(BodyCnt === io.PLength.asUInt) {
          goto(STxTail)
        }
      }
    }
    val STxTail: State = new State() {
      whenIsActive {
        when(io.Sink.ready === True && TailCnt < 32) {
          io.Sink.valid := True
          io.Sink.payload := PTail(TailCnt.resize(5))
          TailCnt := TailCnt + 1
        }
        when(TailCnt === 32) {
          goto(SDone)
        }
      }
    }
    val SDone: State = new State() {
      whenIsActive {
        goto(SIdle)
      }
    }
  }

}

/**
 * 主控板卡顶层模块
 *
 * 包括MCASP数据位宽转换 小包解包 同种采样率仲裁 大包封包
 *
 * 其中主控兼容的Slot数目可以随意配置
 * */
case class CtrlTop(SlotNum: Int) extends Component {
  val io = new Bundle {
    val Source = Vec(slave(Stream(Bits(32 bits))), SlotNum)
    val Sink = Vec(master(Stream(Bits(32 bits))), 4)
    val SinkEn = in Vec(Bits(SlotNum bits), 4)
    val PLength = in Vec(Bits(32 bits), 4)
  }


  val iWidth32to320 = new Width32to320(SlotNum)
  val iSmallUnpack = new SmallUnpack(SlotNum)

  val iSameFsArbiter1 = new SameFsArbiter(SlotNum)
  val iSameFsArbiter2 = new SameFsArbiter(SlotNum)
  val iSameFsArbiter3 = new SameFsArbiter(SlotNum)
  val iSameFsArbiter4 = new SameFsArbiter(SlotNum)

  val iBigPack1 = new BigPack()
  val iBigPack2 = new BigPack()
  val iBigPack3 = new BigPack()
  val iBigPack4 = new BigPack()


  iSameFsArbiter1.io.SinkEn := io.SinkEn(0)
  iSameFsArbiter2.io.SinkEn := io.SinkEn(1)
  iSameFsArbiter3.io.SinkEn := io.SinkEn(2)
  iSameFsArbiter4.io.SinkEn := io.SinkEn(3)

  iBigPack1.io.PLength := io.PLength(0)
  iBigPack2.io.PLength := io.PLength(1)
  iBigPack3.io.PLength := io.PLength(2)
  iBigPack4.io.PLength := io.PLength(3)

  //根据主控板卡Slot数目 复制生成相同数目位宽转换模块
  for (i <- 0 until (SlotNum)) {
    io.Source(i) >-> iWidth32to320.io.Source(i)
  }
  //根据主控板卡Slot数目 复制生成相同数目小包解包模块
  for (i <- 0 until (SlotNum)) {
    iWidth32to320.io.Sink(i) >-> iSmallUnpack.io.Source(i)
  }
  //仲裁所有slot中相同位置FIFO
  for (j <- 0 until (SlotNum)) {
    iSmallUnpack.io.Sink(j)(0) >-> iSameFsArbiter1.io.Soure(j) //采样率1的FIFO仲裁
    iSmallUnpack.io.Sink(j)(1) >-> iSameFsArbiter2.io.Soure(j) //采样率2的FIFO仲裁
    iSmallUnpack.io.Sink(j)(2) >-> iSameFsArbiter3.io.Soure(j) //采样率3的FIFO仲裁
    iSmallUnpack.io.Sink(j)(3) >-> iSameFsArbiter4.io.Soure(j) //采样率4的FIFO仲裁
  }
  //所有汇聚数据最终以4种不同包传输到ARM端
  iSameFsArbiter1.io.Sink >-> iBigPack1.io.Source //采样率1的打包
  iSameFsArbiter2.io.Sink >-> iBigPack2.io.Source //采样率2的打包
  iSameFsArbiter3.io.Sink >-> iBigPack3.io.Source //采样率3的打包
  iSameFsArbiter4.io.Sink >-> iBigPack4.io.Source //采样率4的打包

  iBigPack1.io.Sink >> io.Sink(0)
  iBigPack2.io.Sink >> io.Sink(1)
  iBigPack3.io.Sink >> io.Sink(2)
  iBigPack4.io.Sink >> io.Sink(3)


}


object With32to320Top extends App {
  SpinalVerilog(new Width32to320(8))
}

object UnpackTop extends App {
  SpinalVerilog(new SmallUnpack(16))
}

object DiffFsArbiterTop extends App {
  SpinalVerilog(new SameFsArbiter(4))
}

object BigPackTop extends App {
  SpinalVerilog(new BigPack())
}

object CtrlTop extends App {
  SpinalVerilog(new CtrlTop(8))
}