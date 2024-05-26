PRAGMA enable_verification;
CREATE TABLE t1 AS SELECT i, i FROM range(5) tbl(i);
CREATE TABLE t2 AS SELECT i, i, i, i FROM range(5) tbl(i);
CREATE TABLE t3 AS SELECT tbl1.i, tbl2.i FROM range(5) tbl1(i) JOIN range(5) tbl2(i) ON tbl1.i=tbl2.i;
CREATE TABLE t4 AS SELECT * FROM range(5) tbl1(i) JOIN range(5) tbl2(i) ON tbl1.i=tbl2.i;
