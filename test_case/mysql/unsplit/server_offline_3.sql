CREATE TABLE t2 (c1 int,c2 char(10));
INSERT INTO t2 VALUES (1,'aaaaaaaaaa');
INSERT INTO t2 VALUES (2,'bbbbbbbbbb');
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SELECT * FROM t2 ORDER BY c1;
DROP TABLE t2;
