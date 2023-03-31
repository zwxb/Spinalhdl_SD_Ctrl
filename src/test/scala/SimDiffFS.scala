
import spinal.core._
import spinal.core.SInt
import spinal.core.sim._

import scala.util.Random


//def sinTable = (0 until 40).map(i => {
//  val sinValue = Math.sin(2 * Math.PI * i / 40)
//  S((sinValue * ((1 << 8) / 2 - 1)).toInt, 8 bits)
//})


object ADDiffTests {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new ADPackArbiter()).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      //val Cnt = Vec(UInt(32 bits), 4)
      val Cnt = new Array[Int](4)

      for(i<-0 until(4)){
        Cnt(i) = 1
      }

      for (i <- 0 until (4)) {
        dut.io.PVaildNum(i) #= 0
        dut.io.PType(i) #= 0
        dut.io.P16Or32Bits(i) #= 0
        dut.io.PExtPhase(i) #= 0
        dut.io.PExtTriCnt(i) #= 0
        dut.io.PExtTrigger(i) #= 0.toBoolean
      }
      for (i <- 0 until 5) {
        dut.clockDomain.waitSampling()
      }
      dut.io.PVaildNum(0) #= 0
      dut.io.PVaildNum(1) #= 1
      dut.io.PVaildNum(2) #= 2
      dut.io.PVaildNum(3) #= 3

      dut.io.PType(0) #= 0
      dut.io.PType(1) #= 1
      dut.io.PType(2) #= 2
      dut.io.PType(3) #= 3

      dut.io.PExtPhase(0) #= 0
      dut.io.PExtPhase(1) #= 1
      dut.io.PExtPhase(2) #= 2
      dut.io.PExtPhase(3) #= 3

      dut.io.PExtTriCnt(0) #= 0
      dut.io.PExtTriCnt(1) #= 1
      dut.io.PExtTriCnt(2) #= 2
      dut.io.PExtTriCnt(3) #= 3

      dut.io.PExtTrigger(0) #= 0.toBoolean
      dut.io.PExtTrigger(1) #= 1.toBoolean
      dut.io.PExtTrigger(2) #= 0.toBoolean
      dut.io.PExtTrigger(3) #= 0.toBoolean


      for (i <- 0 until 4) {
        dut.io.source(i).valid #= false
        dut.io.source(i).payload #= 0
      }
      dut.clockDomain.waitSampling()

      for (x <- 0 until (100)) {
        for (i <- 0 until (4)) {
          dut.io.source(i).valid #= Random.nextBoolean()
          if(dut.io.source(i).valid.toBoolean == true){
            Cnt(i) = Cnt(i) + 1
          }
          dut.io.source(i).payload #= Cnt(i)
        }
        dut.clockDomain.waitSampling()
      }
      simSuccess()
    }
  }
}