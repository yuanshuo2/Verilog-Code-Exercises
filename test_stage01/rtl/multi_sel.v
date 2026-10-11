`timescale 1ns/1ns
module multi_sel (
    input [7:0] d,
    input clk,
    input rst,
    output reg [10:0] out,
    output reg input_grant
);
//已知d为一个8位数，请在每个时钟周期分别输出该数乘1/3/7/8,并输出一个信号通知此时刻输入的d有效（d给出的信号的上升沿表示写入有效）
reg [1:0] cnt;
reg [7:0] d_reg;
always @(posedge clk or negedge rst) begin
if(!rst) begin 
    cnt <= 2'b0;
    out <= 11'b0;
    input_grant <= 1'b0;
    d_reg <= 8'b0;
end
else begin 
    cnt<= cnt + 2'b01;
    case(cnt)
        2'b0: begin
        d_reg <= d;
        out <= d;
        input_grant <= 1'b1;

      end
        2'b1: begin
            out <= (d_reg<<1)+d_reg;//d*3
            input_grant <= 1'b0;
        end
        2'b10: begin
            out <= (d_reg<<3)-d_reg;//d*7
            input_grant <= 1'b0;
        end
        2'b11: begin
            out <= (d_reg<<3);//d*8
            input_grant <= 1'b0;
        end
endcase


    end
end
endmodule