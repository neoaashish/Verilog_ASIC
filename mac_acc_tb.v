`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2021 06:02:20 AM
// Design Name: 
// Module Name: mac_acc_tb
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

module mac_acc_tb();

    parameter half_cycle = 20;
    
    reg [127:0] data_p[39:0];
    reg [127:0] data_w[39:0];
   
    wire [21:0] acc_out;
    
    reg [127:0] pixels,weights;
   
    reg [7:0] bias; 
    
    reg [7:0] count; 
    reg clk,reset_counter,reset_accum;
    wire clk2;
    
    integer outfile;
    integer outfile2;
    
    assign #2 clk2 = clk;
    
    //mac_acc macc(clk2, reset_accum, bias, pixels, weights, acc_out);
    mac_acc macc(clk2, reset_accum, bias, pixels, weights, sigmoid_out);
    
    initial begin
     $readmemh("digits_hex.txt", data_p);
     $readmemh("weights_hex.txt", data_w);
     outfile = $fopen("sim_acc.txt","w");
     outfile2 = $fopen("sim_mac.txt","w");
     outfile3 = $fopen("sigmoid_out.txt","w");
     clk = 0;
     count = 0;
     reset_counter = 1;
     reset_accum = 1;
     bias = 11;
     #145 reset_counter = 0;
    end
    
   always #half_cycle clk=!clk;
   
   //write acc output to file
   always @(posedge clk)
    if ((count>7)&(count[1:0] == 2'b00))begin
     $fdisplay(outfile, "%h", acc_out);
     $fdisplay(outfile3, "%h", sigmoid_out);
     end
     
   //write mac output to file
   always @(posedge clk)
    if ((count>3)&&(count<43))
     $fdisplay(outfile2, "%h", macc.mac_out);
     
   always @(posedge clk2)begin
     pixels = data_p[count];
     weights = data_w[count];
     
     if(!reset_counter) begin
      count = count + 1;
      if (count == 4)
       reset_accum = 0;
       
      if (count == 47) begin
       $fclose(outfile);
       $fclose(outfile2);
       $fclose(outfile3);
       $finish;
      end 
     end 
   end       

endmodule
