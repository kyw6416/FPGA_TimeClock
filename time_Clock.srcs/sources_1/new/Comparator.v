`timescale 1ns / 1ps

module Comparator(
    input [6:0] i_msec,
    output [3:0] o_fndDP
    );

    assign o_fndDP = (i_msec < 50) ? 10 : 11;   // 참으면 11 50이상이면 10 -> 10이면 DP 11이면 디폴트값 ff
endmodule
