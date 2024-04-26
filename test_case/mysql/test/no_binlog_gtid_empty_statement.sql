--

-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc

USE test;

-- With anonymous GTIDs
--source include/set_gtid_next.inc
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;

-- Sets GTID_MODE to ON for the second part of the test
--let $rpl_gtid_mode= ON
--let $rpl_set_enforce_gtid_consistency= 1
--let $rpl_server_numbers= 1
--let $rpl_skip_sync= 1
--source include/rpl_set_gtid_mode.inc

-- Just in case that the server has some GTID_EXECUTED
SET GTID_NEXT='AUTOMATIC';

-- With non-anonymous GTIDs
--source include/set_gtid_next.inc
CREATE TABLE t2 (c1 INT);
INSERT INTO t2 VALUES (1);
DROP TABLE t2;

-- Cleanup
SET GTID_NEXT='AUTOMATIC';
