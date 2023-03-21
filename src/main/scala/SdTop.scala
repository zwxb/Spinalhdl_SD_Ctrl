
import spinal.lib.bus.wishbone
import spinal.core._
import spinal.lib._
import spinal.lib.fsm._
import spinal.lib.bus.wishbone.{Wishbone, WishboneConfig}
import spinal.lib.com.spi.WishboneSpiMasterCtrl
import spinal.lib.{master, slave}

//class SD_Top() extends Component {
//
//  val sdctl1 = new sdc_controller()
//
//  val wishbonesdctl1 = new WishboneSdioMasterCtrl()
//
//  noIoPrefix()
//
//  sdctl1.renameIO()
//
//  wishbonesdctl1.ConnectSdCtrl(sdctl1.io.SdIface)
//
//}

//object Top {
//  def main(args: Array[String]) {
//    SpinalVerilog(new SD_Top())
//  }
//}
