

`timescale 1ns/1ns

module tb_Tff_2();
	reg clk=0;
	always #5 clk = ~clk;  // Create clock with period=10
// A testbench
    
//=========== 新增部分开始 ===========
reg data;
reg rst;
wire q;

// 实例化待测模块Tff_2
Tff_2 u_Tff_2(
    .data(data),
    .clk(clk),
    .rst(rst),
    .q(q)
);

// 测试激励
initial begin
    rst  = 1'b0;   // 低电平复位
    data = 1'b0;
    #20;
    rst  = 1'b1;   // 释放复位
    #10;

    data = 1'b1;   // 打开使能，允许第一级触发器翻转
    #40;
    data = 1'b0;   // 关闭使能，停止翻转
    #20;

    rst = 1'b0;    // 再次复位测试
    #10;
    rst = 1'b1;

    #30;
    $finish;       // 结束仿真
end
//=========== 新增部分结束 ===========
  
//end    
  initial begin
    $dumpfile("out.vcd");
    // This will dump all signal, which may not be useful
    //$dumpvars;
    // dumping only this module
    //$dumpvars(1, tb_Tff_2);
    // dumping only these variable
    // the first number (level) is actually useless
    $dumpvars(0, tb_Tff_2);
end  
    
endmodule