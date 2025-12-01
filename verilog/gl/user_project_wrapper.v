module user_project_wrapper (user_clock2,
    wb_clk_i,
    wb_rst_i,
    wbs_ack_o,
    wbs_cyc_i,
    wbs_stb_i,
    wbs_we_i,
    vssa2,
    vdda2,
    vssa1,
    vdda1,
    vssd2,
    vccd2,
    vssd1,
    vccd1,
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
 inout vssa2;
 inout vdda2;
 inout vssa1;
 inout vdda1;
 inout vssd2;
 inout vccd2;
 inout vssd1;
 inout vccd1;
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

 wire \dffram_addr[0] ;
 wire \dffram_addr[1] ;
 wire \dffram_addr[2] ;
 wire \dffram_addr[3] ;
 wire \dffram_addr[4] ;
 wire \dffram_addr[5] ;
 wire \dffram_addr[6] ;
 wire \dffram_addr[7] ;
 wire \dffram_addr[8] ;
 wire dffram_en;
 wire \dffram_rdata[0] ;
 wire \dffram_rdata[10] ;
 wire \dffram_rdata[11] ;
 wire \dffram_rdata[12] ;
 wire \dffram_rdata[13] ;
 wire \dffram_rdata[14] ;
 wire \dffram_rdata[15] ;
 wire \dffram_rdata[16] ;
 wire \dffram_rdata[17] ;
 wire \dffram_rdata[18] ;
 wire \dffram_rdata[19] ;
 wire \dffram_rdata[1] ;
 wire \dffram_rdata[20] ;
 wire \dffram_rdata[21] ;
 wire \dffram_rdata[22] ;
 wire \dffram_rdata[23] ;
 wire \dffram_rdata[24] ;
 wire \dffram_rdata[25] ;
 wire \dffram_rdata[26] ;
 wire \dffram_rdata[27] ;
 wire \dffram_rdata[28] ;
 wire \dffram_rdata[29] ;
 wire \dffram_rdata[2] ;
 wire \dffram_rdata[30] ;
 wire \dffram_rdata[31] ;
 wire \dffram_rdata[3] ;
 wire \dffram_rdata[4] ;
 wire \dffram_rdata[5] ;
 wire \dffram_rdata[6] ;
 wire \dffram_rdata[7] ;
 wire \dffram_rdata[8] ;
 wire \dffram_rdata[9] ;
 wire \dffram_wdata[0] ;
 wire \dffram_wdata[10] ;
 wire \dffram_wdata[11] ;
 wire \dffram_wdata[12] ;
 wire \dffram_wdata[13] ;
 wire \dffram_wdata[14] ;
 wire \dffram_wdata[15] ;
 wire \dffram_wdata[16] ;
 wire \dffram_wdata[17] ;
 wire \dffram_wdata[18] ;
 wire \dffram_wdata[19] ;
 wire \dffram_wdata[1] ;
 wire \dffram_wdata[20] ;
 wire \dffram_wdata[21] ;
 wire \dffram_wdata[22] ;
 wire \dffram_wdata[23] ;
 wire \dffram_wdata[24] ;
 wire \dffram_wdata[25] ;
 wire \dffram_wdata[26] ;
 wire \dffram_wdata[27] ;
 wire \dffram_wdata[28] ;
 wire \dffram_wdata[29] ;
 wire \dffram_wdata[2] ;
 wire \dffram_wdata[30] ;
 wire \dffram_wdata[31] ;
 wire \dffram_wdata[3] ;
 wire \dffram_wdata[4] ;
 wire \dffram_wdata[5] ;
 wire \dffram_wdata[6] ;
 wire \dffram_wdata[7] ;
 wire \dffram_wdata[8] ;
 wire \dffram_wdata[9] ;
 wire \dffram_we[0] ;
 wire \dffram_we[1] ;
 wire \dffram_we[2] ;
 wire \dffram_we[3] ;
 wire \mem_addr[0] ;
 wire \mem_addr[1] ;
 wire \mem_addr[2] ;
 wire \mem_addr[3] ;
 wire \mem_addr[4] ;
 wire \mem_addr[5] ;
 wire \mem_addr[6] ;
 wire \mem_addr[7] ;
 wire \mem_addr[8] ;
 wire mem_en;
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
 wire \mem_we[0] ;
 wire \mem_we[1] ;
 wire \mem_we[2] ;
 wire \mem_we[3] ;

 DFFRAM512x32 u_dffram (.CLK(wb_clk_i),
    .EN0(dffram_en),
    .VGND(vssd1),
    .VPWR(vccd1),
    .A0({\dffram_addr[8] ,
    \dffram_addr[7] ,
    \dffram_addr[6] ,
    \dffram_addr[5] ,
    \dffram_addr[4] ,
    \dffram_addr[3] ,
    \dffram_addr[2] ,
    \dffram_addr[1] ,
    \dffram_addr[0] }),
    .Di0({\dffram_wdata[31] ,
    \dffram_wdata[30] ,
    \dffram_wdata[29] ,
    \dffram_wdata[28] ,
    \dffram_wdata[27] ,
    \dffram_wdata[26] ,
    \dffram_wdata[25] ,
    \dffram_wdata[24] ,
    \dffram_wdata[23] ,
    \dffram_wdata[22] ,
    \dffram_wdata[21] ,
    \dffram_wdata[20] ,
    \dffram_wdata[19] ,
    \dffram_wdata[18] ,
    \dffram_wdata[17] ,
    \dffram_wdata[16] ,
    \dffram_wdata[15] ,
    \dffram_wdata[14] ,
    \dffram_wdata[13] ,
    \dffram_wdata[12] ,
    \dffram_wdata[11] ,
    \dffram_wdata[10] ,
    \dffram_wdata[9] ,
    \dffram_wdata[8] ,
    \dffram_wdata[7] ,
    \dffram_wdata[6] ,
    \dffram_wdata[5] ,
    \dffram_wdata[4] ,
    \dffram_wdata[3] ,
    \dffram_wdata[2] ,
    \dffram_wdata[1] ,
    \dffram_wdata[0] }),
    .Do0({\dffram_rdata[31] ,
    \dffram_rdata[30] ,
    \dffram_rdata[29] ,
    \dffram_rdata[28] ,
    \dffram_rdata[27] ,
    \dffram_rdata[26] ,
    \dffram_rdata[25] ,
    \dffram_rdata[24] ,
    \dffram_rdata[23] ,
    \dffram_rdata[22] ,
    \dffram_rdata[21] ,
    \dffram_rdata[20] ,
    \dffram_rdata[19] ,
    \dffram_rdata[18] ,
    \dffram_rdata[17] ,
    \dffram_rdata[16] ,
    \dffram_rdata[15] ,
    \dffram_rdata[14] ,
    \dffram_rdata[13] ,
    \dffram_rdata[12] ,
    \dffram_rdata[11] ,
    \dffram_rdata[10] ,
    \dffram_rdata[9] ,
    \dffram_rdata[8] ,
    \dffram_rdata[7] ,
    \dffram_rdata[6] ,
    \dffram_rdata[5] ,
    \dffram_rdata[4] ,
    \dffram_rdata[3] ,
    \dffram_rdata[2] ,
    \dffram_rdata[1] ,
    \dffram_rdata[0] }),
    .WE0({\dffram_we[3] ,
    \dffram_we[2] ,
    \dffram_we[1] ,
    \dffram_we[0] }));
 memory_macro u_memory_arb (.clk(wb_clk_i),
    .cpu_mem_en(mem_en),
    .mem_en(dffram_en),
    .rst_n(wb_rst_i),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .wbs_ack_o(wbs_ack_o),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_stb_i(wbs_stb_i),
    .wbs_we_i(wbs_we_i),
    .cpu_mem_addr({\mem_addr[8] ,
    \mem_addr[7] ,
    \mem_addr[6] ,
    \mem_addr[5] ,
    \mem_addr[4] ,
    \mem_addr[3] ,
    \mem_addr[2] ,
    \mem_addr[1] ,
    \mem_addr[0] }),
    .cpu_mem_rdata({\mem_rdata[31] ,
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
    .cpu_mem_wdata({\mem_wdata[31] ,
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
    .cpu_mem_we({\mem_we[3] ,
    \mem_we[2] ,
    \mem_we[1] ,
    \mem_we[0] }),
    .mem_addr({\dffram_addr[8] ,
    \dffram_addr[7] ,
    \dffram_addr[6] ,
    \dffram_addr[5] ,
    \dffram_addr[4] ,
    \dffram_addr[3] ,
    \dffram_addr[2] ,
    \dffram_addr[1] ,
    \dffram_addr[0] }),
    .mem_rdata({\dffram_rdata[31] ,
    \dffram_rdata[30] ,
    \dffram_rdata[29] ,
    \dffram_rdata[28] ,
    \dffram_rdata[27] ,
    \dffram_rdata[26] ,
    \dffram_rdata[25] ,
    \dffram_rdata[24] ,
    \dffram_rdata[23] ,
    \dffram_rdata[22] ,
    \dffram_rdata[21] ,
    \dffram_rdata[20] ,
    \dffram_rdata[19] ,
    \dffram_rdata[18] ,
    \dffram_rdata[17] ,
    \dffram_rdata[16] ,
    \dffram_rdata[15] ,
    \dffram_rdata[14] ,
    \dffram_rdata[13] ,
    \dffram_rdata[12] ,
    \dffram_rdata[11] ,
    \dffram_rdata[10] ,
    \dffram_rdata[9] ,
    \dffram_rdata[8] ,
    \dffram_rdata[7] ,
    \dffram_rdata[6] ,
    \dffram_rdata[5] ,
    \dffram_rdata[4] ,
    \dffram_rdata[3] ,
    \dffram_rdata[2] ,
    \dffram_rdata[1] ,
    \dffram_rdata[0] }),
    .mem_wdata({\dffram_wdata[31] ,
    \dffram_wdata[30] ,
    \dffram_wdata[29] ,
    \dffram_wdata[28] ,
    \dffram_wdata[27] ,
    \dffram_wdata[26] ,
    \dffram_wdata[25] ,
    \dffram_wdata[24] ,
    \dffram_wdata[23] ,
    \dffram_wdata[22] ,
    \dffram_wdata[21] ,
    \dffram_wdata[20] ,
    \dffram_wdata[19] ,
    \dffram_wdata[18] ,
    \dffram_wdata[17] ,
    \dffram_wdata[16] ,
    \dffram_wdata[15] ,
    \dffram_wdata[14] ,
    \dffram_wdata[13] ,
    \dffram_wdata[12] ,
    \dffram_wdata[11] ,
    \dffram_wdata[10] ,
    \dffram_wdata[9] ,
    \dffram_wdata[8] ,
    \dffram_wdata[7] ,
    \dffram_wdata[6] ,
    \dffram_wdata[5] ,
    \dffram_wdata[4] ,
    \dffram_wdata[3] ,
    \dffram_wdata[2] ,
    \dffram_wdata[1] ,
    \dffram_wdata[0] }),
    .mem_we({\dffram_we[3] ,
    \dffram_we[2] ,
    \dffram_we[1] ,
    \dffram_we[0] }),
    .wbs_adr_i({wbs_adr_i[31],
    wbs_adr_i[30],
    wbs_adr_i[29],
    wbs_adr_i[28],
    wbs_adr_i[27],
    wbs_adr_i[26],
    wbs_adr_i[25],
    wbs_adr_i[24],
    wbs_adr_i[23],
    wbs_adr_i[22],
    wbs_adr_i[21],
    wbs_adr_i[20],
    wbs_adr_i[19],
    wbs_adr_i[18],
    wbs_adr_i[17],
    wbs_adr_i[16],
    wbs_adr_i[15],
    wbs_adr_i[14],
    wbs_adr_i[13],
    wbs_adr_i[12],
    wbs_adr_i[11],
    wbs_adr_i[10],
    wbs_adr_i[9],
    wbs_adr_i[8],
    wbs_adr_i[7],
    wbs_adr_i[6],
    wbs_adr_i[5],
    wbs_adr_i[4],
    wbs_adr_i[3],
    wbs_adr_i[2],
    wbs_adr_i[1],
    wbs_adr_i[0]}),
    .wbs_dat_i({wbs_dat_i[31],
    wbs_dat_i[30],
    wbs_dat_i[29],
    wbs_dat_i[28],
    wbs_dat_i[27],
    wbs_dat_i[26],
    wbs_dat_i[25],
    wbs_dat_i[24],
    wbs_dat_i[23],
    wbs_dat_i[22],
    wbs_dat_i[21],
    wbs_dat_i[20],
    wbs_dat_i[19],
    wbs_dat_i[18],
    wbs_dat_i[17],
    wbs_dat_i[16],
    wbs_dat_i[15],
    wbs_dat_i[14],
    wbs_dat_i[13],
    wbs_dat_i[12],
    wbs_dat_i[11],
    wbs_dat_i[10],
    wbs_dat_i[9],
    wbs_dat_i[8],
    wbs_dat_i[7],
    wbs_dat_i[6],
    wbs_dat_i[5],
    wbs_dat_i[4],
    wbs_dat_i[3],
    wbs_dat_i[2],
    wbs_dat_i[1],
    wbs_dat_i[0]}),
    .wbs_dat_o({wbs_dat_o[31],
    wbs_dat_o[30],
    wbs_dat_o[29],
    wbs_dat_o[28],
    wbs_dat_o[27],
    wbs_dat_o[26],
    wbs_dat_o[25],
    wbs_dat_o[24],
    wbs_dat_o[23],
    wbs_dat_o[22],
    wbs_dat_o[21],
    wbs_dat_o[20],
    wbs_dat_o[19],
    wbs_dat_o[18],
    wbs_dat_o[17],
    wbs_dat_o[16],
    wbs_dat_o[15],
    wbs_dat_o[14],
    wbs_dat_o[13],
    wbs_dat_o[12],
    wbs_dat_o[11],
    wbs_dat_o[10],
    wbs_dat_o[9],
    wbs_dat_o[8],
    wbs_dat_o[7],
    wbs_dat_o[6],
    wbs_dat_o[5],
    wbs_dat_o[4],
    wbs_dat_o[3],
    wbs_dat_o[2],
    wbs_dat_o[1],
    wbs_dat_o[0]}),
    .wbs_sel_i({wbs_sel_i[3],
    wbs_sel_i[2],
    wbs_sel_i[1],
    wbs_sel_i[0]}));
 picorv32_soc u_soc (.clk(wb_clk_i),
    .mem_en(mem_en),
    .rst_n(wb_rst_i),
    .vccd1(vccd1),
    .vssd1(vssd1),
    .io_in({io_in[37],
    io_in[36],
    io_in[35],
    io_in[34],
    io_in[33],
    io_in[32],
    io_in[31],
    io_in[30],
    io_in[29],
    io_in[28],
    io_in[27],
    io_in[26],
    io_in[25],
    io_in[24],
    io_in[23],
    io_in[22],
    io_in[21],
    io_in[20],
    io_in[19],
    io_in[18],
    io_in[17],
    io_in[16],
    io_in[15],
    io_in[14],
    io_in[13],
    io_in[12],
    io_in[11],
    io_in[10],
    io_in[9],
    io_in[8],
    io_in[7],
    io_in[6],
    io_in[5],
    io_in[4],
    io_in[3],
    io_in[2],
    io_in[1],
    io_in[0]}),
    .io_oeb({io_oeb[37],
    io_oeb[36],
    io_oeb[35],
    io_oeb[34],
    io_oeb[33],
    io_oeb[32],
    io_oeb[31],
    io_oeb[30],
    io_oeb[29],
    io_oeb[28],
    io_oeb[27],
    io_oeb[26],
    io_oeb[25],
    io_oeb[24],
    io_oeb[23],
    io_oeb[22],
    io_oeb[21],
    io_oeb[20],
    io_oeb[19],
    io_oeb[18],
    io_oeb[17],
    io_oeb[16],
    io_oeb[15],
    io_oeb[14],
    io_oeb[13],
    io_oeb[12],
    io_oeb[11],
    io_oeb[10],
    io_oeb[9],
    io_oeb[8],
    io_oeb[7],
    io_oeb[6],
    io_oeb[5],
    io_oeb[4],
    io_oeb[3],
    io_oeb[2],
    io_oeb[1],
    io_oeb[0]}),
    .io_out({io_out[37],
    io_out[36],
    io_out[35],
    io_out[34],
    io_out[33],
    io_out[32],
    io_out[31],
    io_out[30],
    io_out[29],
    io_out[28],
    io_out[27],
    io_out[26],
    io_out[25],
    io_out[24],
    io_out[23],
    io_out[22],
    io_out[21],
    io_out[20],
    io_out[19],
    io_out[18],
    io_out[17],
    io_out[16],
    io_out[15],
    io_out[14],
    io_out[13],
    io_out[12],
    io_out[11],
    io_out[10],
    io_out[9],
    io_out[8],
    io_out[7],
    io_out[6],
    io_out[5],
    io_out[4],
    io_out[3],
    io_out[2],
    io_out[1],
    io_out[0]}),
    .irq_out({user_irq[2],
    user_irq[1],
    user_irq[0]}),
    .mem_addr({\mem_addr[8] ,
    \mem_addr[7] ,
    \mem_addr[6] ,
    \mem_addr[5] ,
    \mem_addr[4] ,
    \mem_addr[3] ,
    \mem_addr[2] ,
    \mem_addr[1] ,
    \mem_addr[0] }),
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
    .mem_we({\mem_we[3] ,
    \mem_we[2] ,
    \mem_we[1] ,
    \mem_we[0] }));
endmodule
