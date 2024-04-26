--

--
-- The *huge* output of mysqlbinlog will be redirected to
-- $MYSQLTEST_VARDIR/$mysqlbinlog_output
--
--let $mysqlbinlog_output= tmp/mysqlbinlog_big_1.out

----source include/force_myisam_default.inc
--source include/have_myisam.inc
--let $engine_type= MyISAM

--
-- This test case is insensitive to the binlog format
-- because we don't display the output of mysqlbinlog.
--
----source include/have_binlog_format_row.inc

--source include/have_log_bin.inc

-- This is a big test.
--source include/big_test.inc

--echo --
--echo -- Preparatory cleanup.
--echo --
--disable_warnings
DROP TABLE IF EXISTS t1;
SET timestamp=1000000000;
let $orig_max_allowed_packet = 
query_get_value(SELECT @@global.max_allowed_packet, @@global.max_allowed_packet, 1);
SET @@global.max_allowed_packet= 1024*1024*1024;
  c1 LONGTEXT
  ) ENGINE=$engine_type DEFAULT CHARSET latin1;
INSERT INTO t1 VALUES (REPEAT('ManyMegaByteBlck', 4194304));
INSERT INTO t1 VALUES (REPEAT('ManyMegaByteBlck', 2097152));
INSERT INTO t1 VALUES (REPEAT('ManyMegaByteBlck', 262144));
INSERT INTO t1 VALUES (REPEAT('ManyMegaByteBlck', 32768));
UPDATE t1 SET c1 = CONCAT(c1, c1);
DELETE FROM t1 WHERE c1 >= 'ManyMegaByteBlck';
let $MYSQLD_DATADIR= `select @@datadir`;
DROP TABLE t1;
