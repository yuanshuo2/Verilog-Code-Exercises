

`timescale 1ns/1ns

module tb_Tff_2();
	reg clk=0;
	always #5 clk = ~clk;  // Create clock with period=10
// A testbench
    
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