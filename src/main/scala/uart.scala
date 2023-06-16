import spinal.core._
import spinal.core.sim.{SimConfig, fork, simSuccess}
import spinal.lib._
import spinal.lib.fsm._
import spinal.lib.com.uart._


case class MuartTx() extends Component {

  val io = new Bundle {
    val UartClock = in Bool()
    val UartReset = in Bool()
    val TxData = slave(Stream(Bits(8 bits)))
    val RxData = master(Stream(Bits(8 bits)))
    val UartEn = in Bool()
    val UartIo = master(Uart())
  }

  val uartBaudrate = 115200 Hz

  val coreClockDomain = ClockDomain(io.UartClock, io.UartReset, frequency = FixedFrequency(100 MHz))

  val UartClkArea = new ClockingArea(coreClockDomain) {
    val iUartCtrl = new UartCtrl()
    iUartCtrl.io.config.setClockDivider(uartBaudrate)
    println(iUartCtrl.clockDivider)
    iUartCtrl.io.config.frame.dataLength := 7
    iUartCtrl.io.config.frame.parity := UartParityType.NONE
    iUartCtrl.io.config.frame.stop := UartStopType.ONE
    iUartCtrl.io.uart <> io.UartIo

    io.TxData.queue(1024) >> iUartCtrl.io.write
    io.RxData << iUartCtrl.io.read.queue(16)
    iUartCtrl.io.writeBreak := False

  }
}


case class MuartRx() extends Component {

  val io = new Bundle {
    val UartClock = in Bool()
    val UartReset = in Bool()
    val UartIo = master(Uart())
  }

  noIoPrefix()

  val uartBaudrate = 115200 Hz

  val coreClockDomain = ClockDomain(io.UartClock, io.UartReset, frequency = FixedFrequency(100 MHz))

  val UartClkArea = new ClockingArea(coreClockDomain) {

    val RxFifo = new StreamFifo(dataType = Bits(8 bits), 16)

    val iUartCtrl = new UartCtrl()

    iUartCtrl.io.config.setClockDivider(uartBaudrate)
    println(iUartCtrl.clockDivider)
    iUartCtrl.io.config.frame.dataLength := 7
    iUartCtrl.io.config.frame.parity := UartParityType.NONE
    iUartCtrl.io.config.frame.stop := UartStopType.ONE
    iUartCtrl.io.uart <> io.UartIo
    iUartCtrl.io.writeBreak := False

    RxFifo.io.push << iUartCtrl.io.read
    RxFifo.io.pop >> iUartCtrl.io.write


  }
}

case class TopMuartRx() extends Component {
  val io = new Bundle {
    val Clk50M = in Bool()
    val Clk50MRst = in Bool()
    val UartClk = in Bool()
    val UartIo = master(Uart())
  }

  noIoPrefix()

  val iMuartRx = new MuartRx()

  val Clk50M = ClockDomain(io.Clk50M, io.Clk50MRst,frequency = FixedFrequency(50 MHz))

  val clk50MArea = new ClockingArea(Clk50M) {
    val UartRest = Reg(Bool())
    val RstTimeOut = Timeout(1 ms)

    when(RstTimeOut){
      UartRest := False
    }otherwise{
      UartRest := True
    }
  }

  iMuartRx.io.UartReset := clk50MArea.UartRest
  iMuartRx.io.UartClock <> io.UartClk
  iMuartRx.io.UartIo <> io.UartIo


}

object TopMuartRx1 extends App {
  SpinalVerilog(new TopMuartRx())
}



case class TestMuartTxRx() extends Component {

  val io = new Bundle {
    val UartClock = in Bool()
    val UartReset = in Bool()
    val TxData = slave(Stream(Bits(8 bits)))
    val RxData = master(Stream(Bits(8 bits)))
    val UartEn = in Bool()
    val Tx = out Bool()
    val Rx = in Bool()
  }

  val iMUartTx = new MuartTx()
  val iMUartRx = new MuartRx()

  val coreClockDomain = ClockDomain(io.UartClock, io.UartReset)

  iMUartTx.io.UartClock <> io.UartClock
  iMUartTx.io.UartReset <> io.UartReset
  iMUartRx.io.UartClock <> io.UartClock
  iMUartRx.io.UartReset <> io.UartReset


  iMUartTx.io.TxData <> io.TxData
  iMUartTx.io.RxData <> io.RxData
  iMUartTx.io.UartEn <> io.UartEn

  iMUartRx.io.UartIo.rxd := iMUartTx.io.UartIo.txd

  io.Tx <> iMUartRx.io.UartIo.txd
  io.Rx <> iMUartTx.io.UartIo.rxd

}


object uartCtrlTop extends App {
  SpinalVerilog(new MuartRx())
}


