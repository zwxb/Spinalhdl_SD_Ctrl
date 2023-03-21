
import spinal.core._
import spinal.core.SInt
import spinal.core.sim._


//def sinTable = (0 until 40).map(i => {
//  val sinValue = Math.sin(2 * Math.PI * i / 40)
//  S((sinValue * ((1 << 8) / 2 - 1)).toInt, 8 bits)
//})


object DutTests {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new IIR(16)).doSim { dut =>
      dut.clockDomain.forkStimulus(10)
      dut.io.input.valid #= false
      dut.io.input.payload #= 0
      dut.clockDomain.waitSampling()

      val Freq = 400


      val SinBuffer1 = List.tabulate(Freq)(i => {
        val sinValue = Math.sin(2 * Math.PI * i / Freq)
        sinValue * 100
      })
      val SinBuffer2 = List.tabulate(Freq)(i => {
        val sinValue = Math.sin(20 * Math.PI * i / Freq)
        sinValue * 100
      })

      val SinBuffer3 = List.tabulate(Freq)(i => {
        val sinValue = Math.sin(20 * Math.PI * i / Freq) + Math.sin(50 * Math.PI * i / Freq) + Math.sin(60 * Math.PI * i / Freq)
        sinValue * 100
      })

      val source = List.concat(SinBuffer1, SinBuffer1, SinBuffer2, SinBuffer2, SinBuffer2, SinBuffer3, SinBuffer3, SinBuffer3)

      println(source)


      for (x <- source) {
        dut.io.input.payload #= x.toLong
        println(x.toLong)
        dut.io.input.valid #= true
        dut.clockDomain.waitSampling()
      }
      simSuccess()
    }
  }
}