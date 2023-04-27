import spinal.core.sim._
import spinal.core.sim.{SimConfig, fork, simSuccess}

object TestArbiter134 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new TriBigPack()).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      var Ncnt: Int = 0
      dut.io.ChEN #= 7
      dut.io.Sink.ready #= true
      dut.io.PTrigger #= false
      dut.io.PLength #= 512
      dut.io.B16Or32 #= true
      dut.io.Start #= true


      for (i <- 0 until 128) {
        dut.clockDomain.waitSampling()
      }

      val pushThread = fork {

        dut.io.Source.valid #= false

        for (x <- 0 until (2049)) {

          dut.io.Source.valid #= true
          dut.io.Source.payload #= Ncnt

          if (Ncnt == 100) {
            dut.io.PTrigger #= true
          }
          if (Ncnt == 300) {
            dut.io.PTrigger #= false
          }
          if (Ncnt == 800) {
            dut.io.PTrigger #= true
          }
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


object TestArbiter567 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new TriggerCheck()).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      var Ncnt: Int = 0
      dut.io.Exttiger #= true
      dut.io.ExtType #= 0
      dut.io.Start #= true

      for (i <- 0 until 128) {
        dut.clockDomain.waitSampling()
      }
      val pushThread = fork {

        for (x <- 0 until (2049)) {
          if (Ncnt == 100) {
            dut.io.Exttiger #= false
          }
          if (Ncnt == 500) {
            dut.io.Exttiger #= true
          }
          if (Ncnt == 1000) {
            dut.io.ClearExt #= true
          }
          if (Ncnt == 1010) {
            dut.io.ClearExt #= false
          }
          dut.clockDomain.waitSampling()
          for (i <- 0 until (128)) {
            dut.clockDomain.waitSampling()
          }
          Ncnt = Ncnt + 1
          println(Ncnt)
        }
        simSuccess()
      }
      pushThread.join()
    }
  }
}


object TestArbiter789 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new TriggerPack()).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      var Ncnt: Int = 0
      dut.io.ChEN #= 7
      dut.io.Sink.ready #= true
      dut.io.Exttiger #= true
      dut.io.ExtType #= 0
      dut.io.PLength #= 512
      dut.io.B16Or32 #= true
      dut.io.Start #= true



      for (i <- 0 until 128) {
        dut.clockDomain.waitSampling()
      }

      val pushThread = fork {

        dut.io.Source.valid #= false

        for (x <- 0 until (2049)) {

          dut.io.Source.valid #= true
          dut.io.Source.payload #= Ncnt

          if (Ncnt == 100) {
            dut.io.Exttiger #= false
          }
          if (Ncnt == 300) {
            dut.io.Exttiger #= true
          }
          if (Ncnt == 800) {
            dut.io.Exttiger #= false
          }
          if(Ncnt == 1200){
            dut.io.Exttiger #= true
          }
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