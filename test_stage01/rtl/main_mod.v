`timescale 1ns/1ns

//子模块min2：时序逻辑，异步复位，两数取最小
module min2(
    input               clk,
    input               rst_n,
    input      [7:0]    a,
    input      [7:0]    b,
    output reg [7:0]    c
);
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        c <= 8'd0;
    end
    else begin
        c <= (a < b) ? a : b;
    end
end
endmodule

//顶层模块main_mod
module main_mod(
    input               clk,
    input               rst_n,
    input      [7:0]    a,
    input      [7:0]    b,
    input      [7:0]    c,
    output     [7:0]    d
);

wire [7:0] min_ab;
reg  [7:0] c_delay;  //把c寄存一拍，和min_ab时序对齐

//给c打一拍，和min_ab同步
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        c_delay <= 8'd0;
    end
    else begin
        c_delay <= c;
    end
end

//第1级：比较a,b，延迟1clk得到min_ab
min2 u_min_ab(
    .clk(clk),
    .rst_n(rst_n),
    .a(a),
    .b(b),
    .c(min_ab)
);

//第2级：min_ab 和 延迟一拍后的c_delay 比较，再延迟1clk得到d
min2 u_min_final(
    .clk(clk),
    .rst_n(rst_n),
    .a(min_ab),
    .b(c_delay),
    .c(d)
);

endmodule
