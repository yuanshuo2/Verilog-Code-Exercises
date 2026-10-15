`timescale 1ns/1ns
module data_select(
	input clk,
	input rst_n,
	input signed[7:0]a,
	input signed[7:0]b,
	input [1:0]select,
	output reg signed [8:0]c
);
//根据指示信号select的不同，对输入信号a,b实现不同的运算。
//输入信号a,b为8bit有符号数，当select信号为0，输出a；当select信号为1，输出b；
//当select信号为2，输出a+b；当select信号为3，输出a-b.
always@(posedge clk or negedge rst_n)begin 
	if(!rst_n)begin 
		c<=9'b0;
	end
	else begin 
		case(select)
		2'b00 : c<=a;
		2'b01 : c<=b;
		2'b10 : c<=a+b;
		default : c<=a-b;
		endcase
	end
end
endmodule