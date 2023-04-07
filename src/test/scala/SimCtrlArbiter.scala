import spinal.core._
import spinal.core.SInt
import spinal.core.sim._
import scala.util.Random

object TestArbiter12 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new UnpackSmall2()).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      for(i<-0 until(4)){
        dut.io.Sink(i).ready #= true
      }


      for (i <- 0 until 20) {
        dut.clockDomain.waitSampling()
      }

      val pushThread = fork {

        dut.io.Source.valid #= false

        for (x <- 0 until (100)) {

          dut.io.Source.valid #= true
          dut.io.Source.payload #= BigInt("12346678111111112222222233333333444444445555555566666666777777778888888812345678",16)
//            println(Math.pow(2, 316), Math.pow(2, 298))
            dut.clockDomain.waitSampling()
          dut.io.Source.valid #= false

          for (i <- 0 until (40)) {
            dut.clockDomain.waitSampling()
          }
        }
        simSuccess()
      }
      pushThread.join()
    }
  }
}