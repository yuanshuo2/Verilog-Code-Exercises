module comparator_4(
    input  [3:0] A,
    input  [3:0] B,
    output wire Y2, // A>B
    output wire Y1, // A=B
    output wire Y0  // A<B
);

// 内部连线，每一位相等标志
wire eq3, eq2, eq1, eq0;

// 同或门，判断每一位A[i] == B[i]
xnor g_eq3(eq3, A[3], B[3]);
xnor g_eq2(eq2, A[2], B[2]);
xnor g_eq1(eq1, A[1], B[1]);
xnor g_eq0(eq0, A[0], B[0]);

// 计算A>B: Y2
wire w1,w2,w3,w4;
and g1(w1, A[3], ~B[3]);
and g2(w2, eq3, A[2], ~B[2]);
and g3(w3, eq3, eq2, A[1], ~B[1]);
and g4(w4, eq3, eq2, eq1, A[0], ~B[0]);
or  gY2(Y2, w1, w2, w3, w4);

// 计算A<B: Y0
wire w5,w6,w7,w8;
and g5(w5, ~A[3], B[3]);
and g6(w6, eq3, ~A[2], B[2]);
and g7(w7, eq3, eq2, ~A[1], B[1]);
and g8(w8, eq3, eq2, eq1, ~A[0], B[0]);
or  gY0(Y0, w5, w6, w7, w8);

// 计算A=B: Y1，四位全部相等
and gY1(Y1, eq3, eq2, eq1, eq0);

endmodule
