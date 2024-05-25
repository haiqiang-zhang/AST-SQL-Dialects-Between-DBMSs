CREATE INDEX i_bmtest_a ON bmscantest(a);
CREATE INDEX i_bmtest_b ON bmscantest(b);
set enable_indexscan=false;
set enable_seqscan=false;
set work_mem = 64;
SELECT count(*) FROM bmscantest WHERE a = 1 AND b = 1;
SELECT count(*) FROM bmscantest WHERE a = 1 OR b = 1;
DROP TABLE bmscantest;
