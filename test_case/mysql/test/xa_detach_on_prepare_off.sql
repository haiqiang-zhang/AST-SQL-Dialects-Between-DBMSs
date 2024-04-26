--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
--let $CURGLOB_xa_detach_on_prepare = `SELECT @@GLOBAL.xa_detach_on_prepare`
--let $CURSESS_xa_detach_on_prepare = `SELECT @@SESSION.xa_detach_on_prepare`
SET GLOBAL xa_detach_on_prepare = false;
SET SESSION xa_detach_on_prepare = false;
drop table if exists t1, t2;
create table t1 (a int) engine=innodb;
insert t1 values (10);
select * from t1;

xa start 'test2';
insert t1 values (20);
select * from t1;

xa start 'testa','testb';
insert t1 values (30);

xa end 'testa','testb';
create table t2 (a int);

--        gtrid [ , bqual [ , formatID ] ]
xa start 0x7465737462, 0x2030405060, 0xb;
insert t1 values (40);

-- uncomment the line below when binlog will be able to prepare
--disconnect con1;

xa prepare 'testa','testb';

-- When this connection has already started an own XA transaction
-- it cannot execute XA COMMIT for another XA.
--error ER_XAER_RMFAIL
xa commit 'testb',0x2030405060,11;

-- "Foreign" XA is not in an allowed state to be committed
--error ER_XAER_NOTA
xa commit 'testb',0x2030405060,11;

select * from t1;

xa recover;
drop table t1;

--
-- Bug#28323: Server crashed in xid cache operations
--

--disable_warnings
drop table if exists t1;

create table t1(a int, b int, c varchar(20), primary key(a)) engine = innodb;
insert into t1 values(1, 1, 'a');
insert into t1 values(2, 2, 'b');
update t1 set c = 'aa' where a = 1;
update t1 set c = 'bb' where a = 2;
update t1 set c = 'aa' where a = 1;
select count(*) from t1;
drop table t1;
CREATE TABLE t1(a INT) ENGINE=InnoDB;
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

xa start 'a';

--
-- Bug#45548: XA transaction without access to InnoDB tables crashes the server
--

xa start 'a';

xa start 'a';

--
-- BUG#43171 - Assertion failed: thd->transaction.xid_state.xid.is_null()
--
CREATE TABLE t1(a INT, KEY(a)) ENGINE=InnoDB;
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
connection con1;
UPDATE t1 SET a=3 WHERE a=1;
UPDATE t1 SET a=4 WHERE a=2;
let $wait_timeout= 2;
let $wait_condition= SELECT 1 FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE ID=$conn_id AND STATE='Searching rows for update';
UPDATE t1 SET a=5 WHERE a=1;

XA START 'xid1';
DROP TABLE t1;

XA START 'x';
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT, b INT, PRIMARY KEY(a)) engine=InnoDB;
INSERT INTO t1 VALUES (1, 1), (2, 2);
UPDATE t1 SET b= 3 WHERE a=1;
UPDATE t1 SET b=4 WHERE a=2;
UPDATE t1 SET b=6 WHERE a=2;
DROP TABLE t1;

CREATE TABLE t1 (a INT) engine=InnoDB;
INSERT INTO t1 VALUES (1);

XA END 'a';
SELECT * FROM t1;
INSERT INTO t1 VALUES (2);
SET @a=(SELECT * FROM t1);

XA PREPARE 'a';
SELECT * FROM t1;
INSERT INTO t1 VALUES (2);
SET @a=(SELECT * FROM t1);
UPDATE t1 SET a=1 WHERE a=2;

XA COMMIT 'a';
SELECT * FROM t1;
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
xa start 0xABCDEF1234567890, 0x01, 0x02 ;

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
set session lock_wait_timeout=1;
create table asd (a int);
insert into asd values(1);
insert into asd values(1);
drop table asd;

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
CREATE TABLE t1 (a INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
