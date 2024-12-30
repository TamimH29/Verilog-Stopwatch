`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 08:54:26 AM
// Design Name: 
// Module Name: tb_up_counter
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


module tb_up_counter;

reg [15:0] load;
wire [15:0] result;

up_counter uc1(
    .load(load),
    .result(result)
);

initial begin

load = 16'b0000000000000000;

#100

load = 16'b0001000000000000;

#100

load = 16'b1001100110011001;

end

endmodule
