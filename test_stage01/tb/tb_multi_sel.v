`timescale 1ns/1ns
module tb_multi_sel();

    reg        clk = 0;
    reg        rst;
    reg  [7:0] d;
    wire [10:0] out;
    wire        input_grant;

    // 例化被测模块
    multi_sel u_multi_sel(
        .d           (d),
        .clk         (clk),
        .rst         (rst),
        .out         (out),
        .input_grant (input_grant)
    );

    // 时钟:周期 10ns
    always #5 clk = ~clk;

    initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, tb_multi_sel);
    end

    // 激励:按波形示意图的节奏给 d
    initial begin
        rst = 0;
        d   = 8'd143;        // 复位期间 d 已经是 143

        #15;                 // rst 低约 1.5 个周期后释放
        rst = 1;

        // 每个数保持 4 个时钟周期(40ns)
        #40;  d = 8'd7;      // -> 输出 7, 21, 49, 56
        #40;  d = 8'd6;      // -> 输出 6, 18, 42, 48
        #20;  d = 8'd128;    // 保持很短,不产生完整输出(和波形一致)
        #20;  d = 8'd129;    // -> 输出 129, 387, 903, 1032
        #40;

        $finish;
    end

endmodule
