CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);
SELECT CONVERT_TZ(a, a, a) FROM t1;
DROP TABLE t1;
SELECT @@SYSTEM_TIME_ZONE;
SELECT @@SYSTEM_TIME_ZONE;
