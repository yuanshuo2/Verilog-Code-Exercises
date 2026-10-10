`timescale 1ns/1ns
module Tff_2 (
input wire data, clk, rst,
output reg q  
);
//*************code***********//
//第一个触发器
reg tmp
always@(posedge clk or negedge rst) begin
    if(!rst) 
        tmp <= 1'b0;
    else if(data)
        tmp <= ~tmp;
    end
//第二个触发器
always@(posedge clk or negedge rst) begin
    if(!rst)
        q<=1'b0;
    else if(tmp)
        q<=~q;
end

//*************code***********//
endmodule