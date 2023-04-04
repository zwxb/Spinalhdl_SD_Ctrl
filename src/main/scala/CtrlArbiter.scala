import spinal.core._
import spinal.lib._
import spinal.lib.fsm._

case class UnpackSmall() extends Component {
  val io = new Bundle {

    val Soure = slave(Stream(Bits(320 bits)))

    val Sink = Vec(master(Stream(Bits(32 bits))), 4)

  }

  noIoPrefix()

  val PVaildNum = Bits(6 bits)
  val PType = Bits(4 bits)
  val FIF0 = Stream(Bits(32 bits))
  val FIF02 = Stream(Bits(32 bits))
  val FIFO1 = Stream(Bits(320 bits))
  val PCnt = Reg(UInt(6 bits)) init (0)

  PVaildNum := 0
  PType := 0

  when(io.Soure.fire) {
    PCnt := 0
    PVaildNum := io.Soure.payload.subdivideIn(32 bits)(0)(15 downto 10)
    PType := io.Soure.payload.subdivideIn(32 bits)(0)(31 downto 28)
  }

  io.Soure.queue(4) >> FIFO1

  StreamWidthAdapter(FIFO1, FIF0)

  when(FIF0.valid === True) {
    PCnt := PCnt + 1
  }

  FIF0.queue(4).throwWhen(PCnt > PVaildNum.asUInt) >> FIF02

  switch(PType) {
    is(0) {
      FIF02 >> io.Sink(0)
    }
    is(1) {
      FIF02 >> io.Sink(1)
    }
    is(2) {
      FIF02 >> io.Sink(2)
    }
    is(3) {
      FIF02 >> io.Sink(3)
    }
  }


}

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
  SpinalVerilog(new UnpackSmall())
}

object DiffFsArbiterTop extends App {
  SpinalVerilog(new DiffFsArbiter())
}

object BigPackTop extends App {
  SpinalVerilog(new BigPack())
}