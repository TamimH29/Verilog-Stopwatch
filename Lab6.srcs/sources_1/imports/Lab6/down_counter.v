`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 01:10:26 AM
// Design Name: 
// Module Name: down_counter
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


module down_counter(
    input [15:0] load,
    output reg [15:0] result
    );  
    reg [3:0] p0,p1,p2,p3;
    reg [3:0] tc_array;
    
    always @ (*)
    begin
        p3 = load [15:12];
        p2 = load [11:8];
        p1 = load [7:4];
        p0 = load [3:0];
        
        tc_array[3] = (p3 == 4'b0000);
        tc_array[2] = (p2 == 4'b0000);
        tc_array[1] = (p1 == 4'b0000);
        tc_array[0] = (p0 == 4'b0000);
        
        case(tc_array)
            4'b0000: result = {p3, p2, p1, p0 - 1'b1};
            4'b0001: result = {p3, p2, p1 - 1'b1, 4'b1001};
            4'b0010: result = {p3, p2, p1, p0 - 1'b1};
            4'b0011: result = {p3, p2 - 1'b1, 4'b1001, 4'b1001};
            4'b0100: result = {p3, p2, p1, p0 - 1'b1};
            4'b0101: result = {p3, p2, p1 - 1'b1, 4'b1001};
            4'b0110: result = {p3, p2, p1, p0 - 1'b1};
            4'b0111: result = {p3 - 1'b1, 4'b1001, 4'b1001, 4'b1001};
            4'b1000: result = {p3, p2, p1, p0 - 1'b1};
            4'b1001: result = {p3, p2, p1 - 1'b1, 4'b1001};
            4'b1010: result = {p3, p2, p1, p0 - 1'b1};
            4'b1011: result = {p3, p2 - 1'b1, 4'b1001, 4'b1001};
            4'b1100: result = {p3, p2, p1, p0 - 1'b1};
            4'b1101: result = {p3, p2, p1 - 1'b1, 4'b1001};
            4'b1110: result = {p3, p2, p1, p0 - 1'b1};
            4'b1111: result = {p3, p2, p1 ,p0};
            default: result = {p3, p2, p1, p0};
        endcase 
    end
endmodule
