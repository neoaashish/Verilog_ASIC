`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2021 01:16:08 PM
// Design Name: 
// Module Name: IPwrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//sigmoid LUT has a 22 bit IP but OP of the LUT is 8 bit, with 7 fractional bits// thus we only use 7 out of 12 fractional bits and 

module IPwrapper(
    input [21:0]acc_out,
    output [7:0]wrapper_out
    );
    
    wire sign;
    wire [8:0]addr;
    reg ovf;
    
    assign sign=acc_out[21]; // first bit sign bit
    assign addr=acc_out[13:5]; // 7 fraction bits & 2 integer bits
    
    // a21 a20 a19 a18 a17 a16 a15 a14 a13 a12 .  a11  a10  a9   a8   a7   a6   a5   a4   a3   a2   a1   a0 
    // s9  s8  s7  s6  s5  s4  s3  s2  s1  s0  .  s'1  s'2  s'3  s'4  s'5  s'6  s'7  s'8  s'9  s'10 s'11 s'12
    always@(*)begin
        if(acc_out[21]==0)
            ovf = |(acc_out[20:14]);
        else
            ovf = (~(&acc_out[20:14])) || (~(|acc_out[13:5])); 
    end    
    sigmoid_0 inst(addr,sign,ovf,wrapper_out);
    
endmodule