import spinal.core._
import spinal.lib._
import spinal.core.sim.{SimConfig, fork, simSuccess}
import spinal.lib._
import spinal.lib.fsm._

case class DoubleCore() extends Component {
  val io = new Bundle {
    val AD1 = slave(Flow(SInt(24 bits)))
    val AD128 = slave(Flow(SInt(24 bits)))
    val ADOut = master(Flow(SInt(24 bits)))
  }

  noIoPrefix()

  val Flag = Reg(Bool()) init (False)
  val FlagCnt = Counter(2049, inc = (Flag === True))
  val DevAD128 = Reg(SInt(24 bits)) init (0)
  val AD128Error = Reg(SInt(24 bits)) init (0)
//  val AD128Out = Reg(SInt(24 bits)) init (0)


  when(io.AD128.valid === True) {
    DevAD128 := (io.AD128.payload >> 7).resize(24)
    AD128Error := io.AD128.payload - DevAD128
    when(DevAD128 >= 50 || DevAD128 <= -50) {
      Flag := True
      FlagCnt.clear()
    }
  }
  when(FlagCnt.value === 2047) {
    Flag := False
  }
  when(Flag === True) {
    io.ADOut <> io.AD1
  } otherwise {
    io.ADOut.valid := io.AD128.valid
    io.ADOut.payload := DevAD128 + AD128Error
  }

}

object DoubleCoreTop extends App {
  SpinalVerilog(new DoubleCore())
}

