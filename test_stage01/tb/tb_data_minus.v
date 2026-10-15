`timescale 1ns/1ns
module testbench();
    reg [7:0] a,b;   //data_minus是无符号数，不要写signed！
    reg clk,rst_n;
    wire [7:0]c;     //输出c是8bit无符号

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0,testbench);
end

// 生成时钟：周期20ns，10ns高，10ns低
initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
end

//复位+激励
initial begin
    rst_n = 1'b0; //复位拉低
    a = 8'd0;
    b = 8'd0;
    #20;          //等待20ns
    rst_n = 1'b1; //释放复位

    //测试用例1：a > b
    #20;
    a = 8'd200;
    b = 8'd10;

    //测试用例2：a < b
    #20;
    a = 8'd10;
    b = 8'd200;

    //测试用例3：a == b，差值为0
    #20;
    a = 8'd123;
    b = 8'd123;

    //测试用例4：边界
    #20;
    a = 8'd255;
    b = 8'd0;

    #40;
    $finish; //结束仿真
end

//实例化被测模块 dut
data_minus dut(
    .clk(clk),
    .rst_n(rst_n),
    .a(a),
    .b(b),
    .c(c)
);

endmodule
