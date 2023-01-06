// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : WishboneSdioMasterCtrl
// Git hash  : cc7dab01becb71a5fd3a0c12616793f00169bab4

`timescale 1ns/1ps

module WishboneSdioMasterCtrl (
  output reg          Mwb_CYC,
  output reg          Mwb_STB,
  input               Mwb_ACK,
  output reg          Mwb_WE,
  output reg [31:0]   Mwb_ADR,
  input      [31:0]   Mwb_DAT_MISO,
  output reg [31:0]   Mwb_DAT_MOSI,
  output reg [3:0]    Mwb_SEL,
  input               Swb_CYC,
  input               Swb_STB,
  output reg          Swb_ACK,
  input               Swb_WE,
  input      [31:0]   Swb_ADR,
  output reg [31:0]   Swb_DAT_MISO,
  input      [31:0]   Swb_DAT_MOSI,
  input      [3:0]    Swb_SEL,
  output     [31:0]   RSPReg,
  output     [31:0]   RSPReg41,
  output     [31:0]   RSPReg2,
  output     [31:0]   RSPReg3,
  output     [31:0]   Rddata,
  input               ISRCmd,
  input               ISRData,
  input               clk,
  input               reset
);
  localparam fsm_SCoreRest_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreRest_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreRest_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreRest_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreClkDivider_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreStart_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreStart_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreStart_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreStart_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SCoreBlkSize_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreBlkNum_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck = 2'd2;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr = 2'd3;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand = 2'd1;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck = 2'd2;
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
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 = 4'd10;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet = 4'd11;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait = 4'd12;
  localparam fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish = 4'd13;
  localparam fsm_SCoreSandData_fsm_enumDef_BOOT = 4'd0;
  localparam fsm_SCoreSandData_fsm_enumDef_IDLE = 4'd1;
  localparam fsm_SCoreSandData_fsm_enumDef_DmaAddr = 4'd2;
  localparam fsm_SCoreSandData_fsm_enumDef_SSDCmd25 = 4'd3;
  localparam fsm_SCoreSandData_fsm_enumDef_WrData = 4'd4;
  localparam fsm_SCoreSandData_fsm_enumDef_WrDataDelay = 4'd5;
  localparam fsm_SCoreSandData_fsm_enumDef_CheckIsrDone = 4'd6;
  localparam fsm_SCoreSandData_fsm_enumDef_ClearIsrData = 4'd7;
  localparam fsm_SCoreSandData_fsm_enumDef_SSDCmd12 = 4'd8;
  localparam fsm_SCoreSandData_fsm_enumDef_BdIsr = 4'd9;
  localparam fsm_SCoreSandData_fsm_enumDef_BdIsrGet = 4'd10;
  localparam fsm_SCoreSandData_fsm_enumDef_BdIsrCheck = 4'd11;
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
  localparam fsm_enumDef_SSDCmd7 = 5'd19;
  localparam fsm_enumDef_SSDCmd16 = 5'd20;
  localparam fsm_enumDef_SSDcmd55_2 = 5'd21;
  localparam fsm_enumDef_SSDACmd6 = 5'd22;
  localparam fsm_enumDef_SCoreBlkSize = 5'd23;
  localparam fsm_enumDef_SCoreBlkNum = 5'd24;
  localparam fsm_enumDef_SCoreSandData = 5'd25;
  localparam fsm_enumDef_SCoreAddrAdd = 5'd26;

  wire       [0:0]    _zz_Mwb_DAT_MOSI_26;
  wire       [0:0]    _zz_Mwb_DAT_MOSI_27;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_28;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_29;
  wire       [4:0]    _zz_Mwb_DAT_MOSI_30;
  wire       [4:0]    _zz_Mwb_DAT_MOSI_31;
  wire       [4:0]    _zz_Mwb_DAT_MOSI_32;
  wire       [4:0]    _zz_Mwb_DAT_MOSI_33;
  wire       [0:0]    _zz_Mwb_DAT_MOSI_34;
  wire       [0:0]    _zz_Mwb_DAT_MOSI_35;
  wire       [5:0]    _zz_Mwb_ADR_38;
  wire       [5:0]    _zz_Mwb_ADR_39;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_6;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_7;
  wire       [3:0]    _zz_Mwb_ADR_40;
  wire       [3:0]    _zz_Mwb_ADR_41;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_36;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_37;
  wire       [8:0]    _zz_Mwb_DAT_MOSI_38;
  wire       [8:0]    _zz_Mwb_DAT_MOSI_39;
  wire       [5:0]    _zz_Mwb_ADR_42;
  wire       [5:0]    _zz_Mwb_ADR_43;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_1_1;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_1_2;
  wire       [3:0]    _zz_Mwb_ADR_44;
  wire       [3:0]    _zz_Mwb_ADR_45;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_40;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_41;
  wire       [5:0]    _zz_Mwb_ADR_46;
  wire       [5:0]    _zz_Mwb_ADR_47;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_2_1;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_2_2;
  wire       [3:0]    _zz_Mwb_ADR_48;
  wire       [3:0]    _zz_Mwb_ADR_49;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_42;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_43;
  wire       [30:0]   _zz_Mwb_DAT_MOSI_44;
  wire       [30:0]   _zz_Mwb_DAT_MOSI_45;
  wire       [5:0]    _zz_Mwb_ADR_50;
  wire       [5:0]    _zz_Mwb_ADR_51;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_3_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_3_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_3_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l531_3;
  wire       [3:0]    _zz_Mwb_ADR_52;
  wire       [3:0]    _zz_Mwb_ADR_53;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_46;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_47;
  wire       [5:0]    _zz_Mwb_ADR_54;
  wire       [5:0]    _zz_Mwb_ADR_55;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_4_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_4_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_4_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l531_4;
  wire       [3:0]    _zz_Mwb_ADR_56;
  wire       [3:0]    _zz_Mwb_ADR_57;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_48;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_49;
  wire       [5:0]    _zz_Mwb_ADR_58;
  wire       [5:0]    _zz_Mwb_ADR_59;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_5_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_5_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_5_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l531_5;
  wire       [3:0]    _zz_Mwb_ADR_60;
  wire       [3:0]    _zz_Mwb_ADR_61;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_50;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_51;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_52;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_53;
  wire       [5:0]    _zz_Mwb_ADR_62;
  wire       [5:0]    _zz_Mwb_ADR_63;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_6_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_6_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_6_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l531_6;
  wire       [3:0]    _zz_Mwb_ADR_64;
  wire       [3:0]    _zz_Mwb_ADR_65;
  wire       [10:0]   _zz_Mwb_DAT_MOSI_54;
  wire       [10:0]   _zz_Mwb_DAT_MOSI_55;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_56;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_57;
  wire       [5:0]    _zz_Mwb_ADR_66;
  wire       [5:0]    _zz_Mwb_ADR_67;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_7_1;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_7_2;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_7_3;
  wire       [31:0]   _zz_when_WbSdCtrl_l531_7;
  wire       [3:0]    _zz_Mwb_ADR_68;
  wire       [3:0]    _zz_Mwb_ADR_69;
  wire       [12:0]   _zz_Mwb_DAT_MOSI_58;
  wire       [12:0]   _zz_Mwb_DAT_MOSI_59;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_60;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_61;
  wire       [5:0]    _zz_Mwb_ADR_70;
  wire       [5:0]    _zz_Mwb_ADR_71;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_8;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_8_1;
  wire       [3:0]    _zz_Mwb_ADR_72;
  wire       [3:0]    _zz_Mwb_ADR_73;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_62;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_63;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_64;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_65;
  wire       [5:0]    _zz_Mwb_ADR_74;
  wire       [5:0]    _zz_Mwb_ADR_75;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_9;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_9_1;
  wire       [3:0]    _zz_Mwb_ADR_76;
  wire       [3:0]    _zz_Mwb_ADR_77;
  wire       [10:0]   _zz_Mwb_DAT_MOSI_66;
  wire       [10:0]   _zz_Mwb_DAT_MOSI_67;
  wire       [1:0]    _zz_Mwb_DAT_MOSI_68;
  wire       [1:0]    _zz_Mwb_DAT_MOSI_69;
  wire       [5:0]    _zz_Mwb_ADR_78;
  wire       [5:0]    _zz_Mwb_ADR_79;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_10;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_10_1;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_10_2;
  wire       [31:0]   _zz_when_WbSdCtrl_l531_10;
  wire       [3:0]    _zz_Mwb_ADR_80;
  wire       [3:0]    _zz_Mwb_ADR_81;
  wire       [8:0]    _zz_Mwb_DAT_MOSI_70;
  wire       [8:0]    _zz_Mwb_DAT_MOSI_71;
  wire       [7:0]    _zz_Mwb_DAT_MOSI_72;
  wire       [7:0]    _zz_Mwb_DAT_MOSI_73;
  wire       [12:0]   _zz_Mwb_DAT_MOSI_74;
  wire       [12:0]   _zz_Mwb_DAT_MOSI_75;
  wire       [5:0]    _zz_Mwb_ADR_82;
  wire       [5:0]    _zz_Mwb_ADR_83;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_11;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_11_1;
  wire       [3:0]    _zz_Mwb_ADR_84;
  wire       [3:0]    _zz_Mwb_ADR_85;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_76;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_77;
  wire       [5:0]    _zz_Mwb_ADR_86;
  wire       [5:0]    _zz_Mwb_ADR_87;
  wire       [31:0]   _zz_when_WbSdCtrl_l528_12;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_12_1;
  wire       [3:0]    _zz_Mwb_ADR_88;
  wire       [3:0]    _zz_Mwb_ADR_89;
  wire       [31:0]   _zz_Swb_DAT_MISO;
  wire       [5:0]    _zz_Mwb_ADR_90;
  wire       [5:0]    _zz_Mwb_ADR_91;
  reg        [31:0]   NormalIsrStatus;
  reg        [31:0]   CmdResponseRegA41;
  reg        [31:0]   CmdResponseReg2;
  reg        [31:0]   CmdResponseReg3;
  wire       [31:0]   cmdResponseReg7;
  reg        [31:0]   BdIsrStatus;
  reg        [3:0]    RSPCardStatus;
  wire       [3:0]    FBTXNum;
  wire       [3:0]    FBRxNum;
  wire       [31:0]   GetRdData;
  reg        [31:0]   TestBclkAddr;
  wire                when_WbSdCtrl_l68;
  reg        [31:0]   CmdResponseReg;
  wire       [15:0]   LBits;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  wire       [5:0]    _zz_Mwb_ADR;
  wire       [0:0]    _zz_Mwb_DAT_MOSI;
  reg                 fsm_SCoreRest_fsm_wantExit;
  reg                 fsm_SCoreRest_fsm_wantStart;
  wire                fsm_SCoreRest_fsm_wantKill;
  wire       [5:0]    _zz_Mwb_ADR_1;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_1;
  reg                 fsm_SCoreCmdTimeOut_fsm_wantExit;
  reg                 fsm_SCoreCmdTimeOut_fsm_wantStart;
  wire                fsm_SCoreCmdTimeOut_fsm_wantKill;
  wire       [4:0]    _zz_Mwb_ADR_2;
  reg                 fsm_SCoredataTimeOut_fsm_wantExit;
  reg                 fsm_SCoredataTimeOut_fsm_wantStart;
  wire                fsm_SCoredataTimeOut_fsm_wantKill;
  wire       [5:0]    _zz_Mwb_ADR_3;
  reg                 fsm_SCoreClkDivider_fsm_wantExit;
  reg                 fsm_SCoreClkDivider_fsm_wantStart;
  wire                fsm_SCoreClkDivider_fsm_wantKill;
  wire       [5:0]    _zz_Mwb_ADR_4;
  reg                 fsm_SCoreStart_fsm_wantExit;
  reg                 fsm_SCoreStart_fsm_wantStart;
  wire                fsm_SCoreStart_fsm_wantKill;
  wire       [5:0]    _zz_Mwb_ADR_5;
  wire       [4:0]    _zz_Mwb_DAT_MOSI_2;
  reg                 fsm_SCoreCmdIsrEn_fsm_wantExit;
  reg                 fsm_SCoreCmdIsrEn_fsm_wantStart;
  wire                fsm_SCoreCmdIsrEn_fsm_wantKill;
  wire       [6:0]    _zz_Mwb_ADR_6;
  wire       [4:0]    _zz_Mwb_DAT_MOSI_3;
  reg                 fsm_SCoreDataIsrEn_fsm_wantExit;
  reg                 fsm_SCoreDataIsrEn_fsm_wantStart;
  wire                fsm_SCoreDataIsrEn_fsm_wantKill;
  wire       [4:0]    _zz_Mwb_ADR_7;
  wire       [0:0]    _zz_Mwb_DAT_MOSI_4;
  reg                 fsm_SCoreDataWithSet_fsm_wantExit;
  reg                 fsm_SCoreDataWithSet_fsm_wantStart;
  wire                fsm_SCoreDataWithSet_fsm_wantKill;
  reg                 fsm_SSDCmd0_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_8;
  reg                 fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238;
  wire       [5:0]    _zz_Mwb_ADR_9;
  reg                 fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_5;
  wire       [8:0]    _zz_Mwb_DAT_MOSI_6;
  reg                 fsm_SSDcmd8_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_10;
  reg                 fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_1;
  wire       [5:0]    _zz_Mwb_ADR_11;
  reg                 fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_7;
  reg                 fsm_SSDcmd55_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_12;
  reg                 fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_2;
  wire       [5:0]    _zz_Mwb_ADR_13;
  reg                 fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_8;
  wire       [30:0]   _zz_Mwb_DAT_MOSI_9;
  wire       [0:0]    _zz_when_WbSdCtrl_l528;
  reg                 fsm_SSDAcmd41_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_14;
  reg                 fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_3;
  wire       [5:0]    _zz_Mwb_ADR_15;
  reg                 fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_10;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_1;
  reg                 fsm_SSDCmd2_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_16;
  reg                 fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_4;
  wire       [5:0]    _zz_Mwb_ADR_17;
  reg                 fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_11;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_2;
  reg                 fsm_SSDCmd3_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_18;
  reg                 fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_5;
  wire       [5:0]    _zz_Mwb_ADR_19;
  reg                 fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_12;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_13;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_3;
  reg                 fsm_SSDCmd9_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_20;
  reg                 fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_6;
  wire       [5:0]    _zz_Mwb_ADR_21;
  reg                 fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [10:0]   _zz_Mwb_DAT_MOSI_14;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_15;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_4;
  reg                 fsm_SSDCmd7_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_22;
  reg                 fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_7;
  wire       [5:0]    _zz_Mwb_ADR_23;
  reg                 fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [12:0]   _zz_Mwb_DAT_MOSI_16;
  wire       [9:0]    _zz_Mwb_DAT_MOSI_17;
  reg                 fsm_SSDCmd16_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_24;
  reg                 fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_8;
  wire       [5:0]    _zz_Mwb_ADR_25;
  reg                 fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [13:0]   _zz_Mwb_DAT_MOSI_18;
  wire       [31:0]   _zz_Mwb_DAT_MOSI_19;
  reg                 fsm_SSDcmd55_2_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_26;
  reg                 fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_9;
  wire       [5:0]    _zz_Mwb_ADR_27;
  reg                 fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [10:0]   _zz_Mwb_DAT_MOSI_20;
  wire       [1:0]    _zz_Mwb_DAT_MOSI_21;
  wire       [0:0]    _zz_when_WbSdCtrl_l528_5;
  reg                 fsm_SSDACmd6_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_28;
  reg                 fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_10;
  wire       [5:0]    _zz_Mwb_ADR_29;
  reg                 fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantKill;
  wire       [6:0]    _zz_Mwb_ADR_30;
  wire       [8:0]    _zz_Mwb_DAT_MOSI_22;
  reg                 fsm_SCoreBlkSize_fsm_wantExit;
  reg                 fsm_SCoreBlkSize_fsm_wantStart;
  wire                fsm_SCoreBlkSize_fsm_wantKill;
  wire       [6:0]    _zz_Mwb_ADR_31;
  wire       [7:0]    _zz_Mwb_DAT_MOSI_23;
  reg                 fsm_SCoreBlkNum_fsm_wantExit;
  reg                 fsm_SCoreBlkNum_fsm_wantStart;
  wire                fsm_SCoreBlkNum_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_wantKill;
  reg        [31:0]   fsm_SCoreSandData_fsm_TxCnt;
  wire       [6:0]    _zz_Mwb_ADR_32;
  reg                 fsm_SCoreSandData_fsm_DmaAddr_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_DmaAddr_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_DmaAddr_fsm_wantKill;
  wire       [12:0]   _zz_Mwb_DAT_MOSI_24;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_33;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_11;
  wire       [5:0]    _zz_Mwb_ADR_34;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_12;
  wire       [5:0]    _zz_Mwb_ADR_35;
  reg                 fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantKill;
  wire       [11:0]   _zz_Mwb_DAT_MOSI_25;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantKill;
  wire       [2:0]    _zz_Mwb_ADR_36;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill;
  reg        [8:0]    _zz_when_State_l238_13;
  wire       [5:0]    _zz_Mwb_ADR_37;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit;
  reg                 fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart;
  wire                fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill;
  reg        [1:0]    fsm_SCoreRest_fsm_stateReg;
  reg        [1:0]    fsm_SCoreRest_fsm_stateNext;
  wire                when_WbSdCtrl_l415;
  reg        [1:0]    fsm_SCoreCmdTimeOut_fsm_stateReg;
  reg        [1:0]    fsm_SCoreCmdTimeOut_fsm_stateNext;
  wire                when_WbSdCtrl_l415_1;
  reg        [1:0]    fsm_SCoredataTimeOut_fsm_stateReg;
  reg        [1:0]    fsm_SCoredataTimeOut_fsm_stateNext;
  wire                when_WbSdCtrl_l415_2;
  reg        [1:0]    fsm_SCoreClkDivider_fsm_stateReg;
  reg        [1:0]    fsm_SCoreClkDivider_fsm_stateNext;
  wire                when_WbSdCtrl_l415_3;
  reg        [1:0]    fsm_SCoreStart_fsm_stateReg;
  reg        [1:0]    fsm_SCoreStart_fsm_stateNext;
  wire                when_WbSdCtrl_l415_4;
  reg        [1:0]    fsm_SCoreCmdIsrEn_fsm_stateReg;
  reg        [1:0]    fsm_SCoreCmdIsrEn_fsm_stateNext;
  wire                when_WbSdCtrl_l415_5;
  reg        [1:0]    fsm_SCoreDataIsrEn_fsm_stateReg;
  reg        [1:0]    fsm_SCoreDataIsrEn_fsm_stateNext;
  wire                when_WbSdCtrl_l415_6;
  reg        [1:0]    fsm_SCoreDataWithSet_fsm_stateReg;
  reg        [1:0]    fsm_SCoreDataWithSet_fsm_stateNext;
  wire                when_WbSdCtrl_l415_7;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_8;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_9;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_10;
  reg        [3:0]    fsm_SSDCmd0_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd0_fsm_stateNext;
  wire                when_State_l238;
  wire                when_WbSdCtrl_l490;
  wire                when_WbSdCtrl_l508;
  wire                when_WbSdCtrl_l525;
  wire                when_WbSdCtrl_l528;
  wire                when_WbSdCtrl_l531;
  wire                when_WbSdCtrl_l545;
  wire                when_StateMachine_l253;
  wire                when_StateMachine_l253_1;
  wire                when_StateMachine_l253_2;
  wire                when_StateMachine_l253_3;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_11;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_12;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_13;
  reg        [3:0]    fsm_SSDcmd8_fsm_stateReg;
  reg        [3:0]    fsm_SSDcmd8_fsm_stateNext;
  wire                when_State_l238_1;
  wire                when_WbSdCtrl_l490_1;
  wire                when_WbSdCtrl_l508_1;
  wire                when_WbSdCtrl_l525_1;
  wire                when_WbSdCtrl_l528_1;
  wire                when_WbSdCtrl_l531_1;
  wire                when_WbSdCtrl_l545_1;
  wire                when_StateMachine_l253_4;
  wire                when_StateMachine_l253_5;
  wire                when_StateMachine_l253_6;
  wire                when_StateMachine_l253_7;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_14;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_15;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_16;
  reg        [3:0]    fsm_SSDcmd55_fsm_stateReg;
  reg        [3:0]    fsm_SSDcmd55_fsm_stateNext;
  wire                when_State_l238_2;
  wire                when_WbSdCtrl_l490_2;
  wire                when_WbSdCtrl_l508_2;
  wire                when_WbSdCtrl_l525_2;
  wire                when_WbSdCtrl_l528_2;
  wire                when_WbSdCtrl_l531_2;
  wire                when_WbSdCtrl_l545_2;
  wire                when_StateMachine_l253_8;
  wire                when_StateMachine_l253_9;
  wire                when_StateMachine_l253_10;
  wire                when_StateMachine_l253_11;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_17;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_18;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_19;
  reg        [3:0]    fsm_SSDAcmd41_fsm_stateReg;
  reg        [3:0]    fsm_SSDAcmd41_fsm_stateNext;
  wire                when_State_l238_3;
  wire                when_WbSdCtrl_l490_3;
  wire                when_WbSdCtrl_l508_3;
  wire                when_WbSdCtrl_l525_3;
  wire                when_WbSdCtrl_l528_3;
  wire                when_WbSdCtrl_l531_3;
  wire                when_WbSdCtrl_l545_3;
  wire                when_StateMachine_l253_12;
  wire                when_StateMachine_l253_13;
  wire                when_StateMachine_l253_14;
  wire                when_StateMachine_l253_15;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_20;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_21;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_22;
  reg        [3:0]    fsm_SSDCmd2_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd2_fsm_stateNext;
  wire                when_State_l238_4;
  wire                when_WbSdCtrl_l490_4;
  wire                when_WbSdCtrl_l508_4;
  wire                when_WbSdCtrl_l525_4;
  wire                when_WbSdCtrl_l528_4;
  wire                when_WbSdCtrl_l531_4;
  wire                when_WbSdCtrl_l545_4;
  wire                when_StateMachine_l253_16;
  wire                when_StateMachine_l253_17;
  wire                when_StateMachine_l253_18;
  wire                when_StateMachine_l253_19;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_23;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_24;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_25;
  reg        [3:0]    fsm_SSDCmd3_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd3_fsm_stateNext;
  wire                when_State_l238_5;
  wire                when_WbSdCtrl_l490_5;
  wire                when_WbSdCtrl_l508_5;
  wire                when_WbSdCtrl_l525_5;
  wire                when_WbSdCtrl_l528_5;
  wire                when_WbSdCtrl_l531_5;
  wire                when_WbSdCtrl_l545_5;
  wire                when_StateMachine_l253_20;
  wire                when_StateMachine_l253_21;
  wire                when_StateMachine_l253_22;
  wire                when_StateMachine_l253_23;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_26;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_27;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_28;
  reg        [3:0]    fsm_SSDCmd9_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd9_fsm_stateNext;
  wire                when_State_l238_6;
  wire                when_WbSdCtrl_l490_6;
  wire                when_WbSdCtrl_l508_6;
  wire                when_WbSdCtrl_l525_6;
  wire                when_WbSdCtrl_l528_6;
  wire                when_WbSdCtrl_l531_6;
  wire                when_WbSdCtrl_l545_6;
  wire                when_StateMachine_l253_24;
  wire                when_StateMachine_l253_25;
  wire                when_StateMachine_l253_26;
  wire                when_StateMachine_l253_27;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_29;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_30;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_31;
  reg        [3:0]    fsm_SSDCmd7_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd7_fsm_stateNext;
  wire                when_State_l238_7;
  wire                when_WbSdCtrl_l490_7;
  wire                when_WbSdCtrl_l508_7;
  wire                when_WbSdCtrl_l525_7;
  wire                when_WbSdCtrl_l528_7;
  wire                when_WbSdCtrl_l531_7;
  wire                when_WbSdCtrl_l545_7;
  wire                when_StateMachine_l253_28;
  wire                when_StateMachine_l253_29;
  wire                when_StateMachine_l253_30;
  wire                when_StateMachine_l253_31;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_32;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_33;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_34;
  reg        [3:0]    fsm_SSDCmd16_fsm_stateReg;
  reg        [3:0]    fsm_SSDCmd16_fsm_stateNext;
  wire                when_State_l238_8;
  wire                when_WbSdCtrl_l490_8;
  wire                when_WbSdCtrl_l508_8;
  wire                when_WbSdCtrl_l525_8;
  wire                when_WbSdCtrl_l528_8;
  wire                when_WbSdCtrl_l531_8;
  wire                when_WbSdCtrl_l545_8;
  wire                when_StateMachine_l253_32;
  wire                when_StateMachine_l253_33;
  wire                when_StateMachine_l253_34;
  wire                when_StateMachine_l253_35;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_35;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_36;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_37;
  reg        [3:0]    fsm_SSDcmd55_2_fsm_stateReg;
  reg        [3:0]    fsm_SSDcmd55_2_fsm_stateNext;
  wire                when_State_l238_9;
  wire                when_WbSdCtrl_l490_9;
  wire                when_WbSdCtrl_l508_9;
  wire                when_WbSdCtrl_l525_9;
  wire                when_WbSdCtrl_l528_9;
  wire                when_WbSdCtrl_l531_9;
  wire                when_WbSdCtrl_l545_9;
  wire                when_StateMachine_l253_36;
  wire                when_StateMachine_l253_37;
  wire                when_StateMachine_l253_38;
  wire                when_StateMachine_l253_39;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_38;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_39;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_40;
  reg        [3:0]    fsm_SSDACmd6_fsm_stateReg;
  reg        [3:0]    fsm_SSDACmd6_fsm_stateNext;
  wire                when_State_l238_10;
  wire                when_WbSdCtrl_l490_10;
  wire                when_WbSdCtrl_l508_10;
  wire                when_WbSdCtrl_l525_10;
  wire                when_WbSdCtrl_l528_10;
  wire                when_WbSdCtrl_l531_10;
  wire                when_WbSdCtrl_l545_10;
  wire                when_StateMachine_l253_40;
  wire                when_StateMachine_l253_41;
  wire                when_StateMachine_l253_42;
  wire                when_StateMachine_l253_43;
  reg        [1:0]    fsm_SCoreBlkSize_fsm_stateReg;
  reg        [1:0]    fsm_SCoreBlkSize_fsm_stateNext;
  wire                when_WbSdCtrl_l415_41;
  reg        [1:0]    fsm_SCoreBlkNum_fsm_stateReg;
  reg        [1:0]    fsm_SCoreBlkNum_fsm_stateNext;
  wire                when_WbSdCtrl_l415_42;
  reg        [1:0]    fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_43;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_44;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_45;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_46;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext;
  wire                when_State_l238_11;
  wire                when_WbSdCtrl_l490_11;
  wire                when_WbSdCtrl_l508_11;
  wire                when_WbSdCtrl_l525_11;
  wire                when_WbSdCtrl_l528_11;
  wire                when_WbSdCtrl_l531_11;
  wire                when_WbSdCtrl_l545_11;
  wire                when_StateMachine_l253_44;
  wire                when_StateMachine_l253_45;
  wire                when_StateMachine_l253_46;
  wire                when_StateMachine_l253_47;
  reg        [1:0]    fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext;
  wire                when_WbSdCtrl_l415_47;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext;
  wire                when_WbSdCtrl_l415_48;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext;
  wire                when_WbSdCtrl_l415_49;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg;
  reg        [1:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext;
  wire                when_WbSdCtrl_l415_50;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg;
  reg        [3:0]    fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext;
  wire                when_State_l238_12;
  wire                when_WbSdCtrl_l490_12;
  wire                when_WbSdCtrl_l508_12;
  wire                when_WbSdCtrl_l525_12;
  wire                when_WbSdCtrl_l528_12;
  wire                when_WbSdCtrl_l531_12;
  wire                when_WbSdCtrl_l545_12;
  wire                when_StateMachine_l253_48;
  wire                when_StateMachine_l253_49;
  wire                when_StateMachine_l253_50;
  wire                when_StateMachine_l253_51;
  reg        [3:0]    fsm_SCoreSandData_fsm_stateReg;
  reg        [3:0]    fsm_SCoreSandData_fsm_stateNext;
  wire                when_WbSdCtrl_l590;
  wire                when_WbSdCtrl_l595;
  wire                when_WbSdCtrl_l597;
  wire                when_State_l238_13;
  wire                when_WbSdCtrl_l609;
  wire                when_WbSdCtrl_l631;
  wire                when_WbSdCtrl_l640;
  wire                when_WbSdCtrl_l643;
  wire                when_StateMachine_l253_52;
  wire                when_StateMachine_l253_53;
  wire                when_StateMachine_l253_54;
  wire                when_StateMachine_l253_55;
  wire                when_StateMachine_l253_56;
  reg        [4:0]    fsm_stateReg;
  reg        [4:0]    fsm_stateNext;
  wire                when_WbSdCtrl_l303;
  wire                when_WbSdCtrl_l330;
  wire                when_StateMachine_l253_57;
  wire                when_StateMachine_l253_58;
  wire                when_StateMachine_l253_59;
  wire                when_StateMachine_l253_60;
  wire                when_StateMachine_l253_61;
  wire                when_StateMachine_l253_62;
  wire                when_StateMachine_l253_63;
  wire                when_StateMachine_l253_64;
  wire                when_StateMachine_l253_65;
  wire                when_StateMachine_l253_66;
  wire                when_StateMachine_l253_67;
  wire                when_StateMachine_l253_68;
  wire                when_StateMachine_l253_69;
  wire                when_StateMachine_l253_70;
  wire                when_StateMachine_l253_71;
  wire                when_StateMachine_l253_72;
  wire                when_StateMachine_l253_73;
  wire                when_StateMachine_l253_74;
  wire                when_StateMachine_l253_75;
  wire                when_StateMachine_l253_76;
  wire                when_StateMachine_l253_77;
  wire                when_StateMachine_l253_78;
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
  reg [127:0] fsm_stateReg_string;
  reg [127:0] fsm_stateNext_string;
  `endif


  assign _zz_Mwb_DAT_MOSI_26 = _zz_Mwb_DAT_MOSI;
  assign _zz_Mwb_DAT_MOSI_27 = _zz_Mwb_DAT_MOSI;
  assign _zz_Mwb_DAT_MOSI_28 = _zz_Mwb_DAT_MOSI_1;
  assign _zz_Mwb_DAT_MOSI_29 = _zz_Mwb_DAT_MOSI_1;
  assign _zz_Mwb_DAT_MOSI_30 = _zz_Mwb_DAT_MOSI_2;
  assign _zz_Mwb_DAT_MOSI_31 = _zz_Mwb_DAT_MOSI_2;
  assign _zz_Mwb_DAT_MOSI_32 = _zz_Mwb_DAT_MOSI_3;
  assign _zz_Mwb_DAT_MOSI_33 = _zz_Mwb_DAT_MOSI_3;
  assign _zz_Mwb_DAT_MOSI_34 = _zz_Mwb_DAT_MOSI_4;
  assign _zz_Mwb_DAT_MOSI_35 = _zz_Mwb_DAT_MOSI_4;
  assign _zz_Mwb_ADR_38 = 6'h34;
  assign _zz_Mwb_ADR_39 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_7 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_6 = {31'd0, _zz_when_WbSdCtrl_l528_7};
  assign _zz_Mwb_ADR_40 = 4'b1000;
  assign _zz_Mwb_ADR_41 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_36 = _zz_Mwb_DAT_MOSI_5;
  assign _zz_Mwb_DAT_MOSI_37 = _zz_Mwb_DAT_MOSI_5;
  assign _zz_Mwb_DAT_MOSI_38 = _zz_Mwb_DAT_MOSI_6;
  assign _zz_Mwb_DAT_MOSI_39 = _zz_Mwb_DAT_MOSI_6;
  assign _zz_Mwb_ADR_42 = 6'h34;
  assign _zz_Mwb_ADR_43 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_1_2 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_1_1 = {31'd0, _zz_when_WbSdCtrl_l528_1_2};
  assign _zz_Mwb_ADR_44 = 4'b1000;
  assign _zz_Mwb_ADR_45 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_40 = _zz_Mwb_DAT_MOSI_7;
  assign _zz_Mwb_DAT_MOSI_41 = _zz_Mwb_DAT_MOSI_7;
  assign _zz_Mwb_ADR_46 = 6'h34;
  assign _zz_Mwb_ADR_47 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_2_2 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_2_1 = {31'd0, _zz_when_WbSdCtrl_l528_2_2};
  assign _zz_Mwb_ADR_48 = 4'b1000;
  assign _zz_Mwb_ADR_49 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_42 = _zz_Mwb_DAT_MOSI_8;
  assign _zz_Mwb_DAT_MOSI_43 = _zz_Mwb_DAT_MOSI_8;
  assign _zz_Mwb_DAT_MOSI_44 = _zz_Mwb_DAT_MOSI_9;
  assign _zz_Mwb_DAT_MOSI_45 = _zz_Mwb_DAT_MOSI_9;
  assign _zz_Mwb_ADR_50 = 6'h34;
  assign _zz_Mwb_ADR_51 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_3_1 = {31'd0, _zz_when_WbSdCtrl_l528};
  assign _zz_when_WbSdCtrl_l528_3_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_3_2 = {31'd0, _zz_when_WbSdCtrl_l528_3_3};
  assign _zz_when_WbSdCtrl_l531_3 = {31'd0, _zz_when_WbSdCtrl_l528};
  assign _zz_Mwb_ADR_52 = 4'b1000;
  assign _zz_Mwb_ADR_53 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_46 = _zz_Mwb_DAT_MOSI_10;
  assign _zz_Mwb_DAT_MOSI_47 = _zz_Mwb_DAT_MOSI_10;
  assign _zz_Mwb_ADR_54 = 6'h34;
  assign _zz_Mwb_ADR_55 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_4_1 = {31'd0, _zz_when_WbSdCtrl_l528_1};
  assign _zz_when_WbSdCtrl_l528_4_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_4_2 = {31'd0, _zz_when_WbSdCtrl_l528_4_3};
  assign _zz_when_WbSdCtrl_l531_4 = {31'd0, _zz_when_WbSdCtrl_l528_1};
  assign _zz_Mwb_ADR_56 = 4'b1000;
  assign _zz_Mwb_ADR_57 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_48 = _zz_Mwb_DAT_MOSI_11;
  assign _zz_Mwb_DAT_MOSI_49 = _zz_Mwb_DAT_MOSI_11;
  assign _zz_Mwb_ADR_58 = 6'h34;
  assign _zz_Mwb_ADR_59 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_5_1 = {31'd0, _zz_when_WbSdCtrl_l528_2};
  assign _zz_when_WbSdCtrl_l528_5_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_5_2 = {31'd0, _zz_when_WbSdCtrl_l528_5_3};
  assign _zz_when_WbSdCtrl_l531_5 = {31'd0, _zz_when_WbSdCtrl_l528_2};
  assign _zz_Mwb_ADR_60 = 4'b1000;
  assign _zz_Mwb_ADR_61 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_50 = _zz_Mwb_DAT_MOSI_12;
  assign _zz_Mwb_DAT_MOSI_51 = _zz_Mwb_DAT_MOSI_12;
  assign _zz_Mwb_DAT_MOSI_52 = _zz_Mwb_DAT_MOSI_13;
  assign _zz_Mwb_DAT_MOSI_53 = _zz_Mwb_DAT_MOSI_13;
  assign _zz_Mwb_ADR_62 = 6'h34;
  assign _zz_Mwb_ADR_63 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_6_1 = {31'd0, _zz_when_WbSdCtrl_l528_3};
  assign _zz_when_WbSdCtrl_l528_6_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_6_2 = {31'd0, _zz_when_WbSdCtrl_l528_6_3};
  assign _zz_when_WbSdCtrl_l531_6 = {31'd0, _zz_when_WbSdCtrl_l528_3};
  assign _zz_Mwb_ADR_64 = 4'b1000;
  assign _zz_Mwb_ADR_65 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_54 = _zz_Mwb_DAT_MOSI_14;
  assign _zz_Mwb_DAT_MOSI_55 = _zz_Mwb_DAT_MOSI_14;
  assign _zz_Mwb_DAT_MOSI_56 = _zz_Mwb_DAT_MOSI_15;
  assign _zz_Mwb_DAT_MOSI_57 = _zz_Mwb_DAT_MOSI_15;
  assign _zz_Mwb_ADR_66 = 6'h34;
  assign _zz_Mwb_ADR_67 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_7_1 = {31'd0, _zz_when_WbSdCtrl_l528_4};
  assign _zz_when_WbSdCtrl_l528_7_3 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_7_2 = {31'd0, _zz_when_WbSdCtrl_l528_7_3};
  assign _zz_when_WbSdCtrl_l531_7 = {31'd0, _zz_when_WbSdCtrl_l528_4};
  assign _zz_Mwb_ADR_68 = 4'b1000;
  assign _zz_Mwb_ADR_69 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_58 = _zz_Mwb_DAT_MOSI_16;
  assign _zz_Mwb_DAT_MOSI_59 = _zz_Mwb_DAT_MOSI_16;
  assign _zz_Mwb_DAT_MOSI_60 = _zz_Mwb_DAT_MOSI_17;
  assign _zz_Mwb_DAT_MOSI_61 = _zz_Mwb_DAT_MOSI_17;
  assign _zz_Mwb_ADR_70 = 6'h34;
  assign _zz_Mwb_ADR_71 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_8_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_8 = {31'd0, _zz_when_WbSdCtrl_l528_8_1};
  assign _zz_Mwb_ADR_72 = 4'b1000;
  assign _zz_Mwb_ADR_73 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_62 = _zz_Mwb_DAT_MOSI_18;
  assign _zz_Mwb_DAT_MOSI_63 = _zz_Mwb_DAT_MOSI_18;
  assign _zz_Mwb_DAT_MOSI_64 = _zz_Mwb_DAT_MOSI_19;
  assign _zz_Mwb_DAT_MOSI_65 = _zz_Mwb_DAT_MOSI_19;
  assign _zz_Mwb_ADR_74 = 6'h34;
  assign _zz_Mwb_ADR_75 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_9_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_9 = {31'd0, _zz_when_WbSdCtrl_l528_9_1};
  assign _zz_Mwb_ADR_76 = 4'b1000;
  assign _zz_Mwb_ADR_77 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_66 = _zz_Mwb_DAT_MOSI_20;
  assign _zz_Mwb_DAT_MOSI_67 = _zz_Mwb_DAT_MOSI_20;
  assign _zz_Mwb_DAT_MOSI_68 = _zz_Mwb_DAT_MOSI_21;
  assign _zz_Mwb_DAT_MOSI_69 = _zz_Mwb_DAT_MOSI_21;
  assign _zz_Mwb_ADR_78 = 6'h34;
  assign _zz_Mwb_ADR_79 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_10 = {31'd0, _zz_when_WbSdCtrl_l528_5};
  assign _zz_when_WbSdCtrl_l528_10_2 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_10_1 = {31'd0, _zz_when_WbSdCtrl_l528_10_2};
  assign _zz_when_WbSdCtrl_l531_10 = {31'd0, _zz_when_WbSdCtrl_l528_5};
  assign _zz_Mwb_ADR_80 = 4'b1000;
  assign _zz_Mwb_ADR_81 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_70 = _zz_Mwb_DAT_MOSI_22;
  assign _zz_Mwb_DAT_MOSI_71 = _zz_Mwb_DAT_MOSI_22;
  assign _zz_Mwb_DAT_MOSI_72 = _zz_Mwb_DAT_MOSI_23;
  assign _zz_Mwb_DAT_MOSI_73 = _zz_Mwb_DAT_MOSI_23;
  assign _zz_Mwb_DAT_MOSI_74 = _zz_Mwb_DAT_MOSI_24;
  assign _zz_Mwb_DAT_MOSI_75 = _zz_Mwb_DAT_MOSI_24;
  assign _zz_Mwb_ADR_82 = 6'h34;
  assign _zz_Mwb_ADR_83 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_11_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_11 = {31'd0, _zz_when_WbSdCtrl_l528_11_1};
  assign _zz_Mwb_ADR_84 = 4'b1000;
  assign _zz_Mwb_ADR_85 = 4'b1000;
  assign _zz_Mwb_DAT_MOSI_76 = _zz_Mwb_DAT_MOSI_25;
  assign _zz_Mwb_DAT_MOSI_77 = _zz_Mwb_DAT_MOSI_25;
  assign _zz_Mwb_ADR_86 = 6'h34;
  assign _zz_Mwb_ADR_87 = 6'h34;
  assign _zz_when_WbSdCtrl_l528_12_1 = 1'b1;
  assign _zz_when_WbSdCtrl_l528_12 = {31'd0, _zz_when_WbSdCtrl_l528_12_1};
  assign _zz_Mwb_ADR_88 = 4'b1000;
  assign _zz_Mwb_ADR_89 = 4'b1000;
  assign _zz_Swb_DAT_MISO = fsm_SCoreSandData_fsm_TxCnt;
  assign _zz_Mwb_ADR_90 = 6'h3c;
  assign _zz_Mwb_ADR_91 = 6'h3c;
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_BOOT : fsm_SCoreRest_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : fsm_SCoreRest_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : fsm_SCoreRest_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : fsm_SCoreRest_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreRest_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreRest_fsm_stateNext)
      fsm_SCoreRest_fsm_enumDef_BOOT : fsm_SCoreRest_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : fsm_SCoreRest_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : fsm_SCoreRest_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : fsm_SCoreRest_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreRest_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreCmdTimeOut_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdTimeOut_fsm_stateNext)
      fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreCmdTimeOut_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_BOOT : fsm_SCoredataTimeOut_fsm_stateReg_string = "BOOT        ";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoredataTimeOut_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : fsm_SCoredataTimeOut_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoredataTimeOut_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoredataTimeOut_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoredataTimeOut_fsm_stateNext)
      fsm_SCoredataTimeOut_fsm_enumDef_BOOT : fsm_SCoredataTimeOut_fsm_stateNext_string = "BOOT        ";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : fsm_SCoredataTimeOut_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : fsm_SCoredataTimeOut_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : fsm_SCoredataTimeOut_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoredataTimeOut_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_BOOT : fsm_SCoreClkDivider_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : fsm_SCoreClkDivider_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : fsm_SCoreClkDivider_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : fsm_SCoreClkDivider_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreClkDivider_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreClkDivider_fsm_stateNext)
      fsm_SCoreClkDivider_fsm_enumDef_BOOT : fsm_SCoreClkDivider_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : fsm_SCoreClkDivider_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : fsm_SCoreClkDivider_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : fsm_SCoreClkDivider_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreClkDivider_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_BOOT : fsm_SCoreStart_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : fsm_SCoreStart_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : fsm_SCoreStart_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : fsm_SCoreStart_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreStart_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreStart_fsm_stateNext)
      fsm_SCoreStart_fsm_enumDef_BOOT : fsm_SCoreStart_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : fsm_SCoreStart_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : fsm_SCoreStart_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : fsm_SCoreStart_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreStart_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreCmdIsrEn_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreCmdIsrEn_fsm_stateNext)
      fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreCmdIsrEn_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_BOOT : fsm_SCoreDataIsrEn_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataIsrEn_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : fsm_SCoreDataIsrEn_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreDataIsrEn_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreDataIsrEn_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataIsrEn_fsm_stateNext)
      fsm_SCoreDataIsrEn_fsm_enumDef_BOOT : fsm_SCoreDataIsrEn_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataIsrEn_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : fsm_SCoreDataIsrEn_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : fsm_SCoreDataIsrEn_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreDataIsrEn_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_BOOT : fsm_SCoreDataWithSet_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataWithSet_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : fsm_SCoreDataWithSet_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : fsm_SCoreDataWithSet_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreDataWithSet_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreDataWithSet_fsm_stateNext)
      fsm_SCoreDataWithSet_fsm_enumDef_BOOT : fsm_SCoreDataWithSet_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : fsm_SCoreDataWithSet_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : fsm_SCoreDataWithSet_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : fsm_SCoreDataWithSet_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreDataWithSet_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd0_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd0_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd0_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd0_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd0_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd0_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd0_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd0_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : fsm_SSDcmd8_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd8_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : fsm_SSDcmd8_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : fsm_SSDcmd8_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd8_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : fsm_SSDcmd8_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd8_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd8_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : fsm_SSDcmd55_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : fsm_SSDcmd55_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : fsm_SSDcmd55_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : fsm_SSDcmd55_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd55_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd55_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : fsm_SSDAcmd41_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : fsm_SSDAcmd41_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : fsm_SSDAcmd41_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : fsm_SSDAcmd41_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDAcmd41_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd2_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd2_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd2_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd2_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd2_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd2_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd2_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd2_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd3_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd3_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd3_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd3_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd3_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd3_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd3_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd3_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd9_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd9_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd9_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd9_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd9_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd9_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd9_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd9_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd7_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd7_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd7_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd7_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd7_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd7_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd7_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd7_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd16_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd16_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd16_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : fsm_SSDCmd16_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : fsm_SSDCmd16_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : fsm_SSDCmd16_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : fsm_SSDCmd16_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDCmd16_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_2_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : fsm_SSDcmd55_2_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : fsm_SSDcmd55_2_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : fsm_SSDcmd55_2_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDcmd55_2_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : fsm_SSDACmd6_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : fsm_SSDACmd6_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : fsm_SSDACmd6_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : fsm_SSDACmd6_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : fsm_SSDACmd6_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : fsm_SSDACmd6_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : fsm_SSDACmd6_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SSDACmd6_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_BOOT : fsm_SCoreBlkSize_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkSize_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : fsm_SCoreBlkSize_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkSize_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreBlkSize_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkSize_fsm_stateNext)
      fsm_SCoreBlkSize_fsm_enumDef_BOOT : fsm_SCoreBlkSize_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkSize_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : fsm_SCoreBlkSize_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkSize_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreBlkSize_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_BOOT : fsm_SCoreBlkNum_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkNum_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : fsm_SCoreBlkNum_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkNum_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreBlkNum_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreBlkNum_fsm_stateNext)
      fsm_SCoreBlkNum_fsm_enumDef_BOOT : fsm_SCoreBlkNum_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : fsm_SCoreBlkNum_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : fsm_SCoreBlkNum_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : fsm_SCoreBlkNum_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreBlkNum_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreRdAckWait  ";
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "SCoreRdFinish   ";
      default : fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreWaitAck";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "SCoreClearWr";
      default : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "BOOT        ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreCmdSand";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext_string = "SCoreWaitAck";
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
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreGetRdData1 ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg_string = "SCoreRdAckWait  ";
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
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreGetRdData1 ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "CmdPeponeseGet  ";
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext_string = "SCoreRdAckWait  ";
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
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : fsm_SCoreSandData_fsm_stateReg_string = "WrDataDelay ";
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : fsm_SCoreSandData_fsm_stateReg_string = "CheckIsrDone";
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : fsm_SCoreSandData_fsm_stateReg_string = "ClearIsrData";
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : fsm_SCoreSandData_fsm_stateReg_string = "SSDCmd12    ";
      fsm_SCoreSandData_fsm_enumDef_BdIsr : fsm_SCoreSandData_fsm_stateReg_string = "BdIsr       ";
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : fsm_SCoreSandData_fsm_stateReg_string = "BdIsrGet    ";
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : fsm_SCoreSandData_fsm_stateReg_string = "BdIsrCheck  ";
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
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : fsm_SCoreSandData_fsm_stateNext_string = "WrDataDelay ";
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : fsm_SCoreSandData_fsm_stateNext_string = "CheckIsrDone";
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : fsm_SCoreSandData_fsm_stateNext_string = "ClearIsrData";
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : fsm_SCoreSandData_fsm_stateNext_string = "SSDCmd12    ";
      fsm_SCoreSandData_fsm_enumDef_BdIsr : fsm_SCoreSandData_fsm_stateNext_string = "BdIsr       ";
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : fsm_SCoreSandData_fsm_stateNext_string = "BdIsrGet    ";
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : fsm_SCoreSandData_fsm_stateNext_string = "BdIsrCheck  ";
      default : fsm_SCoreSandData_fsm_stateNext_string = "????????????";
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
      fsm_enumDef_SSDCmd7 : fsm_stateReg_string = "SSDCmd7         ";
      fsm_enumDef_SSDCmd16 : fsm_stateReg_string = "SSDCmd16        ";
      fsm_enumDef_SSDcmd55_2 : fsm_stateReg_string = "SSDcmd55_2      ";
      fsm_enumDef_SSDACmd6 : fsm_stateReg_string = "SSDACmd6        ";
      fsm_enumDef_SCoreBlkSize : fsm_stateReg_string = "SCoreBlkSize    ";
      fsm_enumDef_SCoreBlkNum : fsm_stateReg_string = "SCoreBlkNum     ";
      fsm_enumDef_SCoreSandData : fsm_stateReg_string = "SCoreSandData   ";
      fsm_enumDef_SCoreAddrAdd : fsm_stateReg_string = "SCoreAddrAdd    ";
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
      fsm_enumDef_SSDCmd7 : fsm_stateNext_string = "SSDCmd7         ";
      fsm_enumDef_SSDCmd16 : fsm_stateNext_string = "SSDCmd16        ";
      fsm_enumDef_SSDcmd55_2 : fsm_stateNext_string = "SSDcmd55_2      ";
      fsm_enumDef_SSDACmd6 : fsm_stateNext_string = "SSDACmd6        ";
      fsm_enumDef_SCoreBlkSize : fsm_stateNext_string = "SCoreBlkSize    ";
      fsm_enumDef_SCoreBlkNum : fsm_stateNext_string = "SCoreBlkNum     ";
      fsm_enumDef_SCoreSandData : fsm_stateNext_string = "SCoreSandData   ";
      fsm_enumDef_SCoreAddrAdd : fsm_stateNext_string = "SCoreAddrAdd    ";
      default : fsm_stateNext_string = "????????????????";
    endcase
  end
  `endif

  assign cmdResponseReg7 = 32'h0;
  assign FBTXNum = 4'b0000;
  assign FBRxNum = 4'b0000;
  assign GetRdData = 32'h0;
  always @(*) begin
    Mwb_CYC = 1'b0; // @[Bool.scala 90:28]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_1) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_2) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_3) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_4) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_5) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_6) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_7) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_8) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_9) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_10) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_11) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_12) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_13) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_1) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_1) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_14) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_15) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_16) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_2) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_2) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_17) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_18) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_19) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_3) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_3) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_20) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_21) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_22) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_4) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_4) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_23) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_24) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_25) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_5) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_5) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_26) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_27) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_28) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_6) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_6) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_29) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_30) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_31) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_7) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_7) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_32) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_33) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_34) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_8) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_8) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_35) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_36) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_37) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_9) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_9) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_38) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_39) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_40) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_10) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_10) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_41) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_42) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_43) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_44) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_45) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_46) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_11) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_11) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_47) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_48) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_49) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_50) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 179:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_CYC = 1'b0; // @[WbSdCtrl.scala 191:16]
      end
      default : begin
      end
    endcase
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
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_12) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_12) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
        Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
        if(when_WbSdCtrl_l631) begin
          Mwb_CYC = 1'b1; // @[WbSdCtrl.scala 204:16]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    Mwb_ADR = 32'h0; // @[BitVector.scala 471:10]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_1}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_1) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_1}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {27'd0, _zz_Mwb_ADR_2}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_2) begin
          Mwb_ADR = {27'd0, _zz_Mwb_ADR_2}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_3}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_3) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_3}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_4}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_4) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_4}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_5}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_5) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_5}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {25'd0, _zz_Mwb_ADR_6}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_6) begin
          Mwb_ADR = {25'd0, _zz_Mwb_ADR_6}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {27'd0, _zz_Mwb_ADR_7}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_7) begin
          Mwb_ADR = {27'd0, _zz_Mwb_ADR_7}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_8}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_8) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_8}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_9) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_9}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_10) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_9}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_38}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_39}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_40}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_41}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_10}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_11) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_10}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_12) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_11}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_13) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_11}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_42}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_1) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_43}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_44}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_1) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_45}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_12}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_14) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_12}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_15) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_13}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_16) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_13}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_46}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_2) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_47}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_48}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_2) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_49}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_14}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_17) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_14}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_18) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_15}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_19) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_15}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_50}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_3) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_51}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_52}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_3) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_53}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_16}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_20) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_16}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_21) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_17}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_22) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_17}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_54}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_4) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_55}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_56}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_4) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_57}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_18}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_23) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_18}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_24) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_19}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_25) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_19}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_58}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_5) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_59}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_60}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_5) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_61}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_20}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_26) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_20}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_27) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_21}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_28) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_21}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_62}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_6) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_63}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_64}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_6) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_65}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_22}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_29) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_22}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_30) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_23}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_31) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_23}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_66}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_7) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_67}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_68}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_7) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_69}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_24}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_32) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_24}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_33) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_25}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_34) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_25}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_70}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_8) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_71}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_72}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_8) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_73}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_26}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_35) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_26}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_36) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_27}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_37) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_27}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_74}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_9) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_75}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_76}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_9) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_77}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_28}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_38) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_28}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_39) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_29}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_40) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_29}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_78}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_10) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_79}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_80}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_10) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_81}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {25'd0, _zz_Mwb_ADR_30}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_41) begin
          Mwb_ADR = {25'd0, _zz_Mwb_ADR_30}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {25'd0, _zz_Mwb_ADR_31}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_42) begin
          Mwb_ADR = {25'd0, _zz_Mwb_ADR_31}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {25'd0, _zz_Mwb_ADR_32}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_43) begin
          Mwb_ADR = {25'd0, _zz_Mwb_ADR_32}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_33}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_44) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_33}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_45) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_34}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_46) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_34}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_82}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_11) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_83}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_84}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_11) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_85}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_35}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_47) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_35}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {29'd0, _zz_Mwb_ADR_36}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_48) begin
          Mwb_ADR = {29'd0, _zz_Mwb_ADR_36}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_49) begin
          Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_37}; // @[WbSdCtrl.scala 182:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_50) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_37}; // @[WbSdCtrl.scala 182:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_ADR = 32'h0; // @[WbSdCtrl.scala 194:16]
      end
      default : begin
      end
    endcase
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
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_86}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_12) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_87}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_ADR = {28'd0, _zz_Mwb_ADR_88}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_12) begin
          Mwb_ADR = {28'd0, _zz_Mwb_ADR_89}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
        Mwb_ADR = {26'd0, _zz_Mwb_ADR_90}; // @[WbSdCtrl.scala 207:16]
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
        if(when_WbSdCtrl_l631) begin
          Mwb_ADR = {26'd0, _zz_Mwb_ADR_91}; // @[WbSdCtrl.scala 207:16]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    Mwb_DAT_MOSI = 32'h0; // @[BitVector.scala 471:10]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {31'd0, _zz_Mwb_DAT_MOSI_26}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415) begin
          Mwb_DAT_MOSI = {31'd0, _zz_Mwb_DAT_MOSI_27}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_28}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_1) begin
          Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_29}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_2) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_3) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_4) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {27'd0, _zz_Mwb_DAT_MOSI_30}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_5) begin
          Mwb_DAT_MOSI = {27'd0, _zz_Mwb_DAT_MOSI_31}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {27'd0, _zz_Mwb_DAT_MOSI_32}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_6) begin
          Mwb_DAT_MOSI = {27'd0, _zz_Mwb_DAT_MOSI_33}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {31'd0, _zz_Mwb_DAT_MOSI_34}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_7) begin
          Mwb_DAT_MOSI = {31'd0, _zz_Mwb_DAT_MOSI_35}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_8) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_9) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_10) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {20'd0, _zz_Mwb_DAT_MOSI_36}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_11) begin
          Mwb_DAT_MOSI = {20'd0, _zz_Mwb_DAT_MOSI_37}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {23'd0, _zz_Mwb_DAT_MOSI_38}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_12) begin
          Mwb_DAT_MOSI = {23'd0, _zz_Mwb_DAT_MOSI_39}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_13) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {18'd0, _zz_Mwb_DAT_MOSI_40}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_14) begin
          Mwb_DAT_MOSI = {18'd0, _zz_Mwb_DAT_MOSI_41}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_15) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_16) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {18'd0, _zz_Mwb_DAT_MOSI_42}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_17) begin
          Mwb_DAT_MOSI = {18'd0, _zz_Mwb_DAT_MOSI_43}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {1'd0, _zz_Mwb_DAT_MOSI_44}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_18) begin
          Mwb_DAT_MOSI = {1'd0, _zz_Mwb_DAT_MOSI_45}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_19) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_46}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_20) begin
          Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_47}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_21) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_22) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_48}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_23) begin
          Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_49}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_24) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_25) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {20'd0, _zz_Mwb_DAT_MOSI_50}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_26) begin
          Mwb_DAT_MOSI = {20'd0, _zz_Mwb_DAT_MOSI_51}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = _zz_Mwb_DAT_MOSI_52; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_27) begin
          Mwb_DAT_MOSI = _zz_Mwb_DAT_MOSI_53; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_28) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {21'd0, _zz_Mwb_DAT_MOSI_54}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_29) begin
          Mwb_DAT_MOSI = {21'd0, _zz_Mwb_DAT_MOSI_55}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = _zz_Mwb_DAT_MOSI_56; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_30) begin
          Mwb_DAT_MOSI = _zz_Mwb_DAT_MOSI_57; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_31) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {19'd0, _zz_Mwb_DAT_MOSI_58}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_32) begin
          Mwb_DAT_MOSI = {19'd0, _zz_Mwb_DAT_MOSI_59}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_60}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_33) begin
          Mwb_DAT_MOSI = {22'd0, _zz_Mwb_DAT_MOSI_61}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_34) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {18'd0, _zz_Mwb_DAT_MOSI_62}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_35) begin
          Mwb_DAT_MOSI = {18'd0, _zz_Mwb_DAT_MOSI_63}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = _zz_Mwb_DAT_MOSI_64; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_36) begin
          Mwb_DAT_MOSI = _zz_Mwb_DAT_MOSI_65; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_37) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {21'd0, _zz_Mwb_DAT_MOSI_66}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_38) begin
          Mwb_DAT_MOSI = {21'd0, _zz_Mwb_DAT_MOSI_67}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {30'd0, _zz_Mwb_DAT_MOSI_68}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_39) begin
          Mwb_DAT_MOSI = {30'd0, _zz_Mwb_DAT_MOSI_69}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_40) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {23'd0, _zz_Mwb_DAT_MOSI_70}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_41) begin
          Mwb_DAT_MOSI = {23'd0, _zz_Mwb_DAT_MOSI_71}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {24'd0, _zz_Mwb_DAT_MOSI_72}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_42) begin
          Mwb_DAT_MOSI = {24'd0, _zz_Mwb_DAT_MOSI_73}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_43) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {19'd0, _zz_Mwb_DAT_MOSI_74}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_44) begin
          Mwb_DAT_MOSI = {19'd0, _zz_Mwb_DAT_MOSI_75}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_45) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_46) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_47) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = {20'd0, _zz_Mwb_DAT_MOSI_76}; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_48) begin
          Mwb_DAT_MOSI = {20'd0, _zz_Mwb_DAT_MOSI_77}; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_49) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_50) begin
          Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 183:21]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_DAT_MOSI = 32'h0; // @[WbSdCtrl.scala 195:21]
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    Mwb_STB = 1'b0; // @[Bool.scala 90:28]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_1) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_2) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_3) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_4) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_5) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_6) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_7) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_8) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_9) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_10) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_11) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_12) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_13) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_1) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_1) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_14) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_15) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_16) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_2) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_2) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_17) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_18) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_19) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_3) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_3) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_20) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_21) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_22) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_4) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_4) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_23) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_24) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_25) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_5) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_5) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_26) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_27) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_28) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_6) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_6) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_29) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_30) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_31) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_7) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_7) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_32) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_33) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_34) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_8) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_8) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_35) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_36) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_37) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_9) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_9) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_38) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_39) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_40) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_10) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_10) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_41) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_42) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_43) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_44) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_45) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_46) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_11) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_11) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_47) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_48) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_49) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_50) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 180:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_STB = 1'b0; // @[WbSdCtrl.scala 192:16]
      end
      default : begin
      end
    endcase
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
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_12) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_12) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
        Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
        if(when_WbSdCtrl_l631) begin
          Mwb_STB = 1'b1; // @[WbSdCtrl.scala 205:16]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    Mwb_WE = 1'b0; // @[Bool.scala 90:28]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_1) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_2) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_3) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_4) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_5) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_6) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_7) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_8) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_9) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_10) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_11) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_12) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_13) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_1) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_1) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_14) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_15) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_16) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_2) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_2) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_17) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_18) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_19) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_3) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_3) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_20) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_21) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_22) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_4) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_4) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_23) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_24) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_25) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_5) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_5) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_26) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_27) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_28) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_6) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_6) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_29) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_30) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_31) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_7) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_7) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_32) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_33) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_34) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_8) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_8) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_35) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_36) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_37) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_9) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_9) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_38) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_39) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_40) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_10) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_10) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_41) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_42) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_43) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_44) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_45) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_46) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_11) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_11) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_47) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_48) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_49) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_50) begin
          Mwb_WE = 1'b1; // @[WbSdCtrl.scala 178:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 190:15]
      end
      default : begin
      end
    endcase
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
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_12) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_12) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
        Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
        if(when_WbSdCtrl_l631) begin
          Mwb_WE = 1'b0; // @[WbSdCtrl.scala 203:15]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    Mwb_SEL = 4'b0000; // @[BitVector.scala 471:10]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_1) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_2) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_3) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_4) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_5) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_6) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_7) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_8) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_9) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_10) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_11) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_12) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_13) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_1) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_1) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_14) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_15) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_16) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_2) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_2) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_17) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_18) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_19) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_3) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_3) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_20) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_21) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_22) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_4) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_4) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_23) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_24) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_25) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_5) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_5) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_26) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_27) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_28) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_6) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_6) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_29) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_30) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_31) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_7) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_7) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_32) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_33) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_34) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_8) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_8) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_35) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_36) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_37) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_9) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_9) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_38) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_39) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_40) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_10) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_10) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_41) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_42) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_43) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_44) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_45) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_46) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_11) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_11) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_47) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_48) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_49) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_50) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 181:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        Mwb_SEL = 4'b0000; // @[WbSdCtrl.scala 193:16]
      end
      default : begin
      end
    endcase
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
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        if(when_WbSdCtrl_l508_12) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_12) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
        Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
        if(when_WbSdCtrl_l631) begin
          Mwb_SEL = 4'b1111; // @[WbSdCtrl.scala 206:16]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
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
        if(when_WbSdCtrl_l590) begin
          Swb_DAT_MISO = _zz_Swb_DAT_MISO; // @[WbSdCtrl.scala 593:29]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
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
        if(when_WbSdCtrl_l590) begin
          Swb_ACK = 1'b1; // @[WbSdCtrl.scala 592:24]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
      end
      default : begin
      end
    endcase
  end

  assign when_WbSdCtrl_l68 = (Mwb_ACK && (! Mwb_WE)); // @[BaseType.scala 305:24]
  assign RSPReg = CmdResponseReg; // @[WbSdCtrl.scala 70:13]
  assign RSPReg2 = CmdResponseReg2; // @[WbSdCtrl.scala 71:14]
  assign RSPReg3 = CmdResponseReg3; // @[WbSdCtrl.scala 72:14]
  assign RSPReg41 = CmdResponseRegA41; // @[WbSdCtrl.scala 73:15]
  assign Rddata = GetRdData; // @[WbSdCtrl.scala 74:13]
  assign LBits = 16'h0; // @[Expression.scala 2301:18]
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
      fsm_enumDef_SCoreAddrAdd : begin
      end
      default : begin
        fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
      end
    endcase
  end

  assign fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR = 6'h28; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreRest_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_57) begin
      fsm_SCoreRest_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreRest_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_1 = 6'h20; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_1 = 10'h2ff; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreCmdTimeOut_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_58) begin
      fsm_SCoreCmdTimeOut_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreCmdTimeOut_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_2 = 5'h18; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoredataTimeOut_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_59) begin
      fsm_SCoredataTimeOut_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoredataTimeOut_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_3 = 6'h24; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreClkDivider_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_60) begin
      fsm_SCoreClkDivider_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreClkDivider_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_4 = 6'h28; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreStart_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_61) begin
      fsm_SCoreStart_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreStart_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_5 = 6'h38; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_2 = 5'h1f; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreCmdIsrEn_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_62) begin
      fsm_SCoreCmdIsrEn_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreCmdIsrEn_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_6 = 7'h40; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_3 = 5'h1f; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreDataIsrEn_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_63) begin
      fsm_SCoreDataIsrEn_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreDataIsrEn_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_7 = 5'h1c; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_4 = 1'b1; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreDataWithSet_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_64) begin
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
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531) begin
          fsm_SSDCmd0_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_65) begin
      fsm_SSDCmd0_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_8 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253) begin
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_1) begin
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_9 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_3) begin
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_5 = 12'h800; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_6 = 9'h1aa; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_1) begin
          fsm_SSDcmd8_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_66) begin
      fsm_SSDcmd8_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_10 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_4) begin
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_5) begin
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_11 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_7) begin
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_7 = 14'h3719; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_2) begin
          fsm_SSDcmd55_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_67) begin
      fsm_SSDcmd55_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_12 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_8) begin
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_9) begin
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_13 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_11) begin
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_8 = 14'h2901; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_9 = 31'h40360000; // @[Expression.scala 2342:18]
  assign _zz_when_WbSdCtrl_l528 = 1'b1; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_3) begin
          fsm_SSDAcmd41_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_68) begin
      fsm_SSDAcmd41_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_14 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_12) begin
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_13) begin
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_15 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_15) begin
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_10 = 10'h20a; // @[Expression.scala 2342:18]
  assign _zz_when_WbSdCtrl_l528_1 = 1'b1; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_4) begin
          fsm_SSDCmd2_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_69) begin
      fsm_SSDCmd2_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_16 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_16) begin
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_17) begin
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_17 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_19) begin
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_11 = 10'h319; // @[Expression.scala 2342:18]
  assign _zz_when_WbSdCtrl_l528_2 = 1'b1; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_5) begin
          fsm_SSDCmd3_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_70) begin
      fsm_SSDCmd3_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_18 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_20) begin
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_21) begin
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_19 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_23) begin
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_12 = 12'h902; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_13 = CmdResponseReg3; // @[BaseType.scala 318:22]
  assign _zz_when_WbSdCtrl_l528_3 = 1'b1; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_6) begin
          fsm_SSDCmd9_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_71) begin
      fsm_SSDCmd9_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_20 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_24) begin
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_25) begin
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_21 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_27) begin
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_14 = 11'h759; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_15 = CmdResponseReg3; // @[BaseType.scala 318:22]
  assign _zz_when_WbSdCtrl_l528_4 = 1'b1; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_7) begin
          fsm_SSDCmd7_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_72) begin
      fsm_SSDCmd7_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_22 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_28) begin
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_29) begin
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_23 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_31) begin
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_16 = 13'h1019; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_17 = 10'h200; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_8) begin
          fsm_SSDCmd16_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_73) begin
      fsm_SSDCmd16_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_24 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_32) begin
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_33) begin
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_25 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_35) begin
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_18 = 14'h3719; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_19 = CmdResponseReg3; // @[BaseType.scala 318:22]
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
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_9) begin
          fsm_SSDcmd55_2_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_74) begin
      fsm_SSDcmd55_2_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_26 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_36) begin
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_37) begin
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_27 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_39) begin
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_20 = 11'h619; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_21 = 2'b10; // @[Expression.scala 2342:18]
  assign _zz_when_WbSdCtrl_l528_5 = 1'b1; // @[Expression.scala 2342:18]
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
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_10) begin
          fsm_SSDACmd6_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_75) begin
      fsm_SSDACmd6_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_28 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_40) begin
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_41) begin
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_29 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_43) begin
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_30 = 7'h44; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_22 = 9'h1ff; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreBlkSize_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_76) begin
      fsm_SCoreBlkSize_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreBlkSize_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_31 = 7'h48; // @[Expression.scala 2342:18]
  assign _zz_Mwb_DAT_MOSI_23 = 8'h80; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreBlkNum_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_77) begin
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
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
        if(when_WbSdCtrl_l643) begin
          fsm_SCoreSandData_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_SCoreSandData_fsm_wantStart = 1'b0; // @[StateMachine.scala 152:19]
    if(when_StateMachine_l253_78) begin
      fsm_SCoreSandData_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_32 = 7'h60; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_DmaAddr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_52) begin
      fsm_SCoreSandData_fsm_DmaAddr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_DmaAddr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_24 = 13'h1959; // @[Expression.scala 2342:18]
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
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_53) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_33 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_44) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_45) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_34 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_47) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_35 = 6'h3c; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_55) begin
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_DAT_MOSI_25 = 12'hc00; // @[Expression.scala 2342:18]
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
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l531_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantExit = 1'b1; // @[StateMachine.scala 366:14]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
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
    if(when_StateMachine_l253_56) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_36 = 3'b100; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_48) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_49) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  assign _zz_Mwb_ADR_37 = 6'h34; // @[Expression.scala 2342:18]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantExit = 1'b0; // @[StateMachine.scala 151:28]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
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
    if(when_StateMachine_l253_51) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart = 1'b1; // @[StateMachine.scala 362:15]
    end
  end

  assign fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill = 1'b0; // @[StateMachine.scala 153:18]
  always @(*) begin
    fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreRest_fsm_stateReg)
      fsm_SCoreRest_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreRest_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415) begin
          fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreRest_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreRest_fsm_wantStart) begin
      fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreRest_fsm_wantKill) begin
      fsm_SCoreRest_fsm_stateNext = fsm_SCoreRest_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreCmdTimeOut_fsm_stateReg)
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_1) begin
          fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreCmdTimeOut_fsm_wantStart) begin
      fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreCmdTimeOut_fsm_wantKill) begin
      fsm_SCoreCmdTimeOut_fsm_stateNext = fsm_SCoreCmdTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_1 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoredataTimeOut_fsm_stateReg)
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_2) begin
          fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoredataTimeOut_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoredataTimeOut_fsm_wantStart) begin
      fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoredataTimeOut_fsm_wantKill) begin
      fsm_SCoredataTimeOut_fsm_stateNext = fsm_SCoredataTimeOut_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_2 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreClkDivider_fsm_stateReg)
      fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_3) begin
          fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreClkDivider_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreClkDivider_fsm_wantStart) begin
      fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreClkDivider_fsm_wantKill) begin
      fsm_SCoreClkDivider_fsm_stateNext = fsm_SCoreClkDivider_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_3 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreStart_fsm_stateReg)
      fsm_SCoreStart_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreStart_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_4) begin
          fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreStart_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreStart_fsm_wantStart) begin
      fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreStart_fsm_wantKill) begin
      fsm_SCoreStart_fsm_stateNext = fsm_SCoreStart_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_4 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreCmdIsrEn_fsm_stateReg)
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_5) begin
          fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreCmdIsrEn_fsm_wantStart) begin
      fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreCmdIsrEn_fsm_wantKill) begin
      fsm_SCoreCmdIsrEn_fsm_stateNext = fsm_SCoreCmdIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_5 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreDataIsrEn_fsm_stateReg)
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_6) begin
          fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreDataIsrEn_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreDataIsrEn_fsm_wantStart) begin
      fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreDataIsrEn_fsm_wantKill) begin
      fsm_SCoreDataIsrEn_fsm_stateNext = fsm_SCoreDataIsrEn_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_6 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreDataWithSet_fsm_stateReg)
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_7) begin
          fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreDataWithSet_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreDataWithSet_fsm_wantStart) begin
      fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreDataWithSet_fsm_wantKill) begin
      fsm_SCoreDataWithSet_fsm_stateNext = fsm_SCoreDataWithSet_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_7 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_8) begin
          fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd0_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_8 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_9) begin
          fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd0_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_9 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_10) begin
          fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_10 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490) begin
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
        if(when_WbSdCtrl_l508) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531) begin
          fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDCmd0_fsm_stateNext = fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545) begin
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
  assign when_WbSdCtrl_l490 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l528_6)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_1 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_2 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_3 = ((! (fsm_SSDCmd0_fsm_stateReg == fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd0_fsm_stateNext == fsm_SSDCmd0_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_11) begin
          fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd8_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_11 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_12) begin
          fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd8_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_12 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_13) begin
          fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_13 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_1) begin
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
        if(when_WbSdCtrl_l508_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_1) begin
          fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDcmd8_fsm_stateNext = fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_1) begin
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
  assign when_WbSdCtrl_l490_1 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_1 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_1 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_1 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l528_1_1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_1 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_1 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_4 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreCmd)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_5 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreArguMent)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_6 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreDelay)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_7 = ((! (fsm_SSDcmd8_fsm_stateReg == fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDcmd8_fsm_stateNext == fsm_SSDcmd8_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_14) begin
          fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_14 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_15) begin
          fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_15 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_16) begin
          fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_16 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_2) begin
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
        if(when_WbSdCtrl_l508_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_2) begin
          fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDcmd55_fsm_stateNext = fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_2) begin
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
  assign when_WbSdCtrl_l490_2 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_2 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_2 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_2 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l528_2_1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_2 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_2 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_8 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreCmd)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_9 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreArguMent)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_10 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreDelay)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_11 = ((! (fsm_SSDcmd55_fsm_stateReg == fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDcmd55_fsm_stateNext == fsm_SSDcmd55_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_17) begin
          fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDAcmd41_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_17 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_18) begin
          fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_18 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_19) begin
          fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_19 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_3) begin
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
        if(when_WbSdCtrl_l508_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_3) begin
          fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDAcmd41_fsm_stateNext = fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_3) begin
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
  assign when_WbSdCtrl_l490_3 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_3 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_3 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_3 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l528_3_1 == _zz_when_WbSdCtrl_l528_3_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_3 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l531_3 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_3 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_12 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreCmd)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_13 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_14 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreDelay)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_15 = ((! (fsm_SSDAcmd41_fsm_stateReg == fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDAcmd41_fsm_stateNext == fsm_SSDAcmd41_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_20) begin
          fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd2_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_20 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_21) begin
          fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd2_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_21 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_22) begin
          fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_22 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_4) begin
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
        if(when_WbSdCtrl_l508_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_4) begin
          fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDCmd2_fsm_stateNext = fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_4) begin
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
  assign when_WbSdCtrl_l490_4 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_4 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_4 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_4 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l528_4_1 == _zz_when_WbSdCtrl_l528_4_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_4 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l531_4 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_4 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_16 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_17 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_18 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_19 = ((! (fsm_SSDCmd2_fsm_stateReg == fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd2_fsm_stateNext == fsm_SSDCmd2_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_23) begin
          fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd3_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_23 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_24) begin
          fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd3_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_24 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_25) begin
          fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_25 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_5) begin
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
        if(when_WbSdCtrl_l508_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_5) begin
          fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDCmd3_fsm_stateNext = fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_5) begin
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
  assign when_WbSdCtrl_l490_5 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_5 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_5 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_5 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l528_5_1 == _zz_when_WbSdCtrl_l528_5_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_5 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l531_5 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_5 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_20 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_21 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_22 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_23 = ((! (fsm_SSDCmd3_fsm_stateReg == fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd3_fsm_stateNext == fsm_SSDCmd3_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_26) begin
          fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd9_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_26 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_27) begin
          fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd9_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_27 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_28) begin
          fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_28 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_6) begin
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
        if(when_WbSdCtrl_l508_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_6) begin
          fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDCmd9_fsm_stateNext = fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_6) begin
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
  assign when_WbSdCtrl_l490_6 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_6 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_6 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_6 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l528_6_1 == _zz_when_WbSdCtrl_l528_6_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_6 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l531_6 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_6 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_24 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_25 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_26 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_27 = ((! (fsm_SSDCmd9_fsm_stateReg == fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd9_fsm_stateNext == fsm_SSDCmd9_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_29) begin
          fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd7_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_29 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_30) begin
          fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd7_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_30 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_31) begin
          fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_31 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_7) begin
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
        if(when_WbSdCtrl_l508_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_7) begin
          fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDCmd7_fsm_stateNext = fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_7) begin
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
  assign when_WbSdCtrl_l490_7 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_7 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_7 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_7 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l528_7_1 == _zz_when_WbSdCtrl_l528_7_2)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_7 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l531_7 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_7 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_28 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_29 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_30 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_31 = ((! (fsm_SSDCmd7_fsm_stateReg == fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd7_fsm_stateNext == fsm_SSDCmd7_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_32) begin
          fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd16_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_32 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_33) begin
          fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd16_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_33 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_34) begin
          fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_34 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_8) begin
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
        if(when_WbSdCtrl_l508_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_8) begin
          fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDCmd16_fsm_stateNext = fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_8) begin
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
  assign when_WbSdCtrl_l490_8 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_8 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_8 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_8 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l528_8)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_8 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_8 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_32 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreCmd)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_33 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreArguMent)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_34 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreDelay)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_35 = ((! (fsm_SSDCmd16_fsm_stateReg == fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDCmd16_fsm_stateNext == fsm_SSDCmd16_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_35) begin
          fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_35 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_36) begin
          fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_36 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_37) begin
          fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_37 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_9) begin
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
        if(when_WbSdCtrl_l508_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_9) begin
          fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDcmd55_2_fsm_stateNext = fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_9) begin
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
  assign when_WbSdCtrl_l490_9 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_9 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_9 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_9 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l528_9)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_9 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_9 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_36 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_37 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_38 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_39 = ((! (fsm_SSDcmd55_2_fsm_stateReg == fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDcmd55_2_fsm_stateNext == fsm_SSDcmd55_2_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_38) begin
          fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDACmd6_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_38 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_39) begin
          fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDACmd6_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_39 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_40) begin
          fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_40 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_10) begin
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
        if(when_WbSdCtrl_l508_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
        fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_10) begin
          fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SSDACmd6_fsm_stateNext = fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_10) begin
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
  assign when_WbSdCtrl_l490_10 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_10 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_10 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_10 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l528_10 == _zz_when_WbSdCtrl_l528_10_1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_10 = ((NormalIsrStatus[0] == 1'b1) && (_zz_when_WbSdCtrl_l531_10 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_10 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_40 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreCmd)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_41 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreArguMent)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_42 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreDelay)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_43 = ((! (fsm_SSDACmd6_fsm_stateReg == fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SSDACmd6_fsm_stateNext == fsm_SSDACmd6_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreBlkSize_fsm_stateReg)
      fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_41) begin
          fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreBlkSize_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreBlkSize_fsm_wantStart) begin
      fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreBlkSize_fsm_wantKill) begin
      fsm_SCoreBlkSize_fsm_stateNext = fsm_SCoreBlkSize_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_41 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreBlkNum_fsm_stateReg)
      fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_42) begin
          fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreBlkNum_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreBlkNum_fsm_wantStart) begin
      fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreBlkNum_fsm_wantKill) begin
      fsm_SCoreBlkNum_fsm_stateNext = fsm_SCoreBlkNum_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_42 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg)
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_43) begin
          fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_DmaAddr_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_DmaAddr_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext = fsm_SCoreSandData_fsm_DmaAddr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_43 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_44) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_44 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_45) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_45 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_46) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_46 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_11) begin
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
        if(when_WbSdCtrl_l508_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_11) begin
          fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_11) begin
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
  assign when_WbSdCtrl_l490_11 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_11 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_11 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_11 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l528_11)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_11 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_11 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_44 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_45 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_46 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_47 = ((! (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SCoreSandData_fsm_SSDCmd25_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg)
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_47) begin
          fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_ClearIsrData_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext = fsm_SCoreSandData_fsm_ClearIsrData_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_47 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_48) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_48 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_49) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_49 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  always @(*) begin
    fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg; // @[StateMachine.scala 217:17]
    case(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg)
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreWaitAck : begin
        if(when_WbSdCtrl_l415_50) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr; // @[Enum.scala 148:67]
        end else begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreClearWr : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
      end
      default : begin
      end
    endcase
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantStart) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_SCoreCmdSand; // @[Enum.scala 148:67]
    end
    if(fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_wantKill) begin
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
    end
  end

  assign when_WbSdCtrl_l415_50 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l490_12) begin
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
        if(when_WbSdCtrl_l508_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
        if(when_WbSdCtrl_l525_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreNormalIsrRd; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l528_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l531_12) begin
          fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_BOOT; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext = fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
        if(when_WbSdCtrl_l545_12) begin
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

  assign when_State_l238_12 = (_zz_when_State_l238_13 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l490_12 = (ISRCmd == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l508_12 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l525_12 = (NormalIsrStatus[0] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l528_12 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == _zz_when_WbSdCtrl_l528_12)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l531_12 = ((NormalIsrStatus[0] == 1'b1) && (32'h0 == 32'h0)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l545_12 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_48 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreCmd)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_49 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreArguMent)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_50 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_51 = ((! (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateReg == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr)) && (fsm_SCoreSandData_fsm_SSDCmd12_fsm_stateNext == fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreClearCmdIsr)); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l595) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_CheckIsrDone; // @[Enum.scala 148:67]
        end else begin
          if(when_WbSdCtrl_l597) begin
            fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_BdIsr; // @[Enum.scala 148:67]
          end else begin
            fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_WrData; // @[Enum.scala 148:67]
          end
        end
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
        if(when_State_l238_13) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_CheckIsrDone; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
        if(when_WbSdCtrl_l609) begin
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
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_SSDCmd25; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
        fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_BdIsrGet; // @[Enum.scala 148:67]
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
        if(when_WbSdCtrl_l631) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_BdIsrCheck; // @[Enum.scala 148:67]
        end
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
        if(when_WbSdCtrl_l640) begin
          fsm_SCoreSandData_fsm_stateNext = fsm_SCoreSandData_fsm_enumDef_BdIsr; // @[Enum.scala 148:67]
        end
        if(when_WbSdCtrl_l643) begin
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

  assign when_WbSdCtrl_l590 = (((Swb_WE == 1'b0) && (Swb_CYC == 1'b1)) && (Swb_STB == 1'b1)); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l595 = (32'h00010000 <= fsm_SCoreSandData_fsm_TxCnt); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l597 = (32'h00010000 <= fsm_SCoreSandData_fsm_TxCnt); // @[BaseType.scala 305:24]
  assign when_State_l238_13 = (_zz_when_State_l238_12 <= 9'h001); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l609 = (ISRData == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l631 = (Mwb_ACK == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l640 = (BdIsrStatus[2] == 1'b0); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l643 = (BdIsrStatus[2] == 1'b1); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_52 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_DmaAddr)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_DmaAddr)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_53 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_SSDCmd25)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_SSDCmd25)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_54 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_WrDataDelay)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_WrDataDelay)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_55 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_ClearIsrData)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_ClearIsrData)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_56 = ((! (fsm_SCoreSandData_fsm_stateReg == fsm_SCoreSandData_fsm_enumDef_SSDCmd12)) && (fsm_SCoreSandData_fsm_stateNext == fsm_SCoreSandData_fsm_enumDef_SSDCmd12)); // @[BaseType.scala 305:24]
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
        if(when_WbSdCtrl_l303) begin
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
        if(when_WbSdCtrl_l330) begin
          fsm_stateNext = fsm_enumDef_SSDCmd3; // @[Enum.scala 148:67]
        end else begin
          fsm_stateNext = fsm_enumDef_SSDCmd9; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SSDCmd9 : begin
        if(fsm_SSDCmd9_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDCmd7; // @[Enum.scala 148:67]
        end
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
          fsm_stateNext = fsm_enumDef_SCoreSandData; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreSandData : begin
        if(fsm_SCoreSandData_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_SSDCmd7; // @[Enum.scala 148:67]
        end
      end
      fsm_enumDef_SCoreAddrAdd : begin
        fsm_stateNext = fsm_enumDef_SCoreBlkNum; // @[Enum.scala 148:67]
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

  assign when_WbSdCtrl_l303 = (CmdResponseRegA41[31] == 1'b1); // @[BaseType.scala 305:24]
  assign when_WbSdCtrl_l330 = (RSPCardStatus != 4'b0011); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_57 = ((! (fsm_stateReg == fsm_enumDef_SCoreRest)) && (fsm_stateNext == fsm_enumDef_SCoreRest)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_58 = ((! (fsm_stateReg == fsm_enumDef_SCoreCmdTimeOut)) && (fsm_stateNext == fsm_enumDef_SCoreCmdTimeOut)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_59 = ((! (fsm_stateReg == fsm_enumDef_SCoredataTimeOut)) && (fsm_stateNext == fsm_enumDef_SCoredataTimeOut)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_60 = ((! (fsm_stateReg == fsm_enumDef_SCoreClkDivider)) && (fsm_stateNext == fsm_enumDef_SCoreClkDivider)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_61 = ((! (fsm_stateReg == fsm_enumDef_SCoreStart)) && (fsm_stateNext == fsm_enumDef_SCoreStart)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_62 = ((! (fsm_stateReg == fsm_enumDef_SCoreCmdIsrEn)) && (fsm_stateNext == fsm_enumDef_SCoreCmdIsrEn)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_63 = ((! (fsm_stateReg == fsm_enumDef_SCoreDataIsrEn)) && (fsm_stateNext == fsm_enumDef_SCoreDataIsrEn)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_64 = ((! (fsm_stateReg == fsm_enumDef_SCoreDataWithSet)) && (fsm_stateNext == fsm_enumDef_SCoreDataWithSet)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_65 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd0)) && (fsm_stateNext == fsm_enumDef_SSDCmd0)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_66 = ((! (fsm_stateReg == fsm_enumDef_SSDcmd8)) && (fsm_stateNext == fsm_enumDef_SSDcmd8)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_67 = ((! (fsm_stateReg == fsm_enumDef_SSDcmd55)) && (fsm_stateNext == fsm_enumDef_SSDcmd55)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_68 = ((! (fsm_stateReg == fsm_enumDef_SSDAcmd41)) && (fsm_stateNext == fsm_enumDef_SSDAcmd41)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_69 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd2)) && (fsm_stateNext == fsm_enumDef_SSDCmd2)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_70 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd3)) && (fsm_stateNext == fsm_enumDef_SSDCmd3)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_71 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd9)) && (fsm_stateNext == fsm_enumDef_SSDCmd9)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_72 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd7)) && (fsm_stateNext == fsm_enumDef_SSDCmd7)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_73 = ((! (fsm_stateReg == fsm_enumDef_SSDCmd16)) && (fsm_stateNext == fsm_enumDef_SSDCmd16)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_74 = ((! (fsm_stateReg == fsm_enumDef_SSDcmd55_2)) && (fsm_stateNext == fsm_enumDef_SSDcmd55_2)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_75 = ((! (fsm_stateReg == fsm_enumDef_SSDACmd6)) && (fsm_stateNext == fsm_enumDef_SSDACmd6)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_76 = ((! (fsm_stateReg == fsm_enumDef_SCoreBlkSize)) && (fsm_stateNext == fsm_enumDef_SCoreBlkSize)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_77 = ((! (fsm_stateReg == fsm_enumDef_SCoreBlkNum)) && (fsm_stateNext == fsm_enumDef_SCoreBlkNum)); // @[BaseType.scala 305:24]
  assign when_StateMachine_l253_78 = ((! (fsm_stateReg == fsm_enumDef_SCoreSandData)) && (fsm_stateNext == fsm_enumDef_SCoreSandData)); // @[BaseType.scala 305:24]
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      NormalIsrStatus <= 32'h0; // @[Data.scala 400:33]
      CmdResponseRegA41 <= 32'h0; // @[Data.scala 400:33]
      CmdResponseReg2 <= 32'h0; // @[Data.scala 400:33]
      CmdResponseReg3 <= 32'h0; // @[Data.scala 400:33]
      BdIsrStatus <= 32'h0; // @[Data.scala 400:33]
      RSPCardStatus <= 4'b0000; // @[Data.scala 400:33]
      TestBclkAddr <= 32'h0; // @[Data.scala 400:33]
      fsm_SCoreSandData_fsm_TxCnt <= 32'h0; // @[Data.scala 400:33]
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
      fsm_stateReg <= fsm_enumDef_BOOT; // @[Data.scala 400:33]
    end else begin
      fsm_SCoreRest_fsm_stateReg <= fsm_SCoreRest_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreCmdTimeOut_fsm_stateReg <= fsm_SCoreCmdTimeOut_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoredataTimeOut_fsm_stateReg <= fsm_SCoredataTimeOut_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreClkDivider_fsm_stateReg <= fsm_SCoreClkDivider_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreStart_fsm_stateReg <= fsm_SCoreStart_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreCmdIsrEn_fsm_stateReg <= fsm_SCoreCmdIsrEn_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreDataIsrEn_fsm_stateReg <= fsm_SCoreDataIsrEn_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreDataWithSet_fsm_stateReg <= fsm_SCoreDataWithSet_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd0_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd8_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd55_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDAcmd41_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd2_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd3_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd9_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd7_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDCmd16_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDcmd55_2_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SSDACmd6_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SCoreBlkSize_fsm_stateReg <= fsm_SCoreBlkSize_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreBlkNum_fsm_stateReg <= fsm_SCoreBlkNum_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreSandData_fsm_DmaAddr_fsm_stateReg <= fsm_SCoreSandData_fsm_DmaAddr_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd25_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateReg <= fsm_SCoreSandData_fsm_ClearIsrData_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreCmd_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreArguMent_fsm_stateNext; // @[StateMachine.scala 212:14]
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateReg <= fsm_SCoreSandData_fsm_SSDCmd12_fsm_SCoreClearCmdIsr_fsm_stateNext; // @[StateMachine.scala 212:14]
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
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait1 : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData : begin
          NormalIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 516:27]
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
        end
        fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
        end
        default : begin
        end
      endcase
      fsm_SCoreSandData_fsm_stateReg <= fsm_SCoreSandData_fsm_stateNext; // @[StateMachine.scala 212:14]
      case(fsm_SCoreSandData_fsm_stateReg)
        fsm_SCoreSandData_fsm_enumDef_IDLE : begin
        end
        fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
        end
        fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
        end
        fsm_SCoreSandData_fsm_enumDef_WrData : begin
          if(when_WbSdCtrl_l590) begin
            fsm_SCoreSandData_fsm_TxCnt <= (fsm_SCoreSandData_fsm_TxCnt + 32'h00000001); // @[WbSdCtrl.scala 591:19]
          end
        end
        fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
        end
        fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
        end
        fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
        end
        fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
        end
        fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
        end
        fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
        end
        fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
          BdIsrStatus <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 639:23]
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
            CmdResponseRegA41 <= CmdResponseReg; // @[WbSdCtrl.scala 296:27]
          end
        end
        fsm_enumDef_SSDAcmd41Done : begin
        end
        fsm_enumDef_SSDCmd2 : begin
          if(fsm_SSDCmd2_fsm_wantExit) begin
            CmdResponseReg2 <= CmdResponseReg; // @[WbSdCtrl.scala 313:25]
          end
        end
        fsm_enumDef_SSDCmd3 : begin
          if(fsm_SSDCmd3_fsm_wantExit) begin
            CmdResponseReg3 <= {CmdResponseReg[31 : 16],LBits}; // @[WbSdCtrl.scala 321:25]
            RSPCardStatus <= CmdResponseReg[12 : 9]; // @[WbSdCtrl.scala 322:23]
          end
        end
        fsm_enumDef_SSDStby : begin
        end
        fsm_enumDef_SSDCmd9 : begin
        end
        fsm_enumDef_SSDCmd7 : begin
          if(fsm_SSDCmd7_fsm_wantExit) begin
            RSPCardStatus <= CmdResponseReg[12 : 9]; // @[WbSdCtrl.scala 349:23]
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
        fsm_enumDef_SCoreAddrAdd : begin
          TestBclkAddr <= (TestBclkAddr + 32'h00000001); // @[WbSdCtrl.scala 400:22]
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if(when_WbSdCtrl_l68) begin
      CmdResponseReg <= Mwb_DAT_MISO; // @[WbSdCtrl.scala 68:35]
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
      fsm_SSDCmd0_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd0_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDCmd0_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_2) begin
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
      fsm_SSDcmd8_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd8_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDcmd8_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_6) begin
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
      fsm_SSDcmd55_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDcmd55_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_10) begin
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
      fsm_SSDAcmd41_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDAcmd41_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_14) begin
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
      fsm_SSDCmd2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDCmd2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_18) begin
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
      fsm_SSDCmd3_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd3_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDCmd3_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_22) begin
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
      fsm_SSDCmd9_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd9_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDCmd9_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_26) begin
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
      fsm_SSDCmd7_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd7_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDCmd7_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_30) begin
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
      fsm_SSDCmd16_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDCmd16_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDCmd16_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_34) begin
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
      fsm_SSDcmd55_2_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDcmd55_2_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_38) begin
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
      fsm_SSDACmd6_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SSDACmd6_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SSDACmd6_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_42) begin
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
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd25_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_46) begin
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
        _zz_when_State_l238_13 <= (_zz_when_State_l238_13 - 9'h001); // @[State.scala 237:17]
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
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreGetRdData1 : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_CmdPeponeseGet : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdAckWait : begin
      end
      fsm_SCoreSandData_fsm_SSDCmd12_fsm_enumDef_SCoreRdFinish : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_50) begin
      _zz_when_State_l238_13 <= 9'h1f4; // @[State.scala 233:17]
    end
    case(fsm_SCoreSandData_fsm_stateReg)
      fsm_SCoreSandData_fsm_enumDef_IDLE : begin
      end
      fsm_SCoreSandData_fsm_enumDef_DmaAddr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd25 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_WrDataDelay : begin
        _zz_when_State_l238_12 <= (_zz_when_State_l238_12 - 9'h001); // @[State.scala 237:17]
      end
      fsm_SCoreSandData_fsm_enumDef_CheckIsrDone : begin
      end
      fsm_SCoreSandData_fsm_enumDef_ClearIsrData : begin
      end
      fsm_SCoreSandData_fsm_enumDef_SSDCmd12 : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsr : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrGet : begin
      end
      fsm_SCoreSandData_fsm_enumDef_BdIsrCheck : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253_54) begin
      _zz_when_State_l238_12 <= 9'h1f4; // @[State.scala 233:17]
    end
  end


endmodule
