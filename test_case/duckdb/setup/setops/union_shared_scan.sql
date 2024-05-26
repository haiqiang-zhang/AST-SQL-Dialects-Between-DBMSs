PRAGMA threads=4;
PRAGMA verify_parallelism;
CREATE TABLE tbl AS SELECT * FROM range(10000) tbl(i) UNION ALL SELECT NULL;
