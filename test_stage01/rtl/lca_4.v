`timescale 1ns/1ns
module lca_4(
    input [3:0] A_in,
    input [3:0] B_in,
    input C_1,

    output wire CO,
    output wire [3:0] S
);

// 内部连线
wire G0, G1, G2, G3;
wire P0, P1, P2, P3;
wire C0, C1, C2, C3;

// 1. 生成Gi = Ai & Bi，Pi = Ai ^ Bi
and gG0(G0, A_in[0], B_in[0]);
and gG1(G1, A_in[1], B_in[1]);
and gG2(G2, A_in[2], B_in[2]);
and gG3(G3, A_in[3], B_in[3]);

xor gP0(P0, A_in[0], B_in[0]);
xor gP1(P1, A_in[1], B_in[1]);
xor gP2(P2, A_in[2], B_in[2]);
xor gP3(P3, A_in[3], B_in[3]);

// 2. 超前进位，C_i = G_i | (P_i & C_{i-1})
wire wC0;
and g_c0(wC0, P0, C_1);
or  gC0(C0, G0, wC0);

wire wC1_1, wC1_2;
and g_c1_1(wC1_1, P1, G0);
and g_c1_2(wC1_2, P1, P0, C_1);
or  gC1(C1, G1, wC1_1, wC1_2);

wire wC2_1, wC2_2, wC2_3;
and g_c2_1(wC2_1, P2, G1);
and g_c2_2(wC2_2, P2, P1, G0);
and g_c2_3(wC2_3, P2, P1, P0, C_1);
or  gC2(C2, G2, wC2_1, wC2_2, wC2_3);

wire wC3_1, wC3_2, wC3_3, wC3_4;
and g_c3_1(wC3_1, P3, G2);
and g_c3_2(wC3_2, P3, P2, G1);
and g_c3_3(wC3_3, P3, P2, P1, G0);
and g_c3_4(wC3_4, P3, P2, P1, P0, C_1);
or  gC3(C3, G3, wC3_1, wC3_2, wC3_3, wC3_4);

assign CO = C3;

// 3. 和 S_i = P_i ^ C_{i-1}
xor gS0(S[0], P0, C_1);
xor gS1(S[1], P1, C0);
xor gS2(S[2], P2, C1);
xor gS3(S[3], P3, C2);

endmodule
 