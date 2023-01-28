//import spinal.lib.experimental.math._
//import spinal.lib.experimental.math.Floating
//import spinal.lib._
//import spinal.core._
//import spinal.lib.{master, slave}
//
//case class FloatMult() extends Component {
//  val io = new Bundle {
//    val a = slave(Flow(Bits(32 bits)))
//    val b = slave(Flow(Bits(32 bits)))
//    val c = master(Flow(UInt(64 bits)))
//  }
//
//  noIoPrefix()
//
//  val Fa = Reg(RecFloating32())
//  val Fb = Reg(RecFloating32())
//  val Fc = Reg(RecFloating32())
//
//
//  io.c.valid := False
//  io.c.payload := 0
//
//  when(Fa > Fb) {
//    io.c.valid := True
//  }
//
//
//  when(io.a.valid === True && io.b.valid === True) {
//
//    io.c.payload := io.a.payload.asUInt * io.b.payload.asUInt
//  }
//
//
//}
//
//object Top {
//  def main(args: Array[String]) {
//    SpinalVerilog(new FloatMult())
//  }
//}