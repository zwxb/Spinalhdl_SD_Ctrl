
import spinal.core._
import spinal.core.SInt
import spinal.core.sim._
import scala.util.Random

object TestTT {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new ADPackArbiter(3)).doSim { dut =>

      dut.coreClockDomain.forkStimulus(20 * 1000)

      for (i <- 0 until (3)) {
        dut.io.PVaildNum(i) #= 0
        dut.io.PType(i) #= 0
        dut.io.P16Or32Bits(i) #= 0
        dut.io.PExtPhase(i) #= 0
        dut.io.PExtTriCnt(i) #= 0
        dut.io.PExtTrigger(i) #= 0.toBoolean
      }
      for (i <- 0 until 1) {
        dut.coreClockDomain.waitSampling()
      }

      dut.io.PVaildNum(0) #= 0
      dut.io.PVaildNum(1) #= 1
      dut.io.PVaildNum(2) #= 2

      dut.io.PType(0) #= 0
      dut.io.PType(1) #= 1
      dut.io.PType(2) #= 2

      dut.io.PExtPhase(0) #= 0
      dut.io.PExtPhase(1) #= 1
      dut.io.PExtPhase(2) #= 2

      dut.io.PExtTriCnt(0) #= 0
      dut.io.PExtTriCnt(1) #= 1
      dut.io.PExtTriCnt(2) #= 2

      dut.io.PExtTrigger(0) #= 0.toBoolean
      dut.io.PExtTrigger(1) #= 1.toBoolean
      dut.io.PExtTrigger(2) #= 0.toBoolean


      for (i <- 0 until (10000000)) {
        dut.coreClockDomain.waitSampling()
      }

      simSuccess()
    }
  }
}

object TestArbiter {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new DiffFsArbiter(4)).doSim { dut =>

      dut.clockDomain.forkStimulus(10000)

      dut.io.Sink.ready #= true

      for (i <- 0 until 20) {
        dut.clockDomain.waitSampling()
      }

      val pushThread = fork {

        for (i <- 0 until (4)) {
          dut.io.source(i).valid #= false
        }

        for (x <- 0 until (100)) {
          for (i <- 0 until (4)) {
            dut.io.source(i).valid #= true
            dut.io.source(i).payload #= x
            dut.clockDomain.waitSampling()
            dut.io.source(i).valid #= false
            //            if(dut.io.source(i).valid.toBoolean && dut.io.source(i).ready.toBoolean) {
            //
            //            }
            for (i <- 0 until (16)) {
              dut.clockDomain.waitSampling()
            }
          }
        }
        simSuccess()
      }
      pushThread.join()
    }
  }
}