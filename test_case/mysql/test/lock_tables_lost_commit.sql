

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (con1,localhost,root,,);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT) ENGINE=innodb;
INSERT INTO t1 VALUES(10);
SELECT * FROM t1;
DROP TABLE t1;
