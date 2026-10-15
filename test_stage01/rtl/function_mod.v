`timescale 1ns/1ns

module function_mod(
    input               clk,
    input               rst_n,
    input      [3:0]    a,
    input      [3:0]    b,
    output reg [7:0]    c,
    output reg [7:0]    d
);

//函数：4bit位反转
function [3:0] data_rev;
    input [3:0] data_in;
    begin
        data_rev[0] = data_in[3];
        data_rev[1] = data_in[2];
        data_rev[2] = data_in[1];
        data_rev[3] = data_in[0];
    end
endfunction

//组合逻辑 always@(*)，阻塞赋值 =，**不要posedge clk**
always @(*) begin
    if(!rst_n) begin
        c = 8'd0;
        d = 8'd0;
    end
    else begin
        c = {4'd0, data_rev(a)};
        d = {4'd0, data_rev(b)};
    end
end

endmodule
