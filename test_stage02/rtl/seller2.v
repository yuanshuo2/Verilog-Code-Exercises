`timescale 1ns/1ns
module seller2(
    input  wire clk,
    input  wire rst,
    input  wire d1,
    input  wire d2,
    input  wire sel,
    output reg  out1,
    output reg  out2,
    output reg  out3
);

parameter S0   = 3'd0;  // 0元
parameter S05  = 3'd1;  // 0.5元
parameter S10  = 3'd2;  // 1.0元
parameter S15  = 3'd3;  // 1.5元
parameter S20  = 3'd4;  // 2.0元
parameter S25  = 3'd5;  // 2.5元
parameter S30  = 3'd6;  // 3.0元

reg [2:0] state;
reg [2:0] next;
reg d1r, d2r;

// 状态寄存器
always@(posedge clk or negedge rst) begin
    if (~rst) begin
        state <= S0;
    end
    else begin
        state <= next;
    end
end

// 对投币脉冲d1、d2打一拍寄存
always@(posedge clk or negedge rst) begin
    if (~rst) begin
        d1r <= 1'b0;
        d2r <= 1'b0;
    end
    else begin
        d1r <= d1;
        d2r <= d2;
    end
end

// 状态转移组合逻辑
always@(*) begin
    if (~rst) begin
        next = S0;
    end
    else begin
        case(state)
            S0: begin
                if({d1r, d2r} == 2'b10)
                    next = S05;
                else if({d1r, d2r} == 2'b01)
                    next = S10;
                else
                    next = state;
            end

            S05: begin
                if({d1r, d2r} == 2'b10)
                    next = S10;
                else if({d1r, d2r} == 2'b01)
                    next = S15;
                else
                    next = state;
            end

            S10: begin
                if({d1r, d2r} == 2'b10)
                    next = S15;
                else if({d1r, d2r} == 2'b01)
                    next = S20;
                else
                    next = state;
            end

            S15: begin
                if(!sel) begin // 选择1.5元饮料，金额足够，购买完成返回S0
                    if({d1r, d2r} == 2'b00)
                        next = S0;
                    else if({d1r, d2r} == 2'b10)
                        next = S05;
                    else if({d1r, d2r} == 2'b01)
                        next = S10;
                    else
                        next = state;
                end
                else begin // 选择2.5元饮料，继续投币
                    if({d1r, d2r} == 2'b10)
                        next = S20;
                    else if({d1r, d2r} == 2'b01)
                        next = S25;
                    else
                        next = state;
                end
            end

            S20: begin
                if(!sel) begin // 选1.5元饮料，金额足够，购买完成返回S0
                    if({d1r, d2r} == 2'b00)
                        next = S0;
                    else if({d1r, d2r} == 2'b10)
                        next = S05;
                    else if({d1r, d2r} == 2'b01)
                        next = S10;
                    else
                        next = state;
                end
                else begin // 选2.5元饮料，继续投币
                    if({d1r, d2r} == 2'b10)
                        next = S25;
                    else if({d1r, d2r} == 2'b01)
                        next = S30;
                    else
                        next = state;
                end
            end

            S25: begin
                if({d1r, d2r} == 2'b00)
                    next = S0;
                else if({d1r, d2r} == 2'b10)
                    next = S05;
                else if({d1r, d2r} == 2'b01)
                    next = S10;
                else
                    next = state;
            end

            S30: begin
                if({d1r, d2r} == 2'b00)
                    next = S0;
                else if({d1r, d2r} == 2'b10)
                    next = S05;
                else if({d1r, d2r} == 2'b01)
                    next = S10;
                else
                    next = state;
            end

            default: next = S0;
        endcase
    end
end

// 输出时序逻辑
always@(posedge clk or negedge rst) begin
    if (~rst) begin
        out1 <= 1'b0;
        out2 <= 1'b0;
        out3 <= 1'b0;
    end
    else begin
        case(next)
            S15: begin
                if(!sel) begin
                    out1 <= 1'b1;
                    out3 <= 1'b0;
                end
                else begin
                    out1 <= 1'b0;
                    out3 <= 1'b0;
                end
            end

            S20: begin
                if(!sel) begin
                    out1 <= 1'b1;
                    out3 <= 1'b1;
                end
                else begin
                    out1 <= 1'b0;
                    out3 <= 1'b0;
                end
            end

            S25: begin
                out2 <= 1'b1;
                out3 <= 1'b0;
            end

            S30: begin
                out2 <= 1'b1;
                out3 <= 1'b1;
            end

            default: begin
                out1 <= 1'b0;
                out2 <= 1'b0;
                out3 <= 1'b0;
            end
        endcase
    end
end

endmodule
