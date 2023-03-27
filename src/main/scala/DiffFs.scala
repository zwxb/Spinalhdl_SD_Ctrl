import spinal.core._
import spinal.lib._

class DiffFs() extends Component {
  val io = new Bundle {

    val source = Vec(slave(Stream(Bits(32 bits))), 4)

    val sink = master(Stream(Bits(320 bits)))
    val FsCh = in Vec(Bits(32 bits), 4)
  }

  val FiFO = Vec(Stream(Bits(32 bits)), 4)
  val Package8_Stream = Vec(master(Stream(Bits(256 bits))), 4)
  val package10_Stream = Vec(slave(Stream(Bits(320 bits))), 4)
  val PackageHead = Vec(Bits(32 bits), 4)
  val packageTail = Vec(Bits(32 bits), 4)
  val splicing = Vec(Bits(320 bits), 4)


  /** 不同速率缓冲不同FIFO 最高支持4种不同采样率 */
  for (i <- 0 until 4) {
    io.source(i).queue(16) >> FiFO(i)
  }

  /** 8个数据拼接1包发送 */
  for (i <- 0 until 4) {
    StreamWidthAdapter(FiFO(i), Package8_Stream(i))
  }

  /** 打包数据加入头和尾 */
  for (i <- 0 until 4) {
    splicing(i) := PackageHead(i) ## Package8_Stream(i).payload ## packageTail(i)
  }

  for (i <- 0 until 4) {
    when(Package8_Stream(i).valid && package10_Stream(i).ready) {
      package10_Stream(i).valid := True
      package10_Stream(i).payload := splicing(i)
    }
  }


  val Stream0 = StreamArbiterFactory.roundRobin.onArgs(package10_Stream(3), package10_Stream(2), package10_Stream(1), package10_Stream(0))

  Stream0 >> io.sink

}

object DiffFsTop extends App {
  SpinalVerilog(new DiffFs())
}