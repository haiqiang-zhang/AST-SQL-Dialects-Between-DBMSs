-- Verify the table content
    SELECT count(*), sum(x) FROM t1;
DELETE FROM t1 WHERE x>0;
SELECT count(*), sum(x) FROM t1;
UPDATE t1 SET x=x+1;
SELECT count(*), sum(x) FROM t1;
INSERT INTO t1 SELECT x+32 FROM t1;
SELECT count(*), sum(x) FROM t1;
