`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 06:11:25 AM
// Design Name: 
// Module Name: adder
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


module adder_16_bit(
    input signed [15:0] a,
    input signed [15:0] b,
    output signed [16:0] s
    );
    
    assign s = a+b;     
endmodule

module adder_17_bit(
    input signed [16:0] a,
    input signed [16:0] b,
    output signed [17:0] s
    );
    
    assign s = a+b;     
endmodule

module adder_18_bit(
    input signed [17:0] a,
    input signed [17:0] b,
    output signed [18:0] s
    );
    
    assign s = a+b;     
endmodule

module adder_19_bit(
    input signed [18:0] a,
    input signed [18:0] b,
    output signed [19:0] s
    );
    
    assign s = a+b;     
endmodule

module adder_22_bit(
    input signed [19:0] a,
    input signed [21:0] b,
    output signed [21:0] s
    );
    
    assign s = a+b;     
endmodule