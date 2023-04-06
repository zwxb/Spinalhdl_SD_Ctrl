import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

//case class TestStremFork() extends Component {
//  val io = new Bundle {
//    val Source = slave(Stream(Bits(32 bits)))
//    val Sink = Vec(master(Stream(Bits(32 bits))), 4)
//  }
//
//  StreamFork(io.Source, 4, true) <> io.Sink
//}

//object TestStremForkTop extends App {
//  SpinalVerilog(new TestStremFork())
//}

//case class UnpackSmall() extends Component {
//  val io = new Bundle {
//
//    val Soure = slave(Stream(Bits(320 bits)))
//
//    val Sink = Vec(master(Stream(Bits(32 bits))), 4)
//    //    val Sink = master(Stream(Bits(32 bits)))
//
//  }
//
//  noIoPrefix()
//
//  val PVaildNum = Bits(6 bits)
//  val PType = Bits(4 bits)
//  val FIFO = Stream(Bits(32 bits))
//  val FIFO3 = Stream(Bits(32 bits))
//  val FIFO2 = Vec(Stream(Bits(32 bits)), 4)
//  val FIFO1 = Stream(Bits(320 bits))
//  val PCnt = Reg(UInt(6 bits)) init (0)
//
//  PVaildNum := 0
//  PType := 0
//
//  for (i <- 0 until 4) {
//    io.Sink(i).valid := False
//    io.Sink(i).payload := 0
//  }
//
//  when(io.Soure.fire) {
//    PCnt := 0
//    PVaildNum := io.Soure.payload.subdivideIn(32 bits)(0)(15 downto 10)
//    PType := io.Soure.payload.subdivideIn(32 bits)(0)(31 downto 28)
//  }
//
//  io.Soure.queue(4) >> FIFO1
//
//  StreamWidthAdapter(FIFO1, FIFO)
//
//  when(FIFO.valid === True) {
//    PCnt := PCnt + 1
//  }
//
//  //  FIFO2 << FIFO.queue(4).throwWhen(PCnt > PVaildNum.asUInt)
//  FIFO.throwWhen(PCnt > PVaildNum.asUInt) >> FIFO3
//
//  io.Sink <> StreamFork(FIFO3, portCount = 4, synchronous = true)
//
//
////  FIFO2 <> io.Sink
//
//
//}
//object UnpackTop1 extends App {
//  SpinalVerilog(new UnpackSmall())
//}

/** MCASP接收后的数据解析
 * 根据数据包头信息PType 将数据分类到4种不同FIFO
 * 根据数据包头信息PVaildNum 将无效数据丢弃
 * */
case class UnpackSmall2() extends Component {
  val io = new Bundle {
    val Source = slave(Stream(Bits(320 bits)))
    val Sink = Vec(master(Stream(Bits(32 bits))), 4)
  }

  noIoPrefix()
  val FIFO1 = Stream(Bits(320 bits))
  val FIFO1Fork = Vec(Stream(Bits(320 bits)), 4)
  val FIFO1ForkThrow = Vec(Stream(Bits(320 bits)), 4)
  val FIFO2 = Vec(Stream(Bits(32 bits)), 4)
  val PType = Vec(UInt(4 bits), 4)
  val PValidNum = Vec(UInt(6 bits), 4)
  val PCnt = Vec(Reg(UInt(6 bits)), 4)

  PValidNum.map(_ := 0)
  PType.map(_ := 0)

  io.Source.queue(4) >> FIFO1

  FIFO1Fork <> StreamFork(FIFO1, 4, true)

  //获取当前数据包类型
  for (i <- 0 until (4)) {
    when(FIFO1Fork(i).fire === True) {
      PType(i) := FIFO1Fork(i).payload.subdivideIn(32 bits)(0)(31 downto 28).asUInt
    }
  }
  //根据数据包类型判断是否与当前FIFO类型匹配，不匹配舍弃
  //实际是将不同类型数据包进行分类，将同类型数据包存入到相同FIFO中
  for (i <- 0 until (4)) {
    FIFO1Fork(i).queue(2).throwWhen(i =/= PType(i)) >-> FIFO1ForkThrow(i)
  }

  //获取同种类型数据包种的数据有效个数
  for (i <- 0 until (4)) {
    when(FIFO1ForkThrow(i).fire === True) {
      PCnt(i) := 0
      PValidNum(i) := FIFO1ForkThrow(i).payload.subdivideIn(32 bits)(0)(15 downto (10)).asUInt
    }
  }

  //转换数据位宽 320 bits -> 32 bits
  for (i <- 0 until (4)) {
    StreamWidthAdapter(FIFO1ForkThrow(i), FIFO2(i))
  }

  //有效数据计数
  for (i <- 0 until (4)) {
    when(FIFO2(i).valid === True) {
      PCnt(i) := PCnt(i) + 1
    }
  }
  //丢弃无效数据
  for (i <- 0 until (4)) {
    FIFO2(i).queue(16).throwWhen(PCnt(i) > PValidNum(i)) >> io.Sink(i)
  }

}

/** 分类将会产生四种采样率的FIFO，且每个MCASP对应4种FIFO
 * 仲裁所有MCASP对应的相同采样率的FIFO
 * 仲裁方法按照sequentialOrder来实现
 * */
class DiffFsArbiter() extends Component {
  val io = new Bundle {
    val Soure = Vec(slave(Stream(Bits(32 bits))), 4)
    val Sink = master(Stream(Bits(32 bits)))
  }

  val FIFO = Vec(Stream(Bits(32 bits)), 4)

  for (i <- 0 until 4) {
    io.Soure(i).queue(4) >> FIFO(i)
  }

  val Stream0 = StreamArbiterFactory().roundRobin.sequentialOrder.on(FIFO)

  Stream0 >-> io.Sink

}

/** 同种采样率数据进行封包处理
 * 头 长度固定 32个点
 * 尾 长度固定 32个点
 * 身 长度可调点数
 * 同时包尾包含了当前传输包种的外触发点位置和外触发相位
 * */
class BigPack() extends Component {
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
  PHead.map(_ := 0)
  PTail.map(_ := 0)

  //  io.Source.queue(16) >> FIFO

  val PackTxFsm = new StateMachine {

    val HeadCnt = Reg(UInt(6 bits)) init (0)
    val BodyCnt = Reg(UInt(32 bits)) init (0)
    val TailCnt = Reg(UInt(6 bits)) init (0)

    val SIdle: State = new State with EntryPoint {
      whenIsActive {
        HeadCnt := 0
        BodyCnt := 0
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
        when(io.Sink.ready === True && BodyCnt < io.PLength.asUInt) {
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
          io.Sink.payload := PHead(TailCnt.resize(5))
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


object UnpackTop extends App {
  SpinalVerilog(new UnpackSmall2())
}

object DiffFsArbiterTop extends App {
  SpinalVerilog(new DiffFsArbiter())
}

object BigPackTop extends App {
  SpinalVerilog(new BigPack())
}