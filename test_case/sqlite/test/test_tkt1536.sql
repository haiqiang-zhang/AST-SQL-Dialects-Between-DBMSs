SELECT typeof(a), typeof(b) FROM t1;
INSERT INTO t1(b) SELECT b FROM t1;
SELECT b FROM t1 WHERE rowid=2;
