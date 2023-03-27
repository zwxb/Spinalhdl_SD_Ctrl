
import spinal.core._
import spinal.core.SInt
import spinal.core.sim._


//def sinTable = (0 until 40).map(i => {
//  val sinValue = Math.sin(2 * Math.PI * i / 40)
//  S((sinValue * ((1 << 8) / 2 - 1)).toInt, 8 bits)
//})


object DutTests {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new SerilIIRV1(16)).doSim { dut =>
      dut.clockDomain.forkStimulus(10000)
      dut.io.input.valid #= false
      dut.io.input.payload #= 0
      dut.clockDomain.waitSampling()

      val Mclk = 100000000
      val FFS = 20
      val Fs = Mclk / FFS
      println(Fs)

      val SinHz1 = 200000
      val SinHz2 = 400000

      val Freq1 = Fs / SinHz1
      val freq2 = Fs / SinHz2


      println(Freq1)


      val SinBuffer1 = List.tabulate(Freq1)(i => {
        val sinValue = Math.sin(2 * Math.PI * i / Freq1)
        sinValue * 10
      })
      val SinBuffer2 = List.tabulate(freq2)(i => {
        val sinValue = Math.sin(2 * Math.PI * i / freq2)
        sinValue * 10
      })

      val SinBuffer3 = List.tabulate(Freq1)(i => {
        val sinValue = Math.sin(2 * 5 * Math.PI * i / Freq1)
        sinValue * 10
      })

      val source = List.concat(SinBuffer1, SinBuffer2, SinBuffer3,SinBuffer3)

      println(source)


      for (x <- source) {
        dut.io.input.payload #= x.toLong
        dut.io.input.valid #= true
        dut.clockDomain.waitSampling()
        dut.io.input.valid #= false
        for (i <- 0 until FFS) {
          dut.clockDomain.waitSampling()
        }
      }
      simSuccess()
    }
  }
}