import spinal.core.sim._

object TestArbiter999 {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new DoubleCore()).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)

      val Mclk = 100000000
      val FFS = 100
      val Fs = Mclk / FFS
      println(Fs)

      val SinHz1 = 1

      val Freq1 = Fs / SinHz1

      println(Freq1)

      val SinBuffer = List.tabulate(Freq1)(i => {
        val sinValue = Math.sin(128 * 2 * Math.PI * i / Freq1)
        sinValue * 12800
      })

      val source = List.concat(SinBuffer, SinBuffer, SinBuffer, SinBuffer)


      for (x <- source) {
        dut.io.AD1.payload #= (x/128).toLong
        dut.io.AD1.valid #= true

        dut.io.AD128.payload #= x.toLong + 1
        dut.io.AD128.valid #= true

        dut.clockDomain.waitSampling()
        dut.io.AD1.valid #= false
        dut.io.AD128.valid #= false

        for (i <- 0 until FFS) {
          dut.clockDomain.waitSampling()
        }
      }
      simSuccess()
    }
  }
}
