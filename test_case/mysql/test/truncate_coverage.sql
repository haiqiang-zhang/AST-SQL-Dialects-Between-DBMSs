--

--source include/have_debug_sync.inc
SET DEBUG_SYNC='RESET';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (1);
let $ID= `SELECT @id := CONNECTION_ID()`;
SET DEBUG_SYNC='mdl_upgrade_lock SIGNAL waiting';
SET DEBUG_SYNC='now WAIT_FOR waiting';
let $invisible_assignment_in_select = `SELECT @id := $ID`;
DROP TABLE t1;
SET DEBUG_SYNC='RESET';
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
let $ID= `SELECT @id := CONNECTION_ID()`;
SET DEBUG_SYNC='mdl_acquire_lock_wait SIGNAL waiting';
SET DEBUG_SYNC='now WAIT_FOR waiting';
let $invisible_assignment_in_select = `SELECT @id := $ID`;
DROP TABLE t1;
SET DEBUG_SYNC='RESET';
