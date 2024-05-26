CREATE TABLE bigdata AS SELECT i AS col_a, i AS col_b FROM range(0,10000) tbl(i);
set threads=1;
INSERT INTO bigdata SELECT bigdata.* FROM bigdata, range(9);
PRAGMA verify_parallelism;
pragma threads=4;
