
import spinal.lib.bus.wishbone
import spinal.core._
import spinal.lib._
import spinal.lib.fsm._
import spinal.lib.bus.wishbone.{Wishbone, WishboneConfig}
import spinal.lib.com.spi.WishboneSpiMasterCtrl
import spinal.lib.{master, slave}

/**
 * wishbone接口配置信息
 * */
object WishboneMasterCtrl {
  def getWishboneConfig = WishboneConfig(
    addressWidth = 32,
    dataWidth = 32,
    selWidth = 4
  )
}


case class WishboneSdioMasterCtrl() extends Component {
  val io = new Bundle {
    /**
     * 主wishbone接口
     * */
    val Mwb = master(Wishbone(WishboneMasterCtrl.getWishboneConfig))
    /**
     * 从wishbone接口
     * */
    val Swb = slave(Wishbone(WishboneMasterCtrl.getWishboneConfig))
    /** 状态指示寄存器 */
    val RSPReg = out Bits (32 bits)
    val RSPReg41 = out Bits (32 bits)
    val RSPReg2 = out Bits (32 bits)
    val RSPReg3 = out Bits (32 bits)
    val Rddata = out Bits (32 bits)
    /**
     * 中断指示
     * */
    val ISRCmd = in Bool()
    val ISRData = in Bool()
  }

  /**
   * SD控制流程过程中获取的各个流程状态寄存器
   * */
  val NormalIsrStatus = Reg(Bits(32 bits)) init (0)
  val CmdResponseRegA41 = Reg(Bits(32 bits)) init (0)
  val CmdResponseReg2 = Reg(Bits(32 bits)) init (0)
  val CmdResponseReg3 = Reg(Bits(32 bits)) init (0)
  val cmdResponseReg7 = Reg(Bits(32 bits)) init (0)
  val BdIsrStatus = Reg(Bits(32 bits)) init (0)
  val RSPCardStatus = Reg(Bits(4 bits)) init (0)
  val FBTXNum = Reg(Bits(4 bits)) init (0)
  val FBRxNum = Reg(Bits(4 bits)) init (0)
  val GetRdData = Reg(Bits(32 bits)) init (0)
  //  val TestSystemAddr = Reg(UInt(32 bits)) init(0)
  val TestBclkAddr = Reg(UInt(32 bits)) init (0)


  io.Mwb.clearAll()
  io.Swb.clearAll()

  /**
   * 读取SD卡回复的所有命令响应
   * */
  val CmdResponseReg = RegNextWhen(io.Mwb.DAT_MISO, io.Mwb.ACK & (!io.Mwb.WE))

  io.RSPReg := CmdResponseReg
  io.RSPReg2 := CmdResponseReg2
  io.RSPReg3 := CmdResponseReg3
  io.RSPReg41 := CmdResponseRegA41
  io.Rddata := GetRdData

  noIoPrefix()

  /**
   * 拼接位
   * */
  val LBits = B"16'x0000"

  /**
   * wishbone控制器寄存器表
   * */
  //控制器SD命令伴随参数寄存器
  val CoreArgument = 0x00
  //控制器SD命令设置寄存器
  val CoreCmd = 0x04
  //响应寄存器 bit31 - 0
  val Response0 = 0x08
  //响应寄存器 bit63 - 32
  val Response1 = 0x0C
  //响应寄存器 bit95 - 64
  val Response2 = 0x10
  //响应寄存器 bit119 - 96
  val Response3 = 0x14
  //控制器 数据超市设置寄存器
  val CoreDataTimeOut = 0x18
  //控制器 SD数据线位宽设置
  val CoreDataWidth = 0x1C
  //控制器 命令超时设置寄存器
  val CoreCmdTimeOut = 0x20
  //控制器 软件时钟分频寄存器
  val CoreClkDivider = 0x24
  //控制器 软件复位寄存器
  val CoreSoftWareRst = 0x28
  //控制器 命令响应和错误中断寄存器
  val CoreCmdIsrStatus = 0x34
  //控制器 命令和数据中断控制器使能寄存器
  val CoreCmdIsrEn = 0x38
  //控制器 数据中断状态寄存器
  val CoreDataISrStatus = 0x3C
  //控制器 数据中断使能寄存器
  val CoreDataIsrEn = 0x40
  //控制器 传输块大小 单位byte
  val CoreBlkSize = 0x44
  //控制器 传输块数目
  val CoreBlkCnt = 0x48
  //控制器 DMA开启传输地址
  val CoreDmaAddr = 0x60

  /**
   * core cmd setting reg寄存器中的sd的命令设置
   * 参见Lattice SD Flash Controller Using SD Bus P13
   * */
  //command setting register
  val SDCmd0 = 0x0000
  val SDCmd2 = 0x0200
  val SDCmd3 = 0x0300
  val SDCmd8 = 0x0800
  val SDCmd7 = 0x0700
  val SDCmd9 = 0x0900
  val SDCmd12 = 0x0C00
  val SDCmd17 = 0x1100
  val SDCmd24 = 0x1800
  val SDCmd25 = 0x1900
  val SDCmd55 = 0x3700
  val SDACmd6 = 0x0600
  val SDACmd41 = 0x2900

  /**
   * Reg CoreCmd 0x04的配置参数
   * */
  val NoDataTransfer = 0x00
  val RdDataTransfer = 0x20
  val TxDataTransfer = 0x40
  val CICE = 0x10
  val CRCE = 0x08
  val RSP_48 = 0x01
  val RSP_136 = 0x02

  /**
   * 响应R2大于48bits 选择要读的word
   * */
  val RSP136WordNum0 = 0x00
  val RSP136WordNum1 = 0x40
  val RSP136WordNum2 = 0x80
  val RSP136WordNum3 = 0xC0

  val RSPCardStatusSTBY = 0x3
  val RSPCardStatusTRAN = 0x4

  /**
   * 测试自加基数参数
   * */
  val TestParamCnt = 0x55555555


  /**
   * wishbone 主 总线写时许
   * */
  def MasterWishBoneWr(WrAddr: UInt, WrData: UInt) {
    io.Mwb.WE := True
    io.Mwb.CYC := True
    io.Mwb.STB := True
    io.Mwb.SEL := 0xF
    io.Mwb.ADR := WrAddr.resize(32)
    io.Mwb.DAT_MOSI := WrData.asBits.resize(32)
  }

  /**
   * wishbone 主 总线写时许
   * */
  def ClearMasterWishBoneWr() {
    io.Mwb.WE := False
    io.Mwb.CYC := False
    io.Mwb.STB := False
    io.Mwb.SEL := 0x0
    io.Mwb.ADR := 0
    io.Mwb.DAT_MOSI := 0
  }


  /**
   * wishbone 主 总线读时许
   * */
  def MasterWishBoneRd(RdAddr: UInt) = {
    io.Mwb.WE := False
    io.Mwb.CYC := True
    io.Mwb.STB := True
    io.Mwb.SEL := 0xF
    io.Mwb.ADR := RdAddr.resize(32 bits)
  }


  /**
   * Wishbone控制器的控制实现SD卡的读写
   * 其中涉及SD卡工作电压匹配、容量查询、读写操作
   * */
  var fsm = new StateMachine {
    /**
     * SD控制状态机主流程
     * */
    val IDLE: State = new State with EntryPoint {

      whenIsActive(goto(SCoreRest))
    }
    /**
     * Winshbone控制器的控制流程
     * */
    //复位控制器
    val SCoreRest: State = new StateFsm(SSandCoreCmd(CoreSoftWareRst, 1)) {
      whenCompleted {
        goto(SCoreCmdTimeOut)
      }
    }
    //控制器设置 命令超时时间
    val SCoreCmdTimeOut: State = new StateFsm(SSandCoreCmd(CoreCmdTimeOut, 0x2FF)) {
      whenCompleted {
        goto(SCoredataTimeOut)
      }
    }
    //控制器设置 数据超时时间
    val SCoredataTimeOut: State = new StateFsm(SSandCoreCmd(CoreDataTimeOut, 0)) {
      whenCompleted(goto(SCoreClkDivider))
    }
    //控制器设置时钟分频
    val SCoreClkDivider: State = new StateFsm(SSandCoreCmd(CoreClkDivider, 0)) {
      whenCompleted {
        goto(SCoreStart)
      }
    }
    //启动控制器开始工作
    val SCoreStart: State = new StateFsm(SSandCoreCmd(CoreSoftWareRst, 0)) {
      whenCompleted {
        goto(SCoreCmdIsrEn)
      }
    }
    val SCoreCmdIsrEn: State = new StateFsm(SSandCoreCmd(CoreCmdIsrEn, 0x4F)) {
      whenCompleted {
        goto(SCoreDataIsrEn)
      }
    }
    val SCoreDataIsrEn: State = new StateFsm(SSandCoreCmd(CoreDataIsrEn, 0x4F)) {
      whenCompleted {
        goto(SCoreDataWithSet)
      }
    }
    val SCoreDataWithSet: State = new StateFsm(SSandCoreCmd(CoreDataWidth, 0x01)) {
      whenCompleted(goto(SSDCmd0))
    }

    //使能中断
    //    val SCoreNormIsr: State = new StateFsm(SSandCoreCmd(CoreNormalIsrEn, 0x8001)) {
    //      whenCompleted(goto(SSDCmd0))
    //    }
    /**
     * SD卡初始化和识别流程
     * */
    //发送SD的cmd0命令 将SD置于空闲状态
    val SSDCmd0: State = new StateFsm(SSandCmd(SDCmd0, 0, 0)) {
      whenCompleted {
        goto(SSDcmd8)
      }
    }
    //发送SD的cmd8命令 查看响应判断是否正确电压工作
    val SSDcmd8: State = new StateFsm(SSandCmd(SDCmd8, 0x1AA, 0)) {
      whenCompleted {
        goto(SSDcmd55)
      }
    }
    //发送SD的cmd55命令 启动Acmd前必须前置55
    val SSDcmd55: State = new StateFsm(SSandCmd(SDCmd55 | CICE | CRCE | RSP_48, 0, 0)) {
      whenCompleted {
        goto(SSDAcmd41)
      }
    }
    //发送Acmd41 SD卡初始化 并获取响应
    val SSDAcmd41: State = new StateFsm(SSandCmd(SDACmd41 | RSP_48, 0x40360000, 1)) {
      whenCompleted {
        CmdResponseRegA41 := CmdResponseReg
        goto(SSDAcmd41Done)
      }
    }
    //发送Acmd41后，确认初始化完成
    val SSDAcmd41Done: State = new State {
      whenIsActive {
        when(CmdResponseRegA41(31) === True) {
          goto(SSDCmd2)
        } otherwise {
          goto(SSDcmd55)
        }
      }
    }
    //发送Cmd2命令 并获取响应
    val SSDCmd2: State = new StateFsm(SSandCmd(SDCmd2 | CRCE | RSP_136, 0, 1)) {
      whenCompleted {
        CmdResponseReg2 := CmdResponseReg
        goto(SSDCmd3)
      }
    }
    //发送cmd3命令 获取SD当前寻址地址
    val SSDCmd3: State = new StateFsm(SSandCmd(SDCmd3 | CRCE | CICE | RSP_48, 0, 1)) {
      whenCompleted {
        //取高16bits
        CmdResponseReg3 := CmdResponseReg(31 downto 16) ## LBits
        RSPCardStatus := CmdResponseReg(12 downto 9)
        goto(SSDStby)

      }
    }
    val SSDStby: State = new State {
      whenIsActive {
        //判断当前SD卡状态 是否为STBY
        when(RSPCardStatus =/= RSPCardStatusSTBY) {
          goto(SSDCmd3)
        } otherwise {
          goto(SSDCmd9)
        }
      }
    }
    //发送cmd9命令 获取SD相关状态卡的块长度和卡容量
    val SSDCmd9: State = new StateFsm(SSandCmd(SDCmd9 | RSP_136, (CmdResponseReg3).asUInt, 1)) {
      whenCompleted {
        goto(SSDCmd7)
      }
    }
    /**
     * SD卡数据发送流程
     * */
    //发送cmd7命令 发送CMD7+RCA选中卡片, 发送CMD7+0不选中卡片，RCA是之前CMD3读取到的卡RCA
    val SSDCmd7: State = new StateFsm(SSandCmd(SDCmd7 | CRCE | CICE | RSP_48 | TxDataTransfer, (CmdResponseReg3).asUInt, 1)) {
      whenCompleted {
        RSPCardStatus := CmdResponseReg(12 downto 9)
        goto(SSDcmd55_2)
      }
    }
    val SSDcmd55_2: State = new StateFsm(SSandCmd(SDCmd55 | CICE | CRCE | RSP_48, (CmdResponseReg3).asUInt, 0)) {
      whenCompleted {
        goto(SSDACmd6)
      }
    }
    //设置发送数据位宽
    val SSDACmd6: State = new StateFsm(SSandCmd(SDACmd6 | CICE | CRCE | RSP_48, 2, 1)) {
      whenCompleted {
        goto(SCoreBlkSize)
      }
    }
    //    val SCoreCtrl: State = new StateFsm(SSandCoreCmd(CoreDataWidth, 1)) {
    //      whenCompleted(goto(SCoreRxTxBdNum))
    //    }
    //设置BD中传输blk 块数
    val SCoreBlkSize: State = new StateFsm(SSandCoreCmd(CoreBlkSize, 512)) {
      whenCompleted(goto(SCoreBlkNum))
    }
    val SCoreBlkNum: State = new StateFsm(SSandCoreCmd(CoreBlkCnt, 10)) {
      whenCompleted {
        goto(SCoreSandData)
      }
    }
    //分析BD数量
    //    val ScoreRxTxNum: State = new State {
    //      whenIsActive {
    //        when(GetRdData(7 downto 0).asUInt > 0) {
    //          goto(SCoreSandData)
    //        }
    //      }
    //    }
    //SD数据 读
    //    val SCoreGetData: State = new State {
    //
    //    }
    //SD数据 写
    val SCoreSandData: State = new StateFsm(SSDCmdDataTx(0, TestBclkAddr)) {
      whenCompleted {
        goto(SSDCmd7)
      }
    }
    //自测地址自增
    val SCoreAddrAdd: State = new State {
      whenIsActive {
        TestBclkAddr := TestBclkAddr + 1
        goto(SCoreBlkNum)
      }
    }

    /** 嵌套状态机 发送控制器寄存器状态机 */
    def SSandCoreCmd(addr: UInt, data: UInt) = new StateMachine {
      val SCoreCmdSand: State = new State with EntryPoint {
        whenIsActive {
          MasterWishBoneWr(addr, data)
          goto(SCoreWaitAck)
        }
      }
      val SCoreWaitAck: State = new State {
        whenIsActive {
          when(io.Mwb.ACK === True) {
            MasterWishBoneWr(addr, data)
            goto(SCoreClearWr)
          } otherwise {
            goto(SCoreCmdSand)
          }
        }
      }
      val SCoreClearWr: State = new State {
        whenIsActive {
          ClearMasterWishBoneWr()
          exit()
        }
      }
    }

    /** 嵌套状态机 查询控制器的状态 */
    def SGetCoreCmd(addr: UInt) = new StateMachine {
      val IDLE: State = new State with EntryPoint {
        whenIsActive {
          goto(SCoreNormalIsrRd)
        }
      }
      val SCoreNormalIsrRd: State = new State {
        whenIsActive {
          MasterWishBoneRd(addr)
          goto(SCoreRdAckWait1)
        }
      }
      //等待ACK的状态
      val SCoreRdAckWait1: State = new State {
        whenIsActive {
          when(io.Mwb.ACK === True) {
            MasterWishBoneRd(addr)
            goto(SCoreGetRdData)
          }
        }
      }
      val SCoreGetRdData: State = new State {
        whenIsActive {
          GetRdData := io.Mwb.DAT_MISO
          exit()
        }
      }
    }

    /** 嵌套状态机 命令发送和查看命令发送是否成功 */
    def SSandCmd(Dcmd: UInt, DArguMent: UInt, ReponseEn: UInt) = new StateMachine {
      //发送cmd命令
      val IDLE: State = new State with EntryPoint {
        whenIsActive {
          goto(SCoreCmd)
        }
      }
      //      val SCoreCmdIsrEn: State = new StateFsm(SSandCoreCmd(CoreNormalIsrEn, 0x0001)) {
      //        whenCompleted(goto(SCoreCmd))
      //      }
      val SCoreCmd: State = new StateFsm(SSandCoreCmd(CoreCmd, Dcmd)) {
        whenCompleted {
          goto(SCoreArguMent)
        }
      }
      //发送命令配置参数
      val SCoreArguMent: State = new StateFsm(SSandCoreCmd(CoreArgument, DArguMent)) {
        whenCompleted {
          goto(SCoreDelay)
        }
      }
      val SCoreDelay: State = new StateDelay(500) {
        whenCompleted {
          goto(SCoreNormalIsrRd)
        }
      }
      //      val SCoreWaitCmdIsr: State = new State {
      //        whenIsActive {
      //          when(io.ISRCmd === True) {
      //            goto(SCoreDelay)
      //          }
      //        }
      //      }
      //发送读取传输状态
      val SCoreNormalIsrRd: State = new State {
        whenIsActive {
          MasterWishBoneRd(CoreCmdIsrStatus)
          goto(SCoreRdAckWait1)
        }
      }
      //等待ACK的状态
      val SCoreRdAckWait1: State = new State {
        whenIsActive {
          when(io.Mwb.ACK === True) {
            MasterWishBoneRd(CoreCmdIsrStatus)
            goto(SCoreGetRdData)
          }
        }
      }
      val SCoreGetRdData: State = new State {
        whenIsActive {
          NormalIsrStatus := io.Mwb.DAT_MISO
          goto(SCoreGetRdData1)
        }
      }
      val SCoreGetRdData1: State = new State {
        whenIsActive {
          //          when(NormalIsrStatus(15) === True) {
          //            goto(SCoreCmd)
          //          } otherwise {
          when(NormalIsrStatus(0) === False) {
            goto(SCoreNormalIsrRd)
          }
          when((NormalIsrStatus(0) === True) && (ReponseEn === U(1).resize(32))) {
            goto(CmdPeponeseGet)
          }
          when((NormalIsrStatus(0) === True) && (ReponseEn === U(0).resize(32))) {
            exit()
          }
        }
        //        }
      }
      val CmdPeponeseGet: State = new State {
        whenIsActive {
          MasterWishBoneRd(Response0)
          goto(SCoreRdAckWait)
        }
      }
      val SCoreRdAckWait: State = new State {
        whenIsActive {
          when(io.Mwb.ACK === True) {
            MasterWishBoneRd(Response0)
            goto(SCoreRdFinish)
          }
        }
      }
      val SCoreRdFinish: State = new State {
        whenIsActive {
          exit()
        }
      }
    }

    /** 嵌套状态机 数据发送和查询是否发送完成 */
    def SSDCmdDataTx(sysaddr: UInt, blockaddr: UInt) = new StateMachine {

      val TxCnt = Reg(UInt(32 bits)) init (0)

      val IDLE: State = new State with EntryPoint {
        whenIsActive(goto(DmaAddr))
      }
      //使能数据中断状态
      //      val EnDataIER: State = new StateFsm(SSandCoreCmd(CoreDataIsrEn, 0x0001)) {
      //        whenCompleted(goto(DmaAddr))
      //      }
      val DmaAddr: State = new StateFsm(SSandCoreCmd(CoreDmaAddr, 0x0000)) {
        whenCompleted(goto(SSDCmd25))
      }
      val SSDCmd25: State = new StateFsm(SSandCmd(SDCmd25 | CICE | TxDataTransfer | CRCE | RSP_48, 0, 0)) {
        whenCompleted(goto(WrData))
      }
      //      //参考控制器手册 BD_TX 先写入SysAddr
      //      val WrSysaddr: State = new StateFsm(SSandCoreCmd(CoreBdTx, sysaddr)) {
      //        whenCompleted(goto(WrBlkaddr))
      //      }
      //      //参考控制器手册 BD_TX 先写入BlkAddr
      //      val WrBlkaddr: State = new StateFsm(SSandCoreCmd(CoreBdTx, blockaddr)) {
      //        whenCompleted(goto(WrData))
      //        onExit(
      //          TxCnt := 0
      //        )
      //      }
      //wishbone从接口 写入数据
      val WrData: State = new State {
        whenIsActive {
          when(io.Swb.WE === False && io.Swb.CYC === True && io.Swb.STB === True) {
            TxCnt := TxCnt + 1
            io.Swb.ACK := True
            io.Swb.DAT_MISO := TxCnt.asBits.resize(32)
          }
          when(TxCnt >= 512) {
            goto(BdIsr)
          } otherwise {
            goto(WrData)
          }
        }
        onExit {
          TxCnt := 0
        }
      }
      val WrDataDelay: State = new StateDelay(30) {
        whenCompleted(goto(WrData))
      }

      val BdIsr: State = new State {
        whenIsActive {
          MasterWishBoneRd(CoreDataISrStatus)
          goto(BdIsrGet)
        }
      }
      val BdIsrGet: State = new State {
        whenIsActive {
          when(io.Mwb.ACK === True) {
            MasterWishBoneRd(CoreDataISrStatus)
            goto(BdIsrCheck)
          }
        }
      }
      val BdIsrCheck: State = new State {
        whenIsActive {
          BdIsrStatus := io.Mwb.DAT_MISO
          when(BdIsrStatus(2) === False) {
            goto(BdIsr)
          }
          when((BdIsrStatus(2) === True)) {
            exit()
          }
        }
      }
    }

  }
}

/**
 * 主函数
 * */
object Top {
  def main(args: Array[String]) {
    SpinalVerilog(new WishboneSdioMasterCtrl())
  }
}