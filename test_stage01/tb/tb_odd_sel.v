

`timescale 1ns/1ns



module tb_odd_sel();
reg clk=0;
always #5 clk = ~clk;  // Create clock with period=10
// A testbench

//接下来这一部分是自己添加的激励相关，才明白自测输入的tb代码不全，需要自己更改
reg [31:0] bus;
reg sel;
wire check;

initial begin
    bus = 32'h00000001; sel=1;
    #10;
    bus = 32'h00000003; sel=0;
    #10;
    $finish;
end

//就上面这些
    
    
    
    
//end    
  initial begin
    $dumpfile("out.vcd");
    // This will dump all signal, which may not be useful
    //$dumpvars;
    // dumping only this module
    //$dumpvars(1, tb_odd_sel);
    // dumping only these variable
    // the first number (level) is actually useless
    $dumpvars(0, tb_odd_sel);
end  
    
endmodule