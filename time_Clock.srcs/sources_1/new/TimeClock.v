`timescale 1ns / 1ps

module TimeClock(
    input i_clk,
    input i_reset,
    input i_modeSw,
    input i_en,

    output [3:0] o_digitPosition,
    output [7:0] o_fndFont
    );

    wire w_clk_1khz;
    wire [2:0] w_fndCounter;

    wire [6:0] w_hour; 
    wire [6:0] w_min;
    wire [6:0] w_sec;
    wire [6:0] w_msec;

    ClockDivider clockdiv(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_clk(w_clk_1khz)
    );

    CounterFnd cntFnd(
        .i_clk(w_clk_1khz),
        .i_reset(i_reset),
        .o_counter(w_fndCounter)
    );

    wire [3:0] w_digitPosition;

    DecoderFndDigit decoder_fnd(
        .i_select(w_fndCounter),
        // .i_en(i_en),
        .o_digitPosition(w_digitPosition)
    );

    TriBuffer tbuff(
        .i_x(w_digitPosition),
        .i_en(i_en),
        .o_y(o_digitPosition)
);

    timeClockCounter timeclockCnt(
        .i_clk(w_clk_1khz),
        .i_reset(i_reset),
        .o_hour(w_hour),
        .o_min(w_min),
        .o_sec(w_sec),
        .o_msec(w_msec)
    );

    wire [3:0] w_min10, w_min1, w_hour10, w_hour1;

    DigitDivider digitDiv_HourMin(
        .i_a(w_min),
        .i_b(w_hour),
        .o_a10(w_min10), 
        .o_a1(w_min1), 
        .o_b10(w_hour10),
        .o_b1(w_hour1)
    );


    wire [3:0] w_msec10, w_msec1, w_sec10, w_sec1;

    DigitDivider digitDiv_SecMilSec(
        .i_a(w_msec), 
        .i_b(w_sec),
        .o_a10(w_msec10), 
        .o_a1(w_msec1), 
        .o_b10(w_sec10), 
        .o_b1(w_sec1)
    );
 
    wire [3:0] w_fndDP;

    Comparator comp(
        .i_msec(w_msec),
        .o_fndDP(w_fndDP)
    );

    wire [3:0] w_hourMinMux;

    Mux_8x1 Mux_HourMin(
        .i_a(w_min1), 
        .i_b(w_min10), 
        .i_c(w_hour1), 
        .i_d(w_hour10),
        .i_a1(11), 
        .i_b1(11), 
        .i_c1(w_fndDP), 
        .i_d1(11),
        .i_sel(w_fndCounter),
        .o_y(w_hourMinMux)
    );

    wire [3:0] w_SecMilSecMux;

    Mux_8x1 Mux_SecMilSec(
        .i_a(w_msec1), 
        .i_b(w_msec10), 
        .i_c(w_sec1), 
        .i_d(w_sec10),
        .i_a1(11), 
        .i_b1(11), 
        .i_c1(w_fndDP), 
        .i_d1(11),
        .i_sel(w_fndCounter),
        .o_y(w_SecMilSecMux)
    );

    wire [3:0] w_fndValue;

    Mux_2x1 fndValueMux(
        .i_a(w_SecMilSecMux), 
        .i_b(w_hourMinMux),
        .i_sel(i_modeSw),
        .o_y(w_fndValue)
    );

    BCDtoFND_decoder fndFont(
        .i_value(w_fndValue),
        // .i_en(i_en),
        .o_fndFont(o_fndFont)
    );

endmodule