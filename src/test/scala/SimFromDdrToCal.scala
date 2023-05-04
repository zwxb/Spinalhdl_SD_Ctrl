import spinal.core.sim._
import spinal.core.sim.{SimConfig, fork, simSuccess}

object SimFromDdrtoCal {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new FromDDrToCal()).doSim { dut =>

      dut.clockDomain.forkStimulus(10000)

      for (x <- 0 until (128)) {
        dut.clockDomain.waitSampling()
      }

      val PushThread = fork {
        var Ncnt: Int = 0
        dut.io.ChEn #= 7
        dut.io.Din.valid #= false

        for (x <- 0 until (512)) {

          dut.io.Din.valid #= true
          dut.io.Din.payload #= Ncnt
          dut.clockDomain.waitSampling()
          dut.io.Din.valid #= false

          for (i <- 0 until (12)) {
            dut.clockDomain.waitSampling()
          }
          Ncnt = Ncnt + 1
        }
        simSuccess()
      }
      PushThread.join()
    }
  }
}