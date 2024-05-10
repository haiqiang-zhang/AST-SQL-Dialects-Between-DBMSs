CREATE DATABASE mysqldump_long_query_time;
CREATE TABLE t1 (i int, c char(255));
INSERT INTO t1 VALUES (0, lpad('a', 250, 'b'));
INSERT INTO t1 SELECT i+1,c FROM t1;
INSERT INTO t1 SELECT i+2,c FROM t1;
INSERT INTO t1 SELECT i+4,c FROM t1;
INSERT INTO t1 SELECT i+8,c FROM t1;
INSERT INTO t1 SELECT i+16,c FROM t1;
DROP DATABASE mysqldump_long_query_time;
