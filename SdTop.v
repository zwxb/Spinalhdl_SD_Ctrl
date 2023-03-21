// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : SdTop
// Git hash  : 73e14eb85abd05afa706f44710fcebedb3c0f1bf

`timescale 1ns/1ps

module SdTop (
  input               sd1_wb_clk_i,
  input               sd1_wb_rst_i,
  input      [31:0]   sd1_wb_dat_i,
  output     [31:0]   sd1_wb_dat_o,
  output     [7:0]    sd1_wb_adr_i,
  input      [3:0]    sd1_wb_sel_i,
  input               sd1_wb_we_i,
  input               sd1_wb_cyc_i,
  input               sd1_wb_stb_i,
  output              sd1_wb_ack_o,
  output     [31:0]   sd1_m_wb_dat_o,
  output     [31:0]   sd1_m_wb_dat_i,
  output     [31:0]   sd1_m_wb_adr_o,
  output     [3:0]    sd1_m_wb_sel_o,
  output              sd1_m_wb_we_o,
  output              sd1_m_wb_cyc_o,
  output              sd1_m_wb_stb_o,
  input               sd1_m_wb_ack_i,
  output     [2:0]    sd1_m_wb_cti_o,
  output     [1:0]    sd1_m_wb_bte_o,
  input               sd1_sd_cmd_dat_i,
  output              sd1_sd_cmd_out_o,
  output              sd1_sd_cmd_oe_o,
  input      [3:0]    sd1_sd_dat_dat_i,
  output     [3:0]    sd1_sd_dat_out_o,
  output              sd1_sd_dat_oe_o,
  output              sd1_sd_clk_o_pad,
  input               sd1_sd_clk_i_pad,
  output              sd1_int_cmd,
  output              sd1_int_data,
  input               sd2_wb_clk_i,
  input               sd2_wb_rst_i,
  input      [31:0]   sd2_wb_dat_i,
  output     [31:0]   sd2_wb_dat_o,
  output     [7:0]    sd2_wb_adr_i,
  input      [3:0]    sd2_wb_sel_i,
  input               sd2_wb_we_i,
  input               sd2_wb_cyc_i,
  input               sd2_wb_stb_i,
  output              sd2_wb_ack_o,
  output     [31:0]   sd2_m_wb_dat_o,
  output     [31:0]   sd2_m_wb_dat_i,
  output     [31:0]   sd2_m_wb_adr_o,
  output     [3:0]    sd2_m_wb_sel_o,
  output              sd2_m_wb_we_o,
  output              sd2_m_wb_cyc_o,
  output              sd2_m_wb_stb_o,
  input               sd2_m_wb_ack_i,
  output     [2:0]    sd2_m_wb_cti_o,
  output     [1:0]    sd2_m_wb_bte_o,
  input               sd2_sd_cmd_dat_i,
  output              sd2_sd_cmd_out_o,
  output              sd2_sd_cmd_oe_o,
  input      [3:0]    sd2_sd_dat_dat_i,
  output     [3:0]    sd2_sd_dat_out_o,
  output              sd2_sd_dat_oe_o,
  output              sd2_sd_clk_o_pad,
  input               sd2_sd_clk_i_pad,
  output              sd2_int_cmd,
  output              sd2_int_data,
  input               sd3_wb_clk_i,
  input               sd3_wb_rst_i,
  input      [31:0]   sd3_wb_dat_i,
  output     [31:0]   sd3_wb_dat_o,
  output     [7:0]    sd3_wb_adr_i,
  input      [3:0]    sd3_wb_sel_i,
  input               sd3_wb_we_i,
  input               sd3_wb_cyc_i,
  input               sd3_wb_stb_i,
  output              sd3_wb_ack_o,
  output     [31:0]   sd3_m_wb_dat_o,
  output     [31:0]   sd3_m_wb_dat_i,
  output     [31:0]   sd3_m_wb_adr_o,
  output     [3:0]    sd3_m_wb_sel_o,
  output              sd3_m_wb_we_o,
  output              sd3_m_wb_cyc_o,
  output              sd3_m_wb_stb_o,
  input               sd3_m_wb_ack_i,
  output     [2:0]    sd3_m_wb_cti_o,
  output     [1:0]    sd3_m_wb_bte_o,
  input               sd3_sd_cmd_dat_i,
  output              sd3_sd_cmd_out_o,
  output              sd3_sd_cmd_oe_o,
  input      [3:0]    sd3_sd_dat_dat_i,
  output     [3:0]    sd3_sd_dat_out_o,
  output              sd3_sd_dat_oe_o,
  output              sd3_sd_clk_o_pad,
  input               sd3_sd_clk_i_pad,
  output              sd3_int_cmd,
  output              sd3_int_data,
  input               sd4_wb_clk_i,
  input               sd4_wb_rst_i,
  input      [31:0]   sd4_wb_dat_i,
  output     [31:0]   sd4_wb_dat_o,
  output     [7:0]    sd4_wb_adr_i,
  input      [3:0]    sd4_wb_sel_i,
  input               sd4_wb_we_i,
  input               sd4_wb_cyc_i,
  input               sd4_wb_stb_i,
  output              sd4_wb_ack_o,
  output     [31:0]   sd4_m_wb_dat_o,
  output     [31:0]   sd4_m_wb_dat_i,
  output     [31:0]   sd4_m_wb_adr_o,
  output     [3:0]    sd4_m_wb_sel_o,
  output              sd4_m_wb_we_o,
  output              sd4_m_wb_cyc_o,
  output              sd4_m_wb_stb_o,
  input               sd4_m_wb_ack_i,
  output     [2:0]    sd4_m_wb_cti_o,
  output     [1:0]    sd4_m_wb_bte_o,
  input               sd4_sd_cmd_dat_i,
  output              sd4_sd_cmd_out_o,
  output              sd4_sd_cmd_oe_o,
  input      [3:0]    sd4_sd_dat_dat_i,
  output     [3:0]    sd4_sd_dat_out_o,
  output              sd4_sd_dat_oe_o,
  output              sd4_sd_clk_o_pad,
  input               sd4_sd_clk_i_pad,
  output              sd4_int_cmd,
  output              sd4_int_data
);

  wire       [31:0]   sdctrl1_wb_dat_o;
  wire       [7:0]    sdctrl1_wb_adr_i;
  wire                sdctrl1_wb_ack_o;
  wire       [31:0]   sdctrl1_m_wb_dat_o;
  wire       [31:0]   sdctrl1_m_wb_dat_i;
  wire       [31:0]   sdctrl1_m_wb_adr_o;
  wire       [3:0]    sdctrl1_m_wb_sel_o;
  wire                sdctrl1_m_wb_we_o;
  wire                sdctrl1_m_wb_cyc_o;
  wire                sdctrl1_m_wb_stb_o;
  wire       [2:0]    sdctrl1_m_wb_cti_o;
  wire       [1:0]    sdctrl1_m_wb_bte_o;
  wire                sdctrl1_sd_cmd_out_o;
  wire                sdctrl1_sd_cmd_oe_o;
  wire       [3:0]    sdctrl1_sd_dat_out_o;
  wire                sdctrl1_sd_dat_oe_o;
  wire                sdctrl1_sd_clk_o_pad;
  wire                sdctrl1_int_cmd;
  wire                sdctrl1_int_data;
  wire       [31:0]   sdctrl2_wb_dat_o;
  wire       [7:0]    sdctrl2_wb_adr_i;
  wire                sdctrl2_wb_ack_o;
  wire       [31:0]   sdctrl2_m_wb_dat_o;
  wire       [31:0]   sdctrl2_m_wb_dat_i;
  wire       [31:0]   sdctrl2_m_wb_adr_o;
  wire       [3:0]    sdctrl2_m_wb_sel_o;
  wire                sdctrl2_m_wb_we_o;
  wire                sdctrl2_m_wb_cyc_o;
  wire                sdctrl2_m_wb_stb_o;
  wire       [2:0]    sdctrl2_m_wb_cti_o;
  wire       [1:0]    sdctrl2_m_wb_bte_o;
  wire                sdctrl2_sd_cmd_out_o;
  wire                sdctrl2_sd_cmd_oe_o;
  wire       [3:0]    sdctrl2_sd_dat_out_o;
  wire                sdctrl2_sd_dat_oe_o;
  wire                sdctrl2_sd_clk_o_pad;
  wire                sdctrl2_int_cmd;
  wire                sdctrl2_int_data;
  wire       [31:0]   sdctrl3_wb_dat_o;
  wire       [7:0]    sdctrl3_wb_adr_i;
  wire                sdctrl3_wb_ack_o;
  wire       [31:0]   sdctrl3_m_wb_dat_o;
  wire       [31:0]   sdctrl3_m_wb_dat_i;
  wire       [31:0]   sdctrl3_m_wb_adr_o;
  wire       [3:0]    sdctrl3_m_wb_sel_o;
  wire                sdctrl3_m_wb_we_o;
  wire                sdctrl3_m_wb_cyc_o;
  wire                sdctrl3_m_wb_stb_o;
  wire       [2:0]    sdctrl3_m_wb_cti_o;
  wire       [1:0]    sdctrl3_m_wb_bte_o;
  wire                sdctrl3_sd_cmd_out_o;
  wire                sdctrl3_sd_cmd_oe_o;
  wire       [3:0]    sdctrl3_sd_dat_out_o;
  wire                sdctrl3_sd_dat_oe_o;
  wire                sdctrl3_sd_clk_o_pad;
  wire                sdctrl3_int_cmd;
  wire                sdctrl3_int_data;
  wire       [31:0]   sdctrl4_wb_dat_o;
  wire       [7:0]    sdctrl4_wb_adr_i;
  wire                sdctrl4_wb_ack_o;
  wire       [31:0]   sdctrl4_m_wb_dat_o;
  wire       [31:0]   sdctrl4_m_wb_dat_i;
  wire       [31:0]   sdctrl4_m_wb_adr_o;
  wire       [3:0]    sdctrl4_m_wb_sel_o;
  wire                sdctrl4_m_wb_we_o;
  wire                sdctrl4_m_wb_cyc_o;
  wire                sdctrl4_m_wb_stb_o;
  wire       [2:0]    sdctrl4_m_wb_cti_o;
  wire       [1:0]    sdctrl4_m_wb_bte_o;
  wire                sdctrl4_sd_cmd_out_o;
  wire                sdctrl4_sd_cmd_oe_o;
  wire       [3:0]    sdctrl4_sd_dat_out_o;
  wire                sdctrl4_sd_dat_oe_o;
  wire                sdctrl4_sd_clk_o_pad;
  wire                sdctrl4_int_cmd;
  wire                sdctrl4_int_data;

  sdc_controller sdctrl1 (
    .wb_clk_i     (sd1_wb_clk_i             ), //i
    .wb_rst_i     (sd1_wb_rst_i             ), //i
    .wb_dat_i     (sd1_wb_dat_i[31:0]       ), //i
    .wb_dat_o     (sdctrl1_wb_dat_o[31:0]   ), //o
    .wb_adr_i     (sdctrl1_wb_adr_i[7:0]    ), //o
    .wb_sel_i     (sd1_wb_sel_i[3:0]        ), //i
    .wb_we_i      (sd1_wb_we_i              ), //i
    .wb_cyc_i     (sd1_wb_cyc_i             ), //i
    .wb_stb_i     (sd1_wb_stb_i             ), //i
    .wb_ack_o     (sdctrl1_wb_ack_o         ), //o
    .m_wb_dat_o   (sdctrl1_m_wb_dat_o[31:0] ), //o
    .m_wb_dat_i   (sdctrl1_m_wb_dat_i[31:0] ), //o
    .m_wb_adr_o   (sdctrl1_m_wb_adr_o[31:0] ), //o
    .m_wb_sel_o   (sdctrl1_m_wb_sel_o[3:0]  ), //o
    .m_wb_we_o    (sdctrl1_m_wb_we_o        ), //o
    .m_wb_cyc_o   (sdctrl1_m_wb_cyc_o       ), //o
    .m_wb_stb_o   (sdctrl1_m_wb_stb_o       ), //o
    .m_wb_ack_i   (sd1_m_wb_ack_i           ), //i
    .m_wb_cti_o   (sdctrl1_m_wb_cti_o[2:0]  ), //o
    .m_wb_bte_o   (sdctrl1_m_wb_bte_o[1:0]  ), //o
    .sd_cmd_dat_i (sd1_sd_cmd_dat_i         ), //i
    .sd_cmd_out_o (sdctrl1_sd_cmd_out_o     ), //o
    .sd_cmd_oe_o  (sdctrl1_sd_cmd_oe_o      ), //o
    .sd_dat_dat_i (sd1_sd_dat_dat_i[3:0]    ), //i
    .sd_dat_out_o (sdctrl1_sd_dat_out_o[3:0]), //o
    .sd_dat_oe_o  (sdctrl1_sd_dat_oe_o      ), //o
    .sd_clk_o_pad (sdctrl1_sd_clk_o_pad     ), //o
    .sd_clk_i_pad (sd1_sd_clk_i_pad         ), //i
    .int_cmd      (sdctrl1_int_cmd          ), //o
    .int_data     (sdctrl1_int_data         )  //o
  );
  sdc_controller sdctrl2 (
    .wb_clk_i     (sd2_wb_clk_i             ), //i
    .wb_rst_i     (sd2_wb_rst_i             ), //i
    .wb_dat_i     (sd2_wb_dat_i[31:0]       ), //i
    .wb_dat_o     (sdctrl2_wb_dat_o[31:0]   ), //o
    .wb_adr_i     (sdctrl2_wb_adr_i[7:0]    ), //o
    .wb_sel_i     (sd2_wb_sel_i[3:0]        ), //i
    .wb_we_i      (sd2_wb_we_i              ), //i
    .wb_cyc_i     (sd2_wb_cyc_i             ), //i
    .wb_stb_i     (sd2_wb_stb_i             ), //i
    .wb_ack_o     (sdctrl2_wb_ack_o         ), //o
    .m_wb_dat_o   (sdctrl2_m_wb_dat_o[31:0] ), //o
    .m_wb_dat_i   (sdctrl2_m_wb_dat_i[31:0] ), //o
    .m_wb_adr_o   (sdctrl2_m_wb_adr_o[31:0] ), //o
    .m_wb_sel_o   (sdctrl2_m_wb_sel_o[3:0]  ), //o
    .m_wb_we_o    (sdctrl2_m_wb_we_o        ), //o
    .m_wb_cyc_o   (sdctrl2_m_wb_cyc_o       ), //o
    .m_wb_stb_o   (sdctrl2_m_wb_stb_o       ), //o
    .m_wb_ack_i   (sd2_m_wb_ack_i           ), //i
    .m_wb_cti_o   (sdctrl2_m_wb_cti_o[2:0]  ), //o
    .m_wb_bte_o   (sdctrl2_m_wb_bte_o[1:0]  ), //o
    .sd_cmd_dat_i (sd2_sd_cmd_dat_i         ), //i
    .sd_cmd_out_o (sdctrl2_sd_cmd_out_o     ), //o
    .sd_cmd_oe_o  (sdctrl2_sd_cmd_oe_o      ), //o
    .sd_dat_dat_i (sd2_sd_dat_dat_i[3:0]    ), //i
    .sd_dat_out_o (sdctrl2_sd_dat_out_o[3:0]), //o
    .sd_dat_oe_o  (sdctrl2_sd_dat_oe_o      ), //o
    .sd_clk_o_pad (sdctrl2_sd_clk_o_pad     ), //o
    .sd_clk_i_pad (sd2_sd_clk_i_pad         ), //i
    .int_cmd      (sdctrl2_int_cmd          ), //o
    .int_data     (sdctrl2_int_data         )  //o
  );
  sdc_controller sdctrl3 (
    .wb_clk_i     (sd3_wb_clk_i             ), //i
    .wb_rst_i     (sd3_wb_rst_i             ), //i
    .wb_dat_i     (sd3_wb_dat_i[31:0]       ), //i
    .wb_dat_o     (sdctrl3_wb_dat_o[31:0]   ), //o
    .wb_adr_i     (sdctrl3_wb_adr_i[7:0]    ), //o
    .wb_sel_i     (sd3_wb_sel_i[3:0]        ), //i
    .wb_we_i      (sd3_wb_we_i              ), //i
    .wb_cyc_i     (sd3_wb_cyc_i             ), //i
    .wb_stb_i     (sd3_wb_stb_i             ), //i
    .wb_ack_o     (sdctrl3_wb_ack_o         ), //o
    .m_wb_dat_o   (sdctrl3_m_wb_dat_o[31:0] ), //o
    .m_wb_dat_i   (sdctrl3_m_wb_dat_i[31:0] ), //o
    .m_wb_adr_o   (sdctrl3_m_wb_adr_o[31:0] ), //o
    .m_wb_sel_o   (sdctrl3_m_wb_sel_o[3:0]  ), //o
    .m_wb_we_o    (sdctrl3_m_wb_we_o        ), //o
    .m_wb_cyc_o   (sdctrl3_m_wb_cyc_o       ), //o
    .m_wb_stb_o   (sdctrl3_m_wb_stb_o       ), //o
    .m_wb_ack_i   (sd3_m_wb_ack_i           ), //i
    .m_wb_cti_o   (sdctrl3_m_wb_cti_o[2:0]  ), //o
    .m_wb_bte_o   (sdctrl3_m_wb_bte_o[1:0]  ), //o
    .sd_cmd_dat_i (sd3_sd_cmd_dat_i         ), //i
    .sd_cmd_out_o (sdctrl3_sd_cmd_out_o     ), //o
    .sd_cmd_oe_o  (sdctrl3_sd_cmd_oe_o      ), //o
    .sd_dat_dat_i (sd3_sd_dat_dat_i[3:0]    ), //i
    .sd_dat_out_o (sdctrl3_sd_dat_out_o[3:0]), //o
    .sd_dat_oe_o  (sdctrl3_sd_dat_oe_o      ), //o
    .sd_clk_o_pad (sdctrl3_sd_clk_o_pad     ), //o
    .sd_clk_i_pad (sd3_sd_clk_i_pad         ), //i
    .int_cmd      (sdctrl3_int_cmd          ), //o
    .int_data     (sdctrl3_int_data         )  //o
  );
  sdc_controller sdctrl4 (
    .wb_clk_i     (sd4_wb_clk_i             ), //i
    .wb_rst_i     (sd4_wb_rst_i             ), //i
    .wb_dat_i     (sd4_wb_dat_i[31:0]       ), //i
    .wb_dat_o     (sdctrl4_wb_dat_o[31:0]   ), //o
    .wb_adr_i     (sdctrl4_wb_adr_i[7:0]    ), //o
    .wb_sel_i     (sd4_wb_sel_i[3:0]        ), //i
    .wb_we_i      (sd4_wb_we_i              ), //i
    .wb_cyc_i     (sd4_wb_cyc_i             ), //i
    .wb_stb_i     (sd4_wb_stb_i             ), //i
    .wb_ack_o     (sdctrl4_wb_ack_o         ), //o
    .m_wb_dat_o   (sdctrl4_m_wb_dat_o[31:0] ), //o
    .m_wb_dat_i   (sdctrl4_m_wb_dat_i[31:0] ), //o
    .m_wb_adr_o   (sdctrl4_m_wb_adr_o[31:0] ), //o
    .m_wb_sel_o   (sdctrl4_m_wb_sel_o[3:0]  ), //o
    .m_wb_we_o    (sdctrl4_m_wb_we_o        ), //o
    .m_wb_cyc_o   (sdctrl4_m_wb_cyc_o       ), //o
    .m_wb_stb_o   (sdctrl4_m_wb_stb_o       ), //o
    .m_wb_ack_i   (sd4_m_wb_ack_i           ), //i
    .m_wb_cti_o   (sdctrl4_m_wb_cti_o[2:0]  ), //o
    .m_wb_bte_o   (sdctrl4_m_wb_bte_o[1:0]  ), //o
    .sd_cmd_dat_i (sd4_sd_cmd_dat_i         ), //i
    .sd_cmd_out_o (sdctrl4_sd_cmd_out_o     ), //o
    .sd_cmd_oe_o  (sdctrl4_sd_cmd_oe_o      ), //o
    .sd_dat_dat_i (sd4_sd_dat_dat_i[3:0]    ), //i
    .sd_dat_out_o (sdctrl4_sd_dat_out_o[3:0]), //o
    .sd_dat_oe_o  (sdctrl4_sd_dat_oe_o      ), //o
    .sd_clk_o_pad (sdctrl4_sd_clk_o_pad     ), //o
    .sd_clk_i_pad (sd4_sd_clk_i_pad         ), //i
    .int_cmd      (sdctrl4_int_cmd          ), //o
    .int_data     (sdctrl4_int_data         )  //o
  );
  assign sd1_wb_dat_o = sdctrl1_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd1_wb_adr_i = sdctrl1_wb_adr_i; // @[SdContrller.scala 55:11]
  assign sd1_wb_ack_o = sdctrl1_wb_ack_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_dat_o = sdctrl1_m_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_dat_i = sdctrl1_m_wb_dat_i; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_adr_o = sdctrl1_m_wb_adr_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_sel_o = sdctrl1_m_wb_sel_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_we_o = sdctrl1_m_wb_we_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_cyc_o = sdctrl1_m_wb_cyc_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_stb_o = sdctrl1_m_wb_stb_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_cti_o = sdctrl1_m_wb_cti_o; // @[SdContrller.scala 55:11]
  assign sd1_m_wb_bte_o = sdctrl1_m_wb_bte_o; // @[SdContrller.scala 55:11]
  assign sd1_sd_cmd_out_o = sdctrl1_sd_cmd_out_o; // @[SdContrller.scala 55:11]
  assign sd1_sd_cmd_oe_o = sdctrl1_sd_cmd_oe_o; // @[SdContrller.scala 55:11]
  assign sd1_sd_dat_out_o = sdctrl1_sd_dat_out_o; // @[SdContrller.scala 55:11]
  assign sd1_sd_dat_oe_o = sdctrl1_sd_dat_oe_o; // @[SdContrller.scala 55:11]
  assign sd1_sd_clk_o_pad = sdctrl1_sd_clk_o_pad; // @[SdContrller.scala 55:11]
  assign sd1_int_cmd = sdctrl1_int_cmd; // @[SdContrller.scala 55:11]
  assign sd1_int_data = sdctrl1_int_data; // @[SdContrller.scala 55:11]
  assign sd2_wb_dat_o = sdctrl2_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd2_wb_adr_i = sdctrl2_wb_adr_i; // @[SdContrller.scala 55:11]
  assign sd2_wb_ack_o = sdctrl2_wb_ack_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_dat_o = sdctrl2_m_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_dat_i = sdctrl2_m_wb_dat_i; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_adr_o = sdctrl2_m_wb_adr_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_sel_o = sdctrl2_m_wb_sel_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_we_o = sdctrl2_m_wb_we_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_cyc_o = sdctrl2_m_wb_cyc_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_stb_o = sdctrl2_m_wb_stb_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_cti_o = sdctrl2_m_wb_cti_o; // @[SdContrller.scala 55:11]
  assign sd2_m_wb_bte_o = sdctrl2_m_wb_bte_o; // @[SdContrller.scala 55:11]
  assign sd2_sd_cmd_out_o = sdctrl2_sd_cmd_out_o; // @[SdContrller.scala 55:11]
  assign sd2_sd_cmd_oe_o = sdctrl2_sd_cmd_oe_o; // @[SdContrller.scala 55:11]
  assign sd2_sd_dat_out_o = sdctrl2_sd_dat_out_o; // @[SdContrller.scala 55:11]
  assign sd2_sd_dat_oe_o = sdctrl2_sd_dat_oe_o; // @[SdContrller.scala 55:11]
  assign sd2_sd_clk_o_pad = sdctrl2_sd_clk_o_pad; // @[SdContrller.scala 55:11]
  assign sd2_int_cmd = sdctrl2_int_cmd; // @[SdContrller.scala 55:11]
  assign sd2_int_data = sdctrl2_int_data; // @[SdContrller.scala 55:11]
  assign sd3_wb_dat_o = sdctrl3_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd3_wb_adr_i = sdctrl3_wb_adr_i; // @[SdContrller.scala 55:11]
  assign sd3_wb_ack_o = sdctrl3_wb_ack_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_dat_o = sdctrl3_m_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_dat_i = sdctrl3_m_wb_dat_i; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_adr_o = sdctrl3_m_wb_adr_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_sel_o = sdctrl3_m_wb_sel_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_we_o = sdctrl3_m_wb_we_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_cyc_o = sdctrl3_m_wb_cyc_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_stb_o = sdctrl3_m_wb_stb_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_cti_o = sdctrl3_m_wb_cti_o; // @[SdContrller.scala 55:11]
  assign sd3_m_wb_bte_o = sdctrl3_m_wb_bte_o; // @[SdContrller.scala 55:11]
  assign sd3_sd_cmd_out_o = sdctrl3_sd_cmd_out_o; // @[SdContrller.scala 55:11]
  assign sd3_sd_cmd_oe_o = sdctrl3_sd_cmd_oe_o; // @[SdContrller.scala 55:11]
  assign sd3_sd_dat_out_o = sdctrl3_sd_dat_out_o; // @[SdContrller.scala 55:11]
  assign sd3_sd_dat_oe_o = sdctrl3_sd_dat_oe_o; // @[SdContrller.scala 55:11]
  assign sd3_sd_clk_o_pad = sdctrl3_sd_clk_o_pad; // @[SdContrller.scala 55:11]
  assign sd3_int_cmd = sdctrl3_int_cmd; // @[SdContrller.scala 55:11]
  assign sd3_int_data = sdctrl3_int_data; // @[SdContrller.scala 55:11]
  assign sd4_wb_dat_o = sdctrl4_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd4_wb_adr_i = sdctrl4_wb_adr_i; // @[SdContrller.scala 55:11]
  assign sd4_wb_ack_o = sdctrl4_wb_ack_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_dat_o = sdctrl4_m_wb_dat_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_dat_i = sdctrl4_m_wb_dat_i; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_adr_o = sdctrl4_m_wb_adr_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_sel_o = sdctrl4_m_wb_sel_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_we_o = sdctrl4_m_wb_we_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_cyc_o = sdctrl4_m_wb_cyc_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_stb_o = sdctrl4_m_wb_stb_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_cti_o = sdctrl4_m_wb_cti_o; // @[SdContrller.scala 55:11]
  assign sd4_m_wb_bte_o = sdctrl4_m_wb_bte_o; // @[SdContrller.scala 55:11]
  assign sd4_sd_cmd_out_o = sdctrl4_sd_cmd_out_o; // @[SdContrller.scala 55:11]
  assign sd4_sd_cmd_oe_o = sdctrl4_sd_cmd_oe_o; // @[SdContrller.scala 55:11]
  assign sd4_sd_dat_out_o = sdctrl4_sd_dat_out_o; // @[SdContrller.scala 55:11]
  assign sd4_sd_dat_oe_o = sdctrl4_sd_dat_oe_o; // @[SdContrller.scala 55:11]
  assign sd4_sd_clk_o_pad = sdctrl4_sd_clk_o_pad; // @[SdContrller.scala 55:11]
  assign sd4_int_cmd = sdctrl4_int_cmd; // @[SdContrller.scala 55:11]
  assign sd4_int_data = sdctrl4_int_data; // @[SdContrller.scala 55:11]

endmodule
