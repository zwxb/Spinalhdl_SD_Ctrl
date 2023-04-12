import spinal.core._
import spinal.core.SInt
import spinal.core.sim._
import scala.util.Random

object TestArbiter12 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new SmallUnpack(8)).doSim { dut =>

      dut.clockDomain.forkStimulus(10000)

      for (j <- 0 until (8)) {
        for (i <- 0 until (4)) {
          dut.io.Sink(j)(i).ready #= true
        }
      }


      for (i <- 0 until 20) {
        dut.clockDomain.waitSampling()
      }

      val pushThread = fork {

        for (i <- 0 until (8)) {
          dut.io.Source(i).valid #= false
        }


        for (x <- 0 until (100)) {
          for (i <- 0 until (8)) {
            dut.io.Source(i).valid #= true
            dut.io.Source(i).payload #= BigInt("32348678111111112222222233333333444444445555555566666666777777778888888812345678", 16)
            dut.clockDomain.waitSampling()
            dut.io.Source(i).valid #= false
          }

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

object TestArbiter34 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new BigPack()).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      var Ncnt: Int = 0
      dut.io.Sink.ready #= true

      dut.io.PLength #= 512

      for (i <- 0 until 128) {
        dut.clockDomain.waitSampling()
      }

      val pushThread = fork {

        dut.io.Source.valid #= false

        for (x <- 0 until (2049)) {

          dut.io.Source.valid #= true
          dut.io.Source.payload #= Ncnt
          dut.clockDomain.waitSampling()
          dut.io.Source.valid #= false
          println("now is wait start!")
          for (i <- 0 until (128)) {
            dut.clockDomain.waitSampling()
          }
          println("now is wait end!")
          Ncnt = Ncnt + 1
          println(Ncnt)
        }
        simSuccess()
      }
      pushThread.join()
    }
  }
}

object TestArbiter56 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new SameFsArbiter(8)).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      var Ncnt: Int = 0

      for (i <- 0 until (8)) {
        dut.io.Soure(i).valid #= false
      }
      dut.io.Sink.ready #= true
      dut.io.SinkEn #= 6

      for (i <- 0 until 128) {
        dut.clockDomain.waitSampling()
      }

      val pushThread = fork {

        for (x <- 0 until (2049)) {
          for (i <- 0 until (8)) {
            dut.io.Soure(i).valid #= true
            dut.io.Soure(i).payload #= Ncnt
            dut.clockDomain.waitSampling()
            dut.io.Soure(i).valid #= false
            for (i <- 0 until (128)) {
              dut.clockDomain.waitSampling()
            }
            Ncnt = Ncnt + 1
          }
        }
        simSuccess()
      }
      pushThread.join()
    }
  }
}