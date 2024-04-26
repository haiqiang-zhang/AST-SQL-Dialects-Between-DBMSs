--   - Stored routines
--   - Triggers
--   - Events
--   - Views
--##############################################################################

--source include/have_debug.inc
--source include/have_log_bin.inc

-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

-- Clear previous tests binlog.
--disable_query_log
reset binary logs and gtids;

SET SESSION DEBUG="+d,simulate_create_routine_failure";
CREATE PROCEDURE p() SELECT 1;
CREATE FUNCTION f() RETURNS INT return 1;
SET SESSION DEBUG="-d,simulate_create_routine_failure";
CREATE PROCEDURE p() SELECT 1;
CREATE FUNCTION f() RETURNS INT return 1;

SET SESSION DEBUG="+d,simulate_alter_routine_failure";
ALTER FUNCTION f comment "atomic DDL on routine";
ALTER PROCEDURE p comment "atomic DDL on routine";
SET SESSION DEBUG="-d,simulate_alter_routine_failure";

SET SESSION DEBUG="+d,simulate_alter_routine_xcommit_failure";
ALTER FUNCTION f comment "atomic DDL on routine";
ALTER PROCEDURE p comment "atomic DDL on routine";
SET SESSION DEBUG="-d,simulate_alter_routine_xcommit_failure";
ALTER FUNCTION f comment "atomic DDL on routine";
ALTER PROCEDURE p comment "atomic DDL on routine";

SET SESSION DEBUG="+d,simulate_drop_routine_failure";
DROP FUNCTION f;
DROP PROCEDURE p;
SET SESSION DEBUG="-d,simulate_drop_routine_failure";
DROP FUNCTION f;
DROP PROCEDURE p;

-- Clear previous tests binlog.
--disable_query_log
reset binary logs and gtids;

CREATE TABLE t1(a INT);
CREATE TRIGGER trig1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;

SET SESSION DEBUG="+d,simulate_create_trigger_failure";
CREATE TRIGGER trig2 AFTER INSERT ON t1 FOR EACH ROW BEGIN END;
SET SESSION DEBUG="-d,simulate_create_trigger_failure";
CREATE TRIGGER trig2 AFTER INSERT ON t1 FOR EACH ROW BEGIN END;

SET SESSION DEBUG="+d,simulate_drop_trigger_failure";
DROP TRIGGER trig2;
SET SESSION DEBUG="-d,simulate_drop_trigger_failure";
DROP TRIGGER trig2;

DROP TABLE t1;

-- Clear previous tests binlog.
--disable_query_log
reset binary logs and gtids;

SET SESSION DEBUG="+d,simulate_create_event_failure";
CREATE EVENT event1 ON SCHEDULE EVERY 1 YEAR DO SELECT 1;
SET SESSION DEBUG="-d,simulate_create_event_failure";
CREATE EVENT event1 ON SCHEDULE EVERY 1 YEAR DO SELECT 1;
CREATE EVENT IF NOT EXISTS event1 ON SCHEDULE EVERY 1 YEAR DO SELECT 1;

SET SESSION DEBUG="+d,simulate_alter_event_failure";
ALTER EVENT event1 COMMENT "Atomic Event's DDL";
SET SESSION DEBUG="-d,simulate_alter_event_failure";
ALTER EVENT event1 COMMENT "Atomic Event's DDL";
SET SESSION DEBUG="+d,simulate_drop_event_failure";
DROP EVENT event1;
DROP EVENT IF EXISTS event1;
SET SESSION DEBUG="-d,simulate_drop_event_failure";
DROP EVENT event1;
DROP EVENT IF EXISTS event1;

-- Clear previous tests binlog.
--disable_query_log
reset binary logs and gtids;

CREATE VIEW v1 AS SELECT 1;
CREATE VIEW v2 AS SELECT * FROM v1;
DROP VIEW v1;

SET SESSION DEBUG="+d,simulate_create_view_failure";
CREATE VIEW v1 AS SELECT 1;
SET SESSION DEBUG="-d,simulate_create_view_failure";
CREATE VIEW v1 AS SELECT 1;

SET SESSION DEBUG="+d,simulate_create_view_failure";
ALTER VIEW v1 AS SELECT 1 as a1, 2 AS a2;
SET SESSION DEBUG="-d,simulate_create_view_failure";
ALTER VIEW v1 AS SELECT 1 as a1, 2 AS a2;

SET SESSION DEBUG="+d,simulate_drop_view_failure";
DROP VIEW v1;
SET SESSION DEBUG="-d,simulate_drop_view_failure";
DROP VIEW v1;
DROP VIEW IF EXISTS v1;

CREATE VIEW v3 AS SELECT 1;
CREATE VIEW v4 AS SELECT 1;
CREATE TABLE t1(f1 int);
DROP VIEW t1, v3, v4;
DROP VIEW IF EXISTS v3, v4, v5;
DROP VIEW v2;
DROP TABLE t1;

-- Clear previous tests binlog.
--disable_query_log
reset binary logs and gtids;

SET @orig_lock_wait_timeout= @@global.lock_wait_timeout;
SET GLOBAL lock_wait_timeout= 1;

CREATE TABLE t1(f1 INT);
CREATE FUNCTION f() RETURNS INT return 1;
CREATE VIEW v1 AS SELECT 2 as f2;
CREATE VIEW v2 AS SELECT f() as f1, v1.f2 FROM v1;
SET DEBUG_SYNC="rm_table_no_locks_before_delete_table SIGNAL drop_func WAIT_FOR go";
SET DEBUG_SYNC="now WAIT_FOR drop_func";
DROP FUNCTION f;
DROP VIEW v1;
SET DEBUG_SYNC="now SIGNAL go";
DROP VIEW v1;
SET DEBUG_SYNC='after_acquiring_mdl_lock_on_routine SIGNAL drop_view WAIT_FOR go';
SET DEBUG_SYNC='now WAIT_FOR drop_view';
CREATE VIEW v1 AS SELECT 2 as f2;
SET DEBUG_SYNC="now SIGNAL go";
CREATE VIEW v1 AS SELECT 2 as f2;

-- connection default;
CREATE FUNCTION f() RETURNS INT return 1;

-- Cleanup
connection default;
SET DEBUG_SYNC='RESET';
DROP VIEW v1, v2;
SET GLOBAL lock_wait_timeout= @orig_lock_wait_timeout;
CREATE FUNCTION f1() RETURNS INT return 1;

SET SESSION DEBUG='+d,fail_while_acquiring_dd_object';
CREATE FUNCTION f1() RETURNS INT return 1;
ALTER FUNCTION f1 COMMENT "wl9173";
CREATE VIEW v1 AS SELECT 1;
DROP VIEW v1;
SET SESSION DEBUG='-d,fail_while_acquiring_dd_object';
DROP FUNCTION f1;

SET SESSION DEBUG='+d,fail_while_acquiring_routine_schema_obj';
CREATE FUNCTION f1() RETURNS INT return 1;
SET SESSION DEBUG='-d,fail_while_acquiring_routine_schema_obj';

CREATE VIEW v1 AS SELECT 2 as f2;
SET SESSION DEBUG='+d,fail_while_acquiring_view_obj';
DROP VIEW v1;
SET SESSION DEBUG='-d,fail_while_acquiring_view_obj';
DROP VIEW v1;
CREATE FUNCTION f1() RETURNS INT return 1;
SET DEBUG='+d,fail_while_dropping_dd_object';
DROP FUNCTION f1;
SET DEBUG='-d,fail_while_dropping_dd_object';
DROP FUNCTION f1;
