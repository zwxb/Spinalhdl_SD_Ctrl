
import spinal.core._
import spinal.core.SInt
import spinal.core.sim._
import scala.util.Random

//object TestADPackArbiter {
//  def main(args: Array[String]): Unit = {
//    SimConfig.withWave.compile(new ADPackArbiter()).doSim { dut =>
//      dut.clockDomain.forkStimulus(10000)
//
//      //val Cnt = Vec(UInt(32 bits), 4)
//      val Cnt = new Array[Int](4)
//
//
//      for (i <- 0 until 4) {
//        dut.io.source(i).valid #= false
//        dut.io.source(i).payload #= 0
//      }
//
//      for (i <- 0 until (4)) {
//        Cnt(i) = 1
//      }
//
//      for (i <- 0 until (4)) {
//        dut.io.PVaildNum(i) #= 0
//        dut.io.PType(i) #= 0
//        dut.io.P16Or32Bits(i) #= 0
//        dut.io.PExtPhase(i) #= 0
//        dut.io.PExtTriCnt(i) #= 0
//        dut.io.PExtTrigger(i) #= 0.toBoolean
//      }
//      for (i <- 0 until 1) {
//        dut.clockDomain.waitSampling()
//      }
//
//      dut.io.PVaildNum(0) #= 0
//      dut.io.PVaildNum(1) #= 1
//      dut.io.PVaildNum(2) #= 2
//      dut.io.PVaildNum(3) #= 3
//
//      dut.io.PType(0) #= 0
//      dut.io.PType(1) #= 1
//      dut.io.PType(2) #= 2
//      dut.io.PType(3) #= 3
//
//      dut.io.PExtPhase(0) #= 0
//      dut.io.PExtPhase(1) #= 1
//      dut.io.PExtPhase(2) #= 2
//      dut.io.PExtPhase(3) #= 3
//
//      dut.io.PExtTriCnt(0) #= 0
//      dut.io.PExtTriCnt(1) #= 1
//      dut.io.PExtTriCnt(2) #= 2
//      dut.io.PExtTriCnt(3) #= 3
//
//      dut.io.PExtTrigger(0) #= 0.toBoolean
//      dut.io.PExtTrigger(1) #= 1.toBoolean
//      dut.io.PExtTrigger(2) #= 0.toBoolean
//      dut.io.PExtTrigger(3) #= 0.toBoolean
//
//
//      dut.clockDomain.waitSampling()
//
//
//      for (x <- 0 until (100)) {
//        for (i <- 0 until (4)) {
//          dut.io.source(i).valid #= true
//          dut.io.source(i).payload #= x
//          dut.clockDomain.waitSampling()
//          dut.io.source(i).valid #= false
//          for (i <- 0 until (16)) {
//            dut.clockDomain.waitSampling()
//          }
//        }
//      }
//      simSuccess()
//
//    }
//  }
//}

object TestArbiter {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new DiffFsArbiter()).doSim { dut =>

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