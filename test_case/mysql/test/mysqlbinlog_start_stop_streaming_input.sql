
-- source include/have_binlog_format_mixed_or_statement.inc

CREATE TABLE t1 (a INT);

-- We need to set fixed timestamps in this test.
-- Use a date in the future to keep a growing timestamp along the
-- binlog (including the Start_log_event). This test will work
-- unchanged everywhere, because mysql-test-run has fixed TZ, which it
-- exports (so mysqlbinlog has same fixed TZ).
--let $datetime_1= 2031-01-01 12:00:00
eval SET TIMESTAMP= UNIX_TIMESTAMP("$datetime_1");
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(2);
INSERT INTO t1 VALUES(3);

SET TIMESTAMP= UNIX_TIMESTAMP("2034-01-01 12:00:00");
INSERT INTO t1 VALUES(4);
INSERT INTO t1 VALUES(5);
DROP TABLE t1;
