PRAGMA verify_parallelism;
pragma threads=4;
CREATE TABLE bigdata AS SELECT i AS col_a, i AS col_b FROM range(0,10000) tbl(i);
