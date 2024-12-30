`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2024 12:39:54 PM
// Design Name: 
// Module Name: tb_stopwatch_main
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


module tb_stopwatch_main;
reg clk;
reg reset;
reg startstop; 
reg [7:0] sw;
reg [1:0] modein;
wire [15:0] out;

stopwatch_main s1(
    .clk(clk),
    .reset(reset),
    .startstop(startstop),
    .sw(sw),
    .modein(modein),
    .out(out)
    );

initial begin

clk = 0;
reset = 0;
startstop = 0;
sw = 8'b10011001;
modein = 2'b10;
#50

startstop = 1;
#10

startstop = 0;
#100

reset = 1;
#10

reset = 0;
#10

startstop = 1;
#10

sw = 8'b10000000;
#20

startstop = 0;
#200

modein = 2'b01;
#40

startstop = 1;
#20

startstop = 0;
#20

reset = 1;
#10

reset = 0;
#200

modein = 2'b11;
#30

startstop = 1;
#40

startstop = 0;

end

always
#10 clk = ~clk;

endmodule
