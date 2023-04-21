import spinal.lib.bus.wishbone
import spinal.core._
import spinal.lib.blackbox.xilinx.s7.IOBUF
import spinal.lib._
import spinal.lib.blackbox.xilinx.s7.IBUFG
import spinal.lib.fsm._
import spinal.lib.bus.wishbone.{Wishbone, WishboneConfig}
import spinal.lib.com.spi.WishboneSpiMasterCtrl
import spinal.lib.{master, slave}

import javax.management.ValueExp

case class MIOBUFIO() extends Bundle {
  val MISO = in Bool()
  val MOT = out Bool()
  val MOSI = out Bool()
  val IO = inout(Analog(Bool()))
}

case class MCASPIO() extends Bundle with IMasterSlave {
  val Clk = Bool()
  val Fx = Bool()
  val Data = Bits(4 bits)

  override def asMaster(): Unit = {
    out(Clk, Fx, Data)
  }
}

case class SPIFLASHIO() extends Bundle with IMasterSlave {
  val Sck = Bool()
  val Cs = Bool()
  val MOSI = Bool()
  val MISO = Bool()

  override def asMaster(): Unit = {
    out(Sck, Cs, MOSI)
    in(MISO)
  }
}

case class SLOTCSIO() extends Bundle with IMasterSlave {
  val CS = Bool()

  override def asMaster(): Unit = {
    out(CS)
  }
}

case class UARTIO() extends Bundle with IMasterSlave {
  val Tx = Bool()
  val Rx = Bool()

  override def asMaster(): Unit = {
    out(Tx)
    in(Rx)
  }
}

case class UARTMCUIO() extends Bundle {

  val MUart = Vec(master(new UARTIO()), 3)
  val SUart = Vec(slave(new UARTIO()), 3)

}

/**
 * 硬件每个SLOT 预留6根数据线
 *
 * 6根数据线为IO型
 *
 * 6根数据线复用为MCASP
 *
 * MorS决定为Master or Slave
 *
 * MCASP主控搜索板确定板卡类型
 *
 * DA ：主控Mcasp: Master 采集Mcasp: Slave AD相反
 * */
case class McaspGpio() extends Component {
  val io = new Bundle {
    val gpio = Vec(new MIOBUFIO(), 6)
    val MMcasp = master(new MCASPIO())
    val SMcasp = slave(new MCASPIO())
    val MorS = in Bool()
  }

  val gpioin = Vec(Bool(), 6)
  val gpioout = Vec(Bool(), 6)
  val gpioinout = Vec(Bool(), 6)

  io.gpio(0).MOSI := io.SMcasp.Clk
  io.gpio(1).MOSI := io.SMcasp.Fx
  io.gpio(2).MOSI := io.SMcasp.Data(0)
  io.gpio(3).MOSI := io.SMcasp.Data(1)
  io.gpio(4).MOSI := io.SMcasp.Data(2)
  io.gpio(5).MOSI := io.SMcasp.Data(3)

  io.MMcasp.Clk := io.gpio(0).MISO
  io.MMcasp.Fx := io.gpio(1).MISO
  io.MMcasp.Data(0) := io.gpio(2).MISO
  io.MMcasp.Data(1) := io.gpio(3).MISO
  io.MMcasp.Data(2) := io.gpio(4).MISO
  io.MMcasp.Data(3) := io.gpio(5).MISO

  //对所有input分组
  //  for (i <- 0 until (6)) {
  //    io.gpio(i).MOSI := gpioout(i)
  //  }
  //  for (i <- 0 until (6)) {
  //    gpioin(i) := io.gpio(i).MISO
  //  }
  for (i <- 0 until (6)) {
    io.gpio(i).MOT := io.MorS
  }


}

/**
 * 硬件每个SLOT 预留6根数据线
 *
 * 6根数据线为IO型
 *
 * 6根数据线复用为SPI烧录线
 *
 * MorS决定为Master or Slave
 *
 * 主控SPI: Master 采集SPI: Slave
 * */
case class SpiFlashGpio() extends Component {
  val io = new Bundle {
    val gpio = Vec(new MIOBUFIO(), 6)
    val MSpi = master(SPIFLASHIO())
    val SSpi = slave(SPIFLASHIO())
    val MorS = in Bool()
  }

  val gpioin = Vec(Bool(), 6)
  val gpioout = Vec(Bool(), 6)
  val gpioinout = Vec(Bool(), 6)

  gpioout(0) := io.SSpi.Sck
  gpioout(1) := io.SSpi.Cs
  gpioout(2) := io.SSpi.MOSI
  gpioout(3) := io.MSpi.MISO
  gpioout(4) := False
  gpioout(5) := False

  io.MSpi.Sck := gpioin(0)
  io.MSpi.Cs := gpioin(1)
  io.MSpi.MOSI := gpioin(2)
  io.SSpi.MISO := gpioin(3)

  //对所有input分组
  for (i <- 0 until (6)) {
    gpioin(i) := io.gpio(i).MISO
  }
  for (i <- 0 until (6)) {
    io.gpio(i).MOSI := gpioout(i)
  }
  for (i <- 0 until (3)) {
    io.gpio(i).MOT := io.MorS
  }
  for (i <- 3 until (6)) {
    io.gpio(i).MOT := !io.MorS
  }


}

/**
 * 硬件每个SLOT 预留6根数据线
 *
 * 6根数据线为IO型
 *
 * 6根数据线复用为Slot搜素
 *
 * MorS决定为Master or Slave
 *
 * 主控Slot: Master 采集slot: Slave
 * */
case class SlotGpio() extends Component {
  val io = new Bundle {
    val gpio = Vec(new MIOBUFIO(), 6)
    val MSlot = master(SLOTCSIO())
    val SSlot = slave(SLOTCSIO())
    val MorS = in Bool()
  }

  val gpioin = Vec(Bool(), 6)
  val gpioout = Vec(Bool(), 6)
  val gpioinout = Vec(Bool(), 6)

  //  gpioin.foreach(_ := False)
  //  gpioout.foreach(_ := False)
  gpioout(0) := False
  gpioout(1) := io.SSlot.CS
  gpioout(2) := False
  gpioout(3) := False
  gpioout(4) := False
  gpioout(5) := False

  io.MSlot.CS := gpioin(1)

  //对所有input分组
  for (i <- 0 until (6)) {
    gpioin(i) := io.gpio(i).MISO
  }
  for (i <- 0 until (6)) {
    io.gpio(i).MOSI := gpioout(i)
  }
  for (i <- 0 until (6)) {
    io.gpio(i).MOT := io.MorS
  }

}

/**
 * 硬件每个SLOT 预留6根数据线
 *
 * 6根数据线为IO型
 *
 * 6根数据线复用为3个Uart烧录单片机
 *
 * MorS决定为Master or Slave
 *
 * 主控Uart: Master 采集Uart: Slave
 * */
case class UartGpio() extends Component {
  val io = new Bundle {
    val gpio = Vec(new MIOBUFIO(), 6)
    val MUart = Vec(master(UARTIO()), 3)
    val SUart = Vec(slave(UARTIO()),3)
    val MorS = in Bool()
  }

  val gpioin = Vec(Bool(), 6)
  val gpioout = Vec(Bool(), 6)
  val gpioinout = Vec(Bool(), 6)


  gpioout(0) := io.MUart(0).Rx
  gpioout(1) := io.MUart(1).Rx
  gpioout(2) := io.MUart(2).Rx
  gpioout(3) := False
  gpioout(4) := False
  gpioout(5) := False

  io.MUart(0).Tx := gpioin(0)
  io.MUart(1).Tx := gpioin(1)
  io.MUart(2).Tx := gpioin(2)

  //对所有input分组
  for (i <- 0 until (6)) {
    gpioin(i) := io.gpio(i).MISO
  }
  for (i <- 0 until (6)) {
    io.gpio(i).MOSI := gpioout(i)
  }
  for (i <- 0 until (3)) {
    io.gpio(i).MOT := io.MorS
  }
  for (i <- 3 until (6)) {
    io.gpio(i).MOT := !io.MorS
  }

}


case class GpioMulti() extends Component {
  val io = new Bundle {
    val Gpio = Vec(Vec(inout(Analog(Bool())), 6), 12)
    val MMcasp = Vec(master(new MCASPIO()), 12)
    val SMcasp = Vec(slave(new MCASPIO()), 12)
    val MorS = in Vec(Bool(), 12)
  }

  val iSlot = Array.fill(12)(Array.fill(6)(new IOBUF()))

  val iSlotMcasp = Array.fill(12)(new McaspGpio())
//  val iSlotSpi = Array.fill(12)(new SpiFlashGpio())
  //  val SlotCs = Array.fill(12)(new SlotGpio())
  //  val slotUart = Array.fill(12)(new UartGpio())


  for (j <- 0 until (12)) {

    for (i <- 0 until (6)) {
      io.Gpio(j)(i) <> iSlot(j)(i).IO
      iSlot(j)(i).IO <> iSlotMcasp(j).io.gpio(i).IO
      iSlot(j)(i).O <> iSlotMcasp(j).io.gpio(i).MISO
      iSlot(j)(i).I <> iSlotMcasp(j).io.gpio(i).MOSI
      iSlot(j)(i).T <> iSlotMcasp(j).io.gpio(i).MOT
    }

    io.MMcasp(j) <> iSlotMcasp(j).io.MMcasp
    io.SMcasp(j) <> iSlotMcasp(j).io.SMcasp
    io.MorS(j) <> iSlotMcasp(j).io.MorS

  }
}


object ioMcaspTop extends App {
  SpinalVerilog(new McaspGpio())
}

object ioTop extends App {
  SpinalVerilog(GpioMulti())
}