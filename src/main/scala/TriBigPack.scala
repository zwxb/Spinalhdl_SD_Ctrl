import spinal.core._
import spinal.core.sim.{SimConfig, fork, simSuccess}
import spinal.lib._
import spinal.lib.fsm._

case class TriggerCheck() extends Component {
  val io = new Bundle {
    val Start = in Bool()
    val ClearExt = in Bool()
    val Exttiger = in Bool()
    val ExtType = in Bits (2 bits)
    val FliterEt = out Bool()
  }
  val ExtFF = History(!io.Exttiger, 32, null, False)

  val ExtOut = Reg(Bool()) init (False)

  io.FliterEt := ExtOut


  when(io.Start === True && ExtFF.asBits.resize(32) === 1 && io.ExtType === 1) {
    ExtOut := True
  } elsewhen (io.Start === True && ExtFF.asBits.resize(32) === B"32'xFFFFFFFE" && io.ExtType === 0) {
    ExtOut := True
  } elsewhen (io.ClearExt.rise()) {
    ExtOut := False
  } elsewhen (io.Start === False) {
    ExtOut := False
  }

}


object zzCtrlTop extends App {
  SpinalVerilog(new TriggerCheck())
}


case class TriBigPack() extends Component {
  val io = new Bundle {
    val Source = slave(Stream(Bits(32 bits)))
    val PLength = in Bits (32 bits)
    val PTrigger = in Bool()
    val ChEN = in UInt (32 bits)
    val B16Or32 = in Bool()
    val Start = in Bool()
    val ClearTri = out Bool()
    val Sink = master(Stream(Bits(32 bits)))
  }


  val HeadCnt = Reg(UInt(6 bits)) init (0)
  val BodyCnt = Reg(UInt(32 bits)) init (0)
  val TailCnt = Reg(UInt(6 bits)) init (0)
  val TriCnt = Reg(UInt(32 bits)) init (0)
  val RepeatCnt = Reg(UInt(32 bits)) init (0)
  val TriCntBak = Reg(UInt(32 bits)) init (0)
  val TriClearReg = Reg(Bool()) init (False)
  val FIFO = Stream(Bits(32 bits))
  val PHead = Vec(Bits(32 bits), 32)
  val PTail = Vec(Bits(32 bits), 32)

  io.Source.ready := True
  io.Sink.valid := False
  io.Sink.payload := 0
  io.ClearTri := TriClearReg


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


    val SIdle: State = new State with EntryPoint {
      whenIsActive {
        HeadCnt := 0
        BodyCnt := 0
        TailCnt := 0
        RepeatCnt := 0
        TriClearReg := False
        when(io.Start === True) {
          goto(STxHead)
        }
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
          RepeatCnt := RepeatCnt + 1
          when(RepeatCnt === io.ChEN - 1) {
            RepeatCnt := 0
            TriCnt := TriCnt + 1
          }
          when(io.PTrigger.rise()) {
            when(io.B16Or32 === True) {
              TriCntBak := (TriCnt >> 1).resize(32 bits)
            } otherwise {
              TriCntBak := TriCnt
            }
            TriClearReg := True
          }
        }
        when(BodyCnt === io.PLength.asUInt) {
          goto(STxTail)
        }
      }
      onExit {
        TriCnt := 0
      }
    }
    val STxTail: State = new State() {
      whenIsActive {
        PTail(2) := TriCntBak.asBits
        PTail(3) := 1000
        when(io.Sink.ready === True && TailCnt < 32) {
          io.Sink.valid := True
          io.Sink.payload := PTail(TailCnt.resize(5))
          TailCnt := TailCnt + 1
        }
        when(TailCnt === 32) {
          goto(SDone)
        }
      }
      onExit {
        TriCntBak := 0
      }
    }
    val SDone: State = new State() {
      whenIsActive {
        goto(SIdle)
      }
    }
  }

}


object iiCtrlTop extends App {
  SpinalVerilog(new TriBigPack())
}


