import spinal.core._
import spinal.lib._

case class FromDDrToCal() extends Component {
  val io = new Bundle {
    val Din = slave(Stream(Bits(16 bits)))
    val DOut = Vec(master(Flow(Bits(16 bits))), 8)
    val ChEn = in Bits (8 bits)
  }

  val FIFOJoin = Vec(Stream(Bits(16 bits)), 8)
  val RegChEn = io.ChEn.subdivideIn(1 bits)

  noIoPrefix()

  FIFOJoin <> StreamFork(io.Din, 8, true)

  for (i <- 0 until (8)) {
    FIFOJoin(i).throwWhen(RegChEn(i) === 0).toFlow >> io.DOut(i)
  }
}

object FromDDrToCalTop extends App {
  SpinalVerilog(new FromDDrToCal)
}


case class FromCalToMcasp() extends Component {
  val io = new Bundle {
    val Din = Vec(slave(Flow(Bits(16 bits))), 8)
    val Dout = master(Stream(Bits(32 bits)))
    val ChEn = in Bits(8 bits)
  }

  noIoPrefix()

  val FIFO = Vec(Stream(Bits(16 bits)), 8)

  for (i <- 0 until 8) {
    io.Din(i).toStream.queue(4) >> FIFO(i)
  }

  //重新构建sequentialOrder函数
  //重新构建的函数 加入FIFO的使能开关 关闭后的FIFO将不再进行仲裁
  //关闭后的顺序仍然按照FIFO定义后的顺序
  val arbiter = StreamArbiterFactory()
  arbiter.arbitrationLogic = core => {
    new Area {

      import core._

      val ValidMask = Bits(8 bits)

      val State = (Bool())

      ValidMask := FromCalToMcasp.this.io.ChEn.pull()

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

  StreamWidthAdapter(Stream0, io.Dout)

}

object FromCalToMcaspTop extends App {
  SpinalVerilog(new FromCalToMcasp())
}