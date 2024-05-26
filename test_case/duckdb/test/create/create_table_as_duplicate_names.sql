SELECT * FROM range(5) tbl1(i) JOIN range(5) tbl2(i) ON tbl1.i=tbl2.i;
SELECT i, i FROM range(5) tbl(i);
SELECT * FROM (SELECT i, i FROM range(5) tbl(i)) tbl;
SELECT * FROM (SELECT i, i, i, i FROM range(5) tbl(i)) tbl;
SELECT * FROM t1;
SELECT * FROM (SELECT i, i, i, i FROM range(5) tbl(i)) tbl;
SELECT * FROM (SELECT * FROM range(5) tbl1(i) JOIN range(5) tbl2(i) ON tbl1.i=tbl2.i) tbl;
SELECT * FROM t3;
SELECT * FROM t4;
