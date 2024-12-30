`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2024 04:40:18 PM
// Design Name: 
// Module Name: stopwatch_main
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


module stopwatch_main(
    input clk,
    input reset,
    input startstop,
    input [7:0] sw,
    input [1:0] modein,
    output reg [15:0] out,
    output [3:0] an,
    output [6:0] sseg
    );
    
    //define no load values for state 00 and state 10 respectively
    wire [15:0] noload1, noload2;
    assign noload1 = 16'b0000000000000000;
    assign noload2 = 16'b1001100110011001;
    
    //preset value to be set based on sw inputs
    reg [15:0] preset;
    
    //initially stopped state
    reg stop = 1'b1;
    reg stopflag = 1'b0;
        
    //prev to hold previous output and pass as argument to modules
    reg [15:0] prev;
    
    //load to hold the reset load value of current state
    reg [15:0] load;
    
    //state and next state
    reg [1:0] state;
    reg [1:0] next_state;
    
    //res stores the outputs from each mode
    wire [15:0] res1;
    wire [15:0] res2;
    wire [15:0] res3;
    wire [15:0] res4;
    reg init = 1'b0;
    
    //combinational logic block
    always @(*)
    begin
        //preset is sw inputs followed by 8bits 0
        preset = {sw, 8'b00000000};
        //next_state is a function of input mode only
        case(modein)
            2'b00: next_state = 2'b00;
            2'b01: next_state = 2'b01;
            2'b10: next_state = 2'b10;
            2'b11: next_state = 2'b11;
            default: next_state = 2'b00;
        endcase
        
        //assign load reset value based on current state
        case(state)
            2'b00: load = noload1;
            2'b01: load = preset;
            2'b10: load = noload2;
            2'b11: load = preset;
            default: load = noload1;
        endcase
        
        
    end
    
    //calculate operation of mode 00 and store in res1
    up_counter u1( 
    .load(prev),  
    .result(res1));
    
    //calculate operation of mode 01 and store in res2
    up_counter u2(
    .load(prev), 
    .result(res2));
    
    //calculate operation of mode 10 and store in res3
    down_counter d1(
    .load(prev),
    .result(res3));
    
    //calculate operation of mode 11 and store in res4
    down_counter d2(
    .load(prev),
    .result(res4));
    
    wire timer_clock;
    clk_div_timer t1(.clk(clk), .slow_clock(timer_clock));
    
    //on rising edge of stopstart button, toggle state of timer
    /*always@(posedge startstop)
    begin
        stop <= ~stop;
    end*/
    
    //sequential logic block 
    always@(posedge clk or posedge reset)
    begin
    if(reset)
        begin
        //assign output to initial loads bsed on mode
        case(modein)
            2'b00: begin
            out <= noload1;
            prev <= noload1;
            end
            2'b01: begin
            out <= preset;
            prev <= preset;
            end
            2'b10: begin
            out <= noload2;
            prev <= noload2;
            end
            2'b11: begin
            out <= preset;
            prev <= preset;
            end
            default: begin
            out <= load;
            prev <= load;
            end
        endcase
            state <= next_state;
        end
    else
    begin
        //if initializing, changing modes, or reset
        if((state != modein) || ~init)
        begin
            //assign output to initial loads bsed on mode
            case(modein)
                2'b00: begin
                out <= noload1;
                prev <= noload1;
                end
                2'b01: begin
                out <= preset;
                prev <= preset;
                end
                2'b10: begin
                out <= noload2;
                prev <= noload2;
                end
                2'b11: begin
                out <= preset;
                prev <= preset;
                end
                default: begin
                out <= load;
                prev <= load;
                end
            endcase
            //if switching states, start next state in stop
            if(state != modein)
                stop <= 1'b1;   

            //after initializing to first state based on modein, no need to initialize again
            if(~init)
                init <= 1'b1;
        end
        
        else
        begin
            //if stopped, output value is same
            if(stop)
                out <= prev;
            else
            //if not stopped, output based on state, prev updated to output value
                case(state)
                    2'b00: begin
                    out <= res1;
                    prev <= res1;
                    end
                    2'b01: begin
                    out <= res2;
                    prev <= res2;
                    end
                    2'b10: begin
                    out <= res3;
                    prev <= res3;
                    end
                    2'b11: begin
                    out <= res4;
                    prev <= res4;
                    end
                    default: begin
                    out <= res1;
                    prev <= res1;
                    end
                endcase 
        end
            if(startstop)
            begin
                if(!stopflag)
                begin
                    stopflag = 1'b1;
                    stop <= ~stop;
                end
            end
            else
                stopflag = 1'b0;
            state <= next_state;
        end
        //unconditional update state 
    end
    
    wire [6:0] in0, in1, in2, in3;
    wire display_clock;
    
    hexto7segment c1 (.x(out[3:0]), .r(in0));
    hexto7segment c2 (.x(out[7:4]), .r(in1));
    hexto7segment c3 (.x(out[11:8]), .r(in2));
    hexto7segment c4 (.x(out[15:12]), .r(in3));
    
    clk_disp a1(.clk(clk), .slow_clk(display_clock));
    
    time_mux_FSM f1(
    .clk (display_clock),
    .in0 (in0),
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .an(an),
    .sseg(sseg));
    
endmodule
