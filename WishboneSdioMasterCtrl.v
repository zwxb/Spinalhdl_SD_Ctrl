// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : WishboneSdioMasterCtrl
// Git hash  : 5ec68e9a08fa954abe8e93d0aa9740277d16b445

`timescale 1ns/1ps

module WishboneSdioMasterCtrl (
  output              Mwb_CYC,
  output              Mwb_STB,
  input               Mwb_ACK,
  output              Mwb_WE,
  output     [31:0]   Mwb_ADR,
  input      [31:0]   Mwb_DAT_MISO,
  output     [31:0]   Mwb_DAT_MOSI,
  output     [3:0]    Mwb_SEL,
  input               Swb_CYC,
  input               Swb_STB,
  output reg          Swb_ACK,
  input               Swb_WE,
  input      [31:0]   Swb_ADR,
  output reg [31:0]   Swb_DAT_MISO,
  input      [31:0]   Swb_DAT_MOSI,
  input      [3:0]    Swb_SEL,
  input               SWrData_valid,
  output              SWrData_ready,
  input      [31:0]   SWrData_payload,
  output reg          MRdData_valid,
  input               MRdData_ready,
  output reg [31:0]   MRdData_payload,
  output     [31:0]   RSPReg,
  output     [31:0]   RSPReg41,
  output     [31:0]   RSPReg2,
  output     [31:0]   RSPReg3,
  output     [31:0]   Rddata,
  input               SDWrOrRd,
  input      [31:0]   SDWrOrRdBlkNum,
  input      [31:0]   SDWrOrRdAddr,
  output reg [31:0]   SDWrOrRdStatus,
  input               ISRCmd,
  input               ISRData,
  input               clk,
  input               reset
);
  localparam fsm_SCoreRest_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreRest_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreRest_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreRest_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreClkDivider_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreStart_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreStart_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreStart_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreStart_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd0_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDCmd0_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd8_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDcmd8_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDcmd55_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDAcmd41_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDAcmd41_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd2_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDCmd2_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd3_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDCmd3_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd9_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDCmd9_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd7_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDCmd7_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd16_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDCmd16_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_2_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDcmd55_2_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDACmd6_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SSDACmd6_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SCoreBlkSize_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreBlkNum_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_SCoreSandData_fsm_enumDef_BOOT = 3'd0;
  localparam fsm_SCoreSandData_fsm_enumDef_IDLE = 3'd1;
  localparam fsm_SCoreSandData_fsm_enumDef_DmaAddr = 3'd2;
  localparam fsm_SCoreSandData_fsm_enumDef_SSDCmd25 = 3'd3;
  localparam fsm_SCoreSandData_fsm_enumDef_WrData = 3'd4;
  localparam fsm_SCoreSandData_fsm_enumDef_CheckIsrDone = 3'd5;
  localparam fsm_SCoreSandData_fsm_enumDef_ClearIsrData = 3'd6;
  localparam fsm_SCoreSandData_fsm_enumDef_SSDCmd12 = 3'd7;
  localparam fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE = 2'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd = 4'd2;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent = 4'd3;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay = 4'd4;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr = 4'd5;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr = 4'd6;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd = 4'd7;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 = 4'd8;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData = 4'd9;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet = 4'd10;
  localparam fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish = 4'd11;
  localparam fsm_ScoreGetData_fsm_enumDef_BOOT = 3'd0;
  localparam fsm_ScoreGetData_fsm_enumDef_IDLE = 3'd1;
  localparam fsm_ScoreGetData_fsm_enumDef_DmaAddr = 3'd2;
  localparam fsm_ScoreGetData_fsm_enumDef_SSDCmd18 = 3'd3;
  localparam fsm_ScoreGetData_fsm_enumDef_RdData = 3'd4;
  localparam fsm_ScoreGetData_fsm_enumDef_CheckIsrDone = 3'd5;
  localparam fsm_ScoreGetData_fsm_enumDef_ClearIsrData = 3'd6;
  localparam fsm_ScoreGetData_fsm_enumDef_SSDCmd12 = 3'd7;
  localparam fsm_enumDef_BOOT = 5'd0;
  localparam fsm_enumDef_IDLE = 5'd1;
  localparam fsm_enumDef_SCoreRest = 5'd2;
  localparam fsm_enumDef_SCoreCmdTimeOut = 5'd3;
  localparam fsm_enumDef_SCoredataTimeOut = 5'd4;
  localparam fsm_enumDef_SCoreClkDivider = 5'd5;
  localparam fsm_enumDef_SCoreStart = 5'd6;
  localparam fsm_enumDef_SCoreCmdIsrEn = 5'd7;
  localparam fsm_enumDef_SCoreDataIsrEn = 5'd8;
  localparam fsm_enumDef_SCoreDataWithSet = 5'd9;
  localparam fsm_enumDef_SSDCmd0 = 5'd10;
  localparam fsm_enumDef_SSDcmd8 = 5'd11;
  localparam fsm_enumDef_SSDcmd55 = 5'd12;
  localparam fsm_enumDef_SSDAcmd41 = 5'd13;
  localparam fsm_enumDef_SSDAcmd41Done = 5'd14;
  localparam fsm_enumDef_SSDCmd2 = 5'd15;
  localparam fsm_enumDef_SSDCmd3 = 5'd16;
  localparam fsm_enumDef_SSDStby = 5'd17;
  localparam fsm_enumDef_SSDCmd9 = 5'd18;
  localparam fsm_enumDef_SSDWrOrRd = 5'd19;
  localparam fsm_enumDef_SSDCmd7 = 5'd20;
  localparam fsm_enumDef_SSDCmd16 = 5'd21;
  localparam fsm_enumDef_SSDcmd55_2 = 5'd22;
  localparam fsm_enumDef_SSDACmd6 = 5'd23;
  localparam fsm_enumDef_SCoreBlkSize = 5'd24;
  localparam fsm_enumDef_SCoreBlkNum = 5'd25;
  localparam fsm_enumDef_SCoreSandData = 5'd26;
  localparam fsm_enumDef_ScoreGetData = 5'd27;

  wire       [5:0]    _zz_addr1;
  wire       [0:0]    _zz_Mosi1;
  wire       [5:0]    _zz_addr2;
  wire       [4:0]    _zz_addr1_1;
  wire       [5:0]    _zz_addr2_1;
  wire       [5:0]    _zz_addr1_2;
  wire       [5:0]    _zz_addr2_2;
  wire       [4:0]    _zz_Mosi2;
  wire       [6:0]    _zz_addr1_3;
  wire       [4:0]    _zz_Mosi1_1;
  wire       [4:0]    _zz_addr2_3;
  wire       [0:0]    _zz_Mosi2_1;
  wire       [2:0]    _zz_addr1_4;
  wire       [5:0]    _zz_addr1_5;
  wire       [5:0]    _zz_addr2_4;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_6;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_7;
  wire       [5:0]    _zz_addr2_5;
  wire       [3:0]    _zz_addr2_6;
  wire       [2:0]    _zz_addr1_6;
  wire       [11:0]   _zz_Mosi1_2;
  wire       [8:0]    _zz_Mosi2_2;
  wire       [5:0]    _zz_addr1_7;
  wire       [5:0]    _zz_addr2_7;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_1_1;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_1_2;
  wire       [5:0]    _zz_addr2_8;
  wire       [3:0]    _zz_addr2_9;
  wire       [2:0]    _zz_addr1_8;
  wire       [13:0]   _zz_Mosi1_3;
  wire       [5:0]    _zz_addr1_9;
  wire       [5:0]    _zz_addr2_10;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_2_1;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_2_2;
  wire       [5:0]    _zz_addr2_11;
  wire       [3:0]    _zz_addr2_12;
  wire       [2:0]    _zz_addr1_10;
  wire       [13:0]   _zz_Mosi1_4;
  wire       [30:0]   _zz_Mosi2_3;
  wire       [5:0]    _zz_addr1_11;
  wire       [5:0]    _zz_addr2_13;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_3_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_3_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_3_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l692_3;
  wire       [5:0]    _zz_addr2_14;
  wire       [3:0]    _zz_addr2_15;
  wire       [2:0]    _zz_addr1_12;
  wire       [9:0]    _zz_Mosi1_5;
  wire       [5:0]    _zz_addr1_13;
  wire       [5:0]    _zz_addr2_16;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_4_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_4_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_4_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l692_4;
  wire       [5:0]    _zz_addr2_17;
  wire       [3:0]    _zz_addr2_18;
  wire       [2:0]    _zz_addr1_14;
  wire       [9:0]    _zz_Mosi1_6;
  wire       [5:0]    _zz_addr1_15;
  wire       [5:0]    _zz_addr2_19;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_5_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_5_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_5_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l692_5;
  wire       [5:0]    _zz_addr2_20;
  wire       [3:0]    _zz_addr2_21;
  wire       [2:0]    _zz_addr1_16;
  wire       [11:0]   _zz_Mosi1_7;
  wire       [31:0]   _zz_Mosi2_4;
  wire       [5:0]    _zz_addr1_17;
  wire       [5:0]    _zz_addr2_22;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_6_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_6_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_6_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l692_6;
  wire       [5:0]    _zz_addr2_23;
  wire       [3:0]    _zz_addr2_24;
  wire       [2:0]    _zz_addr1_18;
  wire       [31:0]   _zz_Mosi1_8;
  wire       [31:0]   _zz_Mosi2_5;
  wire       [5:0]    _zz_addr1_19;
  wire       [5:0]    _zz_addr2_25;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_7_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_7_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_7_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l692_7;
  wire       [5:0]    _zz_addr2_26;
  wire       [3:0]    _zz_addr2_27;
  wire       [2:0]    _zz_addr1_20;
  wire       [12:0]   _zz_Mosi1_9;
  wire       [9:0]    _zz_Mosi2_6;
  wire       [5:0]    _zz_addr1_21;
  wire       [5:0]    _zz_addr2_28;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_8;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_8_1;
  wire       [5:0]    _zz_addr2_29;
  wire       [3:0]    _zz_addr2_30;
  wire       [2:0]    _zz_addr1_22;
  wire       [13:0]   _zz_Mosi1_10;
  wire       [31:0]   _zz_Mosi2_7;
  wire       [5:0]    _zz_addr1_23;
  wire       [5:0]    _zz_addr2_31;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_9;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_9_1;
  wire       [5:0]    _zz_addr2_32;
  wire       [3:0]    _zz_addr2_33;
  wire       [2:0]    _zz_addr1_24;
  wire       [10:0]   _zz_Mosi1_11;
  wire       [1:0]    _zz_Mosi2_8;
  wire       [5:0]    _zz_addr1_25;
  wire       [5:0]    _zz_addr2_34;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_10;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_10_1;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_10_2;
  wire       [31:0]   _zz_when_WbSdCtrl_l692_10;
  wire       [5:0]    _zz_addr2_35;
  wire       [3:0]    _zz_addr2_36;
  wire       [6:0]    _zz_addr2_37;
  wire       [8:0]    _zz_Mosi2_9;
  wire       [6:0]    _zz_addr2_38;
  wire       [31:0]   _zz_Mosi2_10;
  wire       [6:0]    _zz_addr1_26;
  wire       [2:0]    _zz_addr1_27;
  wire       [12:0]   _zz_Mosi1_12;
  wire       [5:0]    _zz_addr1_28;
  wire       [5:0]    _zz_addr2_39;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_11;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_11_1;
  wire       [5:0]    _zz_addr2_40;
  wire       [3:0]    _zz_addr2_41;
  wire       [5:0]    _zz_addr1_29;
  wire       [2:0]    _zz_addr1_30;
  wire       [11:0]   _zz_Mosi1_13;
  wire       [5:0]    _zz_addr1_31;
  wire       [5:0]    _zz_addr2_42;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_12;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_12_1;
  wire       [5:0]    _zz_addr2_43;
  wire       [3:0]    _zz_addr2_44;
  wire       [31:0]   _zz_Swb_DAT_MISO;
  wire       [6:0]    _zz_addr2_45;
  wire       [31:0]   _zz_Mosi2_11;
  wire       [2:0]    _zz_addr1_32;
  wire       [12:0]   _zz_Mosi1_14;
  wire       [5:0]    _zz_addr1_33;
  wire       [5:0]    _zz_addr2_46;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_13;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_13_1;
  wire       [5:0]    _zz_addr2_47;
  wire       [3:0]    _zz_addr2_48;
  wire       [5:0]    _zz_addr2_49;
  wire       [2:0]    _zz_addr1_34;
  wire       [11:0]   _zz_Mosi1_15;
  wire       [5:0]    _zz_addr1_35;
  wire       [5:0]    _zz_addr2_50;
  wire       [31:0]   _zz_when_WbSdCtrl_l689_14;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_14_1;
  wire       [5:0]    _zz_addr2_51;
  wire       [3:0]    _zz_addr2_52;
  reg        [31:0]   NormalIsrStatus;
  reg        [31:0]   CmdResponseRegA41;
  reg        [31:0]   CmdResponseReg2;
  reg        [31:0]   CmdResponseReg3;
  wire       [31:0]   CmdResponseReg7;
  wire       [31:0]   BdIsrStatus;
  reg        [3:0]    RSPCardStatus;
  wire       [3:0]    FBTXNum;
  wire       [3:0]    FBRxNum;
  wire       [31:0]   GetRdData;
  wire       [31:0]   TestBclkAddr;
  reg        [31:0]   Cmd7Config;
  reg        [31:0]   TotalBtyesNum;
  wire                when_WbSdCtrl_l110;
  reg        [31:0]   CmdResponseReg;
  wire       [15:0]   LBits;
  wire       [3:0]    SELConfig;
  wire       [31:0]   ClearData;
  reg                 We1;
  reg                 We2;
  reg                 Cyc1;
  reg                 Cyc2;
  reg                 Stb1;
  reg                 Stb2;
  reg        [3:0]    Sel1;
  reg        [3:0]    Sel2;
  reg        [31:0]   addr1;
  reg        [31:0]   addr2;
  reg        [31:0]   Mosi1;
  reg        [31:0]   Mosi2;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg                 fsm_SCoreRest_fsm_wantExit;
  reg                 fsm_SCoreRest_fsm_wantStart;
  wire                fsm_SCoreRest_fsm_wantKill;
  reg                 fsm_SCoreCmdTimeOut_fsm_wantExit;
  reg                 fsm_SCoreCmdTimeOut_fsm_wantStart;
  wire                fsm_SCoreCmdTimeOut_fsm_wantKill;
  reg                 fsm_SCoredataTimeOut_fsm_wantExit;
  reg                 fsm_SCoredataTimeOut_fsm_wantStart;
  wire                fsm_SCoredataTimeOut_fsm_wantKill;
  reg                 fsm_SCoreClkDivider_fsm_wantExit;
  reg                 fsm_SCoreClkDivider_fsm_wantStart;
  wire                fsm_SCoreClkDivider_fsm_wantKill;
  reg                 fsm_SCoreStart_fsm_wantExit;
  reg                 fsm_SCoreStart_fsm_wantStart;
  wire                fsm_SCoreStart_fsm_wantKill;
  reg                 fsm_SCoreCmdIsrEn_fsm_wantExit;
  reg                 fsm_SCoreCmdIsrEn_fsm_wantStart;
  wire                fsm_SCoreCmdIsrEn_fsm_wantKill;
  reg                 fsm_SCoreDataIsrEn_fsm_wantExit;
  reg                 fsm_SCoreDataIsrEn_fsm_wantStart;
  wire                fsm_SCoreDataIsrEn_fsm_wantKill;
  reg                 fsm_SCoreDataWithSet_fsm_wantExit;
  reg                 fsm_SCoreDataWithSet_fsm_wantStart;
  wire                fsm_SCoreDataWithSet_fsm_wantKill;
  reg                 fsm_SSDCmd0_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_wantKill;
  reg                 fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238;
  reg                 fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_SSDcmd8_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_wantKill;
  reg                 fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_1;
  reg                 fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_SSDcmd55_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_wantKill;
  reg                 fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_2;
  reg                 fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [0:0]    _zz_when_WbSdCtrl_l689;
  reg                 fsm_SSDAcmd41_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_wantKill;
  reg                 fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_3;
  reg                 fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_1;
  reg                 fsm_SSDCmd2_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_wantKill;
  reg                 fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_4;
  reg                 fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_2;
  reg                 fsm_SSDCmd3_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_wantKill;
  reg                 fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_5;
  reg                 fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_3;
  reg                 fsm_SSDCmd9_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_wantKill;
  reg                 fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_6;
  reg                 fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_4;
  reg                 fsm_SSDCmd7_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_wantKill;
  reg                 fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_7;
  reg                 fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_SSDCmd16_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_wantKill;
  reg                 fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_8;
  reg                 fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_SSDcmd55_2_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_wantKill;
  reg                 fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_9;
  reg                 fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [0:0]    _zz_when_WbSdCtrl_l689_5;
  reg                 fsm_SSDACmd6_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_wantKill;
  reg                 fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_10;
  reg                 fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_SCoreBlkSize_fsm_wantExit;
  reg                 fsm_SCoreBlkSize_fsm_wantStart;
  wire                fsm_SCoreBlkSize_fsm_wantKill;
  reg                 fsm_SCoreBlkNum_fsm_wantExit;
  reg                 fsm_SCoreBlkNum_fsm_wantStart;
  wire                fsm_SCoreBlkNum_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_wantKill;
  reg        [31:0]   fsm_SCoreSandData_fsm_TxCnt;
  reg                 fsm_SCoreSandData_fsm_DmaAddr_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_DmaAddr_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_DmaAddr_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_11;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_12;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_wantKill;
  reg        [31:0]   fsm_ScoreGetData_fsm_RxCnt;
  reg        [31:0]   fsm_ScoreGetData_fsm_RxData;
  reg                 fsm_ScoreGetData_fsm_DmaAddr_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_DmaAddr_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_DmaAddr_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_13;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_14;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg        [1:0]    fsm_SCoreRest_fsm_stateReg;
  reg        [1:0]    fsm_SCoreRest_fsm_stateNext;
  wire                _zz_when_StateMachine_l237;
  wire                _zz_when_StateMachine_l237_1;
  wire                when_WbSdCtrl_l551;
  wire                when_StateMachine_l237;
  wire                when_StateMachine_l253;
  reg        [1:0]    fsm_SCoreCmdTimeOut_fsm_stateReg;
  reg        [1:0]    fsm_SCoreCmdTimeOut_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_2;
  wire                _zz_when_StateMachine_l237_3;
  wire                when_WbSdCtrl_l577;
  wire                when_StateMachine_l237_1;
  wire                when_StateMachine_l253_1;
  reg        [1:0]    fsm_SCoredataTimeOut_fsm_stateReg;
  reg        [1:0]    fsm_SCoredataTimeOut_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_4;
  wire                _zz_when_StateMachine_l237_5;
  wire                when_WbSdCtrl_l551_1;
  wire                when_StateMachine_l237_2;
  wire                when_StateMachine_l253_2;
  reg        [1:0]    fsm_SCoreClkDivider_fsm_stateReg;
  reg        [1:0]    fsm_SCoreClkDivider_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_6;
  wire                _zz_when_StateMachine_l237_7;
  wire                when_WbSdCtrl_l577_1;
  wire                when_StateMachine_l237_3;
  wire                when_StateMachine_l253_3;
  reg        [1:0]    fsm_SCoreStart_fsm_stateReg;
  reg        [1:0]    fsm_SCoreStart_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_8;
  wire                _zz_when_StateMachine_l237_9;
  wire                when_WbSdCtrl_l551_2;
  wire                when_StateMachine_l237_4;
  wire                when_StateMachine_l253_4;
  reg        [1:0]    fsm_SCoreCmdIsrEn_fsm_stateReg;
  reg        [1:0]    fsm_SCoreCmdIsrEn_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_10;
  wire                _zz_when_StateMachine_l237_11;
  wire                when_WbSdCtrl_l577_2;
  wire                when_StateMachine_l237_5;
  wire                when_StateMachine_l253_5;
  reg        [1:0]    fsm_SCoreDataIsrEn_fsm_stateReg;
  reg        [1:0]    fsm_SCoreDataIsrEn_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_12;
  wire                _zz_when_StateMachine_l237_13;
  wire                when_WbSdCtrl_l551_3;
  wire                when_StateMachine_l237_6;
  wire                when_StateMachine_l253_6;
  reg        [1:0]    fsm_SCoreDataWithSet_fsm_stateReg;
  reg        [1:0]    fsm_SCoreDataWithSet_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_14;
  wire                _zz_when_StateMachine_l237_15;
  wire                when_WbSdCtrl_l577_3;
  wire                when_StateMachine_l237_7;
  wire                when_StateMachine_l253_7;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_16;
  wire                _zz_when_StateMachine_l237_17;
  wire                when_WbSdCtrl_l551_4;
  wire                when_StateMachine_l237_8;
  wire                when_StateMachine_l253_8;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_18;
  wire                _zz_when_StateMachine_l237_19;
  wire                when_WbSdCtrl_l577_4;
  wire                when_StateMachine_l237_9;
  wire                when_StateMachine_l253_9;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_20;
  wire                _zz_when_StateMachine_l237_21;
  wire                when_WbSdCtrl_l551_5;
  wire                when_StateMachine_l237_10;
  wire                when_StateMachine_l253_10;
  reg        [3:0]    fsm_SSDCmd0_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd0_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_22;
  wire                _zz_when_StateMachine_l237_23;
  wire                _zz_when_StateMachine_l237_24;
  wire                _zz_when_StateMachine_l237_25;
  wire                when_State_l238;
  wire                when_WbSdCtrl_l648;
  wire                when_WbSdCtrl_l669;
  wire                when_WbSdCtrl_l686;
  wire                when_WbSdCtrl_l689;
  wire                when_WbSdCtrl_l692;
  wire                when_WbSdCtrl_l702;
  wire                when_StateMachine_l237_11;
  wire                when_StateMachine_l237_12;
  wire                when_StateMachine_l253_11;
  wire                when_StateMachine_l253_12;
  wire                when_StateMachine_l253_13;
  wire                when_StateMachine_l253_14;
  wire                when_StateMachine_l253_15;
  wire                when_StateMachine_l253_16;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_26;
  wire                _zz_when_StateMachine_l237_27;
  wire                when_WbSdCtrl_l551_6;
  wire                when_StateMachine_l237_13;
  wire                when_StateMachine_l253_17;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_28;
  wire                _zz_when_StateMachine_l237_29;
  wire                when_WbSdCtrl_l577_5;
  wire                when_StateMachine_l237_14;
  wire                when_StateMachine_l253_18;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_30;
  wire                _zz_when_StateMachine_l237_31;
  wire                when_WbSdCtrl_l551_7;
  wire                when_StateMachine_l237_15;
  wire                when_StateMachine_l253_19;
  reg        [3:0]    fsm_SSDcmd8_fsm_stateReg;
  reg        [3:0]    fsm_SSDcmd8_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_32;
  wire                _zz_when_StateMachine_l237_33;
  wire                _zz_when_StateMachine_l237_34;
  wire                _zz_when_StateMachine_l237_35;
  wire                when_State_l238_1;
  wire                when_WbSdCtrl_l648_1;
  wire                when_WbSdCtrl_l669_1;
  wire                when_WbSdCtrl_l686_1;
  wire                when_WbSdCtrl_l689_1;
  wire                when_WbSdCtrl_l692_1;
  wire                when_WbSdCtrl_l702_1;
  wire                when_StateMachine_l237_16;
  wire                when_StateMachine_l237_17;
  wire                when_StateMachine_l253_20;
  wire                when_StateMachine_l253_21;
  wire                when_StateMachine_l253_22;
  wire                when_StateMachine_l253_23;
  wire                when_StateMachine_l253_24;
  wire                when_StateMachine_l253_25;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_36;
  wire                _zz_when_StateMachine_l237_37;
  wire                when_WbSdCtrl_l551_8;
  wire                when_StateMachine_l237_18;
  wire                when_StateMachine_l253_26;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_38;
  wire                _zz_when_StateMachine_l237_39;
  wire                when_WbSdCtrl_l577_6;
  wire                when_StateMachine_l237_19;
  wire                when_StateMachine_l253_27;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_40;
  wire                _zz_when_StateMachine_l237_41;
  wire                when_WbSdCtrl_l551_9;
  wire                when_StateMachine_l237_20;
  wire                when_StateMachine_l253_28;
  reg        [3:0]    fsm_SSDcmd55_fsm_stateReg;
  reg        [3:0]    fsm_SSDcmd55_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_42;
  wire                _zz_when_StateMachine_l237_43;
  wire                _zz_when_StateMachine_l237_44;
  wire                _zz_when_StateMachine_l237_45;
  wire                when_State_l238_2;
  wire                when_WbSdCtrl_l648_2;
  wire                when_WbSdCtrl_l669_2;
  wire                when_WbSdCtrl_l686_2;
  wire                when_WbSdCtrl_l689_2;
  wire                when_WbSdCtrl_l692_2;
  wire                when_WbSdCtrl_l702_2;
  wire                when_StateMachine_l237_21;
  wire                when_StateMachine_l237_22;
  wire                when_StateMachine_l253_29;
  wire                when_StateMachine_l253_30;
  wire                when_StateMachine_l253_31;
  wire                when_StateMachine_l253_32;
  wire                when_StateMachine_l253_33;
  wire                when_StateMachine_l253_34;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_46;
  wire                _zz_when_StateMachine_l237_47;
  wire                when_WbSdCtrl_l551_10;
  wire                when_StateMachine_l237_23;
  wire                when_StateMachine_l253_35;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_48;
  wire                _zz_when_StateMachine_l237_49;
  wire                when_WbSdCtrl_l577_7;
  wire                when_StateMachine_l237_24;
  wire                when_StateMachine_l253_36;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_50;
  wire                _zz_when_StateMachine_l237_51;
  wire                when_WbSdCtrl_l551_11;
  wire                when_StateMachine_l237_25;
  wire                when_StateMachine_l253_37;
  reg        [3:0]    fsm_SSDAcmd41_fsm_stateReg;
  reg        [3:0]    fsm_SSDAcmd41_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_52;
  wire                _zz_when_StateMachine_l237_53;
  wire                _zz_when_StateMachine_l237_54;
  wire                _zz_when_StateMachine_l237_55;
  wire                when_State_l238_3;
  wire                when_WbSdCtrl_l648_3;
  wire                when_WbSdCtrl_l669_3;
  wire                when_WbSdCtrl_l686_3;
  wire                when_WbSdCtrl_l689_3;
  wire                when_WbSdCtrl_l692_3;
  wire                when_WbSdCtrl_l702_3;
  wire                when_StateMachine_l237_26;
  wire                when_StateMachine_l237_27;
  wire                when_StateMachine_l253_38;
  wire                when_StateMachine_l253_39;
  wire                when_StateMachine_l253_40;
  wire                when_StateMachine_l253_41;
  wire                when_StateMachine_l253_42;
  wire                when_StateMachine_l253_43;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_56;
  wire                _zz_when_StateMachine_l237_57;
  wire                when_WbSdCtrl_l551_12;
  wire                when_StateMachine_l237_28;
  wire                when_StateMachine_l253_44;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_58;
  wire                _zz_when_StateMachine_l237_59;
  wire                when_WbSdCtrl_l577_8;
  wire                when_StateMachine_l237_29;
  wire                when_StateMachine_l253_45;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_60;
  wire                _zz_when_StateMachine_l237_61;
  wire                when_WbSdCtrl_l551_13;
  wire                when_StateMachine_l237_30;
  wire                when_StateMachine_l253_46;
  reg        [3:0]    fsm_SSDCmd2_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd2_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_62;
  wire                _zz_when_StateMachine_l237_63;
  wire                _zz_when_StateMachine_l237_64;
  wire                _zz_when_StateMachine_l237_65;
  wire                when_State_l238_4;
  wire                when_WbSdCtrl_l648_4;
  wire                when_WbSdCtrl_l669_4;
  wire                when_WbSdCtrl_l686_4;
  wire                when_WbSdCtrl_l689_4;
  wire                when_WbSdCtrl_l692_4;
  wire                when_WbSdCtrl_l702_4;
  wire                when_StateMachine_l237_31;
  wire                when_StateMachine_l237_32;
  wire                when_StateMachine_l253_47;
  wire                when_StateMachine_l253_48;
  wire                when_StateMachine_l253_49;
  wire                when_StateMachine_l253_50;
  wire                when_StateMachine_l253_51;
  wire                when_StateMachine_l253_52;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_66;
  wire                _zz_when_StateMachine_l237_67;
  wire                when_WbSdCtrl_l551_14;
  wire                when_StateMachine_l237_33;
  wire                when_StateMachine_l253_53;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_68;
  wire                _zz_when_StateMachine_l237_69;
  wire                when_WbSdCtrl_l577_9;
  wire                when_StateMachine_l237_34;
  wire                when_StateMachine_l253_54;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_70;
  wire                _zz_when_StateMachine_l237_71;
  wire                when_WbSdCtrl_l551_15;
  wire                when_StateMachine_l237_35;
  wire                when_StateMachine_l253_55;
  reg        [3:0]    fsm_SSDCmd3_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd3_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_72;
  wire                _zz_when_StateMachine_l237_73;
  wire                _zz_when_StateMachine_l237_74;
  wire                _zz_when_StateMachine_l237_75;
  wire                when_State_l238_5;
  wire                when_WbSdCtrl_l648_5;
  wire                when_WbSdCtrl_l669_5;
  wire                when_WbSdCtrl_l686_5;
  wire                when_WbSdCtrl_l689_5;
  wire                when_WbSdCtrl_l692_5;
  wire                when_WbSdCtrl_l702_5;
  wire                when_StateMachine_l237_36;
  wire                when_StateMachine_l237_37;
  wire                when_StateMachine_l253_56;
  wire                when_StateMachine_l253_57;
  wire                when_StateMachine_l253_58;
  wire                when_StateMachine_l253_59;
  wire                when_StateMachine_l253_60;
  wire                when_StateMachine_l253_61;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_76;
  wire                _zz_when_StateMachine_l237_77;
  wire                when_WbSdCtrl_l551_16;
  wire                when_StateMachine_l237_38;
  wire                when_StateMachine_l253_62;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_78;
  wire                _zz_when_StateMachine_l237_79;
  wire                when_WbSdCtrl_l577_10;
  wire                when_StateMachine_l237_39;
  wire                when_StateMachine_l253_63;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_80;
  wire                _zz_when_StateMachine_l237_81;
  wire                when_WbSdCtrl_l551_17;
  wire                when_StateMachine_l237_40;
  wire                when_StateMachine_l253_64;
  reg        [3:0]    fsm_SSDCmd9_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd9_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_82;
  wire                _zz_when_StateMachine_l237_83;
  wire                _zz_when_StateMachine_l237_84;
  wire                _zz_when_StateMachine_l237_85;
  wire                when_State_l238_6;
  wire                when_WbSdCtrl_l648_6;
  wire                when_WbSdCtrl_l669_6;
  wire                when_WbSdCtrl_l686_6;
  wire                when_WbSdCtrl_l689_6;
  wire                when_WbSdCtrl_l692_6;
  wire                when_WbSdCtrl_l702_6;
  wire                when_StateMachine_l237_41;
  wire                when_StateMachine_l237_42;
  wire                when_StateMachine_l253_65;
  wire                when_StateMachine_l253_66;
  wire                when_StateMachine_l253_67;
  wire                when_StateMachine_l253_68;
  wire                when_StateMachine_l253_69;
  wire                when_StateMachine_l253_70;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_86;
  wire                _zz_when_StateMachine_l237_87;
  wire                when_WbSdCtrl_l551_18;
  wire                when_StateMachine_l237_43;
  wire                when_StateMachine_l253_71;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_88;
  wire                _zz_when_StateMachine_l237_89;
  wire                when_WbSdCtrl_l577_11;
  wire                when_StateMachine_l237_44;
  wire                when_StateMachine_l253_72;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_90;
  wire                _zz_when_StateMachine_l237_91;
  wire                when_WbSdCtrl_l551_19;
  wire                when_StateMachine_l237_45;
  wire                when_StateMachine_l253_73;
  reg        [3:0]    fsm_SSDCmd7_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd7_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_92;
  wire                _zz_when_StateMachine_l237_93;
  wire                _zz_when_StateMachine_l237_94;
  wire                _zz_when_StateMachine_l237_95;
  wire                when_State_l238_7;
  wire                when_WbSdCtrl_l648_7;
  wire                when_WbSdCtrl_l669_7;
  wire                when_WbSdCtrl_l686_7;
  wire                when_WbSdCtrl_l689_7;
  wire                when_WbSdCtrl_l692_7;
  wire                when_WbSdCtrl_l702_7;
  wire                when_StateMachine_l237_46;
  wire                when_StateMachine_l237_47;
  wire                when_StateMachine_l253_74;
  wire                when_StateMachine_l253_75;
  wire                when_StateMachine_l253_76;
  wire                when_StateMachine_l253_77;
  wire                when_StateMachine_l253_78;
  wire                when_StateMachine_l253_79;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_96;
  wire                _zz_when_StateMachine_l237_97;
  wire                when_WbSdCtrl_l551_20;
  wire                when_StateMachine_l237_48;
  wire                when_StateMachine_l253_80;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_98;
  wire                _zz_when_StateMachine_l237_99;
  wire                when_WbSdCtrl_l577_12;
  wire                when_StateMachine_l237_49;
  wire                when_StateMachine_l253_81;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_100;
  wire                _zz_when_StateMachine_l237_101;
  wire                when_WbSdCtrl_l551_21;
  wire                when_StateMachine_l237_50;
  wire                when_StateMachine_l253_82;
  reg        [3:0]    fsm_SSDCmd16_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd16_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_102;
  wire                _zz_when_StateMachine_l237_103;
  wire                _zz_when_StateMachine_l237_104;
  wire                _zz_when_StateMachine_l237_105;
  wire                when_State_l238_8;
  wire                when_WbSdCtrl_l648_8;
  wire                when_WbSdCtrl_l669_8;
  wire                when_WbSdCtrl_l686_8;
  wire                when_WbSdCtrl_l689_8;
  wire                when_WbSdCtrl_l692_8;
  wire                when_WbSdCtrl_l702_8;
  wire                when_StateMachine_l237_51;
  wire                when_StateMachine_l237_52;
  wire                when_StateMachine_l253_83;
  wire                when_StateMachine_l253_84;
  wire                when_StateMachine_l253_85;
  wire                when_StateMachine_l253_86;
  wire                when_StateMachine_l253_87;
  wire                when_StateMachine_l253_88;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_106;
  wire                _zz_when_StateMachine_l237_107;
  wire                when_WbSdCtrl_l551_22;
  wire                when_StateMachine_l237_53;
  wire                when_StateMachine_l253_89;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_108;
  wire                _zz_when_StateMachine_l237_109;
  wire                when_WbSdCtrl_l577_13;
  wire                when_StateMachine_l237_54;
  wire                when_StateMachine_l253_90;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_110;
  wire                _zz_when_StateMachine_l237_111;
  wire                when_WbSdCtrl_l551_23;
  wire                when_StateMachine_l237_55;
  wire                when_StateMachine_l253_91;
  reg        [3:0]    fsm_SSDcmd55_2_fsm_stateReg;
  reg        [3:0]    fsm_SSDcmd55_2_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_112;
  wire                _zz_when_StateMachine_l237_113;
  wire                _zz_when_StateMachine_l237_114;
  wire                _zz_when_StateMachine_l237_115;
  wire                when_State_l238_9;
  wire                when_WbSdCtrl_l648_9;
  wire                when_WbSdCtrl_l669_9;
  wire                when_WbSdCtrl_l686_9;
  wire                when_WbSdCtrl_l689_9;
  wire                when_WbSdCtrl_l692_9;
  wire                when_WbSdCtrl_l702_9;
  wire                when_StateMachine_l237_56;
  wire                when_StateMachine_l237_57;
  wire                when_StateMachine_l253_92;
  wire                when_StateMachine_l253_93;
  wire                when_StateMachine_l253_94;
  wire                when_StateMachine_l253_95;
  wire                when_StateMachine_l253_96;
  wire                when_StateMachine_l253_97;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_116;
  wire                _zz_when_StateMachine_l237_117;
  wire                when_WbSdCtrl_l551_24;
  wire                when_StateMachine_l237_58;
  wire                when_StateMachine_l253_98;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_118;
  wire                _zz_when_StateMachine_l237_119;
  wire                when_WbSdCtrl_l577_14;
  wire                when_StateMachine_l237_59;
  wire                when_StateMachine_l253_99;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_120;
  wire                _zz_when_StateMachine_l237_121;
  wire                when_WbSdCtrl_l551_25;
  wire                when_StateMachine_l237_60;
  wire                when_StateMachine_l253_100;
  reg        [3:0]    fsm_SSDACmd6_fsm_stateReg;
  reg        [3:0]    fsm_SSDACmd6_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_122;
  wire                _zz_when_StateMachine_l237_123;
  wire                _zz_when_StateMachine_l237_124;
  wire                _zz_when_StateMachine_l237_125;
  wire                when_State_l238_10;
  wire                when_WbSdCtrl_l648_10;
  wire                when_WbSdCtrl_l669_10;
  wire                when_WbSdCtrl_l686_10;
  wire                when_WbSdCtrl_l689_10;
  wire                when_WbSdCtrl_l692_10;
  wire                when_WbSdCtrl_l702_10;
  wire                when_StateMachine_l237_61;
  wire                when_StateMachine_l237_62;
  wire                when_StateMachine_l253_101;
  wire                when_StateMachine_l253_102;
  wire                when_StateMachine_l253_103;
  wire                when_StateMachine_l253_104;
  wire                when_StateMachine_l253_105;
  wire                when_StateMachine_l253_106;
  reg        [1:0]    fsm_SCoreBlkSize_fsm_stateReg;
  reg        [1:0]    fsm_SCoreBlkSize_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_126;
  wire                _zz_when_StateMachine_l237_127;
  wire                when_WbSdCtrl_l577_15;
  wire                when_StateMachine_l237_63;
  wire                when_StateMachine_l253_107;
  reg        [1:0]    fsm_SCoreBlkNum_fsm_stateReg;
  reg        [1:0]    fsm_SCoreBlkNum_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_128;
  wire                _zz_when_StateMachine_l237_129;
  wire                when_WbSdCtrl_l577_16;
  wire                when_StateMachine_l237_64;
  wire                when_StateMachine_l253_108;
  reg        [1:0]    fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_130;
  wire                _zz_when_StateMachine_l237_131;
  wire                when_WbSdCtrl_l551_26;
  wire                when_StateMachine_l237_65;
  wire                when_StateMachine_l253_109;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_132;
  wire                _zz_when_StateMachine_l237_133;
  wire                when_WbSdCtrl_l551_27;
  wire                when_StateMachine_l237_66;
  wire                when_StateMachine_l253_110;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_134;
  wire                _zz_when_StateMachine_l237_135;
  wire                when_WbSdCtrl_l577_17;
  wire                when_StateMachine_l237_67;
  wire                when_StateMachine_l253_111;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_136;
  wire                _zz_when_StateMachine_l237_137;
  wire                when_WbSdCtrl_l551_28;
  wire                when_StateMachine_l237_68;
  wire                when_StateMachine_l253_112;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_138;
  wire                _zz_when_StateMachine_l237_139;
  wire                _zz_when_StateMachine_l237_140;
  wire                _zz_when_StateMachine_l237_141;
  wire                when_State_l238_11;
  wire                when_WbSdCtrl_l648_11;
  wire                when_WbSdCtrl_l669_11;
  wire                when_WbSdCtrl_l686_11;
  wire                when_WbSdCtrl_l689_11;
  wire                when_WbSdCtrl_l692_11;
  wire                when_WbSdCtrl_l702_11;
  wire                when_StateMachine_l237_69;
  wire                when_StateMachine_l237_70;
  wire                when_StateMachine_l253_113;
  wire                when_StateMachine_l253_114;
  wire                when_StateMachine_l253_115;
  wire                when_StateMachine_l253_116;
  wire                when_StateMachine_l253_117;
  wire                when_StateMachine_l253_118;
  reg        [1:0]    fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_142;
  wire                _zz_when_StateMachine_l237_143;
  wire                when_WbSdCtrl_l551_29;
  wire                when_StateMachine_l237_71;
  wire                when_StateMachine_l253_119;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_144;
  wire                _zz_when_StateMachine_l237_145;
  wire                when_WbSdCtrl_l551_30;
  wire                when_StateMachine_l237_72;
  wire                when_StateMachine_l253_120;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_146;
  wire                _zz_when_StateMachine_l237_147;
  wire                when_WbSdCtrl_l577_18;
  wire                when_StateMachine_l237_73;
  wire                when_StateMachine_l253_121;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_148;
  wire                _zz_when_StateMachine_l237_149;
  wire                when_WbSdCtrl_l551_31;
  wire                when_StateMachine_l237_74;
  wire                when_StateMachine_l253_122;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_150;
  wire                _zz_when_StateMachine_l237_151;
  wire                _zz_when_StateMachine_l237_152;
  wire                _zz_when_StateMachine_l237_153;
  wire                when_State_l238_12;
  wire                when_WbSdCtrl_l648_12;
  wire                when_WbSdCtrl_l669_12;
  wire                when_WbSdCtrl_l686_12;
  wire                when_WbSdCtrl_l689_12;
  wire                when_WbSdCtrl_l692_12;
  wire                when_WbSdCtrl_l702_12;
  wire                when_StateMachine_l237_75;
  wire                when_StateMachine_l237_76;
  wire                when_StateMachine_l253_123;
  wire                when_StateMachine_l253_124;
  wire                when_StateMachine_l253_125;
  wire                when_StateMachine_l253_126;
  wire                when_StateMachine_l253_127;
  wire                when_StateMachine_l253_128;
  reg        [2:0]    fsm_SCoreSandData_fsm_stateReg;
  reg        [2:0]    fsm_SCoreSandData_fsm_stateNext;
  wire                when_WbSdCtrl_l734;
  wire                when_WbSdCtrl_l740;
  wire                when_WbSdCtrl_l749;
  wire                when_StateMachine_l253_129;
  wire                when_StateMachine_l253_130;
  wire                when_StateMachine_l253_131;
  wire                when_StateMachine_l253_132;
  reg        [1:0]    fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_154;
  wire                _zz_when_StateMachine_l237_155;
  wire                when_WbSdCtrl_l577_19;
  wire                when_StateMachine_l237_77;
  wire                when_StateMachine_l253_133;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_156;
  wire                _zz_when_StateMachine_l237_157;
  wire                when_WbSdCtrl_l551_32;
  wire                when_StateMachine_l237_78;
  wire                when_StateMachine_l253_134;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_158;
  wire                _zz_when_StateMachine_l237_159;
  wire                when_WbSdCtrl_l577_20;
  wire                when_StateMachine_l237_79;
  wire                when_StateMachine_l253_135;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_160;
  wire                _zz_when_StateMachine_l237_161;
  wire                when_WbSdCtrl_l551_33;
  wire                when_StateMachine_l237_80;
  wire                when_StateMachine_l253_136;
  reg        [3:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg;
  reg        [3:0]    fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_162;
  wire                _zz_when_StateMachine_l237_163;
  wire                _zz_when_StateMachine_l237_164;
  wire                _zz_when_StateMachine_l237_165;
  wire                when_State_l238_13;
  wire                when_WbSdCtrl_l648_13;
  wire                when_WbSdCtrl_l669_13;
  wire                when_WbSdCtrl_l686_13;
  wire                when_WbSdCtrl_l689_13;
  wire                when_WbSdCtrl_l692_13;
  wire                when_WbSdCtrl_l702_13;
  wire                when_StateMachine_l237_81;
  wire                when_StateMachine_l237_82;
  wire                when_StateMachine_l253_137;
  wire                when_StateMachine_l253_138;
  wire                when_StateMachine_l253_139;
  wire                when_StateMachine_l253_140;
  wire                when_StateMachine_l253_141;
  wire                when_StateMachine_l253_142;
  reg        [1:0]    fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_166;
  wire                _zz_when_StateMachine_l237_167;
  wire                when_WbSdCtrl_l577_21;
  wire                when_StateMachine_l237_83;
  wire                when_StateMachine_l253_143;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_168;
  wire                _zz_when_StateMachine_l237_169;
  wire                when_WbSdCtrl_l551_34;
  wire                when_StateMachine_l237_84;
  wire                when_StateMachine_l253_144;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_170;
  wire                _zz_when_StateMachine_l237_171;
  wire                when_WbSdCtrl_l577_22;
  wire                when_StateMachine_l237_85;
  wire                when_StateMachine_l253_145;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_172;
  wire                _zz_when_StateMachine_l237_173;
  wire                when_WbSdCtrl_l551_35;
  wire                when_StateMachine_l237_86;
  wire                when_StateMachine_l253_146;
  reg        [3:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg;
  reg        [3:0]    fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext;
  wire                _zz_when_StateMachine_l237_174;
  wire                _zz_when_StateMachine_l237_175;
  wire                _zz_when_StateMachine_l237_176;
  wire                _zz_when_StateMachine_l237_177;
  wire                when_State_l238_14;
  wire                when_WbSdCtrl_l648_14;
  wire                when_WbSdCtrl_l669_14;
  wire                when_WbSdCtrl_l686_14;
  wire                when_WbSdCtrl_l689_14;
  wire                when_WbSdCtrl_l692_14;
  wire                when_WbSdCtrl_l702_14;
  wire                when_StateMachine_l237_87;
  wire                when_StateMachine_l237_88;
  wire                when_StateMachine_l253_147;
  wire                when_StateMachine_l253_148;
  wire                when_StateMachine_l253_149;
  wire                when_StateMachine_l253_150;
  wire                when_StateMachine_l253_151;
  wire                when_StateMachine_l253_152;
  reg        [2:0]    fsm_ScoreGetData_fsm_stateReg;
  reg        [2:0]    fsm_ScoreGetData_fsm_stateNext;
  wire                when_WbSdCtrl_l808;
  wire                when_WbSdCtrl_l815;
  wire                when_WbSdCtrl_l824;
  wire                when_StateMachine_l253_153;
  wire                when_StateMachine_l253_154;
  wire                when_StateMachine_l253_155;
  wire                when_StateMachine_l253_156;
  reg        [4:0]    fsm_stateReg;
  reg        [4:0]    fsm_stateNext;
  wire                when_WbSdCtrl_l433;
  wire                when_WbSdCtrl_l461;
  wire                when_WbSdCtrl_l477;
  wire                when_WbSdCtrl_l518;
  wire                when_StateMachine_l253_157;
  wire                when_StateMachine_l253_158;
  wire                when_StateMachine_l253_159;
  wire                when_StateMachine_l253_160;
  wire                when_StateMachine_l253_161;
  wire                when_StateMachine_l253_162;
  wire                when_StateMachine_l253_163;
  wire                when_StateMachine_l253_164;
  wire                when_StateMachine_l253_165;
  wire                when_StateMachine_l253_166;
  wire                when_StateMachine_l253_167;
  wire                when_StateMachine_l253_168;
  wire                when_StateMachine_l253_169;
  wire                when_StateMachine_l253_170;
  wire                when_StateMachine_l253_171;
  wire                when_StateMachine_l253_172;
  wire                when_StateMachine_l253_173;
  wire                when_StateMachine_l253_174;
  wire                when_StateMachine_l253_175;
  wire                when_StateMachine_l253_176;
  wire                when_StateMachine_l253_177;
  wire                when_StateMachine_l253_178;
  wire                when_StateMachine_l253_179;
  `ifndef SYNTHESIS
  reg [95:0] fsm_SCoreRest_fsm_stateReg_string;
  reg [95:0] fsm_SCoreRest_fsm_stateNext_string;
  reg [95:0] fsm_SCoreCmdTimeOut_fsm_stateReg_string;
  reg [95:0] fsm_SCoreCmdTimeOut_fsm_stateNext_string;
  reg [95:0] fsm_SCoredataTimeOut_fsm_stateReg_string;
  reg [95:0] fsm_SCoredataTimeOut_fsm_stateNext_string;
  reg [95:0] fsm_SCoreClkDivider_fsm_stateReg_string;
  reg [95:0] fsm_SCoreClkDivider_fsm_stateNext_string;
  reg [95:0] fsm_SCoreStart_fsm_stateReg_string;
  reg [95:0] fsm_SCoreStart_fsm_stateNext_string;
  reg [95:0] fsm_SCoreCmdIsrEn_fsm_stateReg_string;
  reg [95:0] fsm_SCoreCmdIsrEn_fsm_stateNext_string;
  reg [95:0] fsm_SCoreDataIsrEn_fsm_stateReg_string;
  reg [95:0] fsm_SCoreDataIsrEn_fsm_stateNext_string;
  reg [95:0] fsm_SCoreDataWithSet_fsm_stateReg_string;
  reg [95:0] fsm_SCoreDataWithSet_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDCmd0_fsm_stateReg_string;
  reg [127:0] fsm_SSDCmd0_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDcmd8_fsm_stateReg_string;
  reg [127:0] fsm_SSDcmd8_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDcmd55_fsm_stateReg_string;
  reg [127:0] fsm_SSDcmd55_fsm_stateNext_string;
  reg [95:0] fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDAcmd41_fsm_stateReg_string;
  reg [127:0] fsm_SSDAcmd41_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDCmd2_fsm_stateReg_string;
  reg [127:0] fsm_SSDCmd2_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDCmd3_fsm_stateReg_string;
  reg [127:0] fsm_SSDCmd3_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDCmd9_fsm_stateReg_string;
  reg [127:0] fsm_SSDCmd9_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDCmd7_fsm_stateReg_string;
  reg [127:0] fsm_SSDCmd7_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDCmd16_fsm_stateReg_string;
  reg [127:0] fsm_SSDCmd16_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDcmd55_2_fsm_stateReg_string;
  reg [127:0] fsm_SSDcmd55_2_fsm_stateNext_string;
  reg [95:0] fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SSDACmd6_fsm_stateReg_string;
  reg [127:0] fsm_SSDACmd6_fsm_stateNext_string;
  reg [95:0] fsm_SCoreBlkSize_fsm_stateReg_string;
  reg [95:0] fsm_SCoreBlkSize_fsm_stateNext_string;
  reg [95:0] fsm_SCoreBlkNum_fsm_stateReg_string;
  reg [95:0] fsm_SCoreBlkNum_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string;
  reg [127:0] fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string;
  reg [127:0] fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string;
  reg [95:0] fsm_SCoreSandData_fsm_stateReg_string;
  reg [95:0] fsm_SCoreSandData_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string;
  reg [127:0] fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string;
  reg [127:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string;
  reg [127:0] fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string;
  reg [95:0] fsm_ScoreGetData_fsm_stateReg_string;
  reg [95:0] fsm_ScoreGetData_fsm_stateNext_string;
  reg [127:0] fsm_stateReg_string;
  reg [127:0] fsm_stateNext_string;
  `endif


  assign _zz_addr1 = 6'h28;
  assign _zz_Mosi1 = 1'b1;
  assign _zz_addr2 = 6'h20;
  assign _zz_addr1_1 = 5'h18;
  assign _zz_addr2_1 = 6'h24;
  assign _zz_addr1_2 = 6'h28;
  assign _zz_addr2_2 = 6'h38;
  assign _zz_Mosi2 = 5'h1f;
  assign _zz_addr1_3 = 7'h40;
  assign _zz_Mosi1_1 = 5'h1f;
  assign _zz_addr2_3 = 5'h1c;
  assign _zz_Mosi2_1 = 1'b1;
  assign _zz_addr1_4 = 3'b100;
  assign _zz_addr1_5 = 6'h34;
  assign _zz_addr2_4 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_7 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_6 = {31'd0, _zz_when_WbSdCtrl_l689_7};
  assign _zz_addr2_5 = 6'h34;
  assign _zz_addr2_6 = 4'b1000;
  assign _zz_addr1_6 = 3'b100;
  assign _zz_Mosi1_2 = 12'h800;
  assign _zz_Mosi2_2 = 9'h1aa;
  assign _zz_addr1_7 = 6'h34;
  assign _zz_addr2_7 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_1_2 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_1_1 = {31'd0, _zz_when_WbSdCtrl_l689_1_2};
  assign _zz_addr2_8 = 6'h34;
  assign _zz_addr2_9 = 4'b1000;
  assign _zz_addr1_8 = 3'b100;
  assign _zz_Mosi1_3 = 14'h3719;
  assign _zz_addr1_9 = 6'h34;
  assign _zz_addr2_10 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_2_2 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_2_1 = {31'd0, _zz_when_WbSdCtrl_l689_2_2};
  assign _zz_addr2_11 = 6'h34;
  assign _zz_addr2_12 = 4'b1000;
  assign _zz_addr1_10 = 3'b100;
  assign _zz_Mosi1_4 = 14'h2901;
  assign _zz_Mosi2_3 = 31'h40360000;
  assign _zz_addr1_11 = 6'h34;
  assign _zz_addr2_13 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_3_1 = {31'd0, _zz_when_WbSdCtrl_l689};
  assign _zz_when_WbSdCtrl_l689_3_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_3_2 = {31'd0, _zz_when_WbSdCtrl_l689_3_3};
  assign _zz_when_WbSdCtrl_l692_3 = {31'd0, _zz_when_WbSdCtrl_l689};
  assign _zz_addr2_14 = 6'h34;
  assign _zz_addr2_15 = 4'b1000;
  assign _zz_addr1_12 = 3'b100;
  assign _zz_Mosi1_5 = 10'h20a;
  assign _zz_addr1_13 = 6'h34;
  assign _zz_addr2_16 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_4_1 = {31'd0, _zz_when_WbSdCtrl_l689_1};
  assign _zz_when_WbSdCtrl_l689_4_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_4_2 = {31'd0, _zz_when_WbSdCtrl_l689_4_3};
  assign _zz_when_WbSdCtrl_l692_4 = {31'd0, _zz_when_WbSdCtrl_l689_1};
  assign _zz_addr2_17 = 6'h34;
  assign _zz_addr2_18 = 4'b1000;
  assign _zz_addr1_14 = 3'b100;
  assign _zz_Mosi1_6 = 10'h319;
  assign _zz_addr1_15 = 6'h34;
  assign _zz_addr2_19 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_5_1 = {31'd0, _zz_when_WbSdCtrl_l689_2};
  assign _zz_when_WbSdCtrl_l689_5_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_5_2 = {31'd0, _zz_when_WbSdCtrl_l689_5_3};
  assign _zz_when_WbSdCtrl_l692_5 = {31'd0, _zz_when_WbSdCtrl_l689_2};
  assign _zz_addr2_20 = 6'h34;
  assign _zz_addr2_21 = 4'b1000;
  assign _zz_addr1_16 = 3'b100;
  assign _zz_Mosi1_7 = 12'h902;
  assign _zz_Mosi2_4 = CmdResponseReg3;
  assign _zz_addr1_17 = 6'h34;
  assign _zz_addr2_22 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_6_1 = {31'd0, _zz_when_WbSdCtrl_l689_3};
  assign _zz_when_WbSdCtrl_l689_6_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_6_2 = {31'd0, _zz_when_WbSdCtrl_l689_6_3};
  assign _zz_when_WbSdCtrl_l692_6 = {31'd0, _zz_when_WbSdCtrl_l689_3};
  assign _zz_addr2_23 = 6'h34;
  assign _zz_addr2_24 = 4'b1000;
  assign _zz_addr1_18 = 3'b100;
  assign _zz_Mosi1_8 = Cmd7Config;
  assign _zz_Mosi2_5 = CmdResponseReg3;
  assign _zz_addr1_19 = 6'h34;
  assign _zz_addr2_25 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_7_1 = {31'd0, _zz_when_WbSdCtrl_l689_4};
  assign _zz_when_WbSdCtrl_l689_7_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_7_2 = {31'd0, _zz_when_WbSdCtrl_l689_7_3};
  assign _zz_when_WbSdCtrl_l692_7 = {31'd0, _zz_when_WbSdCtrl_l689_4};
  assign _zz_addr2_26 = 6'h34;
  assign _zz_addr2_27 = 4'b1000;
  assign _zz_addr1_20 = 3'b100;
  assign _zz_Mosi1_9 = 13'h1019;
  assign _zz_Mosi2_6 = 10'h200;
  assign _zz_addr1_21 = 6'h34;
  assign _zz_addr2_28 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_8_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_8 = {31'd0, _zz_when_WbSdCtrl_l689_8_1};
  assign _zz_addr2_29 = 6'h34;
  assign _zz_addr2_30 = 4'b1000;
  assign _zz_addr1_22 = 3'b100;
  assign _zz_Mosi1_10 = 14'h3719;
  assign _zz_Mosi2_7 = CmdResponseReg3;
  assign _zz_addr1_23 = 6'h34;
  assign _zz_addr2_31 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_9_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_9 = {31'd0, _zz_when_WbSdCtrl_l689_9_1};
  assign _zz_addr2_32 = 6'h34;
  assign _zz_addr2_33 = 4'b1000;
  assign _zz_addr1_24 = 3'b100;
  assign _zz_Mosi1_11 = 11'h619;
  assign _zz_Mosi2_8 = 2'b10;
  assign _zz_addr1_25 = 6'h34;
  assign _zz_addr2_34 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_10 = {31'd0, _zz_when_WbSdCtrl_l689_5};
  assign _zz_when_WbSdCtrl_l689_10_2 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_10_1 = {31'd0, _zz_when_WbSdCtrl_l689_10_2};
  assign _zz_when_WbSdCtrl_l692_10 = {31'd0, _zz_when_WbSdCtrl_l689_5};
  assign _zz_addr2_35 = 6'h34;
  assign _zz_addr2_36 = 4'b1000;
  assign _zz_addr2_37 = 7'h44;
  assign _zz_Mosi2_9 = 9'h1ff;
  assign _zz_addr2_38 = 7'h48;
  assign _zz_Mosi2_10 = SDWrOrRdBlkNum;
  assign _zz_addr1_26 = 7'h60;
  assign _zz_addr1_27 = 3'b100;
  assign _zz_Mosi1_12 = 13'h1959;
  assign _zz_addr1_28 = 6'h34;
  assign _zz_addr2_39 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_11_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_11 = {31'd0, _zz_when_WbSdCtrl_l689_11_1};
  assign _zz_addr2_40 = 6'h34;
  assign _zz_addr2_41 = 4'b1000;
  assign _zz_addr1_29 = 6'h3c;
  assign _zz_addr1_30 = 3'b100;
  assign _zz_Mosi1_13 = 12'hc00;
  assign _zz_addr1_31 = 6'h34;
  assign _zz_addr2_42 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_12_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_12 = {31'd0, _zz_when_WbSdCtrl_l689_12_1};
  assign _zz_addr2_43 = 6'h34;
  assign _zz_addr2_44 = 4'b1000;
  assign _zz_Swb_DAT_MISO = fsm_SCoreSandData_fsm_TxCnt;
  assign _zz_addr2_45 = 7'h60;
  assign _zz_Mosi2_11 = SDWrOrRdAddr;
  assign _zz_addr1_32 = 3'b100;
  assign _zz_Mosi1_14 = 13'h1239;
  assign _zz_addr1_33 = 6'h34;
  assign _zz_addr2_46 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_13_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_13 = {31'd0, _zz_when_WbSdCtrl_l689_13_1};
  assign _zz_addr2_47 = 6'h34;
  assign _zz_addr2_48 = 4'b1000;
  assign _zz_addr2_49 = 6'h3c;
  assign _zz_addr1_34 = 3'b100;
  assign _zz_Mosi1_15 = 12'hc00;
  assign _zz_addr1_35 = 6'h34;
  assign _zz_addr2_50 = 6'h34;
  assign _zz_when_WbSdCtrl_l689_14_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l689_14 = {31'd0, _zz_when_WbSdCtrl_l689_14_1};
  assign _zz_addr2_51 = 6'h34;
  assign _zz_addr2_52 = 4'b1000;
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_BOOT : fsm_SCoreRest_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreRest_fsm_enumDef_SCoreCmdIDE : fsm_SCoreRest_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : fsm_SCoreRest_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : fsm_SCoreRest_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreRest_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreRest_fsm_stateNext)
      fsm_SCoreRest_fsm_enumDef_BOOT : fsm_SCoreRest_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreRest_fsm_enumDef_SCoreCmdIDE : fsm_SCoreRest_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : fsm_SCoreRest_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : fsm_SCoreRest_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreRest_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdIDE : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdTimeOut_fsm_stateNext)
      fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdIDE : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_BOOT : fsm_SCoredataTimeOut_fsm_stateReg_string = "BOOT        ";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdIDE : fsm_SCoredataTimeOut_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoredataTimeOut_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoredataTimeOut_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoredataTimeOut_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoredataTimeOut_fsm_stateNext)
      fsm_SCoredataTimeOut_fsm_enumDef_BOOT : fsm_SCoredataTimeOut_fsm_stateNext_string = "BOOT        ";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdIDE : fsm_SCoredataTimeOut_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoredataTimeOut_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoredataTimeOut_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoredataTimeOut_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_BOOT : fsm_SCoreClkDivider_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdIDE : fsm_SCoreClkDivider_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : fsm_SCoreClkDivider_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : fsm_SCoreClkDivider_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreClkDivider_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreClkDivider_fsm_stateNext)
      fsm_SCoreClkDivider_fsm_enumDef_BOOT : fsm_SCoreClkDivider_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdIDE : fsm_SCoreClkDivider_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : fsm_SCoreClkDivider_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : fsm_SCoreClkDivider_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreClkDivider_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_BOOT : fsm_SCoreStart_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreStart_fsm_enumDef_SCoreCmdIDE : fsm_SCoreStart_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : fsm_SCoreStart_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : fsm_SCoreStart_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreStart_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreStart_fsm_stateNext)
      fsm_SCoreStart_fsm_enumDef_BOOT : fsm_SCoreStart_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreStart_fsm_enumDef_SCoreCmdIDE : fsm_SCoreStart_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : fsm_SCoreStart_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : fsm_SCoreStart_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreStart_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdIDE : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdIsrEn_fsm_stateNext)
      fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdIDE : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_BOOT : fsm_SCoreDataIsrEn_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdIDE : fsm_SCoreDataIsrEn_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataIsrEn_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreDataIsrEn_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreDataIsrEn_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataIsrEn_fsm_stateNext)
      fsm_SCoreDataIsrEn_fsm_enumDef_BOOT : fsm_SCoreDataIsrEn_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdIDE : fsm_SCoreDataIsrEn_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataIsrEn_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreDataIsrEn_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreDataIsrEn_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_BOOT : fsm_SCoreDataWithSet_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdIDE : fsm_SCoreDataWithSet_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataWithSet_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : fsm_SCoreDataWithSet_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreDataWithSet_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataWithSet_fsm_stateNext)
      fsm_SCoreDataWithSet_fsm_enumDef_BOOT : fsm_SCoreDataWithSet_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdIDE : fsm_SCoreDataWithSet_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataWithSet_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : fsm_SCoreDataWithSet_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreDataWithSet_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_stateReg)
      fsm_SSDCmd0_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_stateReg_string = "BOOT            ";
      fsm_SSDCmd0_fsm_enumDef_IDLE : fsm_SSDCmd0_fsm_stateReg_string = "IDLE            ";
      fsm_SSDCmd0_fsm_enumDef_SCoreCmd : fsm_SSDCmd0_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDCmd0_fsm_enumDef_SCoreArguMent : fsm_SSDCmd0_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDCmd0_fsm_enumDef_SCoreDelay : fsm_SSDCmd0_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd0_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd0_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd0_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd0_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd0_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd0_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd0_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd0_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_stateNext)
      fsm_SSDCmd0_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_stateNext_string = "BOOT            ";
      fsm_SSDCmd0_fsm_enumDef_IDLE : fsm_SSDCmd0_fsm_stateNext_string = "IDLE            ";
      fsm_SSDCmd0_fsm_enumDef_SCoreCmd : fsm_SSDCmd0_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDCmd0_fsm_enumDef_SCoreArguMent : fsm_SSDCmd0_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDCmd0_fsm_enumDef_SCoreDelay : fsm_SSDCmd0_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd0_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd0_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd0_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd0_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd0_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd0_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd0_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd0_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_stateReg)
      fsm_SSDcmd8_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_stateReg_string = "BOOT            ";
      fsm_SSDcmd8_fsm_enumDef_IDLE : fsm_SSDcmd8_fsm_stateReg_string = "IDLE            ";
      fsm_SSDcmd8_fsm_enumDef_SCoreCmd : fsm_SSDcmd8_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDcmd8_fsm_enumDef_SCoreArguMent : fsm_SSDcmd8_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDcmd8_fsm_enumDef_SCoreDelay : fsm_SSDcmd8_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDcmd8_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDcmd8_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDcmd8_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDcmd8_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : fsm_SSDcmd8_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd8_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd8_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd8_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_stateNext)
      fsm_SSDcmd8_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_stateNext_string = "BOOT            ";
      fsm_SSDcmd8_fsm_enumDef_IDLE : fsm_SSDcmd8_fsm_stateNext_string = "IDLE            ";
      fsm_SSDcmd8_fsm_enumDef_SCoreCmd : fsm_SSDcmd8_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDcmd8_fsm_enumDef_SCoreArguMent : fsm_SSDcmd8_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDcmd8_fsm_enumDef_SCoreDelay : fsm_SSDcmd8_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDcmd8_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDcmd8_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDcmd8_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDcmd8_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : fsm_SSDcmd8_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd8_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd8_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd8_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_stateReg)
      fsm_SSDcmd55_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_stateReg_string = "BOOT            ";
      fsm_SSDcmd55_fsm_enumDef_IDLE : fsm_SSDcmd55_fsm_stateReg_string = "IDLE            ";
      fsm_SSDcmd55_fsm_enumDef_SCoreCmd : fsm_SSDcmd55_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDcmd55_fsm_enumDef_SCoreArguMent : fsm_SSDcmd55_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDcmd55_fsm_enumDef_SCoreDelay : fsm_SSDcmd55_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDcmd55_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDcmd55_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDcmd55_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDcmd55_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : fsm_SSDcmd55_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd55_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd55_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_stateNext)
      fsm_SSDcmd55_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_stateNext_string = "BOOT            ";
      fsm_SSDcmd55_fsm_enumDef_IDLE : fsm_SSDcmd55_fsm_stateNext_string = "IDLE            ";
      fsm_SSDcmd55_fsm_enumDef_SCoreCmd : fsm_SSDcmd55_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDcmd55_fsm_enumDef_SCoreArguMent : fsm_SSDcmd55_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDcmd55_fsm_enumDef_SCoreDelay : fsm_SSDcmd55_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDcmd55_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDcmd55_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDcmd55_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDcmd55_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : fsm_SSDcmd55_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd55_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd55_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_stateReg)
      fsm_SSDAcmd41_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_stateReg_string = "BOOT            ";
      fsm_SSDAcmd41_fsm_enumDef_IDLE : fsm_SSDAcmd41_fsm_stateReg_string = "IDLE            ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreCmd : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreDelay : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : fsm_SSDAcmd41_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDAcmd41_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_stateNext)
      fsm_SSDAcmd41_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_stateNext_string = "BOOT            ";
      fsm_SSDAcmd41_fsm_enumDef_IDLE : fsm_SSDAcmd41_fsm_stateNext_string = "IDLE            ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreCmd : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreDelay : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : fsm_SSDAcmd41_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDAcmd41_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_stateReg)
      fsm_SSDCmd2_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_stateReg_string = "BOOT            ";
      fsm_SSDCmd2_fsm_enumDef_IDLE : fsm_SSDCmd2_fsm_stateReg_string = "IDLE            ";
      fsm_SSDCmd2_fsm_enumDef_SCoreCmd : fsm_SSDCmd2_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDCmd2_fsm_enumDef_SCoreArguMent : fsm_SSDCmd2_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDCmd2_fsm_enumDef_SCoreDelay : fsm_SSDCmd2_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd2_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd2_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd2_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd2_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd2_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd2_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd2_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd2_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_stateNext)
      fsm_SSDCmd2_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_stateNext_string = "BOOT            ";
      fsm_SSDCmd2_fsm_enumDef_IDLE : fsm_SSDCmd2_fsm_stateNext_string = "IDLE            ";
      fsm_SSDCmd2_fsm_enumDef_SCoreCmd : fsm_SSDCmd2_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDCmd2_fsm_enumDef_SCoreArguMent : fsm_SSDCmd2_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDCmd2_fsm_enumDef_SCoreDelay : fsm_SSDCmd2_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd2_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd2_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd2_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd2_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd2_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd2_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd2_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd2_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_stateReg)
      fsm_SSDCmd3_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_stateReg_string = "BOOT            ";
      fsm_SSDCmd3_fsm_enumDef_IDLE : fsm_SSDCmd3_fsm_stateReg_string = "IDLE            ";
      fsm_SSDCmd3_fsm_enumDef_SCoreCmd : fsm_SSDCmd3_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDCmd3_fsm_enumDef_SCoreArguMent : fsm_SSDCmd3_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDCmd3_fsm_enumDef_SCoreDelay : fsm_SSDCmd3_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd3_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd3_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd3_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd3_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd3_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd3_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd3_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd3_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_stateNext)
      fsm_SSDCmd3_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_stateNext_string = "BOOT            ";
      fsm_SSDCmd3_fsm_enumDef_IDLE : fsm_SSDCmd3_fsm_stateNext_string = "IDLE            ";
      fsm_SSDCmd3_fsm_enumDef_SCoreCmd : fsm_SSDCmd3_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDCmd3_fsm_enumDef_SCoreArguMent : fsm_SSDCmd3_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDCmd3_fsm_enumDef_SCoreDelay : fsm_SSDCmd3_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd3_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd3_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd3_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd3_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd3_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd3_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd3_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd3_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_stateReg)
      fsm_SSDCmd9_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_stateReg_string = "BOOT            ";
      fsm_SSDCmd9_fsm_enumDef_IDLE : fsm_SSDCmd9_fsm_stateReg_string = "IDLE            ";
      fsm_SSDCmd9_fsm_enumDef_SCoreCmd : fsm_SSDCmd9_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDCmd9_fsm_enumDef_SCoreArguMent : fsm_SSDCmd9_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDCmd9_fsm_enumDef_SCoreDelay : fsm_SSDCmd9_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd9_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd9_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd9_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd9_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd9_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd9_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd9_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd9_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_stateNext)
      fsm_SSDCmd9_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_stateNext_string = "BOOT            ";
      fsm_SSDCmd9_fsm_enumDef_IDLE : fsm_SSDCmd9_fsm_stateNext_string = "IDLE            ";
      fsm_SSDCmd9_fsm_enumDef_SCoreCmd : fsm_SSDCmd9_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDCmd9_fsm_enumDef_SCoreArguMent : fsm_SSDCmd9_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDCmd9_fsm_enumDef_SCoreDelay : fsm_SSDCmd9_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd9_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd9_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd9_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd9_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd9_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd9_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd9_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd9_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_stateReg)
      fsm_SSDCmd7_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_stateReg_string = "BOOT            ";
      fsm_SSDCmd7_fsm_enumDef_IDLE : fsm_SSDCmd7_fsm_stateReg_string = "IDLE            ";
      fsm_SSDCmd7_fsm_enumDef_SCoreCmd : fsm_SSDCmd7_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDCmd7_fsm_enumDef_SCoreArguMent : fsm_SSDCmd7_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDCmd7_fsm_enumDef_SCoreDelay : fsm_SSDCmd7_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd7_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd7_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd7_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd7_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd7_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd7_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd7_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd7_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_stateNext)
      fsm_SSDCmd7_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_stateNext_string = "BOOT            ";
      fsm_SSDCmd7_fsm_enumDef_IDLE : fsm_SSDCmd7_fsm_stateNext_string = "IDLE            ";
      fsm_SSDCmd7_fsm_enumDef_SCoreCmd : fsm_SSDCmd7_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDCmd7_fsm_enumDef_SCoreArguMent : fsm_SSDCmd7_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDCmd7_fsm_enumDef_SCoreDelay : fsm_SSDCmd7_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd7_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd7_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd7_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd7_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd7_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd7_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd7_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd7_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_stateReg)
      fsm_SSDCmd16_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_stateReg_string = "BOOT            ";
      fsm_SSDCmd16_fsm_enumDef_IDLE : fsm_SSDCmd16_fsm_stateReg_string = "IDLE            ";
      fsm_SSDCmd16_fsm_enumDef_SCoreCmd : fsm_SSDCmd16_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDCmd16_fsm_enumDef_SCoreArguMent : fsm_SSDCmd16_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDCmd16_fsm_enumDef_SCoreDelay : fsm_SSDCmd16_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd16_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd16_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd16_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd16_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd16_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd16_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd16_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd16_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_stateNext)
      fsm_SSDCmd16_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_stateNext_string = "BOOT            ";
      fsm_SSDCmd16_fsm_enumDef_IDLE : fsm_SSDCmd16_fsm_stateNext_string = "IDLE            ";
      fsm_SSDCmd16_fsm_enumDef_SCoreCmd : fsm_SSDCmd16_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDCmd16_fsm_enumDef_SCoreArguMent : fsm_SSDCmd16_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDCmd16_fsm_enumDef_SCoreDelay : fsm_SSDCmd16_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDCmd16_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDCmd16_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDCmd16_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDCmd16_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : fsm_SSDCmd16_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd16_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd16_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd16_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_stateReg_string = "BOOT            ";
      fsm_SSDcmd55_2_fsm_enumDef_IDLE : fsm_SSDcmd55_2_fsm_stateReg_string = "IDLE            ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_2_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd55_2_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_stateNext)
      fsm_SSDcmd55_2_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_stateNext_string = "BOOT            ";
      fsm_SSDcmd55_2_fsm_enumDef_IDLE : fsm_SSDcmd55_2_fsm_stateNext_string = "IDLE            ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_2_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd55_2_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_stateReg)
      fsm_SSDACmd6_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_stateReg_string = "BOOT            ";
      fsm_SSDACmd6_fsm_enumDef_IDLE : fsm_SSDACmd6_fsm_stateReg_string = "IDLE            ";
      fsm_SSDACmd6_fsm_enumDef_SCoreCmd : fsm_SSDACmd6_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SSDACmd6_fsm_enumDef_SCoreArguMent : fsm_SSDACmd6_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SSDACmd6_fsm_enumDef_SCoreDelay : fsm_SSDACmd6_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDACmd6_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDACmd6_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDACmd6_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDACmd6_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : fsm_SSDACmd6_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : fsm_SSDACmd6_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : fsm_SSDACmd6_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SSDACmd6_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_stateNext)
      fsm_SSDACmd6_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_stateNext_string = "BOOT            ";
      fsm_SSDACmd6_fsm_enumDef_IDLE : fsm_SSDACmd6_fsm_stateNext_string = "IDLE            ";
      fsm_SSDACmd6_fsm_enumDef_SCoreCmd : fsm_SSDACmd6_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SSDACmd6_fsm_enumDef_SCoreArguMent : fsm_SSDACmd6_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SSDACmd6_fsm_enumDef_SCoreDelay : fsm_SSDACmd6_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr : fsm_SSDACmd6_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr : fsm_SSDACmd6_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd : fsm_SSDACmd6_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : fsm_SSDACmd6_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : fsm_SSDACmd6_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : fsm_SSDACmd6_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : fsm_SSDACmd6_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDACmd6_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_BOOT : fsm_SCoreBlkSize_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdIDE : fsm_SCoreBlkSize_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkSize_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkSize_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreBlkSize_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkSize_fsm_stateNext)
      fsm_SCoreBlkSize_fsm_enumDef_BOOT : fsm_SCoreBlkSize_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdIDE : fsm_SCoreBlkSize_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkSize_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkSize_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreBlkSize_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_BOOT : fsm_SCoreBlkNum_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdIDE : fsm_SCoreBlkNum_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkNum_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkNum_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreBlkNum_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkNum_fsm_stateNext)
      fsm_SCoreBlkNum_fsm_enumDef_BOOT : fsm_SCoreBlkNum_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdIDE : fsm_SCoreBlkNum_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkNum_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkNum_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreBlkNum_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "BOOT            ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "IDLE            ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "BOOT            ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "IDLE            ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "BOOT            ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "IDLE            ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreCmd        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreDelay      ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "BOOT            ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "IDLE            ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreCmd        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreDelay      ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_enumDef_IDLE : fsm_SCoreSandData_fsm_stateReg_string = "IDLE        ";
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : fsm_SCoreSandData_fsm_stateReg_string = "DmaAddr     ";
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : fsm_SCoreSandData_fsm_stateReg_string = "SSDCmd25    ";
      fsm_SCoreSandData_fsm_enumDef_WrData : fsm_SCoreSandData_fsm_stateReg_string = "WrData      ";
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : fsm_SCoreSandData_fsm_stateReg_string = "CheckIsrDone";
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : fsm_SCoreSandData_fsm_stateReg_string = "ClearIsrData";
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : fsm_SCoreSandData_fsm_stateReg_string = "SSDCmd12    ";
      default : fsm_SCoreSandData_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_stateNext)
      fsm_SCoreSandData_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_enumDef_IDLE : fsm_SCoreSandData_fsm_stateNext_string = "IDLE        ";
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : fsm_SCoreSandData_fsm_stateNext_string = "DmaAddr     ";
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : fsm_SCoreSandData_fsm_stateNext_string = "SSDCmd25    ";
      fsm_SCoreSandData_fsm_enumDef_WrData : fsm_SCoreSandData_fsm_stateNext_string = "WrData      ";
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : fsm_SCoreSandData_fsm_stateNext_string = "CheckIsrDone";
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : fsm_SCoreSandData_fsm_stateNext_string = "ClearIsrData";
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : fsm_SCoreSandData_fsm_stateNext_string = "SSDCmd12    ";
      default : fsm_SCoreSandData_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg)
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext)
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "BOOT            ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "IDLE            ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreCmd        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreDelay      ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1 : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "BOOT            ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "IDLE            ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreCmd        ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreDelay      ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1 : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg)
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext)
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdIDE ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "BOOT            ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "IDLE            ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreCmd        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreArguMent   ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreDelay      ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreWaitCmdIsr ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreClearCmdIsr";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreNormalIsrRd";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreRdAckWait1 ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreGetRdData  ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreRdFinish   ";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "BOOT            ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "IDLE            ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreCmd        ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreArguMent   ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreDelay      ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreWaitCmdIsr ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreClearCmdIsr";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreNormalIsrRd";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreRdAckWait1 ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreGetRdData  ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_stateReg)
      fsm_ScoreGetData_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_stateReg_string = "BOOT        ";
      fsm_ScoreGetData_fsm_enumDef_IDLE : fsm_ScoreGetData_fsm_stateReg_string = "IDLE        ";
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : fsm_ScoreGetData_fsm_stateReg_string = "DmaAddr     ";
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : fsm_ScoreGetData_fsm_stateReg_string = "SSDCmd18    ";
      fsm_ScoreGetData_fsm_enumDef_RdData : fsm_ScoreGetData_fsm_stateReg_string = "RdData      ";
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : fsm_ScoreGetData_fsm_stateReg_string = "CheckIsrDone";
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : fsm_ScoreGetData_fsm_stateReg_string = "ClearIsrData";
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : fsm_ScoreGetData_fsm_stateReg_string = "SSDCmd12    ";
      default : fsm_ScoreGetData_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_ScoreGetData_fsm_stateNext)
      fsm_ScoreGetData_fsm_enumDef_BOOT : fsm_ScoreGetData_fsm_stateNext_string = "BOOT        ";
      fsm_ScoreGetData_fsm_enumDef_IDLE : fsm_ScoreGetData_fsm_stateNext_string = "IDLE        ";
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : fsm_ScoreGetData_fsm_stateNext_string = "DmaAddr     ";
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : fsm_ScoreGetData_fsm_stateNext_string = "SSDCmd18    ";
      fsm_ScoreGetData_fsm_enumDef_RdData : fsm_ScoreGetData_fsm_stateNext_string = "RdData      ";
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : fsm_ScoreGetData_fsm_stateNext_string = "CheckIsrDone";
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : fsm_ScoreGetData_fsm_stateNext_string = "ClearIsrData";
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : fsm_ScoreGetData_fsm_stateNext_string = "SSDCmd12    ";
      default : fsm_ScoreGetData_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT            ";
      fsm_enumDef_IDLE : fsm_stateReg_string = "IDLE            ";
      fsm_enumDef_SCoreRest : fsm_stateReg_string = "SCoreRest       ";
      fsm_enumDef_SCoreCmdTimeOut : fsm_stateReg_string = "SCoreCmdTimeOut ";
      fsm_enumDef_SCoredataTimeOut : fsm_stateReg_string = "SCoredataTimeOut";
      fsm_enumDef_SCoreClkDivider : fsm_stateReg_string = "SCoreClkDivider ";
      fsm_enumDef_SCoreStart : fsm_stateReg_string = "SCoreStart      ";
      fsm_enumDef_SCoreCmdIsrEn : fsm_stateReg_string = "SCoreCmdIsrEn   ";
      fsm_enumDef_SCoreDataIsrEn : fsm_stateReg_string = "SCoreDataIsrEn  ";
      fsm_enumDef_SCoreDataWithSet : fsm_stateReg_string = "SCoreDataWithSet";
      fsm_enumDef_SSDCmd0 : fsm_stateReg_string = "SSDCmd0         ";
      fsm_enumDef_SSDcmd8 : fsm_stateReg_string = "SSDcmd8         ";
      fsm_enumDef_SSDcmd55 : fsm_stateReg_string = "SSDcmd55        ";
      fsm_enumDef_SSDAcmd41 : fsm_stateReg_string = "SSDAcmd41       ";
      fsm_enumDef_SSDAcmd41Done : fsm_stateReg_string = "SSDAcmd41Done   ";
      fsm_enumDef_SSDCmd2 : fsm_stateReg_string = "SSDCmd2         ";
      fsm_enumDef_SSDCmd3 : fsm_stateReg_string = "SSDCmd3         ";
      fsm_enumDef_SSDStby : fsm_stateReg_string = "SSDStby         ";
      fsm_enumDef_SSDCmd9 : fsm_stateReg_string = "SSDCmd9         ";
      fsm_enumDef_SSDWrOrRd : fsm_stateReg_string = "SSDWrOrRd       ";
      fsm_enumDef_SSDCmd7 : fsm_stateReg_string = "SSDCmd7         ";
      fsm_enumDef_SSDCmd16 : fsm_stateReg_string = "SSDCmd16        ";
      fsm_enumDef_SSDcmd55_2 : fsm_stateReg_string = "SSDcmd55_2      ";
      fsm_enumDef_SSDACmd6 : fsm_stateReg_string = "SSDACmd6        ";
      fsm_enumDef_SCoreBlkSize : fsm_stateReg_string = "SCoreBlkSize    ";
      fsm_enumDef_SCoreBlkNum : fsm_stateReg_string = "SCoreBlkNum     ";
      fsm_enumDef_SCoreSandData : fsm_stateReg_string = "SCoreSandData   ";
      fsm_enumDef_ScoreGetData : fsm_stateReg_string = "ScoreGetData    ";
      default : fsm_stateReg_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT            ";
      fsm_enumDef_IDLE : fsm_stateNext_string = "IDLE            ";
      fsm_enumDef_SCoreRest : fsm_stateNext_string = "SCoreRest       ";
      fsm_enumDef_SCoreCmdTimeOut : fsm_stateNext_string = "SCoreCmdTimeOut ";
      fsm_enumDef_SCoredataTimeOut : fsm_stateNext_string = "SCoredataTimeOut";
      fsm_enumDef_SCoreClkDivider : fsm_stateNext_string = "SCoreClkDivider ";
      fsm_enumDef_SCoreStart : fsm_stateNext_string = "SCoreStart      ";
      fsm_enumDef_SCoreCmdIsrEn : fsm_stateNext_string = "SCoreCmdIsrEn   ";
      fsm_enumDef_SCoreDataIsrEn : fsm_stateNext_string = "SCoreDataIsrEn  ";
      fsm_enumDef_SCoreDataWithSet : fsm_stateNext_string = "SCoreDataWithSet";
      fsm_enumDef_SSDCmd0 : fsm_stateNext_string = "SSDCmd0         ";
      fsm_enumDef_SSDcmd8 : fsm_stateNext_string = "SSDcmd8         ";
      fsm_enumDef_SSDcmd55 : fsm_stateNext_string = "SSDcmd55        ";
      fsm_enumDef_SSDAcmd41 : fsm_stateNext_string = "SSDAcmd41       ";
      fsm_enumDef_SSDAcmd41Done : fsm_stateNext_string = "SSDAcmd41Done   ";
      fsm_enumDef_SSDCmd2 : fsm_stateNext_string = "SSDCmd2         ";
      fsm_enumDef_SSDCmd3 : fsm_stateNext_string = "SSDCmd3         ";
      fsm_enumDef_SSDStby : fsm_stateNext_string = "SSDStby         ";
      fsm_enumDef_SSDCmd9 : fsm_stateNext_string = "SSDCmd9         ";
      fsm_enumDef_SSDWrOrRd : fsm_stateNext_string = "SSDWrOrRd       ";
      fsm_enumDef_SSDCmd7 : fsm_stateNext_string = "SSDCmd7         ";
      fsm_enumDef_SSDCmd16 : fsm_stateNext_string = "SSDCmd16        ";
      fsm_enumDef_SSDcmd55_2 : fsm_stateNext_string = "SSDcmd55_2      ";
      fsm_enumDef_SSDACmd6 : fsm_stateNext_string = "SSDACmd6        ";
      fsm_enumDef_SCoreBlkSize : fsm_stateNext_string = "SCoreBlkSize    ";
      fsm_enumDef_SCoreBlkNum : fsm_stateNext_string = "SCoreBlkNum     ";
      fsm_enumDef_SCoreSandData : fsm_stateNext_string = "SCoreSandData   ";
      fsm_enumDef_ScoreGetData : fsm_stateNext_string = "ScoreGetData    ";
      default : fsm_stateNext_string = "????????????????";
    endcase
  end
  `endif

  assign CmdResponseReg7 = 32'h0;
  assign BdIsrStatus = 32'h0;
  assign FBTXNum = 4'b0000;
  assign FBRxNum = 4'b0000;
  assign GetRdData = 32'h0;
  assign TestBclkAddr = 32'h0;
  always @(*) begin
    SDWrOrRdStatus = 32'h0; // @[WbSdCtrl.scala 99:21]
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
        SDWrOrRdStatus = 32'h00000001; // @[WbSdCtrl.scala 733:29]
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
        if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit) begin
          SDWrOrRdStatus = 32'h0; // @[WbSdCtrl.scala 759:29]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    Swb_DAT_MISO = 32'h0; // @[BitVector.scala 471:10]
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
        if(when_WbSdCtrl_l734) begin
          Swb_DAT_MISO = _zz_Swb_DAT_MISO; // @[WbSdCtrl.scala 737:29]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    Swb_ACK = 1'b0; // @[Bool.scala 90:28]
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
        if(when_WbSdCtrl_l734) begin
          Swb_ACK = 1'b1; // @[WbSdCtrl.scala 736:24]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      default : begin
      end
    endcase
    case(fsm_ScoreGetData_fsm_stateReg)
      fsm_ScoreGetData_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : begin
      end
      fsm_ScoreGetData_fsm_enumDef_RdData : begin
        if(when_WbSdCtrl_l808) begin
          Swb_ACK = 1'b1; // @[WbSdCtrl.scala 810:24]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : begin
      end
      default : begin
      end
    endcase
  end

  assign SWrData_ready = 1'b1; // @[WbSdCtrl.scala 103:20]
  always @(*) begin
    MRdData_valid = 1'b0; // @[WbSdCtrl.scala 104:20]
    case(fsm_ScoreGetData_fsm_stateReg)
      fsm_ScoreGetData_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : begin
      end
      fsm_ScoreGetData_fsm_enumDef_RdData : begin
        if(when_WbSdCtrl_l808) begin
          MRdData_valid = 1'b1; // @[WbSdCtrl.scala 811:30]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    MRdData_payload = 32'h0; // @[WbSdCtrl.scala 105:22]
    case(fsm_ScoreGetData_fsm_stateReg)
      fsm_ScoreGetData_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : begin
      end
      fsm_ScoreGetData_fsm_enumDef_RdData : begin
        if(when_WbSdCtrl_l808) begin
          MRdData_payload = Swb_DAT_MOSI; // @[WbSdCtrl.scala 812:32]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : begin
      end
      default : begin
      end
    endcase
  end

  assign when_WbSdCtrl_l110 = (Mwb_ACK && (! Mwb_WE)); // @[BaseType.scala 305:24]
  assign RSPReg = CmdResponseReg; // @[WbSdCtrl.scala 112:13]
  assign RSPReg2 = CmdResponseReg2; // @[WbSdCtrl.scala 113:14]
  assign RSPReg3 = CmdResponseReg3; // @[WbSdCtrl.scala 114:14]
  assign RSPReg41 = CmdResponseRegA41; // @[WbSdCtrl.scala 115:15]
  assign Rddata = GetRdData; // @[WbSdCtrl.scala 116:13]
  assign LBits = 16'h0; // @[Expression.scala 2301:18]
  assign SELConfig = 4'b0000;
  assign ClearData = 32'h0;
  assign Mwb_WE = (We1 || We2); // @[WbSdCtrl.scala 244:13]
  assign Mwb_CYC = (Cyc1 || Cyc2); // @[WbSdCtrl.scala 245:14]
  assign Mwb_STB = (Stb1 || Stb2); // @[WbSdCtrl.scala 246:14]
  assign Mwb_SEL = (Sel1 | Sel2); // @[WbSdCtrl.scala 247:14]
  assign Mwb_ADR = (addr1 | addr2); // @[WbSdCtrl.scala 248:14]
  assign Mwb_DAT_MOSI = (Mosi1 | Mosi2); // @[WbSdCtrl.scala 249:19]
  assign fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
  always @(*) begin
    fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
      end
      fsm_enumDef_SCoreRest : begin
      end
      fsm_enumDef_SCoreCmdTimeOut : begin
      end
      fsm_enumDef_SCoredataTimeOut : begin
      end
      fsm_enumDef_SCoreClkDivider : begin
      end
      fsm_enumDef_SCoreStart : begin
      end
      fsm_enumDef_SCoreCmdIsrEn : begin
      end
      fsm_enumDef_SCoreDataIsrEn : begin
      end
      fsm_enumDef_SCoreDataWithSet : begin
      end
      fsm_enumDef_SSDCmd0 : begin
      end
      fsm_enumDef_SSDcmd8 : begin
      end
      fsm_enumDef_SSDcmd55 : begin
      end
      fsm_enumDef_SSDAcmd41 : begin
      end
      fsm_enumDef_SSDAcmd41Done : begin
      end
      fsm_enumDef_SSDCmd2 : begin
      end
      fsm_enumDef_SSDCmd3 : begin
      end
      fsm_enumDef_SSDStby : begin
      end
      fsm_enumDef_SSDCmd9 : begin
      end
      fsm_enumDef_SSDWrOrRd : begin
      end
      fsm_enumDef_SSDCmd7 : begin
      end
      fsm_enumDef_SSDCmd16 : begin
      end
      fsm_enumDef_SSDcmd55_2 : begin
      end
      fsm_enumDef_SSDACmd6 : begin
      end
      fsm_enumDef_SCoreBlkSize : begin
      end
      fsm_enumDef_SCoreBlkNum : begin
      end
      fsm_enumDef_SCoreSandData : begin
      end
      fsm_enumDef_ScoreGetData : begin
      end
      default : begin
        fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
      end
    endcase
  end

  assign fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreRest_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreRest_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreRest_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_157) begin
      fsm_SCoreRest_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreRest_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreCmdTimeOut_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreCmdTimeOut_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreCmdTimeOut_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_158) begin
      fsm_SCoreCmdTimeOut_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreCmdTimeOut_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoredataTimeOut_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoredataTimeOut_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoredataTimeOut_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_159) begin
      fsm_SCoredataTimeOut_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoredataTimeOut_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreClkDivider_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreClkDivider_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreClkDivider_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_160) begin
      fsm_SCoreClkDivider_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreClkDivider_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreStart_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreStart_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreStart_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_161) begin
      fsm_SCoreStart_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreStart_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreCmdIsrEn_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreCmdIsrEn_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreCmdIsrEn_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_162) begin
      fsm_SCoreCmdIsrEn_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreCmdIsrEn_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreDataIsrEn_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreDataIsrEn_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreDataIsrEn_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_163) begin
      fsm_SCoreDataIsrEn_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreDataIsrEn_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreDataWithSet_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreDataWithSet_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreDataWithSet_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_164) begin
      fsm_SCoreDataWithSet_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreDataWithSet_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd0_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd0_fsm_stateReg)
      fsm_SSDCmd0_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692) begin
          fsm_SSDCmd0_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd0_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd0_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_165) begin
      fsm_SSDCmd0_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_11) begin
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_12) begin
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_14) begin
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd8_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd8_fsm_stateReg)
      fsm_SSDcmd8_fsm_enumDef_IDLE : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_1) begin
          fsm_SSDcmd8_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDcmd8_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd8_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_166) begin
      fsm_SSDcmd8_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_20) begin
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_21) begin
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_23) begin
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_fsm_stateReg)
      fsm_SSDcmd55_fsm_enumDef_IDLE : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_2) begin
          fsm_SSDcmd55_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDcmd55_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_167) begin
      fsm_SSDcmd55_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_29) begin
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_30) begin
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_32) begin
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_when_WbSdCtrl_l689 = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDAcmd41_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDAcmd41_fsm_stateReg)
      fsm_SSDAcmd41_fsm_enumDef_IDLE : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_3) begin
          fsm_SSDAcmd41_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDAcmd41_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDAcmd41_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_168) begin
      fsm_SSDAcmd41_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_38) begin
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_39) begin
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_41) begin
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_when_WbSdCtrl_l689_1 = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd2_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd2_fsm_stateReg)
      fsm_SSDCmd2_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_4) begin
          fsm_SSDCmd2_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd2_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd2_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_169) begin
      fsm_SSDCmd2_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_47) begin
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_48) begin
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_50) begin
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_when_WbSdCtrl_l689_2 = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd3_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd3_fsm_stateReg)
      fsm_SSDCmd3_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_5) begin
          fsm_SSDCmd3_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd3_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd3_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_170) begin
      fsm_SSDCmd3_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_56) begin
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_57) begin
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_59) begin
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_when_WbSdCtrl_l689_3 = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd9_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd9_fsm_stateReg)
      fsm_SSDCmd9_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_6) begin
          fsm_SSDCmd9_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd9_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd9_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_171) begin
      fsm_SSDCmd9_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_65) begin
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_66) begin
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_68) begin
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_when_WbSdCtrl_l689_4 = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd7_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd7_fsm_stateReg)
      fsm_SSDCmd7_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_7) begin
          fsm_SSDCmd7_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd7_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd7_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_172) begin
      fsm_SSDCmd7_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_74) begin
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_75) begin
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_77) begin
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd16_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd16_fsm_stateReg)
      fsm_SSDCmd16_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_8) begin
          fsm_SSDCmd16_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd16_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd16_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_173) begin
      fsm_SSDCmd16_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_83) begin
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_84) begin
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_86) begin
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_2_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_enumDef_IDLE : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_9) begin
          fsm_SSDcmd55_2_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDcmd55_2_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_2_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_174) begin
      fsm_SSDcmd55_2_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_92) begin
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_93) begin
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_95) begin
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_when_WbSdCtrl_l689_5 = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDACmd6_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDACmd6_fsm_stateReg)
      fsm_SSDACmd6_fsm_enumDef_IDLE : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_10) begin
          fsm_SSDACmd6_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDACmd6_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDACmd6_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_175) begin
      fsm_SSDACmd6_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_101) begin
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_102) begin
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_104) begin
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreBlkSize_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreBlkSize_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreBlkSize_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_176) begin
      fsm_SCoreBlkSize_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreBlkSize_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreBlkNum_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreBlkNum_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreBlkNum_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_177) begin
      fsm_SCoreBlkNum_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreBlkNum_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
        if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_178) begin
      fsm_SCoreSandData_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_DmaAddr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_DmaAddr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_DmaAddr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_129) begin
      fsm_SCoreSandData_fsm_DmaAddr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_DmaAddr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_130) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_113) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_114) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_116) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_131) begin
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_132) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_123) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_124) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_126) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_stateReg)
      fsm_ScoreGetData_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : begin
      end
      fsm_ScoreGetData_fsm_enumDef_RdData : begin
      end
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : begin
        if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_179) begin
      fsm_ScoreGetData_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_DmaAddr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg)
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_DmaAddr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_DmaAddr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_153) begin
      fsm_ScoreGetData_fsm_DmaAddr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_DmaAddr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_154) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_137) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_138) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_140) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg)
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_155) begin
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l692_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_156) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_147) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_148) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_150) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_when_StateMachine_l237 = (fsm_SCoreRest_fsm_stateReg == fsm_SCoreRest_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_1 = (fsm_SCoreRest_fsm_stateNext == fsm_SCoreRest_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551) begin
          fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreRest_fsm_wantStart) begin
      fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreRest_fsm_wantKill) begin
      fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237 = (_zz_when_StateMachine_l237 && (! _zz_when_StateMachine_l237_1)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253 = ((! _zz_when_StateMachine_l237) && _zz_when_StateMachine_l237_1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_2 = (fsm_SCoreCmdTimeOut_fsm_stateReg == fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_3 = (fsm_SCoreCmdTimeOut_fsm_stateNext == fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577) begin
          fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreCmdTimeOut_fsm_wantStart) begin
      fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreCmdTimeOut_fsm_wantKill) begin
      fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_1 = (_zz_when_StateMachine_l237_2 && (! _zz_when_StateMachine_l237_3)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_1 = ((! _zz_when_StateMachine_l237_2) && _zz_when_StateMachine_l237_3); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_4 = (fsm_SCoredataTimeOut_fsm_stateReg == fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_5 = (fsm_SCoredataTimeOut_fsm_stateNext == fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_1) begin
          fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoredataTimeOut_fsm_wantStart) begin
      fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoredataTimeOut_fsm_wantKill) begin
      fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_1 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_2 = (_zz_when_StateMachine_l237_4 && (! _zz_when_StateMachine_l237_5)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_2 = ((! _zz_when_StateMachine_l237_4) && _zz_when_StateMachine_l237_5); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_6 = (fsm_SCoreClkDivider_fsm_stateReg == fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_7 = (fsm_SCoreClkDivider_fsm_stateNext == fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_1) begin
          fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreClkDivider_fsm_wantStart) begin
      fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreClkDivider_fsm_wantKill) begin
      fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_1 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_3 = (_zz_when_StateMachine_l237_6 && (! _zz_when_StateMachine_l237_7)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_3 = ((! _zz_when_StateMachine_l237_6) && _zz_when_StateMachine_l237_7); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_8 = (fsm_SCoreStart_fsm_stateReg == fsm_SCoreStart_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_9 = (fsm_SCoreStart_fsm_stateNext == fsm_SCoreStart_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_2) begin
          fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreStart_fsm_wantStart) begin
      fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreStart_fsm_wantKill) begin
      fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_2 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_4 = (_zz_when_StateMachine_l237_8 && (! _zz_when_StateMachine_l237_9)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_4 = ((! _zz_when_StateMachine_l237_8) && _zz_when_StateMachine_l237_9); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_10 = (fsm_SCoreCmdIsrEn_fsm_stateReg == fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_11 = (fsm_SCoreCmdIsrEn_fsm_stateNext == fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_2) begin
          fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreCmdIsrEn_fsm_wantStart) begin
      fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreCmdIsrEn_fsm_wantKill) begin
      fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_2 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_5 = (_zz_when_StateMachine_l237_10 && (! _zz_when_StateMachine_l237_11)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_5 = ((! _zz_when_StateMachine_l237_10) && _zz_when_StateMachine_l237_11); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_12 = (fsm_SCoreDataIsrEn_fsm_stateReg == fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_13 = (fsm_SCoreDataIsrEn_fsm_stateNext == fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_3) begin
          fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreDataIsrEn_fsm_wantStart) begin
      fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreDataIsrEn_fsm_wantKill) begin
      fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_3 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_6 = (_zz_when_StateMachine_l237_12 && (! _zz_when_StateMachine_l237_13)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_6 = ((! _zz_when_StateMachine_l237_12) && _zz_when_StateMachine_l237_13); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_14 = (fsm_SCoreDataWithSet_fsm_stateReg == fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_15 = (fsm_SCoreDataWithSet_fsm_stateNext == fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_3) begin
          fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreDataWithSet_fsm_wantStart) begin
      fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreDataWithSet_fsm_wantKill) begin
      fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_3 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_7 = (_zz_when_StateMachine_l237_14 && (! _zz_when_StateMachine_l237_15)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_7 = ((! _zz_when_StateMachine_l237_14) && _zz_when_StateMachine_l237_15); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_16 = (fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg == fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_17 = (fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext == fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_4) begin
          fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_4 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_8 = (_zz_when_StateMachine_l237_16 && (! _zz_when_StateMachine_l237_17)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_8 = ((! _zz_when_StateMachine_l237_16) && _zz_when_StateMachine_l237_17); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_18 = (fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_19 = (fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_4) begin
          fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_4 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_9 = (_zz_when_StateMachine_l237_18 && (! _zz_when_StateMachine_l237_19)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_9 = ((! _zz_when_StateMachine_l237_18) && _zz_when_StateMachine_l237_19); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_20 = (fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_21 = (fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_5) begin
          fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_5 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_10 = (_zz_when_StateMachine_l237_20 && (! _zz_when_StateMachine_l237_21)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_10 = ((! _zz_when_StateMachine_l237_20) && _zz_when_StateMachine_l237_21); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_22 = (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_23 = (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_24 = (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_25 = (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd0_fsm_stateReg)
      fsm_SSDCmd0_fsm_enumDef_IDLE : begin
        fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd0_fsm_wantStart) begin
      fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd0_fsm_wantKill) begin
      fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238 = (_zz_when_State_l238 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_6)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_11 = (_zz_when_StateMachine_l237_22 && (! _zz_when_StateMachine_l237_24)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_12 = (_zz_when_StateMachine_l237_23 && (! _zz_when_StateMachine_l237_25)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_11 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_12 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_13 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_14 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_15 = ((! _zz_when_StateMachine_l237_22) && _zz_when_StateMachine_l237_24); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_16 = ((! _zz_when_StateMachine_l237_23) && _zz_when_StateMachine_l237_25); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_26 = (fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg == fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_27 = (fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext == fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_6) begin
          fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_6 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_13 = (_zz_when_StateMachine_l237_26 && (! _zz_when_StateMachine_l237_27)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_17 = ((! _zz_when_StateMachine_l237_26) && _zz_when_StateMachine_l237_27); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_28 = (fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_29 = (fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_5) begin
          fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_5 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_14 = (_zz_when_StateMachine_l237_28 && (! _zz_when_StateMachine_l237_29)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_18 = ((! _zz_when_StateMachine_l237_28) && _zz_when_StateMachine_l237_29); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_30 = (fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_31 = (fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_7) begin
          fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_7 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_15 = (_zz_when_StateMachine_l237_30 && (! _zz_when_StateMachine_l237_31)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_19 = ((! _zz_when_StateMachine_l237_30) && _zz_when_StateMachine_l237_31); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_32 = (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_33 = (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_34 = (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_35 = (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd8_fsm_stateReg)
      fsm_SSDcmd8_fsm_enumDef_IDLE : begin
        fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd8_fsm_wantStart) begin
      fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd8_fsm_wantKill) begin
      fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_1 = (_zz_when_State_l238_1 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_1 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_1 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_1 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_1 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_1_1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_1 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_1 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_16 = (_zz_when_StateMachine_l237_32 && (! _zz_when_StateMachine_l237_34)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_17 = (_zz_when_StateMachine_l237_33 && (! _zz_when_StateMachine_l237_35)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_20 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreCmd)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_21 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreArguMent)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_22 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreDelay)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_23 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_24 = ((! _zz_when_StateMachine_l237_32) && _zz_when_StateMachine_l237_34); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_25 = ((! _zz_when_StateMachine_l237_33) && _zz_when_StateMachine_l237_35); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_36 = (fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg == fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_37 = (fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext == fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_8) begin
          fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_8 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_18 = (_zz_when_StateMachine_l237_36 && (! _zz_when_StateMachine_l237_37)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_26 = ((! _zz_when_StateMachine_l237_36) && _zz_when_StateMachine_l237_37); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_38 = (fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_39 = (fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_6) begin
          fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_6 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_19 = (_zz_when_StateMachine_l237_38 && (! _zz_when_StateMachine_l237_39)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_27 = ((! _zz_when_StateMachine_l237_38) && _zz_when_StateMachine_l237_39); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_40 = (fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_41 = (fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_9) begin
          fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_9 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_20 = (_zz_when_StateMachine_l237_40 && (! _zz_when_StateMachine_l237_41)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_28 = ((! _zz_when_StateMachine_l237_40) && _zz_when_StateMachine_l237_41); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_42 = (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_43 = (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_44 = (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_45 = (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_fsm_stateReg)
      fsm_SSDcmd55_fsm_enumDef_IDLE : begin
        fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_fsm_wantStart) begin
      fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_fsm_wantKill) begin
      fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_2 = (_zz_when_State_l238_2 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_2 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_2 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_2 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_2 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_2_1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_2 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_2 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_21 = (_zz_when_StateMachine_l237_42 && (! _zz_when_StateMachine_l237_44)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_22 = (_zz_when_StateMachine_l237_43 && (! _zz_when_StateMachine_l237_45)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_29 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreCmd)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_30 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreArguMent)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_31 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreDelay)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_32 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_33 = ((! _zz_when_StateMachine_l237_42) && _zz_when_StateMachine_l237_44); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_34 = ((! _zz_when_StateMachine_l237_43) && _zz_when_StateMachine_l237_45); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_46 = (fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg == fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_47 = (fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext == fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_10) begin
          fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_10 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_23 = (_zz_when_StateMachine_l237_46 && (! _zz_when_StateMachine_l237_47)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_35 = ((! _zz_when_StateMachine_l237_46) && _zz_when_StateMachine_l237_47); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_48 = (fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_49 = (fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_7) begin
          fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_7 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_24 = (_zz_when_StateMachine_l237_48 && (! _zz_when_StateMachine_l237_49)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_36 = ((! _zz_when_StateMachine_l237_48) && _zz_when_StateMachine_l237_49); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_50 = (fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_51 = (fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_11) begin
          fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_11 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_25 = (_zz_when_StateMachine_l237_50 && (! _zz_when_StateMachine_l237_51)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_37 = ((! _zz_when_StateMachine_l237_50) && _zz_when_StateMachine_l237_51); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_52 = (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_53 = (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_54 = (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_55 = (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDAcmd41_fsm_stateReg)
      fsm_SSDAcmd41_fsm_enumDef_IDLE : begin
        fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDAcmd41_fsm_wantStart) begin
      fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDAcmd41_fsm_wantKill) begin
      fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_3 = (_zz_when_State_l238_3 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_3 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_3 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_3 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_3 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l689_3_1 == _zz_when_WbSdCtrl_l689_3_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_3 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l692_3 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_3 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_26 = (_zz_when_StateMachine_l237_52 && (! _zz_when_StateMachine_l237_54)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_27 = (_zz_when_StateMachine_l237_53 && (! _zz_when_StateMachine_l237_55)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_38 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreCmd)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_39 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_40 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreDelay)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_41 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_42 = ((! _zz_when_StateMachine_l237_52) && _zz_when_StateMachine_l237_54); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_43 = ((! _zz_when_StateMachine_l237_53) && _zz_when_StateMachine_l237_55); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_56 = (fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg == fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_57 = (fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext == fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_12) begin
          fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_12 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_28 = (_zz_when_StateMachine_l237_56 && (! _zz_when_StateMachine_l237_57)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_44 = ((! _zz_when_StateMachine_l237_56) && _zz_when_StateMachine_l237_57); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_58 = (fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_59 = (fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_8) begin
          fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_8 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_29 = (_zz_when_StateMachine_l237_58 && (! _zz_when_StateMachine_l237_59)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_45 = ((! _zz_when_StateMachine_l237_58) && _zz_when_StateMachine_l237_59); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_60 = (fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_61 = (fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_13) begin
          fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_13 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_30 = (_zz_when_StateMachine_l237_60 && (! _zz_when_StateMachine_l237_61)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_46 = ((! _zz_when_StateMachine_l237_60) && _zz_when_StateMachine_l237_61); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_62 = (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_63 = (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_64 = (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_65 = (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd2_fsm_stateReg)
      fsm_SSDCmd2_fsm_enumDef_IDLE : begin
        fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd2_fsm_wantStart) begin
      fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd2_fsm_wantKill) begin
      fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_4 = (_zz_when_State_l238_4 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_4 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_4 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_4 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_4 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l689_4_1 == _zz_when_WbSdCtrl_l689_4_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_4 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l692_4 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_4 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_31 = (_zz_when_StateMachine_l237_62 && (! _zz_when_StateMachine_l237_64)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_32 = (_zz_when_StateMachine_l237_63 && (! _zz_when_StateMachine_l237_65)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_47 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_48 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_49 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_50 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_51 = ((! _zz_when_StateMachine_l237_62) && _zz_when_StateMachine_l237_64); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_52 = ((! _zz_when_StateMachine_l237_63) && _zz_when_StateMachine_l237_65); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_66 = (fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg == fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_67 = (fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext == fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_14) begin
          fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_14 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_33 = (_zz_when_StateMachine_l237_66 && (! _zz_when_StateMachine_l237_67)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_53 = ((! _zz_when_StateMachine_l237_66) && _zz_when_StateMachine_l237_67); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_68 = (fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_69 = (fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_9) begin
          fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_9 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_34 = (_zz_when_StateMachine_l237_68 && (! _zz_when_StateMachine_l237_69)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_54 = ((! _zz_when_StateMachine_l237_68) && _zz_when_StateMachine_l237_69); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_70 = (fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_71 = (fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_15) begin
          fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_15 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_35 = (_zz_when_StateMachine_l237_70 && (! _zz_when_StateMachine_l237_71)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_55 = ((! _zz_when_StateMachine_l237_70) && _zz_when_StateMachine_l237_71); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_72 = (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_73 = (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_74 = (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_75 = (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd3_fsm_stateReg)
      fsm_SSDCmd3_fsm_enumDef_IDLE : begin
        fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd3_fsm_wantStart) begin
      fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd3_fsm_wantKill) begin
      fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_5 = (_zz_when_State_l238_5 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_5 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_5 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_5 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_5 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l689_5_1 == _zz_when_WbSdCtrl_l689_5_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_5 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l692_5 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_5 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_36 = (_zz_when_StateMachine_l237_72 && (! _zz_when_StateMachine_l237_74)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_37 = (_zz_when_StateMachine_l237_73 && (! _zz_when_StateMachine_l237_75)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_56 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_57 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_58 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_59 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_60 = ((! _zz_when_StateMachine_l237_72) && _zz_when_StateMachine_l237_74); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_61 = ((! _zz_when_StateMachine_l237_73) && _zz_when_StateMachine_l237_75); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_76 = (fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg == fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_77 = (fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext == fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_16) begin
          fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_16 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_38 = (_zz_when_StateMachine_l237_76 && (! _zz_when_StateMachine_l237_77)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_62 = ((! _zz_when_StateMachine_l237_76) && _zz_when_StateMachine_l237_77); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_78 = (fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_79 = (fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_10) begin
          fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_10 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_39 = (_zz_when_StateMachine_l237_78 && (! _zz_when_StateMachine_l237_79)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_63 = ((! _zz_when_StateMachine_l237_78) && _zz_when_StateMachine_l237_79); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_80 = (fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_81 = (fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_17) begin
          fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_17 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_40 = (_zz_when_StateMachine_l237_80 && (! _zz_when_StateMachine_l237_81)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_64 = ((! _zz_when_StateMachine_l237_80) && _zz_when_StateMachine_l237_81); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_82 = (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_83 = (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_84 = (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_85 = (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd9_fsm_stateReg)
      fsm_SSDCmd9_fsm_enumDef_IDLE : begin
        fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd9_fsm_wantStart) begin
      fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd9_fsm_wantKill) begin
      fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_6 = (_zz_when_State_l238_6 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_6 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_6 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_6 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_6 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l689_6_1 == _zz_when_WbSdCtrl_l689_6_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_6 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l692_6 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_6 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_41 = (_zz_when_StateMachine_l237_82 && (! _zz_when_StateMachine_l237_84)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_42 = (_zz_when_StateMachine_l237_83 && (! _zz_when_StateMachine_l237_85)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_65 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_66 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_67 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_68 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_69 = ((! _zz_when_StateMachine_l237_82) && _zz_when_StateMachine_l237_84); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_70 = ((! _zz_when_StateMachine_l237_83) && _zz_when_StateMachine_l237_85); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_86 = (fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg == fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_87 = (fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext == fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_18) begin
          fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_18 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_43 = (_zz_when_StateMachine_l237_86 && (! _zz_when_StateMachine_l237_87)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_71 = ((! _zz_when_StateMachine_l237_86) && _zz_when_StateMachine_l237_87); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_88 = (fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_89 = (fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_11) begin
          fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_11 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_44 = (_zz_when_StateMachine_l237_88 && (! _zz_when_StateMachine_l237_89)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_72 = ((! _zz_when_StateMachine_l237_88) && _zz_when_StateMachine_l237_89); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_90 = (fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_91 = (fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_19) begin
          fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_19 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_45 = (_zz_when_StateMachine_l237_90 && (! _zz_when_StateMachine_l237_91)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_73 = ((! _zz_when_StateMachine_l237_90) && _zz_when_StateMachine_l237_91); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_92 = (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_93 = (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_94 = (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_95 = (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd7_fsm_stateReg)
      fsm_SSDCmd7_fsm_enumDef_IDLE : begin
        fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd7_fsm_wantStart) begin
      fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd7_fsm_wantKill) begin
      fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_7 = (_zz_when_State_l238_7 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_7 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_7 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_7 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_7 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l689_7_1 == _zz_when_WbSdCtrl_l689_7_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_7 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l692_7 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_7 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_46 = (_zz_when_StateMachine_l237_92 && (! _zz_when_StateMachine_l237_94)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_47 = (_zz_when_StateMachine_l237_93 && (! _zz_when_StateMachine_l237_95)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_74 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_75 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_76 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_77 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_78 = ((! _zz_when_StateMachine_l237_92) && _zz_when_StateMachine_l237_94); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_79 = ((! _zz_when_StateMachine_l237_93) && _zz_when_StateMachine_l237_95); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_96 = (fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg == fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_97 = (fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext == fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_20) begin
          fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_20 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_48 = (_zz_when_StateMachine_l237_96 && (! _zz_when_StateMachine_l237_97)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_80 = ((! _zz_when_StateMachine_l237_96) && _zz_when_StateMachine_l237_97); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_98 = (fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_99 = (fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_12) begin
          fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_12 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_49 = (_zz_when_StateMachine_l237_98 && (! _zz_when_StateMachine_l237_99)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_81 = ((! _zz_when_StateMachine_l237_98) && _zz_when_StateMachine_l237_99); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_100 = (fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_101 = (fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_21) begin
          fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_21 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_50 = (_zz_when_StateMachine_l237_100 && (! _zz_when_StateMachine_l237_101)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_82 = ((! _zz_when_StateMachine_l237_100) && _zz_when_StateMachine_l237_101); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_102 = (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_103 = (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_104 = (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_105 = (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd16_fsm_stateReg)
      fsm_SSDCmd16_fsm_enumDef_IDLE : begin
        fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd16_fsm_wantStart) begin
      fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd16_fsm_wantKill) begin
      fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_8 = (_zz_when_State_l238_8 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_8 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_8 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_8 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_8 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_8)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_8 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_8 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_51 = (_zz_when_StateMachine_l237_102 && (! _zz_when_StateMachine_l237_104)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_52 = (_zz_when_StateMachine_l237_103 && (! _zz_when_StateMachine_l237_105)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_83 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_84 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_85 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_86 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_87 = ((! _zz_when_StateMachine_l237_102) && _zz_when_StateMachine_l237_104); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_88 = ((! _zz_when_StateMachine_l237_103) && _zz_when_StateMachine_l237_105); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_106 = (fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg == fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_107 = (fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext == fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_22) begin
          fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_22 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_53 = (_zz_when_StateMachine_l237_106 && (! _zz_when_StateMachine_l237_107)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_89 = ((! _zz_when_StateMachine_l237_106) && _zz_when_StateMachine_l237_107); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_108 = (fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_109 = (fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_13) begin
          fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_13 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_54 = (_zz_when_StateMachine_l237_108 && (! _zz_when_StateMachine_l237_109)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_90 = ((! _zz_when_StateMachine_l237_108) && _zz_when_StateMachine_l237_109); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_110 = (fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_111 = (fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_23) begin
          fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_23 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_55 = (_zz_when_StateMachine_l237_110 && (! _zz_when_StateMachine_l237_111)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_91 = ((! _zz_when_StateMachine_l237_110) && _zz_when_StateMachine_l237_111); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_112 = (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_113 = (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_114 = (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_115 = (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_2_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_enumDef_IDLE : begin
        fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_2_fsm_wantStart) begin
      fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_2_fsm_wantKill) begin
      fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_9 = (_zz_when_State_l238_9 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_9 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_9 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_9 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_9 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_9)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_9 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_9 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_56 = (_zz_when_StateMachine_l237_112 && (! _zz_when_StateMachine_l237_114)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_57 = (_zz_when_StateMachine_l237_113 && (! _zz_when_StateMachine_l237_115)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_92 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_93 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_94 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_95 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_96 = ((! _zz_when_StateMachine_l237_112) && _zz_when_StateMachine_l237_114); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_97 = ((! _zz_when_StateMachine_l237_113) && _zz_when_StateMachine_l237_115); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_116 = (fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg == fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_117 = (fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext == fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_24) begin
          fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_24 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_58 = (_zz_when_StateMachine_l237_116 && (! _zz_when_StateMachine_l237_117)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_98 = ((! _zz_when_StateMachine_l237_116) && _zz_when_StateMachine_l237_117); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_118 = (fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg == fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_119 = (fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext == fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_14) begin
          fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_14 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_59 = (_zz_when_StateMachine_l237_118 && (! _zz_when_StateMachine_l237_119)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_99 = ((! _zz_when_StateMachine_l237_118) && _zz_when_StateMachine_l237_119); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_120 = (fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_121 = (fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_25) begin
          fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_25 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_60 = (_zz_when_StateMachine_l237_120 && (! _zz_when_StateMachine_l237_121)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_100 = ((! _zz_when_StateMachine_l237_120) && _zz_when_StateMachine_l237_121); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_122 = (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_123 = (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_124 = (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_125 = (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDACmd6_fsm_stateReg)
      fsm_SSDACmd6_fsm_enumDef_IDLE : begin
        fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreCmd : begin
        if(fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
        fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDACmd6_fsm_wantStart) begin
      fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SSDACmd6_fsm_wantKill) begin
      fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_10 = (_zz_when_State_l238_10 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_10 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_10 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_10 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_10 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l689_10 == _zz_when_WbSdCtrl_l689_10_1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_10 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l692_10 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_10 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_61 = (_zz_when_StateMachine_l237_122 && (! _zz_when_StateMachine_l237_124)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_62 = (_zz_when_StateMachine_l237_123 && (! _zz_when_StateMachine_l237_125)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_101 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreCmd)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_102 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreArguMent)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_103 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreDelay)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_104 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_105 = ((! _zz_when_StateMachine_l237_122) && _zz_when_StateMachine_l237_124); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_106 = ((! _zz_when_StateMachine_l237_123) && _zz_when_StateMachine_l237_125); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_126 = (fsm_SCoreBlkSize_fsm_stateReg == fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_127 = (fsm_SCoreBlkSize_fsm_stateNext == fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_15) begin
          fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreBlkSize_fsm_wantStart) begin
      fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreBlkSize_fsm_wantKill) begin
      fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_15 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_63 = (_zz_when_StateMachine_l237_126 && (! _zz_when_StateMachine_l237_127)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_107 = ((! _zz_when_StateMachine_l237_126) && _zz_when_StateMachine_l237_127); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_128 = (fsm_SCoreBlkNum_fsm_stateReg == fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_129 = (fsm_SCoreBlkNum_fsm_stateNext == fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_16) begin
          fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreBlkNum_fsm_wantStart) begin
      fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreBlkNum_fsm_wantKill) begin
      fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_16 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_64 = (_zz_when_StateMachine_l237_128 && (! _zz_when_StateMachine_l237_129)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_108 = ((! _zz_when_StateMachine_l237_128) && _zz_when_StateMachine_l237_129); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_130 = (fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg == fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_131 = (fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext == fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_26) begin
          fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_DmaAddr_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_DmaAddr_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_26 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_65 = (_zz_when_StateMachine_l237_130 && (! _zz_when_StateMachine_l237_131)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_109 = ((! _zz_when_StateMachine_l237_130) && _zz_when_StateMachine_l237_131); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_132 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_133 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_27) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_27 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_66 = (_zz_when_StateMachine_l237_132 && (! _zz_when_StateMachine_l237_133)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_110 = ((! _zz_when_StateMachine_l237_132) && _zz_when_StateMachine_l237_133); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_134 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_135 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_17) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_17 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_67 = (_zz_when_StateMachine_l237_134 && (! _zz_when_StateMachine_l237_135)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_111 = ((! _zz_when_StateMachine_l237_134) && _zz_when_StateMachine_l237_135); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_136 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_137 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_28) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_28 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_68 = (_zz_when_StateMachine_l237_136 && (! _zz_when_StateMachine_l237_137)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_112 = ((! _zz_when_StateMachine_l237_136) && _zz_when_StateMachine_l237_137); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_138 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_139 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_140 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_141 = (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd : begin
        if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_11 = (_zz_when_State_l238_11 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_11 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_11 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_11 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_11 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_11)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_11 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_11 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_69 = (_zz_when_StateMachine_l237_138 && (! _zz_when_StateMachine_l237_140)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_70 = (_zz_when_StateMachine_l237_139 && (! _zz_when_StateMachine_l237_141)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_113 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_114 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_115 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_116 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_117 = ((! _zz_when_StateMachine_l237_138) && _zz_when_StateMachine_l237_140); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_118 = ((! _zz_when_StateMachine_l237_139) && _zz_when_StateMachine_l237_141); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_142 = (fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg == fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_143 = (fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext == fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_29) begin
          fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_29 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_71 = (_zz_when_StateMachine_l237_142 && (! _zz_when_StateMachine_l237_143)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_119 = ((! _zz_when_StateMachine_l237_142) && _zz_when_StateMachine_l237_143); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_144 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_145 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_30) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_30 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_72 = (_zz_when_StateMachine_l237_144 && (! _zz_when_StateMachine_l237_145)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_120 = ((! _zz_when_StateMachine_l237_144) && _zz_when_StateMachine_l237_145); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_146 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_147 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_18) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_18 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_73 = (_zz_when_StateMachine_l237_146 && (! _zz_when_StateMachine_l237_147)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_121 = ((! _zz_when_StateMachine_l237_146) && _zz_when_StateMachine_l237_147); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_148 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_149 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_31) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_31 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_74 = (_zz_when_StateMachine_l237_148 && (! _zz_when_StateMachine_l237_149)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_122 = ((! _zz_when_StateMachine_l237_148) && _zz_when_StateMachine_l237_149); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_150 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_151 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_152 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_153 = (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
        if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
        if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_12 = (_zz_when_State_l238_12 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_12 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_12 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_12 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_12 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_12)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_12 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_12 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_75 = (_zz_when_StateMachine_l237_150 && (! _zz_when_StateMachine_l237_152)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_76 = (_zz_when_StateMachine_l237_151 && (! _zz_when_StateMachine_l237_153)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_123 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_124 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_125 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_126 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_127 = ((! _zz_when_StateMachine_l237_150) && _zz_when_StateMachine_l237_152); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_128 = ((! _zz_when_StateMachine_l237_151) && _zz_when_StateMachine_l237_153); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
        fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_DmaAddr; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
        if(fsm_SCoreSandData_fsm_DmaAddr_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_SSDCmd25; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
        if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_WrData; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
        if(when_WbSdCtrl_l740) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_CheckIsrDone; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_WrData; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
        if(when_WbSdCtrl_l749) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_ClearIsrData; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
        if(fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_SSDCmd12; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
        if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l734 = (((Swb_WE == 1'b0) && (Swb_CYC == 1'b1)) && (Swb_STB == 1'b1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l740 = (TotalBtyesNum <= fsm_SCoreSandData_fsm_TxCnt); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l749 = (ISRData == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_129 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_DmaAddr)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_DmaAddr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_130 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_SSDCmd25)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_SSDCmd25)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_131 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_ClearIsrData)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_ClearIsrData)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_132 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_SSDCmd12)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_SSDCmd12)); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_154 = (fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg == fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_155 = (fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext == fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext = fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg)
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext = fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_19) begin
          fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext = fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext = fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_DmaAddr_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext = fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_DmaAddr_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext = fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_19 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_77 = (_zz_when_StateMachine_l237_154 && (! _zz_when_StateMachine_l237_155)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_133 = ((! _zz_when_StateMachine_l237_154) && _zz_when_StateMachine_l237_155); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_156 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_157 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_32) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_32 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_78 = (_zz_when_StateMachine_l237_156 && (! _zz_when_StateMachine_l237_157)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_134 = ((! _zz_when_StateMachine_l237_156) && _zz_when_StateMachine_l237_157); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_158 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_159 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_20) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_20 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_79 = (_zz_when_StateMachine_l237_158 && (! _zz_when_StateMachine_l237_159)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_135 = ((! _zz_when_StateMachine_l237_158) && _zz_when_StateMachine_l237_159); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_160 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_161 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_33) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_33 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_80 = (_zz_when_StateMachine_l237_160 && (! _zz_when_StateMachine_l237_161)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_136 = ((! _zz_when_StateMachine_l237_160) && _zz_when_StateMachine_l237_161); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_162 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_163 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_164 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_165 = (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd : begin
        if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent : begin
        if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_13) begin
          fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish : begin
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_13 = (_zz_when_State_l238_13 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_13 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_13 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_13 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_13 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_13)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_13 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_13 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_81 = (_zz_when_StateMachine_l237_162 && (! _zz_when_StateMachine_l237_164)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_82 = (_zz_when_StateMachine_l237_163 && (! _zz_when_StateMachine_l237_165)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_137 = ((! (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd)) && (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_138 = ((! (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent)) && (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_139 = ((! (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay)) && (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_140 = ((! (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_141 = ((! _zz_when_StateMachine_l237_162) && _zz_when_StateMachine_l237_164); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_142 = ((! _zz_when_StateMachine_l237_163) && _zz_when_StateMachine_l237_165); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_166 = (fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg == fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_167 = (fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext == fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext = fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg)
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext = fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_21) begin
          fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext = fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext = fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext = fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext = fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_21 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_83 = (_zz_when_StateMachine_l237_166 && (! _zz_when_StateMachine_l237_167)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_143 = ((! _zz_when_StateMachine_l237_166) && _zz_when_StateMachine_l237_167); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_168 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_169 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_34) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_34 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_84 = (_zz_when_StateMachine_l237_168 && (! _zz_when_StateMachine_l237_169)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_144 = ((! _zz_when_StateMachine_l237_168) && _zz_when_StateMachine_l237_169); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_170 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_171 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l577_22) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l577_22 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_85 = (_zz_when_StateMachine_l237_170 && (! _zz_when_StateMachine_l237_171)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_145 = ((! _zz_when_StateMachine_l237_170) && _zz_when_StateMachine_l237_171); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_172 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_173 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        if(when_WbSdCtrl_l551_35) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdIDE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l551_35 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_86 = (_zz_when_StateMachine_l237_172 && (! _zz_when_StateMachine_l237_173)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_146 = ((! _zz_when_StateMachine_l237_172) && _zz_when_StateMachine_l237_173); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_174 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_175 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_176 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1); // @[BaseType.scala 305:24]
  assign _zz_when_StateMachine_l237_177 = (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
        if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
        if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
        if(when_State_l238_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
        if(when_WbSdCtrl_l648_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
        if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l669_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
        if(when_WbSdCtrl_l686_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l689_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l692_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        if(when_WbSdCtrl_l702_14) begin
          fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext = fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_State_l238_14 = (_zz_when_State_l238_14 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l648_14 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l669_14 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l686_14 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l689_14 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l689_14)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l692_14 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l702_14 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_87 = (_zz_when_StateMachine_l237_174 && (! _zz_when_StateMachine_l237_176)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l237_88 = (_zz_when_StateMachine_l237_175 && (! _zz_when_StateMachine_l237_177)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_147 = ((! (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd)) && (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_148 = ((! (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent)) && (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_149 = ((! (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay)) && (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_150 = ((! (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext == fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_151 = ((! _zz_when_StateMachine_l237_174) && _zz_when_StateMachine_l237_176); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_152 = ((! _zz_when_StateMachine_l237_175) && _zz_when_StateMachine_l237_177); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_ScoreGetData_fsm_stateReg)
      fsm_ScoreGetData_fsm_enumDef_IDLE : begin
        fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_DmaAddr; // @[Enum.scala 148:67]
      end
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : begin
        if(fsm_ScoreGetData_fsm_DmaAddr_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_SSDCmd18; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : begin
        if(fsm_ScoreGetData_fsm_SSDCmd18_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_RdData; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_RdData : begin
        if(when_WbSdCtrl_l815) begin
          fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_CheckIsrDone; // @[Enum.scala 148:67]
        end else begin
          fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_RdData; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : begin
        if(when_WbSdCtrl_l824) begin
          fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_ClearIsrData; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : begin
        if(fsm_ScoreGetData_fsm_ClearIsrData_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_SSDCmd12; // @[Enum.scala 148:67]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : begin
        if(fsm_ScoreGetData_fsm_SSDCmd12_fsm_wantExit) begin
          fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      default : begin
      end
    endcase
    if(fsm_ScoreGetData_fsm_wantStart) begin
      fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_ScoreGetData_fsm_wantKill) begin
      fsm_ScoreGetData_fsm_stateNext = fsm_ScoreGetData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l808 = (((Swb_CYC == 1'b1) && (Swb_STB == 1'b1)) && (Swb_WE == 1'b1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l815 = (TotalBtyesNum <= fsm_ScoreGetData_fsm_RxCnt); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l824 = (ISRData == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_153 = ((! (fsm_ScoreGetData_fsm_stateReg == fsm_ScoreGetData_fsm_enumDef_DmaAddr)) && (fsm_ScoreGetData_fsm_stateNext == fsm_ScoreGetData_fsm_enumDef_DmaAddr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_154 = ((! (fsm_ScoreGetData_fsm_stateReg == fsm_ScoreGetData_fsm_enumDef_SSDCmd18)) && (fsm_ScoreGetData_fsm_stateNext == fsm_ScoreGetData_fsm_enumDef_SSDCmd18)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_155 = ((! (fsm_ScoreGetData_fsm_stateReg == fsm_ScoreGetData_fsm_enumDef_ClearIsrData)) && (fsm_ScoreGetData_fsm_stateNext == fsm_ScoreGetData_fsm_enumDef_ClearIsrData)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_156 = ((! (fsm_ScoreGetData_fsm_stateReg == fsm_ScoreGetData_fsm_enumDef_SSDCmd12)) && (fsm_ScoreGetData_fsm_stateNext == fsm_ScoreGetData_fsm_enumDef_SSDCmd12)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_stateNext = fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_stateReg)
      fsm_enumDef_IDLE : begin
        fsm_stateNext = fsm_enumDef_SCoreRest; // @[Enum.scala 148:67]
      end
      fsm_enumDef_SCoreRest : begin
        if(fsm_SCoreRest_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreCmdTimeOut; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreCmdTimeOut : begin
        if(fsm_SCoreCmdTimeOut_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoredataTimeOut; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoredataTimeOut : begin
        if(fsm_SCoredataTimeOut_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreClkDivider; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreClkDivider : begin
        if(fsm_SCoreClkDivider_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreStart; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreStart : begin
        if(fsm_SCoreStart_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreCmdIsrEn; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreCmdIsrEn : begin
        if(fsm_SCoreCmdIsrEn_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreDataIsrEn; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreDataIsrEn : begin
        if(fsm_SCoreDataIsrEn_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreDataWithSet; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreDataWithSet : begin
        if(fsm_SCoreDataWithSet_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDCmd0; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDCmd0 : begin
        if(fsm_SSDCmd0_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDcmd8; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDcmd8 : begin
        if(fsm_SSDcmd8_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDcmd55; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDcmd55 : begin
        if(fsm_SSDcmd55_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDAcmd41; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDAcmd41 : begin
        if(fsm_SSDAcmd41_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDAcmd41Done; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDAcmd41Done : begin
        if(when_WbSdCtrl_l433) begin
          fsm_stateNext = fsm_enumDef_SSDCmd2; // @[Enum.scala 148:67]
        end else begin
          fsm_stateNext = fsm_enumDef_SSDcmd55; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDCmd2 : begin
        if(fsm_SSDCmd2_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDCmd3; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDCmd3 : begin
        if(fsm_SSDCmd3_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDStby; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDStby : begin
        if(when_WbSdCtrl_l461) begin
          fsm_stateNext = fsm_enumDef_SSDCmd3; // @[Enum.scala 148:67]
        end else begin
          fsm_stateNext = fsm_enumDef_SSDCmd9; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDCmd9 : begin
        if(fsm_SSDCmd9_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDWrOrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDWrOrRd : begin
        fsm_stateNext = fsm_enumDef_SSDCmd7; // @[Enum.scala 148:67]
      end
      fsm_enumDef_SSDCmd7 : begin
        if(fsm_SSDCmd7_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDCmd16; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDCmd16 : begin
        if(fsm_SSDCmd16_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDcmd55_2; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDcmd55_2 : begin
        if(fsm_SSDcmd55_2_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDACmd6; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDACmd6 : begin
        if(fsm_SSDACmd6_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreBlkSize; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreBlkSize : begin
        if(fsm_SCoreBlkSize_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SCoreBlkNum; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreBlkNum : begin
        if(fsm_SCoreBlkNum_fsm_wantExit) begin
          if(when_WbSdCtrl_l518) begin
            fsm_stateNext = fsm_enumDef_SCoreSandData; // @[Enum.scala 148:67]
          end else begin
            fsm_stateNext = fsm_enumDef_ScoreGetData; // @[Enum.scala 148:67]
          end
        end
      end
      fsm_enumDef_SCoreSandData : begin
        if(fsm_SCoreSandData_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDWrOrRd; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_ScoreGetData : begin
        if(fsm_ScoreGetData_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDWrOrRd; // @[Enum.scala 148:67]
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_IDLE; // @[Enum.scala 148:67]
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l433 = (CmdResponseRegA41[31] == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l461 = (RSPCardStatus != 4'b0011); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l477 = (SDWrOrRd == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l518 = (SDWrOrRd == 1'b0); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_157 = ((! (fsm_stateReg == fsm_enumDef_SCoreRest)) && (fsm_stateNext == fsm_enumDef_SCoreRest)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_158 = ((! (fsm_stateReg == fsm_enumDef_SCoreCmdTimeOut)) && (fsm_stateNext == fsm_enumDef_SCoreCmdTimeOut)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_159 = ((! (fsm_stateReg == fsm_enumDef_SCoredataTimeOut)) && (fsm_stateNext == fsm_enumDef_SCoredataTimeOut)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_160 = ((! (fsm_stateReg == fsm_enumDef_SCoreClkDivider)) && (fsm_stateNext == fsm_enumDef_SCoreClkDivider)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_161 = ((! (fsm_stateReg == fsm_enumDef_SCoreStart)) && (fsm_stateNext == fsm_enumDef_SCoreStart)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_162 = ((! (fsm_stateReg == fsm_enumDef_SCoreCmdIsrEn)) && (fsm_stateNext == fsm_enumDef_SCoreCmdIsrEn)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_163 = ((! (fsm_stateReg == fsm_enumDef_SCoreDataIsrEn)) && (fsm_stateNext == fsm_enumDef_SCoreDataIsrEn)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_164 = ((! (fsm_stateReg == fsm_enumDef_SCoreDataWithSet)) && (fsm_stateNext == fsm_enumDef_SCoreDataWithSet)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_165 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd0)) && (fsm_stateNext == fsm_enumDef_SSDCmd0)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_166 = ((! (fsm_stateReg == fsm_enumDef_SSDcmd8)) && (fsm_stateNext == fsm_enumDef_SSDcmd8)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_167 = ((! (fsm_stateReg == fsm_enumDef_SSDcmd55)) && (fsm_stateNext == fsm_enumDef_SSDcmd55)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_168 = ((! (fsm_stateReg == fsm_enumDef_SSDAcmd41)) && (fsm_stateNext == fsm_enumDef_SSDAcmd41)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_169 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd2)) && (fsm_stateNext == fsm_enumDef_SSDCmd2)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_170 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd3)) && (fsm_stateNext == fsm_enumDef_SSDCmd3)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_171 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd9)) && (fsm_stateNext == fsm_enumDef_SSDCmd9)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_172 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd7)) && (fsm_stateNext == fsm_enumDef_SSDCmd7)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_173 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd16)) && (fsm_stateNext == fsm_enumDef_SSDCmd16)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_174 = ((! (fsm_stateReg == fsm_enumDef_SSDcmd55_2)) && (fsm_stateNext == fsm_enumDef_SSDcmd55_2)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_175 = ((! (fsm_stateReg == fsm_enumDef_SSDACmd6)) && (fsm_stateNext == fsm_enumDef_SSDACmd6)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_176 = ((! (fsm_stateReg == fsm_enumDef_SCoreBlkSize)) && (fsm_stateNext == fsm_enumDef_SCoreBlkSize)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_177 = ((! (fsm_stateReg == fsm_enumDef_SCoreBlkNum)) && (fsm_stateNext == fsm_enumDef_SCoreBlkNum)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_178 = ((! (fsm_stateReg == fsm_enumDef_SCoreSandData)) && (fsm_stateNext == fsm_enumDef_SCoreSandData)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_179 = ((! (fsm_stateReg == fsm_enumDef_ScoreGetData)) && (fsm_stateNext == fsm_enumDef_ScoreGetData)); // @[BaseType.scala 305:24]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      NormalIsrStatus <= 32'h0; // @[Data.scala 400:33]
      CmdResponseRegA41 <= 32'h0; // @[Data.scala 400:33]
      CmdResponseReg2 <= 32'h0; // @[Data.scala 400:33]
      CmdResponseReg3 <= 32'h0; // @[Data.scala 400:33]
      RSPCardStatus <= 4'b0000; // @[Data.scala 400:33]
      Cmd7Config <= 32'h0; // @[Data.scala 400:33]
      TotalBtyesNum <= 32'h0; // @[Data.scala 400:33]
      We1 <= 1'b0; // @[Data.scala 400:33]
      We2 <= 1'b0; // @[Data.scala 400:33]
      Cyc1 <= 1'b0; // @[Data.scala 400:33]
      Cyc2 <= 1'b0; // @[Data.scala 400:33]
      Stb1 <= 1'b0; // @[Data.scala 400:33]
      Stb2 <= 1'b0; // @[Data.scala 400:33]
      Sel1 <= 4'b0000; // @[Data.scala 400:33]
      Sel2 <= 4'b0000; // @[Data.scala 400:33]
      addr1 <= 32'h0; // @[Data.scala 400:33]
      addr2 <= 32'h0; // @[Data.scala 400:33]
      Mosi1 <= 32'h0; // @[Data.scala 400:33]
      Mosi2 <= 32'h0; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_TxCnt <= 32'h0; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_RxCnt <= 32'h0; // @[Data.scala 400:33]
      fsm_SCoreRest_fsm_stateReg <= fsm_SCoreRest_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreCmdTimeOut_fsm_stateReg <= fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoredataTimeOut_fsm_stateReg <= fsm_SCoredataTimeOut_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreClkDivider_fsm_stateReg <= fsm_SCoreClkDivider_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreStart_fsm_stateReg <= fsm_SCoreStart_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreCmdIsrEn_fsm_stateReg <= fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreDataIsrEn_fsm_stateReg <= fsm_SCoreDataIsrEn_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreDataWithSet_fsm_stateReg <= fsm_SCoreDataWithSet_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd0_fsm_stateReg <= fsm_SSDCmd0_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd8_fsm_stateReg <= fsm_SSDcmd8_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_fsm_stateReg <= fsm_SSDcmd55_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDAcmd41_fsm_stateReg <= fsm_SSDAcmd41_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd2_fsm_stateReg <= fsm_SSDCmd2_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd3_fsm_stateReg <= fsm_SSDCmd3_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd9_fsm_stateReg <= fsm_SSDCmd9_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd7_fsm_stateReg <= fsm_SSDCmd7_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDCmd16_fsm_stateReg <= fsm_SSDCmd16_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDcmd55_2_fsm_stateReg <= fsm_SSDcmd55_2_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SSDACmd6_fsm_stateReg <= fsm_SSDACmd6_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreBlkSize_fsm_stateReg <= fsm_SCoreBlkSize_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreBlkNum_fsm_stateReg <= fsm_SCoreBlkNum_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg <= fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg <= fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_stateReg <= fsm_SCoreSandData_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg <= fsm_ScoreGetData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg <= fsm_ScoreGetData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_ScoreGetData_fsm_stateReg <= fsm_ScoreGetData_fsm_enumDef_BOOT; // @[Data.scala 400:33]
      fsm_stateReg <= fsm_enumDef_BOOT; // @[Data.scala 400:33]
    end else begin
      TotalBtyesNum <= (SDWrOrRdBlkNum <<< 9); // @[WbSdCtrl.scala 215:17]
      fsm_SCoreRest_fsm_stateReg <= fsm_SCoreRest_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {31'd0, _zz_Mosi1}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreCmdTimeOut_fsm_stateReg <= fsm_SCoreCmdTimeOut_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_1) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_1) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {26'd0, _zz_addr2}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SCoredataTimeOut_fsm_stateReg <= fsm_SCoredataTimeOut_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_2) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_2) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {27'd0, _zz_addr1_1}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreClkDivider_fsm_stateReg <= fsm_SCoreClkDivider_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_3) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_3) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {26'd0, _zz_addr2_1}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SCoreStart_fsm_stateReg <= fsm_SCoreStart_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_4) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_4) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_2}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreCmdIsrEn_fsm_stateReg <= fsm_SCoreCmdIsrEn_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_5) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_5) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {26'd0, _zz_addr2_2}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= {27'd0, _zz_Mosi2}; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SCoreDataIsrEn_fsm_stateReg <= fsm_SCoreDataIsrEn_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_6) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_6) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {25'd0, _zz_addr1_3}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {27'd0, _zz_Mosi1_1}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreDataWithSet_fsm_stateReg <= fsm_SCoreDataWithSet_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_7) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_7) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {27'd0, _zz_addr2_3}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= {31'd0, _zz_Mosi2_1}; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_8) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_8) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_4}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_9) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_9) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_10) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_10) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_5}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd0_fsm_stateReg <= fsm_SSDCmd0_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDCmd0_fsm_stateReg)
        fsm_SSDCmd0_fsm_enumDef_IDLE : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_4}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_11) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_12) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_15) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_5}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_16) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_6}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_13) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_17) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_6}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {20'd0, _zz_Mosi1_2}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_14) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_18) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= {23'd0, _zz_Mosi2_2}; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_15) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_19) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_7}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDcmd8_fsm_stateReg <= fsm_SSDcmd8_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDcmd8_fsm_stateReg)
        fsm_SSDcmd8_fsm_enumDef_IDLE : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_7}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_16) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_17) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_24) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_8}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_25) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_9}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_18) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_26) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_8}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {18'd0, _zz_Mosi1_3}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_19) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_27) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_20) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_28) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_9}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDcmd55_fsm_stateReg <= fsm_SSDcmd55_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDcmd55_fsm_stateReg)
        fsm_SSDcmd55_fsm_enumDef_IDLE : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_10}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_21) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_22) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_33) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_11}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_34) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_12}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_23) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_35) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_10}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {18'd0, _zz_Mosi1_4}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_24) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_36) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= {1'd0, _zz_Mosi2_3}; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_25) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_37) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_11}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDAcmd41_fsm_stateReg <= fsm_SSDAcmd41_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDAcmd41_fsm_stateReg)
        fsm_SSDAcmd41_fsm_enumDef_IDLE : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_13}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_26) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_27) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_42) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_14}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_43) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_15}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_28) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_44) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_12}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {22'd0, _zz_Mosi1_5}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_29) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_45) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_30) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_46) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_13}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd2_fsm_stateReg <= fsm_SSDCmd2_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDCmd2_fsm_stateReg)
        fsm_SSDCmd2_fsm_enumDef_IDLE : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_16}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_31) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_32) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_51) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_17}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_52) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_18}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_33) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_53) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_14}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {22'd0, _zz_Mosi1_6}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_34) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_54) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_35) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_55) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_15}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd3_fsm_stateReg <= fsm_SSDCmd3_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDCmd3_fsm_stateReg)
        fsm_SSDCmd3_fsm_enumDef_IDLE : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_19}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_36) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_37) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_60) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_20}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_61) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_21}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_38) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_62) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_16}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {20'd0, _zz_Mosi1_7}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_39) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_63) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= _zz_Mosi2_4; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_40) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_64) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_17}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd9_fsm_stateReg <= fsm_SSDCmd9_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDCmd9_fsm_stateReg)
        fsm_SSDCmd9_fsm_enumDef_IDLE : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_22}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_41) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_42) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_69) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_23}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_70) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_24}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_43) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_71) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_18}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= _zz_Mosi1_8; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_44) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_72) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= _zz_Mosi2_5; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_45) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_73) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_19}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd7_fsm_stateReg <= fsm_SSDCmd7_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDCmd7_fsm_stateReg)
        fsm_SSDCmd7_fsm_enumDef_IDLE : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_25}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_46) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_47) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_78) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_26}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_79) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_27}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_48) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_80) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_20}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {19'd0, _zz_Mosi1_9}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_49) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_81) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= {22'd0, _zz_Mosi2_6}; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_50) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_82) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_21}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDCmd16_fsm_stateReg <= fsm_SSDCmd16_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDCmd16_fsm_stateReg)
        fsm_SSDCmd16_fsm_enumDef_IDLE : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_28}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_51) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_52) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_87) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_29}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_88) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_30}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_53) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_89) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_22}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {18'd0, _zz_Mosi1_10}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_54) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_90) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= _zz_Mosi2_7; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_55) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_91) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_23}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDcmd55_2_fsm_stateReg <= fsm_SSDcmd55_2_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDcmd55_2_fsm_stateReg)
        fsm_SSDcmd55_2_fsm_enumDef_IDLE : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_31}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_56) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_57) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_96) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_32}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_97) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_33}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_58) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_98) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_24}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {21'd0, _zz_Mosi1_11}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_59) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_99) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= {30'd0, _zz_Mosi2_8}; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_60) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_100) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_25}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SSDACmd6_fsm_stateReg <= fsm_SSDACmd6_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SSDACmd6_fsm_stateReg)
        fsm_SSDACmd6_fsm_enumDef_IDLE : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_34}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_61) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_62) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_105) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_35}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_106) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_36}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SCoreBlkSize_fsm_stateReg <= fsm_SCoreBlkSize_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_63) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_107) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {25'd0, _zz_addr2_37}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= {23'd0, _zz_Mosi2_9}; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SCoreBlkNum_fsm_stateReg <= fsm_SCoreBlkNum_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_64) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_108) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {25'd0, _zz_addr2_38}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= _zz_Mosi2_10; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg <= fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_65) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_109) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {25'd0, _zz_addr1_26}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_66) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_110) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_27}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {19'd0, _zz_Mosi1_12}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_67) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_111) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_68) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_112) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_28}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg)
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_39}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_69) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_70) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_117) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_40}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_118) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_41}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg <= fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_71) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_119) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_29}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_72) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_120) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_30}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {20'd0, _zz_Mosi1_13}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_73) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_121) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_74) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_122) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_31}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg)
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_42}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_75) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_76) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_127) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_43}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_128) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_44}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_SCoreSandData_fsm_stateReg <= fsm_SCoreSandData_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SCoreSandData_fsm_stateReg)
        fsm_SCoreSandData_fsm_enumDef_IDLE : begin
        end
        fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
        end
        fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
        end
        fsm_SCoreSandData_fsm_enumDef_WrData : begin
          if(when_WbSdCtrl_l734) begin
            fsm_SCoreSandData_fsm_TxCnt <= (fsm_SCoreSandData_fsm_TxCnt + 32'h00000001); // @[WbSdCtrl.scala 735:19]
          end
        end
        fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
        end
        fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
        end
        fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
        end
        default : begin
        end
      endcase
      fsm_ScoreGetData_fsm_DmaAddr_fsm_stateReg <= fsm_ScoreGetData_fsm_DmaAddr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_77) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_133) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {25'd0, _zz_addr2_45}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= _zz_Mosi2_11; // @[WbSdCtrl.scala 267:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_78) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_134) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_32}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {19'd0, _zz_Mosi1_14}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_79) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_135) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_80) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_136) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_33}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg)
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_46}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_81) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_82) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_141) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_47}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_142) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_48}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateReg <= fsm_ScoreGetData_fsm_ClearIsrData_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_83) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_143) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= {26'd0, _zz_addr2_49}; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_84) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_144) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {29'd0, _zz_addr1_34}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= {20'd0, _zz_Mosi1_15}; // @[WbSdCtrl.scala 258:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_85) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_145) begin
        We2 <= 1'b1; // @[WbSdCtrl.scala 262:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 263:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 264:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 265:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 266:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 267:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
      if(when_StateMachine_l237_86) begin
        We1 <= 1'b0; // @[WbSdCtrl.scala 271:9]
        Cyc1 <= 1'b0; // @[WbSdCtrl.scala 272:10]
        Stb1 <= 1'b0; // @[WbSdCtrl.scala 273:10]
        Sel1 <= 4'b0000; // @[WbSdCtrl.scala 274:10]
        addr1 <= 32'h0; // @[WbSdCtrl.scala 275:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 276:11]
      end
      if(when_StateMachine_l253_146) begin
        We1 <= 1'b1; // @[WbSdCtrl.scala 253:9]
        Cyc1 <= 1'b1; // @[WbSdCtrl.scala 254:10]
        Stb1 <= 1'b1; // @[WbSdCtrl.scala 255:10]
        Sel1 <= 4'b1111; // @[WbSdCtrl.scala 256:10]
        addr1 <= {26'd0, _zz_addr1_35}; // @[WbSdCtrl.scala 257:11]
        Mosi1 <= 32'h0; // @[WbSdCtrl.scala 258:11]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg <= fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg)
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
          We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
          Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
          Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
          Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
          addr2 <= {26'd0, _zz_addr2_50}; // @[WbSdCtrl.scala 338:11]
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      if(when_StateMachine_l237_87) begin
        NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 674:27]
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l237_88) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 280:9]
        Cyc2 <= 1'b0; // @[WbSdCtrl.scala 281:10]
        Stb2 <= 1'b0; // @[WbSdCtrl.scala 282:10]
        Sel2 <= 4'b0000; // @[WbSdCtrl.scala 283:10]
        addr2 <= 32'h0; // @[WbSdCtrl.scala 284:11]
        Mosi2 <= 32'h0; // @[WbSdCtrl.scala 285:11]
      end
      if(when_StateMachine_l253_151) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {26'd0, _zz_addr2_51}; // @[WbSdCtrl.scala 338:11]
      end
      if(when_StateMachine_l253_152) begin
        We2 <= 1'b0; // @[WbSdCtrl.scala 334:9]
        Cyc2 <= 1'b1; // @[WbSdCtrl.scala 335:10]
        Stb2 <= 1'b1; // @[WbSdCtrl.scala 336:10]
        Sel2 <= 4'b1111; // @[WbSdCtrl.scala 337:10]
        addr2 <= {28'd0, _zz_addr2_52}; // @[WbSdCtrl.scala 338:11]
      end
      fsm_ScoreGetData_fsm_stateReg <= fsm_ScoreGetData_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_ScoreGetData_fsm_stateReg)
        fsm_ScoreGetData_fsm_enumDef_IDLE : begin
        end
        fsm_ScoreGetData_fsm_enumDef_DmaAddr : begin
        end
        fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : begin
        end
        fsm_ScoreGetData_fsm_enumDef_RdData : begin
          if(when_WbSdCtrl_l808) begin
            fsm_ScoreGetData_fsm_RxCnt <= (fsm_ScoreGetData_fsm_RxCnt + 32'h00000001); // @[WbSdCtrl.scala 809:19]
          end
        end
        fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : begin
        end
        fsm_ScoreGetData_fsm_enumDef_ClearIsrData : begin
        end
        fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : begin
        end
        default : begin
        end
      endcase
      fsm_stateReg <= fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_stateReg)
        fsm_enumDef_IDLE : begin
        end
        fsm_enumDef_SCoreRest : begin
        end
        fsm_enumDef_SCoreCmdTimeOut : begin
        end
        fsm_enumDef_SCoredataTimeOut : begin
        end
        fsm_enumDef_SCoreClkDivider : begin
        end
        fsm_enumDef_SCoreStart : begin
        end
        fsm_enumDef_SCoreCmdIsrEn : begin
        end
        fsm_enumDef_SCoreDataIsrEn : begin
        end
        fsm_enumDef_SCoreDataWithSet : begin
        end
        fsm_enumDef_SSDCmd0 : begin
        end
        fsm_enumDef_SSDcmd8 : begin
        end
        fsm_enumDef_SSDcmd55 : begin
        end
        fsm_enumDef_SSDAcmd41 : begin
          if(fsm_SSDAcmd41_fsm_wantExit) begin
            CmdResponseRegA41 <= CmdResponseReg; // @[WbSdCtrl.scala 426:27]
          end
        end
        fsm_enumDef_SSDAcmd41Done : begin
        end
        fsm_enumDef_SSDCmd2 : begin
          if(fsm_SSDCmd2_fsm_wantExit) begin
            CmdResponseReg2 <= CmdResponseReg; // @[WbSdCtrl.scala 443:25]
          end
        end
        fsm_enumDef_SSDCmd3 : begin
          if(fsm_SSDCmd3_fsm_wantExit) begin
            CmdResponseReg3 <= {CmdResponseReg[31 : 16],LBits}; // @[WbSdCtrl.scala 451:25]
            RSPCardStatus <= CmdResponseReg[12 : 9]; // @[WbSdCtrl.scala 452:23]
          end
        end
        fsm_enumDef_SSDStby : begin
        end
        fsm_enumDef_SSDCmd9 : begin
        end
        fsm_enumDef_SSDWrOrRd : begin
          if(when_WbSdCtrl_l477) begin
            Cmd7Config <= 32'h00000759; // @[WbSdCtrl.scala 478:22]
          end else begin
            Cmd7Config <= 32'h00000739; // @[WbSdCtrl.scala 480:22]
          end
        end
        fsm_enumDef_SSDCmd7 : begin
          if(fsm_SSDCmd7_fsm_wantExit) begin
            RSPCardStatus <= CmdResponseReg[12 : 9]; // @[WbSdCtrl.scala 491:23]
          end
        end
        fsm_enumDef_SSDCmd16 : begin
        end
        fsm_enumDef_SSDcmd55_2 : begin
        end
        fsm_enumDef_SSDACmd6 : begin
        end
        fsm_enumDef_SCoreBlkSize : begin
        end
        fsm_enumDef_SCoreBlkNum : begin
        end
        fsm_enumDef_SCoreSandData : begin
        end
        fsm_enumDef_ScoreGetData : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(when_WbSdCtrl_l110) begin
      CmdResponseReg <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 110:35]
    end
    case(fsm_SSDCmd0_fsm_stateReg)
      fsm_SSDCmd0_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238 <= (_zz_when_State_l238 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_13) begin
      _zz_when_State_l238 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDcmd8_fsm_stateReg)
      fsm_SSDcmd8_fsm_enumDef_IDLE : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_1 <= (_zz_when_State_l238_1 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_22) begin
      _zz_when_State_l238_1 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDcmd55_fsm_stateReg)
      fsm_SSDcmd55_fsm_enumDef_IDLE : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_2 <= (_zz_when_State_l238_2 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_31) begin
      _zz_when_State_l238_2 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDAcmd41_fsm_stateReg)
      fsm_SSDAcmd41_fsm_enumDef_IDLE : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_3 <= (_zz_when_State_l238_3 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_40) begin
      _zz_when_State_l238_3 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDCmd2_fsm_stateReg)
      fsm_SSDCmd2_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_4 <= (_zz_when_State_l238_4 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_49) begin
      _zz_when_State_l238_4 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDCmd3_fsm_stateReg)
      fsm_SSDCmd3_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_5 <= (_zz_when_State_l238_5 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_58) begin
      _zz_when_State_l238_5 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDCmd9_fsm_stateReg)
      fsm_SSDCmd9_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_6 <= (_zz_when_State_l238_6 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_67) begin
      _zz_when_State_l238_6 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDCmd7_fsm_stateReg)
      fsm_SSDCmd7_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_7 <= (_zz_when_State_l238_7 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_76) begin
      _zz_when_State_l238_7 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDCmd16_fsm_stateReg)
      fsm_SSDCmd16_fsm_enumDef_IDLE : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_8 <= (_zz_when_State_l238_8 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_85) begin
      _zz_when_State_l238_8 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDcmd55_2_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_enumDef_IDLE : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_9 <= (_zz_when_State_l238_9 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_94) begin
      _zz_when_State_l238_9 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SSDACmd6_fsm_stateReg)
      fsm_SSDACmd6_fsm_enumDef_IDLE : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_10 <= (_zz_when_State_l238_10 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_103) begin
      _zz_when_State_l238_10 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_11 <= (_zz_when_State_l238_11 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_115) begin
      _zz_when_State_l238_11 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_12 <= (_zz_when_State_l238_12 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_125) begin
      _zz_when_State_l238_12 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_ScoreGetData_fsm_SSDCmd18_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreCmd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_13 <= (_zz_when_State_l238_13 - 9'h001); // @[State.scala 237:17]
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd18_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_139) begin
      _zz_when_State_l238_13 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_ScoreGetData_fsm_SSDCmd12_fsm_stateReg)
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay : begin
        _zz_when_State_l238_14 <= (_zz_when_State_l238_14 - 9'h001); // @[State.scala 237:17]
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreWaitCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_ScoreGetData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_149) begin
      _zz_when_State_l238_14 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_ScoreGetData_fsm_stateReg)
      fsm_ScoreGetData_fsm_enumDef_IDLE : begin
      end
      fsm_ScoreGetData_fsm_enumDef_DmaAddr : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd18 : begin
      end
      fsm_ScoreGetData_fsm_enumDef_RdData : begin
        if(when_WbSdCtrl_l808) begin
          fsm_ScoreGetData_fsm_RxData <= Swb_DAT_MOSI; // @[WbSdCtrl.scala 813:20]
        end
      end
      fsm_ScoreGetData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_ScoreGetData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_ScoreGetData_fsm_enumDef_SSDCmd12 : begin
      end
      default : begin
      end
    endcase
  end


endmodule
