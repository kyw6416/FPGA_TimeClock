`timescale 1ns / 1ps



module TriBuffer(
    input [3:0] i_x,
    input i_en,
    output [3:0] o_y
    );

    assign o_y = (i_en == 1'b1) ? 4'b1111 : i_x; // z는 high 임피던스
endmodule
