`timescale 1ns / 1ps


module tb_timeClock();

    reg i_clk    = 0;
    reg i_reset  = 0;
    reg i_modeSw = 0;

    wire [3:0] o_digitPosition;
    wire [7:0] o_fndFont;

    TimeClock dut(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_modeSw(i_modeSw),

    .o_digitPosition(o_digitPosition),
    .o_fndFont(o_fndFont)
    );

    always #5 i_clk = ~i_clk;

    initial begin
        #00000 i_modeSw = 1'b0;
        #10000 i_modeSw = 1'b1;
        #10000 i_modeSw = 1'b0;
        #10000 i_modeSw = 1'b1;
        #10000 i_modeSw = 1'b0;
        #10000 $finish;
    end
endmodule
