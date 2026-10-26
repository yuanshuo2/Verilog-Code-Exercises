`timescale 1ns/1ns

module encoder_0(
   input      [8:0]         I_n   ,
   
   output reg [3:0]         Y_n   
);
always @(*) begin
    if      (!I_n[8])  Y_n = 4'b0110;  // I9
    else if (!I_n[7])  Y_n = 4'b0111;  // I8
    else if (!I_n[6])  Y_n = 4'b1000;  // I7
    else if (!I_n[5])  Y_n = 4'b1001;  // I6
    else if (!I_n[4])  Y_n = 4'b1010;  // I5
    else if (!I_n[3])  Y_n = 4'b1011;  // I4
    else if (!I_n[2])  Y_n = 4'b1100;  // I3
    else if (!I_n[1])  Y_n = 4'b1101;  // I2
    else if (!I_n[0])  Y_n = 4'b1110;  // I1
    else               Y_n = 4'b1111;  // 无输入
end
endmodule