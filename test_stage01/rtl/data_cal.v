`timescale 1ns/1ns
module data_cal(
input clk,
input rst,
input [15:0]d,
input [1:0]sel,
output reg[4:0]out,
output reg validout
);

reg [15:0] d_reg; // 用来锁存数据！只有sel=0时才更新

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        d_reg <= 16'd0;
    end
    else begin
        if(sel == 2'b00) begin
            d_reg <= d; // ✅只有sel=0，才把d存到寄存器
        end
        else begin
            d_reg <= d_reg; // sel非0，保持原来锁存的值，不更新
        end
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        out <= 5'd0;
        validout <= 1'b0;
    end
    else begin
        case(sel)
            2'b00: begin
                out <= 5'd0;
                validout <= 1'b0;
            end
            2'b01: begin // d_reg[3:0] + d_reg[7:4]，用锁存数据！！
                out <= d_reg[3:0] + d_reg[7:4];
                validout <= 1'b1;
            end
            2'b10: begin
                out <= d_reg[3:0] + d_reg[11:8];
                validout <= 1'b1;
            end
            2'b11: begin
                out <= d_reg[3:0] + d_reg[15:12];
                validout <= 1'b1;
            end
        endcase
    end
end

endmodule
