// This is the unpowered netlist.
module user_project_wrapper (user_clock2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    analog_io,
    io_in,
    io_oeb,
    io_out,
    la_data_in,
    la_data_out,
    la_oenb,
    user_irq,
    wbs_adr_i,
    wbs_dat_i,
    wbs_dat_o,
    wbs_sel_i);
 input user_clock2;
 input wb_clk_i;
 input wb_rst_i;
 output wbs_ack_o;
 input wbs_cyc_i;
 input wbs_stb_i;
 input wbs_we_i;
 inout [28:0] analog_io;
 input [37:0] io_in;
 output [37:0] io_oeb;
 output [37:0] io_out;
 input [127:0] la_data_in;
 output [127:0] la_data_out;
 input [127:0] la_oenb;
 output [2:0] user_irq;
 input [31:0] wbs_adr_i;
 input [31:0] wbs_dat_i;
 output [31:0] wbs_dat_o;
 input [3:0] wbs_sel_i;

 wire _0_;
 wire _1_;
 wire _2_;
 wire \eoi[0] ;
 wire \eoi[10] ;
 wire \eoi[11] ;
 wire \eoi[12] ;
 wire \eoi[13] ;
 wire \eoi[14] ;
 wire \eoi[15] ;
 wire \eoi[16] ;
 wire \eoi[17] ;
 wire \eoi[18] ;
 wire \eoi[19] ;
 wire \eoi[1] ;
 wire \eoi[20] ;
 wire \eoi[21] ;
 wire \eoi[22] ;
 wire \eoi[23] ;
 wire \eoi[24] ;
 wire \eoi[25] ;
 wire \eoi[26] ;
 wire \eoi[27] ;
 wire \eoi[28] ;
 wire \eoi[29] ;
 wire \eoi[2] ;
 wire \eoi[30] ;
 wire \eoi[31] ;
 wire \eoi[3] ;
 wire \eoi[4] ;
 wire \eoi[5] ;
 wire \eoi[6] ;
 wire \eoi[7] ;
 wire \eoi[8] ;
 wire \eoi[9] ;
 wire \mem_addr[0] ;
 wire \mem_addr[10] ;
 wire \mem_addr[11] ;
 wire \mem_addr[12] ;
 wire \mem_addr[13] ;
 wire \mem_addr[14] ;
 wire \mem_addr[15] ;
 wire \mem_addr[16] ;
 wire \mem_addr[17] ;
 wire \mem_addr[18] ;
 wire \mem_addr[19] ;
 wire \mem_addr[1] ;
 wire \mem_addr[20] ;
 wire \mem_addr[21] ;
 wire \mem_addr[22] ;
 wire \mem_addr[23] ;
 wire \mem_addr[24] ;
 wire \mem_addr[25] ;
 wire \mem_addr[26] ;
 wire \mem_addr[27] ;
 wire \mem_addr[28] ;
 wire \mem_addr[29] ;
 wire \mem_addr[2] ;
 wire \mem_addr[30] ;
 wire \mem_addr[31] ;
 wire \mem_addr[3] ;
 wire \mem_addr[4] ;
 wire \mem_addr[5] ;
 wire \mem_addr[6] ;
 wire \mem_addr[7] ;
 wire \mem_addr[8] ;
 wire \mem_addr[9] ;
 wire mem_instr;
 wire \mem_la_addr[0] ;
 wire \mem_la_addr[10] ;
 wire \mem_la_addr[11] ;
 wire \mem_la_addr[12] ;
 wire \mem_la_addr[13] ;
 wire \mem_la_addr[14] ;
 wire \mem_la_addr[15] ;
 wire \mem_la_addr[16] ;
 wire \mem_la_addr[17] ;
 wire \mem_la_addr[18] ;
 wire \mem_la_addr[19] ;
 wire \mem_la_addr[1] ;
 wire \mem_la_addr[20] ;
 wire \mem_la_addr[21] ;
 wire \mem_la_addr[22] ;
 wire \mem_la_addr[23] ;
 wire \mem_la_addr[24] ;
 wire \mem_la_addr[25] ;
 wire \mem_la_addr[26] ;
 wire \mem_la_addr[27] ;
 wire \mem_la_addr[28] ;
 wire \mem_la_addr[29] ;
 wire \mem_la_addr[2] ;
 wire \mem_la_addr[30] ;
 wire \mem_la_addr[31] ;
 wire \mem_la_addr[3] ;
 wire \mem_la_addr[4] ;
 wire \mem_la_addr[5] ;
 wire \mem_la_addr[6] ;
 wire \mem_la_addr[7] ;
 wire \mem_la_addr[8] ;
 wire \mem_la_addr[9] ;
 wire mem_la_read;
 wire \mem_la_wdata[0] ;
 wire \mem_la_wdata[10] ;
 wire \mem_la_wdata[11] ;
 wire \mem_la_wdata[12] ;
 wire \mem_la_wdata[13] ;
 wire \mem_la_wdata[14] ;
 wire \mem_la_wdata[15] ;
 wire \mem_la_wdata[16] ;
 wire \mem_la_wdata[17] ;
 wire \mem_la_wdata[18] ;
 wire \mem_la_wdata[19] ;
 wire \mem_la_wdata[1] ;
 wire \mem_la_wdata[20] ;
 wire \mem_la_wdata[21] ;
 wire \mem_la_wdata[22] ;
 wire \mem_la_wdata[23] ;
 wire \mem_la_wdata[24] ;
 wire \mem_la_wdata[25] ;
 wire \mem_la_wdata[26] ;
 wire \mem_la_wdata[27] ;
 wire \mem_la_wdata[28] ;
 wire \mem_la_wdata[29] ;
 wire \mem_la_wdata[2] ;
 wire \mem_la_wdata[30] ;
 wire \mem_la_wdata[31] ;
 wire \mem_la_wdata[3] ;
 wire \mem_la_wdata[4] ;
 wire \mem_la_wdata[5] ;
 wire \mem_la_wdata[6] ;
 wire \mem_la_wdata[7] ;
 wire \mem_la_wdata[8] ;
 wire \mem_la_wdata[9] ;
 wire mem_la_write;
 wire \mem_la_wstrb[0] ;
 wire \mem_la_wstrb[1] ;
 wire \mem_la_wstrb[2] ;
 wire \mem_la_wstrb[3] ;
 wire \mem_rdata[0] ;
 wire \mem_rdata[10] ;
 wire \mem_rdata[11] ;
 wire \mem_rdata[12] ;
 wire \mem_rdata[13] ;
 wire \mem_rdata[14] ;
 wire \mem_rdata[15] ;
 wire \mem_rdata[16] ;
 wire \mem_rdata[17] ;
 wire \mem_rdata[18] ;
 wire \mem_rdata[19] ;
 wire \mem_rdata[1] ;
 wire \mem_rdata[20] ;
 wire \mem_rdata[21] ;
 wire \mem_rdata[22] ;
 wire \mem_rdata[23] ;
 wire \mem_rdata[24] ;
 wire \mem_rdata[25] ;
 wire \mem_rdata[26] ;
 wire \mem_rdata[27] ;
 wire \mem_rdata[28] ;
 wire \mem_rdata[29] ;
 wire \mem_rdata[2] ;
 wire \mem_rdata[30] ;
 wire \mem_rdata[31] ;
 wire \mem_rdata[3] ;
 wire \mem_rdata[4] ;
 wire \mem_rdata[5] ;
 wire \mem_rdata[6] ;
 wire \mem_rdata[7] ;
 wire \mem_rdata[8] ;
 wire \mem_rdata[9] ;
 wire mem_ready;
 wire mem_valid;
 wire \mem_wdata[0] ;
 wire \mem_wdata[10] ;
 wire \mem_wdata[11] ;
 wire \mem_wdata[12] ;
 wire \mem_wdata[13] ;
 wire \mem_wdata[14] ;
 wire \mem_wdata[15] ;
 wire \mem_wdata[16] ;
 wire \mem_wdata[17] ;
 wire \mem_wdata[18] ;
 wire \mem_wdata[19] ;
 wire \mem_wdata[1] ;
 wire \mem_wdata[20] ;
 wire \mem_wdata[21] ;
 wire \mem_wdata[22] ;
 wire \mem_wdata[23] ;
 wire \mem_wdata[24] ;
 wire \mem_wdata[25] ;
 wire \mem_wdata[26] ;
 wire \mem_wdata[27] ;
 wire \mem_wdata[28] ;
 wire \mem_wdata[29] ;
 wire \mem_wdata[2] ;
 wire \mem_wdata[30] ;
 wire \mem_wdata[31] ;
 wire \mem_wdata[3] ;
 wire \mem_wdata[4] ;
 wire \mem_wdata[5] ;
 wire \mem_wdata[6] ;
 wire \mem_wdata[7] ;
 wire \mem_wdata[8] ;
 wire \mem_wdata[9] ;
 wire mem_wstrb;
 wire \pcpi_insn[0] ;
 wire \pcpi_insn[10] ;
 wire \pcpi_insn[11] ;
 wire \pcpi_insn[12] ;
 wire \pcpi_insn[13] ;
 wire \pcpi_insn[14] ;
 wire \pcpi_insn[15] ;
 wire \pcpi_insn[16] ;
 wire \pcpi_insn[17] ;
 wire \pcpi_insn[18] ;
 wire \pcpi_insn[19] ;
 wire \pcpi_insn[1] ;
 wire \pcpi_insn[20] ;
 wire \pcpi_insn[21] ;
 wire \pcpi_insn[22] ;
 wire \pcpi_insn[23] ;
 wire \pcpi_insn[24] ;
 wire \pcpi_insn[25] ;
 wire \pcpi_insn[26] ;
 wire \pcpi_insn[27] ;
 wire \pcpi_insn[28] ;
 wire \pcpi_insn[29] ;
 wire \pcpi_insn[2] ;
 wire \pcpi_insn[30] ;
 wire \pcpi_insn[31] ;
 wire \pcpi_insn[3] ;
 wire \pcpi_insn[4] ;
 wire \pcpi_insn[5] ;
 wire \pcpi_insn[6] ;
 wire \pcpi_insn[7] ;
 wire \pcpi_insn[8] ;
 wire \pcpi_insn[9] ;
 wire \pcpi_rd[0] ;
 wire \pcpi_rd[10] ;
 wire \pcpi_rd[11] ;
 wire \pcpi_rd[12] ;
 wire \pcpi_rd[13] ;
 wire \pcpi_rd[14] ;
 wire \pcpi_rd[15] ;
 wire \pcpi_rd[16] ;
 wire \pcpi_rd[17] ;
 wire \pcpi_rd[18] ;
 wire \pcpi_rd[19] ;
 wire \pcpi_rd[1] ;
 wire \pcpi_rd[20] ;
 wire \pcpi_rd[21] ;
 wire \pcpi_rd[22] ;
 wire \pcpi_rd[23] ;
 wire \pcpi_rd[24] ;
 wire \pcpi_rd[25] ;
 wire \pcpi_rd[26] ;
 wire \pcpi_rd[27] ;
 wire \pcpi_rd[28] ;
 wire \pcpi_rd[29] ;
 wire \pcpi_rd[2] ;
 wire \pcpi_rd[30] ;
 wire \pcpi_rd[31] ;
 wire \pcpi_rd[3] ;
 wire \pcpi_rd[4] ;
 wire \pcpi_rd[5] ;
 wire \pcpi_rd[6] ;
 wire \pcpi_rd[7] ;
 wire \pcpi_rd[8] ;
 wire \pcpi_rd[9] ;
 wire pcpi_ready;
 wire \pcpi_rs1[0] ;
 wire \pcpi_rs1[10] ;
 wire \pcpi_rs1[11] ;
 wire \pcpi_rs1[12] ;
 wire \pcpi_rs1[13] ;
 wire \pcpi_rs1[14] ;
 wire \pcpi_rs1[15] ;
 wire \pcpi_rs1[16] ;
 wire \pcpi_rs1[17] ;
 wire \pcpi_rs1[18] ;
 wire \pcpi_rs1[19] ;
 wire \pcpi_rs1[1] ;
 wire \pcpi_rs1[20] ;
 wire \pcpi_rs1[21] ;
 wire \pcpi_rs1[22] ;
 wire \pcpi_rs1[23] ;
 wire \pcpi_rs1[24] ;
 wire \pcpi_rs1[25] ;
 wire \pcpi_rs1[26] ;
 wire \pcpi_rs1[27] ;
 wire \pcpi_rs1[28] ;
 wire \pcpi_rs1[29] ;
 wire \pcpi_rs1[2] ;
 wire \pcpi_rs1[30] ;
 wire \pcpi_rs1[31] ;
 wire \pcpi_rs1[3] ;
 wire \pcpi_rs1[4] ;
 wire \pcpi_rs1[5] ;
 wire \pcpi_rs1[6] ;
 wire \pcpi_rs1[7] ;
 wire \pcpi_rs1[8] ;
 wire \pcpi_rs1[9] ;
 wire \pcpi_rs2[0] ;
 wire \pcpi_rs2[10] ;
 wire \pcpi_rs2[11] ;
 wire \pcpi_rs2[12] ;
 wire \pcpi_rs2[13] ;
 wire \pcpi_rs2[14] ;
 wire \pcpi_rs2[15] ;
 wire \pcpi_rs2[16] ;
 wire \pcpi_rs2[17] ;
 wire \pcpi_rs2[18] ;
 wire \pcpi_rs2[19] ;
 wire \pcpi_rs2[1] ;
 wire \pcpi_rs2[20] ;
 wire \pcpi_rs2[21] ;
 wire \pcpi_rs2[22] ;
 wire \pcpi_rs2[23] ;
 wire \pcpi_rs2[24] ;
 wire \pcpi_rs2[25] ;
 wire \pcpi_rs2[26] ;
 wire \pcpi_rs2[27] ;
 wire \pcpi_rs2[28] ;
 wire \pcpi_rs2[29] ;
 wire \pcpi_rs2[2] ;
 wire \pcpi_rs2[30] ;
 wire \pcpi_rs2[31] ;
 wire \pcpi_rs2[3] ;
 wire \pcpi_rs2[4] ;
 wire \pcpi_rs2[5] ;
 wire \pcpi_rs2[6] ;
 wire \pcpi_rs2[7] ;
 wire \pcpi_rs2[8] ;
 wire \pcpi_rs2[9] ;
 wire pcpi_valid;
 wire pcpi_wait;
 wire pcpi_wr;
 wire \trace_data[0] ;
 wire \trace_data[10] ;
 wire \trace_data[11] ;
 wire \trace_data[12] ;
 wire \trace_data[13] ;
 wire \trace_data[14] ;
 wire \trace_data[15] ;
 wire \trace_data[16] ;
 wire \trace_data[17] ;
 wire \trace_data[18] ;
 wire \trace_data[19] ;
 wire \trace_data[1] ;
 wire \trace_data[20] ;
 wire \trace_data[21] ;
 wire \trace_data[22] ;
 wire \trace_data[23] ;
 wire \trace_data[24] ;
 wire \trace_data[25] ;
 wire \trace_data[26] ;
 wire \trace_data[27] ;
 wire \trace_data[28] ;
 wire \trace_data[29] ;
 wire \trace_data[2] ;
 wire \trace_data[30] ;
 wire \trace_data[31] ;
 wire \trace_data[32] ;
 wire \trace_data[33] ;
 wire \trace_data[34] ;
 wire \trace_data[35] ;
 wire \trace_data[3] ;
 wire \trace_data[4] ;
 wire \trace_data[5] ;
 wire \trace_data[6] ;
 wire \trace_data[7] ;
 wire \trace_data[8] ;
 wire \trace_data[9] ;
 wire trace_valid;
 wire trap;

 picorv32 u_picorv32 (.clk(wb_clk_i),
    .mem_instr(mem_instr),
    .mem_la_read(mem_la_read),
    .mem_la_write(mem_la_write),
    .mem_ready(mem_ready),
    .mem_valid(mem_valid),
    .pcpi_ready(pcpi_ready),
    .pcpi_valid(pcpi_valid),
    .pcpi_wait(pcpi_wait),
    .pcpi_wr(pcpi_wr),
    .resetn(wb_rst_i),
    .trace_valid(trace_valid),
    .trap(trap),
    .eoi({\eoi[31] ,
    \eoi[30] ,
    \eoi[29] ,
    \eoi[28] ,
    \eoi[27] ,
    \eoi[26] ,
    \eoi[25] ,
    \eoi[24] ,
    \eoi[23] ,
    \eoi[22] ,
    \eoi[21] ,
    \eoi[20] ,
    \eoi[19] ,
    \eoi[18] ,
    \eoi[17] ,
    \eoi[16] ,
    \eoi[15] ,
    \eoi[14] ,
    \eoi[13] ,
    \eoi[12] ,
    \eoi[11] ,
    \eoi[10] ,
    \eoi[9] ,
    \eoi[8] ,
    \eoi[7] ,
    \eoi[6] ,
    \eoi[5] ,
    \eoi[4] ,
    \eoi[3] ,
    \eoi[2] ,
    \eoi[1] ,
    \eoi[0] }),
    .irq({_NC1,
    _NC2,
    _NC3,
    _NC4,
    _NC5,
    _NC6,
    _NC7,
    _NC8,
    _NC9,
    _NC10,
    _NC11,
    _NC12,
    _NC13,
    _NC14,
    _NC15,
    _NC16,
    _NC17,
    _NC18,
    _NC19,
    _NC20,
    _NC21,
    _NC22,
    _NC23,
    _NC24,
    _NC25,
    _NC26,
    _NC27,
    _NC28,
    _NC29,
    _NC30,
    _NC31,
    _NC32}),
    .mem_addr({\mem_addr[31] ,
    \mem_addr[30] ,
    \mem_addr[29] ,
    \mem_addr[28] ,
    \mem_addr[27] ,
    \mem_addr[26] ,
    \mem_addr[25] ,
    \mem_addr[24] ,
    \mem_addr[23] ,
    \mem_addr[22] ,
    \mem_addr[21] ,
    \mem_addr[20] ,
    \mem_addr[19] ,
    \mem_addr[18] ,
    \mem_addr[17] ,
    \mem_addr[16] ,
    \mem_addr[15] ,
    \mem_addr[14] ,
    \mem_addr[13] ,
    \mem_addr[12] ,
    \mem_addr[11] ,
    \mem_addr[10] ,
    \mem_addr[9] ,
    \mem_addr[8] ,
    \mem_addr[7] ,
    \mem_addr[6] ,
    \mem_addr[5] ,
    \mem_addr[4] ,
    \mem_addr[3] ,
    \mem_addr[2] ,
    \mem_addr[1] ,
    \mem_addr[0] }),
    .mem_la_addr({\mem_la_addr[31] ,
    \mem_la_addr[30] ,
    \mem_la_addr[29] ,
    \mem_la_addr[28] ,
    \mem_la_addr[27] ,
    \mem_la_addr[26] ,
    \mem_la_addr[25] ,
    \mem_la_addr[24] ,
    \mem_la_addr[23] ,
    \mem_la_addr[22] ,
    \mem_la_addr[21] ,
    \mem_la_addr[20] ,
    \mem_la_addr[19] ,
    \mem_la_addr[18] ,
    \mem_la_addr[17] ,
    \mem_la_addr[16] ,
    \mem_la_addr[15] ,
    \mem_la_addr[14] ,
    \mem_la_addr[13] ,
    \mem_la_addr[12] ,
    \mem_la_addr[11] ,
    \mem_la_addr[10] ,
    \mem_la_addr[9] ,
    \mem_la_addr[8] ,
    \mem_la_addr[7] ,
    \mem_la_addr[6] ,
    \mem_la_addr[5] ,
    \mem_la_addr[4] ,
    \mem_la_addr[3] ,
    \mem_la_addr[2] ,
    \mem_la_addr[1] ,
    \mem_la_addr[0] }),
    .mem_la_wdata({\mem_la_wdata[31] ,
    \mem_la_wdata[30] ,
    \mem_la_wdata[29] ,
    \mem_la_wdata[28] ,
    \mem_la_wdata[27] ,
    \mem_la_wdata[26] ,
    \mem_la_wdata[25] ,
    \mem_la_wdata[24] ,
    \mem_la_wdata[23] ,
    \mem_la_wdata[22] ,
    \mem_la_wdata[21] ,
    \mem_la_wdata[20] ,
    \mem_la_wdata[19] ,
    \mem_la_wdata[18] ,
    \mem_la_wdata[17] ,
    \mem_la_wdata[16] ,
    \mem_la_wdata[15] ,
    \mem_la_wdata[14] ,
    \mem_la_wdata[13] ,
    \mem_la_wdata[12] ,
    \mem_la_wdata[11] ,
    \mem_la_wdata[10] ,
    \mem_la_wdata[9] ,
    \mem_la_wdata[8] ,
    \mem_la_wdata[7] ,
    \mem_la_wdata[6] ,
    \mem_la_wdata[5] ,
    \mem_la_wdata[4] ,
    \mem_la_wdata[3] ,
    \mem_la_wdata[2] ,
    \mem_la_wdata[1] ,
    \mem_la_wdata[0] }),
    .mem_la_wstrb({\mem_la_wstrb[3] ,
    \mem_la_wstrb[2] ,
    \mem_la_wstrb[1] ,
    \mem_la_wstrb[0] }),
    .mem_rdata({\mem_rdata[31] ,
    \mem_rdata[30] ,
    \mem_rdata[29] ,
    \mem_rdata[28] ,
    \mem_rdata[27] ,
    \mem_rdata[26] ,
    \mem_rdata[25] ,
    \mem_rdata[24] ,
    \mem_rdata[23] ,
    \mem_rdata[22] ,
    \mem_rdata[21] ,
    \mem_rdata[20] ,
    \mem_rdata[19] ,
    \mem_rdata[18] ,
    \mem_rdata[17] ,
    \mem_rdata[16] ,
    \mem_rdata[15] ,
    \mem_rdata[14] ,
    \mem_rdata[13] ,
    \mem_rdata[12] ,
    \mem_rdata[11] ,
    \mem_rdata[10] ,
    \mem_rdata[9] ,
    \mem_rdata[8] ,
    \mem_rdata[7] ,
    \mem_rdata[6] ,
    \mem_rdata[5] ,
    \mem_rdata[4] ,
    \mem_rdata[3] ,
    \mem_rdata[2] ,
    \mem_rdata[1] ,
    \mem_rdata[0] }),
    .mem_wdata({\mem_wdata[31] ,
    \mem_wdata[30] ,
    \mem_wdata[29] ,
    \mem_wdata[28] ,
    \mem_wdata[27] ,
    \mem_wdata[26] ,
    \mem_wdata[25] ,
    \mem_wdata[24] ,
    \mem_wdata[23] ,
    \mem_wdata[22] ,
    \mem_wdata[21] ,
    \mem_wdata[20] ,
    \mem_wdata[19] ,
    \mem_wdata[18] ,
    \mem_wdata[17] ,
    \mem_wdata[16] ,
    \mem_wdata[15] ,
    \mem_wdata[14] ,
    \mem_wdata[13] ,
    \mem_wdata[12] ,
    \mem_wdata[11] ,
    \mem_wdata[10] ,
    \mem_wdata[9] ,
    \mem_wdata[8] ,
    \mem_wdata[7] ,
    \mem_wdata[6] ,
    \mem_wdata[5] ,
    \mem_wdata[4] ,
    \mem_wdata[3] ,
    \mem_wdata[2] ,
    \mem_wdata[1] ,
    \mem_wdata[0] }),
    .mem_wstrb({_2_,
    _1_,
    _0_,
    mem_wstrb}),
    .pcpi_insn({\pcpi_insn[31] ,
    \pcpi_insn[30] ,
    \pcpi_insn[29] ,
    \pcpi_insn[28] ,
    \pcpi_insn[27] ,
    \pcpi_insn[26] ,
    \pcpi_insn[25] ,
    \pcpi_insn[24] ,
    \pcpi_insn[23] ,
    \pcpi_insn[22] ,
    \pcpi_insn[21] ,
    \pcpi_insn[20] ,
    \pcpi_insn[19] ,
    \pcpi_insn[18] ,
    \pcpi_insn[17] ,
    \pcpi_insn[16] ,
    \pcpi_insn[15] ,
    \pcpi_insn[14] ,
    \pcpi_insn[13] ,
    \pcpi_insn[12] ,
    \pcpi_insn[11] ,
    \pcpi_insn[10] ,
    \pcpi_insn[9] ,
    \pcpi_insn[8] ,
    \pcpi_insn[7] ,
    \pcpi_insn[6] ,
    \pcpi_insn[5] ,
    \pcpi_insn[4] ,
    \pcpi_insn[3] ,
    \pcpi_insn[2] ,
    \pcpi_insn[1] ,
    \pcpi_insn[0] }),
    .pcpi_rd({\pcpi_rd[31] ,
    \pcpi_rd[30] ,
    \pcpi_rd[29] ,
    \pcpi_rd[28] ,
    \pcpi_rd[27] ,
    \pcpi_rd[26] ,
    \pcpi_rd[25] ,
    \pcpi_rd[24] ,
    \pcpi_rd[23] ,
    \pcpi_rd[22] ,
    \pcpi_rd[21] ,
    \pcpi_rd[20] ,
    \pcpi_rd[19] ,
    \pcpi_rd[18] ,
    \pcpi_rd[17] ,
    \pcpi_rd[16] ,
    \pcpi_rd[15] ,
    \pcpi_rd[14] ,
    \pcpi_rd[13] ,
    \pcpi_rd[12] ,
    \pcpi_rd[11] ,
    \pcpi_rd[10] ,
    \pcpi_rd[9] ,
    \pcpi_rd[8] ,
    \pcpi_rd[7] ,
    \pcpi_rd[6] ,
    \pcpi_rd[5] ,
    \pcpi_rd[4] ,
    \pcpi_rd[3] ,
    \pcpi_rd[2] ,
    \pcpi_rd[1] ,
    \pcpi_rd[0] }),
    .pcpi_rs1({\pcpi_rs1[31] ,
    \pcpi_rs1[30] ,
    \pcpi_rs1[29] ,
    \pcpi_rs1[28] ,
    \pcpi_rs1[27] ,
    \pcpi_rs1[26] ,
    \pcpi_rs1[25] ,
    \pcpi_rs1[24] ,
    \pcpi_rs1[23] ,
    \pcpi_rs1[22] ,
    \pcpi_rs1[21] ,
    \pcpi_rs1[20] ,
    \pcpi_rs1[19] ,
    \pcpi_rs1[18] ,
    \pcpi_rs1[17] ,
    \pcpi_rs1[16] ,
    \pcpi_rs1[15] ,
    \pcpi_rs1[14] ,
    \pcpi_rs1[13] ,
    \pcpi_rs1[12] ,
    \pcpi_rs1[11] ,
    \pcpi_rs1[10] ,
    \pcpi_rs1[9] ,
    \pcpi_rs1[8] ,
    \pcpi_rs1[7] ,
    \pcpi_rs1[6] ,
    \pcpi_rs1[5] ,
    \pcpi_rs1[4] ,
    \pcpi_rs1[3] ,
    \pcpi_rs1[2] ,
    \pcpi_rs1[1] ,
    \pcpi_rs1[0] }),
    .pcpi_rs2({\pcpi_rs2[31] ,
    \pcpi_rs2[30] ,
    \pcpi_rs2[29] ,
    \pcpi_rs2[28] ,
    \pcpi_rs2[27] ,
    \pcpi_rs2[26] ,
    \pcpi_rs2[25] ,
    \pcpi_rs2[24] ,
    \pcpi_rs2[23] ,
    \pcpi_rs2[22] ,
    \pcpi_rs2[21] ,
    \pcpi_rs2[20] ,
    \pcpi_rs2[19] ,
    \pcpi_rs2[18] ,
    \pcpi_rs2[17] ,
    \pcpi_rs2[16] ,
    \pcpi_rs2[15] ,
    \pcpi_rs2[14] ,
    \pcpi_rs2[13] ,
    \pcpi_rs2[12] ,
    \pcpi_rs2[11] ,
    \pcpi_rs2[10] ,
    \pcpi_rs2[9] ,
    \pcpi_rs2[8] ,
    \pcpi_rs2[7] ,
    \pcpi_rs2[6] ,
    \pcpi_rs2[5] ,
    \pcpi_rs2[4] ,
    \pcpi_rs2[3] ,
    \pcpi_rs2[2] ,
    \pcpi_rs2[1] ,
    \pcpi_rs2[0] }),
    .trace_data({\trace_data[35] ,
    \trace_data[34] ,
    \trace_data[33] ,
    \trace_data[32] ,
    \trace_data[31] ,
    \trace_data[30] ,
    \trace_data[29] ,
    \trace_data[28] ,
    \trace_data[27] ,
    \trace_data[26] ,
    \trace_data[25] ,
    \trace_data[24] ,
    \trace_data[23] ,
    \trace_data[22] ,
    \trace_data[21] ,
    \trace_data[20] ,
    \trace_data[19] ,
    \trace_data[18] ,
    \trace_data[17] ,
    \trace_data[16] ,
    \trace_data[15] ,
    \trace_data[14] ,
    \trace_data[13] ,
    \trace_data[12] ,
    \trace_data[11] ,
    \trace_data[10] ,
    \trace_data[9] ,
    \trace_data[8] ,
    \trace_data[7] ,
    \trace_data[6] ,
    \trace_data[5] ,
    \trace_data[4] ,
    \trace_data[3] ,
    \trace_data[2] ,
    \trace_data[1] ,
    \trace_data[0] }));
endmodule

