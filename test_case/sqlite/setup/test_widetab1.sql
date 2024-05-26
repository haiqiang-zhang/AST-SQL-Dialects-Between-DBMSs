CREATE TABLE a(
   a00, a01, a02, a03, a04, a05, a06, a07, a08, a09,
   a10, a11, a12, a13, a14, a15, a16, a17, a18, a19,
   a20, a21, a22, a23, a24, a25, a26, a27, a28, a29,
   a30, a31, a32, a33, a34, a35, a36, a37, a38, a39,
   a40, a41, a42, a43, a44, a45, a46, a47, a48, a49,
   a50, a51, a52, a53, a54, a55, a56, a57, a58, a59,
   pd, bn, vb, bc, cn, ie, qm);
CREATE INDEX a1 on a(pd, bn, vb, bc, cn);
CREATE INDEX a2 on a(pd, bc, ie, qm);
CREATE TABLE b(bg, bc, bn, iv, ln, mg);
CREATE INDEX b1 on b(bn, iv, bg);
CREATE TABLE t1(
    c00,c01,c02,c03,c04,c05,c06,c07,c08,c09,
    c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,
    c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,
    c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,
    c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,
    c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,
    c60,c61,c62,c63,c64,c65,c66,c67,c68,c69,
    c70,c71,c72,c73,c74,c75,c76,c77,c78,c79,
    c80,c81,c82,c83,c84,c85,c86,c87,c88,c89,
    c90,c91,c92,c93,c94,c95,c96,c97,c98,c99,
    a,b,c,d,e
  );
CREATE INDEX t1x1 on t1(c00,a,b,
        c01,c02,c03,c04,c05,c06,c07,c08,c09,
    c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,
    c20,c21,c22,c23,c24,c25,c26,c27,c28,c29,
    c30,c31,c32,c33,c34,c35,c36,c37,c38,c39,
    c40,c41,c42,c43,c44,c45,c46,c47,c48,c49,
    c50,c51,c52,c53,c54,c55,c56,c57,c58,c59,
    c60,c61,c62,c63,c64,c65,c66,c67,c68,c69,
    c70,c71,c72,c73,c74,c75,c76,c77,c78,c79,
    c80,c81,c82,c83,c84,c85,c86,c87,c88,c89,
    c90,c91,c92,c93,c94,c00,c96,c97,c98,c99
  );
CREATE INDEX t1cd ON t1(c,d);
CREATE INDEX t1x2 ON t1(c01,c02,c03,a,b);
