-- Construct a table with many rows of data
    CREATE TABLE t1(x);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(2);
INSERT INTO t1 SELECT x+2 FROM t1;
INSERT INTO t1 SELECT x+4 FROM t1;
INSERT INTO t1 SELECT x+8 FROM t1;
INSERT INTO t1 SELECT x+16 FROM t1;
-- Verify the table content
    SELECT count(*), sum(x) FROM t1;
DELETE FROM t1 WHERE x>0;
SELECT count(*), sum(x) FROM t1;
UPDATE t1 SET x=x+1;
SELECT count(*), sum(x) FROM t1;
INSERT INTO t1 SELECT x+32 FROM t1;
SELECT count(*), sum(x) FROM t1;
