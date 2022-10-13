`timescale 1ns / 1ps

module BCDtoFND_decoder(
    input  [3:0] i_value,
    // input i_en,
    output [7:0] o_fndFont
    );

    reg [7:0] r_fndFont;
    assign o_fndFont = r_fndFont;

    always @(*) begin
        // if (i_en) begin
        //     r_fndFont = 8'b11111111;
        // end
        case (i_value)
            4'h0 : r_fndFont = 8'hc0;
            4'h1 : r_fndFont = 8'hf9;
            4'h2 : r_fndFont = 8'ha4;
            4'h3 : r_fndFont = 8'hb0;
            4'h4 : r_fndFont = 8'h99;
            4'h5 : r_fndFont = 8'h92;
            4'h6 : r_fndFont = 8'h82;
            4'h7 : r_fndFont = 8'hf8;
            4'h8 : r_fndFont = 8'h80;
            4'h9 : r_fndFont = 8'h90;
            4'ha : r_fndFont = 8'h7f;
            default : r_fndFont = 8'hff;
        endcase
        
    end 
endmodule
