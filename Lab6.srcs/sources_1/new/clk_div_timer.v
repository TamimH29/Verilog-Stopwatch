`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 04:53:22 PM
// Design Name: 
// Module Name: clk_div_timer
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


module clk_div_timer(
    input clk,
    output slow_clock
    );
    
    reg [23:0] COUNT;

    assign slow_clock = (COUNT < 24'b010011000100101100111111);
    
    initial begin
        COUNT = 0;
    end
    
    always @ (posedge clk) 
    
        begin
        if(COUNT == 24'b100110001001011010000000)
            COUNT <= 0;
        else
            COUNT <= COUNT + 1;
        end
        
        
endmodule
