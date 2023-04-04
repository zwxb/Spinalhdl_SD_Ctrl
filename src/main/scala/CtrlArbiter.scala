import spinal.core._
import spinal.lib._

case class UnpackSmall() extends Component {
  val io = new Bundle {

    val Soure = slave(Stream(Bits(320 bits)))

    val Sink = master(Stream(Bits(32 bits)))

  }

  noIoPrefix()

  val PVaildNum = Bits(6 bits)
  val PType = Bits(4 bits)
  val FIF0 = Stream(Bits(32 bits))
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

  FIF0.queue(4).throwWhen(PCnt > PVaildNum.asUInt) >> io.Sink

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
    val PTrigger = in Bits (4 bits)
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