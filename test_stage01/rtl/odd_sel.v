`timescale 1ns/1ns
module odd_sel(
input [31:0] bus,
input sel,
output check
);
//*************code***********//
 assign check = sel ? (^bus) : (~^bus);

//*************code***********//
endmodule