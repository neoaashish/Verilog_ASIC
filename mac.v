`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 06:07:51 AM
// Design Name: 
// Module Name: mac
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


module mac(
    input clk,
    input [127:0] pixels_in,
    input [127:0] weights_in,
    output [19:0] sum_reg
    );
    
    reg [127:0] pixels, weights;
    reg [19:0] sum_reg;
    wire [19:0] sum;
    reg [255:0] p_reg;
    wire [255:0] p;
    wire [135:0] s1;
    wire [71:0] s2;
    //reg [71:0] s2_reg;
    wire [37:0] s3;
    
    //input and output registers
    always @(posedge clk) begin
        pixels <= pixels_in;
        weights <= weights_in;
        p_reg <= p;
        sum_reg <= sum;
        //s2_reg <= s2;
    end 
    
    //instantiate multipliers
    genvar i;
    generate
    for (i=0;i<=15;i=i+1)
        multiplier mult(pixels[(127-8*i):(127-8*i-7)],
                        weights[(127-8*i):(127-8*i-7)],
                        p[(255-16*i):(255-16*i-15)]);
    endgenerate 
    
    genvar k;
    generate
    for (k=0;k<=7;k=k+1)
        adder_16_bit add(p_reg[(255-16*2*k):(255-16*2*k-15)],
                  p_reg[(255-16*(2*k+1)):(255-16*(2*k+1)-15)],
                  s1[(135-17*k):(135-17*k-16)]);
    endgenerate
    
    adder_17_bit adder17_1(s1[135:119],s1[118:102],s2[71:54]);
    adder_17_bit adder17_2(s1[101:85],s1[84:68],s2[53:36]);
    adder_17_bit adder17_3(s1[67:51],s1[50:34],s2[35:18]);
    adder_17_bit adder17_4(s1[33:17],s1[16:0],s2[17:0]);
    
    adder_18_bit adder18_1(s2[71:54],s2[53:36],s3[37:19]);
    adder_18_bit adder18_2(s2[35:18],s2[17:0],s3[18:0]);
    
    adder_19_bit adder19_1(s3[37:19], s3[18:0], sum);
endmodule

