
-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

-- Clean up resources used in this test case.
--disable_warnings
SET DEBUG_SYNC= 'RESET';
CREATE FUNCTION f1() RETURNS INT RETURN 1;
SELECT f1();
SET DEBUG_SYNC= 'before_execute_sql_command SIGNAL before WAIT_FOR changed';
SET DEBUG_SYNC= 'now WAIT_FOR before';
DROP FUNCTION f1;
CREATE FUNCTION f1() RETURNS INT RETURN 2;
SET DEBUG_SYNC= 'now SIGNAL changed';
DROP FUNCTION f1;
SET DEBUG_SYNC= 'RESET';
DROP FUNCTION IF EXISTS f1;
CREATE FUNCTION f1() RETURNS INT RETURN 0;
SET DEBUG_SYNC= 'after_wait_locked_pname SIGNAL locked WAIT_FOR issued';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for stored function metadata lock' 
  AND info='SHOW OPEN TABLES WHERE f1()=0';
SET DEBUG_SYNC= 'now SIGNAL issued';
DROP FUNCTION f1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t0 (b INTEGER);
CREATE TABLE t1 (a INTEGER);
CREATE FUNCTION f1(b INTEGER) RETURNS INTEGER RETURN 1;
CREATE PROCEDURE p1() SELECT COUNT(f1(a)) FROM t1, t0;

INSERT INTO t0 VALUES(1);
INSERT INTO t1 VALUES(1), (2);

SET DEBUG_SYNC= 'after_open_table_mdl_shared SIGNAL locked_t1 WAIT_FOR go_for_t0';
SET DEBUG_SYNC= 'now WAIT_FOR locked_t1';
SET DEBUG_SYNC= 'mdl_acquire_lock_wait SIGNAL go_for_t0';
DROP PROCEDURE p1;
DROP FUNCTION f1;
DROP TABLES t0, t1;

--
-- Bug#22700385 - MDL ON STORED ROUTINES IS CASE SENSITIVE EVEN IF ROUTINE NAMES
--                ARE INSENSITIVE
--

--enable_connect_log

--echo -- Case 1: Test case to verify MDL locking from concurrent SELECT and
--echo --         DROP FUNCTION operation with case & access insensitive routine
--echo --         name.

CREATE FUNCTION mIxEdCaSe() RETURNS INT RETURN 1;
SET DEBUG_SYNC='after_shared_lock_pname SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'DROP FUNCTION mixedcase' AND
                     state='Waiting for stored function metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';
CREATE FUNCTION mIxEdCaSe() RETURNS INT RETURN 1;
SET DEBUG_SYNC='after_acquiring_mdl_lock_on_routine SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'SHOW CREATE FUNCTION%' AND
                     state='Waiting for stored function metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';
CREATE FUNCTION mIxEdCaSe() RETURNS INT RETURN 1;
SET DEBUG_SYNC='after_acquiring_mdl_lock_on_routine SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'ALTER FUNCTION mixedcase%' AND
                     state='Waiting for stored function metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';
CREATE PROCEDURE mIxEdCaSe() BEGIN END;
SET DEBUG_SYNC='after_acquiring_mdl_lock_on_routine SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'SHOW CREATE PROCEDURE%' AND
                     state='Waiting for stored procedure metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';
CREATE PROCEDURE mIxEdCaSe() BEGIN END;
SET DEBUG_SYNC='after_acquiring_mdl_lock_on_routine SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'ALTER PROCEDURE mixedcase%' AND
                     state='Waiting for stored procedure metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';

-- Cleanup
--CONNECTION default
SET DEBUG_SYNC='RESET';
