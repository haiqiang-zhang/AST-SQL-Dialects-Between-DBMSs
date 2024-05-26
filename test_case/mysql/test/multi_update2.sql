SELECT 't2 rows before small delete', COUNT(*) FROM t1;
DELETE t1,t2 FROM t1,t2 WHERE t1.b=t2.a AND t1.a < 2;
DELETE t1,t2 FROM t1,t2 WHERE t1.b=t2.a AND t1.a < 100*1000;
DROP TABLE t1,t2;
