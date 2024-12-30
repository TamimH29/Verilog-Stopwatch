`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 01:18:58 PM
// Design Name: 
// Module Name: clk_div_disp
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


module clk_disp(
    input clk,
    output slow_clk
);

    //COUNT register changes based on simulation (2 bits) vs physical implementation (16 bits)
    reg [15:0] COUNT;
    
    assign slow_clk = COUNT[15];
    
    initial begin
        COUNT = 0;
    end
    
    always @ (posedge clk) 
    
        begin
            COUNT = COUNT + 1;
        end
        
endmodule

