//////////////////////////////////////////////////////////////////////
////                                                              ////
////  8051 uart test                                              ////
////                                                              ////
////  This file is part of the 8051 cores project                 ////
////  http://www.opencores.org/cores/8051/                        ////
////                                                              ////
////  Description                                                 ////
////   submodul of oc8051_tb, used to comunicate with 8051        ////
////   serial potr                                                ////
////                                                              ////
////  To Do:                                                      ////
////   nothing                                                    ////
////                                                              ////
////  Author(s):                                                  ////
////      - Simon Teran, simont@opencores.org                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: not supported by cvs2svn $
//

// synopsys translate_off
`include "oc8051_timescale.v"
// synopsys translate_on


module oc8051_uart_test (clk, rst, addr, wr, wr_bit, data_in, data_out, bit_out, rxd, txd, ow, intr, ack, stb);
//
// serial interface simulation. part of oc8051_tb
//
// clk          (in)  clock
// rst		(in)  reset
// addr         (in)  addres [oc8051.ext_addr]
// wr           (in)  write [oc8051.write]
// wr_bit	(in) write bit addresable [oc8051.p3_out.0]
// data_in      (out) data input [oc8051.data_out]
// data_out     (in)  data output [oc8051.data_in]
// rxd		(in)  receive data [oc8051.txd]
// txd		(out) transmit data [oc8051.rxd]
// ow		(in)  owerflov (used in mode 1 and 3) [oc8051.p3_out.1]
// intr		(out) interrupt request [oc8051.p3_in.0]
//

input clk, rst, wr, wr_bit, rxd, ow, stb;
input [7:0] addr, data_in;

output txd, intr, bit_out, ack;
output [7:0] data_out;

wire syn;
reg wr_r, ack;
reg [7:0] addr_r, data_in_r;


oc8051_uart oc8051_uart_test(.rst(rst), .clk(clk), .bit_in(data_in[0]), .rd_addr(addr), .data_in(data_in_r),
                    .wr(wr_r), .wr_bit(wr_bit), .wr_addr(addr_r), .data_out(data_out), .bit_out(bit_out),
                    .rxd(rxd), .txd(txd), .intr(intr), .t1_ow(ow));


always @(posedge clk)
begin
  if (ack) ack <= #1 1'b0;
  else 
    ack <= #1 stb;
end

always @(posedge clk)
begin
  wr_r <= #1 wr;
  addr_r <= #1 addr;
  data_in_r <= #1 data_in;
end


endmodule
