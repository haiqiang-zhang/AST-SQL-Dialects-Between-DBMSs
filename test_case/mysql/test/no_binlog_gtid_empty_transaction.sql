
-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc
--source include/gtid_utils.inc

-- Clean gtid_executed so that test can execute after other tests
RESET BINARY LOGS AND GTIDS;
SET @@SESSION.GTID_NEXT = 'AUTOMATIC';

-- Verify exactly one GTID was generated
--let $gtid_step_count= 1
--let $gtid_step_only_count= 1
--source include/gtid_step_assert.inc

CREATE TABLE t1 (a INT);

CREATE PROCEDURE p1()
BEGIN
  SET @@SESSION.GTID_NEXT = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa:2';
  SET @@SESSION.GTID_NEXT = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa:3';
SET @@SESSION.GTID_NEXT = 'AUTOMATIC';

-- Verify exactly two GTIDs were generated
--let $gtid_step_count= 2
--let $gtid_step_only_count= 1
--source include/gtid_step_assert.inc
--let $gtid_step_only_count= 0

DROP TABLE t1;
DROP PROCEDURE IF EXISTS p1;
