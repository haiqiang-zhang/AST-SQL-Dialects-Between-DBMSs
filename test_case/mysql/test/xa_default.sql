
-- Test requires --xa_detach_on_prepare
--let $option_name = xa_detach_on_prepare
--let $option_value = 1
--source include/only_with_option.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo -- Make it easier to trace connections changes
--enable_connect_log

--echo -- Simple rollback after prepare
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (10);
SELECT * FROM t1;
INSERT INTO t1 VALUES (20);
SELECT * FROM t1;
INSERT INTO t1 VALUES (30);

XA END 'testa','testb';
CREATE TABLE t2 (a INT);

--        gtrid [ , bqual [ , formatID ] ]
XA START 0x7465737462, 0x2030405060, 0xb;
INSERT INTO t1 VALUES (40);
INSERT INTO t1 VALUES (42);

XA PREPARE 'testa','testb';

XA ROLLBACK 'testa','testb';

SELECT * FROM t1;

DROP TABLE t1;


--
-- Bug#28323: Server crashed in xid cache operations
--

CREATE TABLE t1(a INT, b INT, c VARCHAR(20), PRIMARY KEY(a));
INSERT INTO t1 VALUES (1, 1, 'a');
INSERT INTO t1 VALUES (2, 2, 'b');
UPDATE t1 SET c = 'aa' WHERE a = 1;
UPDATE t1 SET c = 'bb' WHERE a = 2;
UPDATE t1 SET c = 'aa' WHERE a = 1;
SELECT COUNT(*) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT);
SET SESSION autocommit=0;
INSERT INTO t1 VALUES(1);
SET SESSION autocommit=1;
SELECT @@autocommit;
INSERT INTO t1 VALUES(1);
DROP TABLE t1;
SET SESSION autocommit=1;

--
-- Bug#44672: Assertion failed: thd->transaction.xid_state.xid.is_null()
--

XA START 'a';

--
-- Bug#45548: XA transaction without access to InnoDB tables crashes the server
--

XA START 'a';

XA START 'a';

--
-- BUG#43171 - Assertion failed: thd->transaction.xid_state.xid.is_null()
--
CREATE TABLE t1(a INT, KEY(a));
INSERT INTO t1 VALUES(1),(2);

-- Part 1: Prepare to test XA START after regular transaction deadlock
BEGIN;
UPDATE t1 SET a=3 WHERE a=1;
UPDATE t1 SET a=4 WHERE a=2;
let $conn_id= `SELECT CONNECTION_ID()`;
let $wait_timeout= 2;
let $wait_condition= SELECT 1 FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE ID=$conn_id AND STATE='Searching rows for update';
UPDATE t1 SET a=5 WHERE a=1;

-- Part 2: Prepare to test XA START after XA transaction deadlock
--connection con1
REAP;
UPDATE t1 SET a=3 WHERE a=1;
UPDATE t1 SET a=4 WHERE a=2;
let $wait_timeout= 2;
let $wait_condition= SELECT 1 FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE ID=$conn_id AND STATE='Searching rows for update';
UPDATE t1 SET a=5 WHERE a=1;

XA START 'xid1';
DROP TABLE t1;

XA START 'x';

CREATE TABLE t1(a INT, b INT, PRIMARY KEY(a));
INSERT INTO t1 VALUES (1, 1), (2, 2);
UPDATE t1 SET b= 3 WHERE a=1;
UPDATE t1 SET b=4 WHERE a=2;
UPDATE t1 SET b=6 WHERE a=2;
DROP TABLE t1;

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);

XA END 'a';
SELECT * FROM t1;
INSERT INTO t1 VALUES (2);
SET @a=(SELECT * FROM t1);

XA PREPARE 'a';
SELECT * FROM t1;
INSERT INTO t1 VALUES (2);

XA COMMIT 'a';
SELECT * FROM t1;
SET @a=(SELECT * FROM t1);
UPDATE t1 SET a=1 WHERE a=2;
DROP TABLE t1;

-- We need to create a deadlock in which xa transaction will be chosen as
-- a victim and rolled back. We will use this scenario:
-- 1. connection default obtains LOCK_X on t1 record
-- 2. connection con2 obtains LOCK_X on t2 and waits for LOCK_X on t1
-- 3. connection default tries to obtain LOCK_X on t2 which causes
--    a cycle, which is resolved by choosing con2 as a victim, because
--    default is "heavier" due to writes made in t1

CREATE TABLE t1 (a INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (a INT) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1);

-- Step 1.
DELETE FROM t1;

-- Step 2.
SELECT a FROM t2 WHERE a=1 FOR SHARE;

let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.innodb_trx
  WHERE trx_query = 'SELECT a FROM t1 WHERE a=1 FOR UPDATE' AND
  trx_operation_state = 'starting index read' AND
  trx_state = 'LOCK WAIT';

-- Step 3.
SELECT a FROM t2 WHERE a=1 FOR UPDATE;

XA END 'xid1';
DROP TABLE t1;
DROP TABLE t2;


-- Wait till all disconnects are completed
--source include/wait_until_count_sessions.inc

--echo --
--echo -- Bug#14670465 PLEASE PRINT HUMAN READABLE, ESCAPED
--echo --              XID DATA IN XA RECOVER OUTPUT
--echo --
--echo --
--echo -- xa Recover command was not diplaying non printable ASCII
--echo -- characters in the XID previosuly. Now there is another column
--echo -- in the result set which is a Hex Encoded String of the XID.
--echo --

--echo -- Check that XIDs which are not normally printable are displayed
--echo -- in readable format when CONVERT XID clause is used.
XA START 0xABCDEF1234567890, 0x01, 0x02 ;

CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);

SELECT * FROM t1;
DROP TABLE t1;

SET SESSION autocommit=0;

XA START 'xid1';

XA START 'xid1';

XA START 'xid1';

XA START 'xid1';

XA START 'xid1';

XA START 'xid1';

XA START 'xid1';
CREATE TABLE t1(i INT);
INSERT INTO t1 VALUES (1);
SET SESSION autocommit = OFF;
INSERT INTO t1 VALUES (2);

XA START 'xid4';
INSERT INTO t1 VALUES (3);
INSERT INTO t1 VALUES (4);
SELECT * FROM t1 ORDER BY i;
SET SESSION autocommit = DEFAULT;
DROP TABLE t1;
SET SESSION lock_wait_timeout=1;
CREATE TABLE asd (a INT);
INSERT INTO asd VALUES (1);
INSERT INTO asd VALUES (1);
DROP TABLE asd;

-- Finish off  disconnected survived transaction
--echo There should be practically no error, but in theory
--echo XAER_NOTA: Unknown XID can be returned if con1 disconnection
--echo took for too long.
--echo todo: consider to make this test dependent on P_S if
--echo todo: such case will be ever registered.

-- There should be no prepared transactions left.
XA RECOVER;

CREATE USER u1;

CREATE USER u2;

XA START 'xid1';
DROP USER u1, u2;
CREATE USER u1;
DROP USER u1;

SET autocommit = 0;

XA START 'xid1';

SET autocommit = 0;
SET autocommit = DEFAULT;
CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TEMPORARY TABLE temp1(i INT);
INSERT INTO temp1 VALUES (1),(2),(3);

XA START 'xa2';
CREATE TEMPORARY TABLE temp2(i INT);

XA START 'xa3';
SELECT * FROM temp1;
INSERT INTO temp1 VALUES (1),(2),(3);
DROP TEMPORARY TABLE temp1;

DROP TEMPORARY TABLE temp1;


XA START 'xa4';
SET SESSION xa_detach_on_prepare=OFF;


CREATE TABLE t1(c1 VARCHAR(128));
INSERT INTO t1 VALUES ('Inserted by xa1');
SELECT * FROM t1;
INSERT INTO t1 VALUES ('Inserted by xa2');
INSERT INTO t1 VALUES ('Inserted by xa5');
SELECT * FROM t1;
SELECT * FROM t1;
INSERT INTO t1 VALUES ('Inserted by xa6');
INSERT INTO t1 VALUES ('Inserted after prepare');
SELECT * FROM t1;
SELECT * FROM t1;
INSERT INTO t1 VALUES ('Inserted by xa7');
CREATE TABLE t2(i INT);
INSERT INTO t2 VALUES (1), (2), (3);
ALTER TABLE t2 ADD COLUMN j INT;
INSERT INTO t2 VALUES (4,4),(5,5);
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t2;
INSERT INTO t1 VALUES ('Inserted by xa8');
SET SESSION autocommit = OFF;
INSERT INTO t1 VALUES ('Inserted by normal transaction');
SELECT * FROM t1;
SET SESSION autocommit=OFF;

XA START 'xa10';
INSERT INTO t1 VALUES ('Inserted by xa10');
INSERT INTO t1 VALUES ('Inserted in savepoint s1');
INSERT INTO t1 VALUES ('Inserted by normal transaction');
SELECT * FROM t1;
INSERT INTO t1 VALUES ('Inserted by xa11');
SELECT * FROM t1;
INSERT INTO t1 VALUES ('Inserted by xa3');
SELECT object_type, object_name, lock_type, lock_duration, lock_status
FROM performance_schema.metadata_locks WHERE object_schema = 'test';
SELECT * FROM t1;
SELECT object_type, object_name, lock_type, lock_duration, lock_status
FROM performance_schema.metadata_locks WHERE object_schema = 'test';
INSERT INTO t1 VALUES ('Inserted by xa4');
SELECT object_type, object_name, lock_type, lock_duration, lock_status
FROM performance_schema.metadata_locks WHERE object_schema = 'test';
SELECT * FROM t1;
SELECT object_type, object_name, lock_type, lock_duration, lock_status
FROM performance_schema.metadata_locks WHERE object_schema = 'test';
DROP TABLE t1;
CREATE TABLE t1(d VARCHAR(128));
INSERT INTO t1 VALUES ('Row 1'), ('Row 2');
SELECT * FROM t1;
SELECT d FROM t1;

XA ROLLBACK 'xa3';
DROP TABLE t1;
CREATE USER xau;
SET xa_detach_on_prepare = OFF;
SET xa_detach_on_prepare = OFF;
SET xa_detach_on_prepare = OFF;
DROP USER xau;
CREATE TABLE t7(i INT);
INSERT INTO t7 VALUES (1),(2),(3);

XA RECOVER;
SELECT * FROM t7;
DROP TABLE t7;
CREATE TABLE t8(i INT);
INSERT INTO t8 VALUES (1),(2),(3);
SELECT * FROM t8;

XA RECOVER;
DROP TABLE t8;
