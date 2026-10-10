`timescale 1ns/1ns
module mux4_1(
input [1:0]d1,d2,d3,d0,
input [1:0]sel,
output[1:0]mux_out
);
//*************code***********//
//题目要求 输出类型为wire
/*错误示范
always@(*) begin
    case(sel)
        2'b00: mux_out=d0;
        2'b01: mux_out=d1;
        2'b10: mux_out=d2;
        2'b11: mux_out=d3;
        default: mux_out=2'b00;
    endcase
end
*/
assign mux_out = (sel==2'b00)?d3:
                 (sel==2'b01)?d2:
                 (sel==2'b10)?d1:
                 (sel==2'b11)?d0:2'b00;
//*************code***********//
endmodule