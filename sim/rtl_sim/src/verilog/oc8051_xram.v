//////////////////////////////////////////////////////////////////////
////                                                              ////
////  8051 external data ram                                      ////
////                                                              ////
////  This file is part of the 8051 cores project                 ////
////  http://www.opencores.org/cores/8051/                        ////
////                                                              ////
////  Description                                                 ////
////   external data ram                                          ////
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


module oc8051_xram (clk, wr, addr, data_in, data_out, ack, stb);
//
// external data ram for simulation. part of oc8051_tb
// it's tehnology dependent
//
// clk          (in)  clock
// addr         (in)  addres
// data_in      (out) data input
// data_out     (in)  data output
// wr           (in)  write
//


input clk, wr, stb;
input [7:0] data_in;
input [15:0] addr;
output [7:0] data_out;
output ack;

reg ackw, ackr;
reg [7:0] data_out;
reg [16:0] count;

//
// buffer
reg [7:0] buff [65535:0];


assign ack =  ackw || ackr;


//
// writing to ram
always @(posedge clk)
begin

  if (wr && stb && !ackw) begin
    buff[addr] <= #1 data_in;
    ackw <= #1 1'b1;
  end else ackw <= #1 1'b0;

end

always @(posedge clk)
  if (stb && !wr && !ackr) begin
    data_out <= #1 buff[addr];
    ackr <= #1 1'b1;
  end else begin
    ackr <= #1 1'b0;
    data_out <= #1 8'h00;
  end


endmodule
