DELETE FROM t1 WHERE a=1 or a=5;
INSERT INTO t1 SET b=repeat('a',600);
UPDATE t1 SET b=repeat('a', 800) where a=10;
INSERT INTO t1 SET b=repeat('a',400);
DELETE FROM t1 WHERE a=2 or a=6;
UPDATE t1 SET b=repeat('a', 600) where a=11;
drop table t1;
