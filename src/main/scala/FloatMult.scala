import spinal.lib.experimental.math._
import spinal.lib.experimental.math.Floating
import spinal.lib._
import spinal.core._
import spinal.lib.{master, slave}

case class FloatMult() extends Component {
  val io = new Bundle {
    val a = slave(Flow(Floating32()))
    val b = slave(Flow(Floating32()))
    val c = master(Flow(Floating32()))
  }

  noIoPrefix()

  io.c.valid := False
  io.c.payload := 0

  when(io.a.valid === True && io.b.valid === True) {

    io.c.valid := True
    io.c.payload := io.a.payload
  }


}

object FloatMultTop extends App {
  SpinalVerilog(new FloatMult())
}