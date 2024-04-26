
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--disable_warnings
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) ENGINE=innodb;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;

DELETE FROM t1;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1 VALUES(1);
SELECT * FROM t1;
DROP TABLE t1;
