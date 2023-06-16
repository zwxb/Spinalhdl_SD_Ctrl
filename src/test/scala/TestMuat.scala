import spinal.core._
import spinal.core.SInt
import spinal.core.sim._
import scala.util.Random


object TestMuart {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new TestMuartTxRx()).doSim { dut =>

      dut.coreClockDomain.forkStimulus(10)

      dut.io.TxData.ready #= true
      dut.io.RxData.ready #= true

      dut.io.UartEn #= true

      for (i <- 0 until 20) {
        dut.coreClockDomain.waitSampling()
      }

      val pushThread = fork {

        dut.io.TxData.valid #= false

        for (x <- 0 until (10)) {
          dut.io.TxData.valid #= true
          dut.io.TxData.payload #= Random.nextInt(256)
          dut.coreClockDomain.waitSampling()
          dut.io.TxData.valid #= false
        }
        for (i <- 0 until 200000) {
          dut.coreClockDomain.waitSampling()
        }
        simSuccess()
      }
      pushThread.join()
    }
  }
}


object TestMuart2 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new TopMuartRx()).doSim { dut =>

      dut.Clk50M.forkStimulus(20*1000) //50M

//      dut.io.TxData.ready #= true
//      dut.io.RxData.ready #= true
//
//      dut.io.UartEn #= true

      for (i <- 0 until 20) {
        dut.Clk50M.waitSampling()
      }

      val pushThread = fork {

//        dut.io.TxData.valid #= false

        for (x <- 0 until (10)) {
//          dut.io.TxData.valid #= true
//          dut.io.TxData.payload #= Random.nextInt(256)
          dut.Clk50M.waitSampling()
//          dut.io.TxData.valid #= false
        }
        for (i <- 0 until 200000) {
          dut.Clk50M.waitSampling()
        }
        simSuccess()
      }
      pushThread.join()
    }
  }
}