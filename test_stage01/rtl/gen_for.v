`timescale 1ns/1ns
module gen_for_module( 
    input [7:0] data_in,
    output [7:0] data_out
);
genvar i;  // generate循环专用变量类型
generate
    for(i = 0; i < 8; i = i + 1) begin : bit_reverse_loop
        assign data_out[i] = data_in[7 - i];
    end
endgenerate

endmodule
