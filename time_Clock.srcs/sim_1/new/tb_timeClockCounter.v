`timescale 1ns / 1ps

module tb_timeClockCounter();

    reg i_clk = 1'b0, i_reset;
    wire [6:0] o_hour, o_min, o_sec, o_msec;
    
    timeClockCounter dut(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_hour(o_hour), 
    .o_min(o_min), 
    .o_sec(o_sec), 
    .o_msec(o_msec)
    );

    always #0.5 i_clk = ~i_clk;

    initial begin
        #00  i_reset = 1'b0;
        #100000 i_reset = 1'b1;
        #100000 $finish;
    end
endmodule
