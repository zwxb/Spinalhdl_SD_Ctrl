import spinal.lib.bus.wishbone
import spinal.core._
import spinal.lib._
import spinal.lib.fsm._
import spinal.lib.bus.wishbone.{Wishbone, WishboneConfig}
import spinal.lib.com.spi.WishboneSpiMasterCtrl
import spinal.lib.{master, slave}

case class SdCtlIface() extends Bundle {
  val wb_clk_i = in Bool()
  val wb_rst_i = in Bool()
  // WISHBONE slave
  val wb_dat_i = in Bits (32 bits)
  val wb_dat_o = out Bits (32 bits)
  val wb_adr_i = out Bits (8 bits)
  val wb_sel_i = in Bits (4 bits)
  val wb_we_i = in Bool()
  val wb_cyc_i = in Bool()
  val wb_stb_i = in Bool()
  val wb_ack_o = out Bool()
  // WISHBONE master
  val m_wb_dat_o = out Bits (32 bits)
  val m_wb_dat_i = out Bits (32 bits)
  val m_wb_adr_o = out Bits (32 bits)
  val m_wb_sel_o = out Bits (4 bits)
  val m_wb_we_o = out Bool()
  val m_wb_cyc_o = out Bool()
  val m_wb_stb_o = out Bool()
  val m_wb_ack_i = in Bool()
  val m_wb_cti_o = out Bits (3 bits)
  val m_wb_bte_o = out Bits (2 bits)
  //SD BUS
  val sd_cmd_dat_i = in Bool()
  val sd_cmd_out_o = out Bool()
  val sd_cmd_oe_o = out Bool()
  //card_detect,
  val sd_dat_dat_i = in Bits (4 bits)
  val sd_dat_out_o = out Bits (4 bits)
  val sd_dat_oe_o = out Bool()
  val sd_clk_o_pad = out Bool()
  val sd_clk_i_pad = in Bool()
  val int_cmd = out Bool()
  val int_data = out Bool()
}


class sdc_controller() extends BlackBox {
  val io = new Bundle {
    val SdIface = new SdCtlIface()
  }

  noIoPrefix()

  def ConnectSdInterface(iface: SdCtlIface): Unit = {
    iface <> io.SdIface
  }

  def renameIO(): Unit = {
    io.flatten.foreach(bt => {
      if (bt.getName().contains("SdIface")) bt.setName(bt.getName().replace("SdIface_", ""))
    })
  }
}

class SdTop() extends Component {

  val sd1 = new SdCtlIface()
  val sd2 = new SdCtlIface()
  val sd3 = new SdCtlIface()
  val sd4 = new SdCtlIface()

  val sdctrl1 = new sdc_controller()
  val sdctrl2 = new sdc_controller()
  val sdctrl3 = new sdc_controller()
  val sdctrl4 = new sdc_controller()

  noIoPrefix()

  sdctrl1.renameIO()
  sdctrl2.renameIO()
  sdctrl3.renameIO()
  sdctrl4.renameIO()

  sdctrl1.ConnectSdInterface(sd1)
  sdctrl2.ConnectSdInterface(sd2)
  sdctrl3.ConnectSdInterface(sd3)
  sdctrl4.ConnectSdInterface(sd4)
}


object Top {
  def main(args: Array[String]) {
    SpinalVerilog(new SdTop())
  }
}
