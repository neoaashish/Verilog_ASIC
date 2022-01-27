`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 06:05:13 AM
// Design Name: 
// Module Name: acc_cltr
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

module acc_FSM(
    input clk,
    input reset, 
    output sel,
    output en
    );
    
    reg [1:0] n_state, c_state;
    parameter s1 = 2'b00;
    parameter s2 = 2'b01;
    parameter s3 = 2'b10;
    parameter s4 = 2'b11;
    
    always @(posedge clk) begin
     if(reset)
        c_state = s1;
     else
        c_state = n_state;
     end
    
    always @(c_state) begin
        case(c_state)
         s1:n_state = s2;
         s2:n_state = s3;
         s3:n_state = s4;
         s4:n_state = s1;
        endcase
     end 
     
     assign sel = (c_state == s1)? 1'b1 : 1'b0;
     assign en = (c_state == s4)? 1'b1 : 1'b0;
    
endmodule
