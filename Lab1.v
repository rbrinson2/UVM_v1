`timescale 1ns / 1ps

module Lab1(
    input A, B, C, D,
    output reg [2:0] I
    );
    
    always @(A, B, C, D) begin
        case({A, B, C, D})
            4'b0000 : I <= 3'd4;
            4'b0001 : I <= 3'd3;
            4'b0010 : I <= 3'd3;
            4'b0100 : I <= 3'd3;
            4'b1000 : I <= 3'd3;
            4'b0011 : I <= 3'd2;
            4'b0101 : I <= 3'd2;
            4'b1001 : I <= 3'd2;
            4'b0110 : I <= 3'd2;
            4'b1010 : I <= 3'd2;
            4'b1100 : I <= 3'd2;
            4'b0111 : I <= 3'd1;
            4'b1011 : I <= 3'd1;
            4'b1101 : I <= 3'd1;
            4'b1110 : I <= 3'd1;
            4'b1111 : I <= 3'd0;
            default : I <= 3'bzzz;
        endcase 
    end
endmodule
