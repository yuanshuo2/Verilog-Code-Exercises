`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input a,
	output reg match
	);
reg [7:0] shift_reg;
always@(posedge clk or negedge rst_n)begin 
	if(!rst_n)begin 
		shift_reg<=8'b0;
		match<=1'b0;
	end
	else begin 
		shift_reg<={shift_reg[6:0],a};
		if(shift_reg==8'b0111_0001)begin //_为分隔符，不能用空格
			match<=1'b1;
		end
		else begin 
			match<=1'b0;
		end
	end
end
  
endmodule