import spinal.lib.bus.wishbone
import spinal.core._
import spinal.lib.blackbox.xilinx.s7.IOBUF
import spinal.lib._
import spinal.lib.blackbox.xilinx.s7.IBUFG
import spinal.lib.fsm._
import spinal.lib.bus.wishbone.{Wishbone, WishboneConfig}
import spinal.lib.com.spi.WishboneSpiMasterCtrl
import spinal.lib.{master, slave}

case class IoBufIo() extends Bundle {
  val In = in Bool()
  val IEn = in Bool()
  val Out = out Bool()
  val InOut = inout(Analog(Bool()))
}


case class UserCfgIo(io: IoBufIo) extends Component {
  println("Use UserCfgIo")
  val GPIO1 = new IOBUF()

  def ioconnect(io: IoBufIo) = {
    println("Use apply")

    io.In <> GPIO1.I
    GPIO1.I := io.In
    GPIO1.T := io.IEn
    //    io.IEn <> GPIO1.T
    io.Out := GPIO1.O
    io.InOut := GPIO1.IO
  }

}

class allio() extends Component {
  val io = new Bundle {
    val rtio = IoBufIo()
  }

  val GPIO = UserCfgIo(io.rtio)
  GPIO.ioconnect(io.rtio)
}


//object Top {
//  def main(args: Array[String]) {
//    SpinalVerilog(new allio())
//  }
//}