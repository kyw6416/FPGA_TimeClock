`timescale 1ns / 1ps

module DecoderFndDigit(
    input [2:0] i_select,
    // input i_en,
    output [3:0] o_digitPosition
    );

    reg [3:0] r_digitPosition;
    assign o_digitPosition = r_digitPosition;

    always @(*) begin
        // if (i_en) begin
        //    r_digitPosition <= 4'b1111;
        // end

        case (i_select)
            3'b000 : r_digitPosition <= 4'b1110;
            3'b001 : r_digitPosition <= 4'b1101;
            3'b010 : r_digitPosition <= 4'b1011;
            3'b011 : r_digitPosition <= 4'b0111;
            3'b100 : r_digitPosition <= 4'b1110;
            3'b101 : r_digitPosition <= 4'b1101;
            3'b110 : r_digitPosition <= 4'b1011;
            3'b111 : r_digitPosition <= 4'b0111;
        endcase

    end
endmodule
