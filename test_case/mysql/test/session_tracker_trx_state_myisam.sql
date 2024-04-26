--    in which case we'll want to know its characteristics to move it:
--
--    - was START TRANSACTION "WITH CONSISTENT SNAPSHOT" used?
--
--    - was START TRANSACTION used with "READ ONLY" or "READ WRITE"?
--      (if neither was given in the statement, we won't flag either,
--      so the default will be used -- it's up to the client to
--      replicate that setting from SET TRANSACTION (i.e. GLOBAL and
--      SESSION transaction_isolation / transaction_read_only) as needed!
--
--    - was "SET TRANSACTION ISOLATION LEVEL" one-shot set for this
--      transaction?
--
--    - was "SET TRANSACTION READ [WRITE|ONLY]" one-shot used?
--
--
-- A transaction may be "explicit" (started with BEGIN WORK /
-- START TRANSACTION) or "implicit" (autocommit==0 && not in an
-- explicit transaction). A transaction of either type will end
-- when a statement causes an implicit or explicit commit.
-- In both cases, we'll see the union of any reads or writes
-- (transactional and non-transactional) that happened up to
-- that point in the transaction.
--
-- In this test, we will document various state transitions between
-- no transaction, implicit transaction, and explict transaction active.
-- We will also show that "work attached" (read/write, transactional/
-- non-transactional) as flagged as expected when a transaction is active.
-- Next, we will show that CHARACTERISTICS tracking supplies the correct
-- SQL statement or sequence of SQL statements to start a new transaction
-- with characteristics identital to that of the on-going transaction.
-- Finally, we'll explore some interesting situations -- reads within
-- a stored function, within LOCK, etc.



--echo --#######################################################################
--echo --
--echo -- set up: save settings
--echo --

SET autocommit=1;
SELECT @@session.session_track_system_variables INTO @old_track_list;
SET @track_list= CONCAT(@old_track_list, ",transaction_isolation,
                                           transaction_read_only");
SET SESSION session_track_system_variables=@track_list;

SELECT @@session.session_track_state_change INTO @old_track_enable;
SET SESSION session_track_state_change=TRUE;

SELECT @@session.session_track_transaction_info INTO @old_track_tx;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";
INSERT INTO t1 VALUES(1);
SELECT 1 FROM DUAL;
DELETE FROM t1;
SET @x=UUID();
SET @x=1;
SELECT 1 FROM DUAL;
SELECT 1 FROM DUAL INTO @x;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);
INSERT INTO t1 VALUES (1);
SELECT f1 FROM t1;
SELECT f1 FROM t2;
	
-- ROLLBACK will throw "couldn't roll back some tables" here.
-- Prevent an implicit, hidden "SHOW WARNINGS" here that would
-- lead to an extra result set, and thereby to a hidden state edge
-- (and a seemingly nonsensical logged change from TX_EMPTY to TX_EMPTY).
ROLLBACK;
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
SET autocommit=0;
	
SET @x=UUID();
SET @x=1;
SET @x=UUID();
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO t1 VALUES(1);
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO t1 VALUES(3);
DROP TABLE t1;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT 1 FROM DUAL;
SELECT 1 FROM DUAL INTO @dummy;
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";
SELECT f1 FROM t2;
DROP TABLE t2;
SET autocommit=1;
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";

	
-- COMMIT clears state, table write is not recorded as outside transaction,
-- then transaction start is recorded:
delimiter |;
DROP TABLE t2;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";


-- COMMIT clears state, table write is not recorded as outside transaction,
-- then transaction start is recorded, finally a write is added:
delimiter |;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
CREATE PROCEDURE proc1()
BEGIN
  SET @dummy = 0;
  IF (SELECT f1 FROM t1) THEN
    SET @dummy = 1;
  END IF;
CREATE PROCEDURE proc2()
BEGIN
  CALL proc1();
  UPDATE t1 SET f1=4;
CREATE PROCEDURE proc3()
BEGIN
  DECLARE x CHAR(36);
  SET x=UUID();
CREATE PROCEDURE proc4(x CHAR(36))
BEGIN
END|
CREATE PROCEDURE proc5()
BEGIN
  SELECT f1 FROM t1;
  SELECT f1 FROM t2;
CREATE PROCEDURE proc6a()
BEGIN
  IF (SELECT f1 FROM t1) THEN
    SET @dummy = 1;
  END IF;
  ALTER TABLE t1 ADD COLUMN f2 INT;
  IF (SELECT f1 FROM t2) THEN
    SET @dummy = 1;
  END IF;
CREATE PROCEDURE proc6b()
BEGIN
  SELECT f1 FROM t1;
  ALTER TABLE t1 ADD COLUMN f3 INT;
  SELECT f1 FROM t2;
CREATE PROCEDURE proc7(x INT)
BEGIN
  SELECT f1   FROM t1;
  SELECT f1*2 FROM t1;
CREATE PROCEDURE proc8(x INT)
BEGIN
  SELECT f1   FROM t1;
  IF (SELECT f1 FROM t2) THEN
    SET @dummy = 1;
  END IF;
CREATE PROCEDURE proc9(x INT)
BEGIN
  SELECT f1   FROM t1;
  IF (SELECT f1 FROM t1) THEN
    SET @dummy = 1;
  END IF;
SET autocommit=0;
SELECT 1 FROM DUAL;
SET autocommit=1;
SELECT 1 FROM DUAL;
DROP PROCEDURE proc1;
DROP PROCEDURE proc2;
DROP PROCEDURE proc3;
DROP PROCEDURE proc4;
DROP PROCEDURE proc5;
DROP PROCEDURE proc6a;
DROP PROCEDURE proc6b;
DROP PROCEDURE proc7;
DROP PROCEDURE proc8;
DROP PROCEDURE proc9;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";
	
-- CONVERT_TZ() accesses a transactional system table in an attached
-- transaction. This is an implementation detail / artifact that does
-- not concern the user transaction, so we hide it (as we do all state
-- from attached transactions).
SELECT CONVERT_TZ('2004-01-01 12:00:00','GMT','MET');
DROP TABLE t2;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
CREATE TABLE t2 (f1 INT) ENGINE="MyISAM";
SET autocommit=0;
SELECT 1  FROM DUAL;
SELECT f1 FROM t1;
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
SELECT f1 FROM t1;
SET TRANSACTION READ ONLY;
SET TRANSACTION READ WRITE;
SET autocommit=1;
INSERT INTO t2 VALUES (3);
INSERT INTO t1 VALUES (3);
SELECT f1 FROM t1 WHERE f1 > 2;
SET SESSION session_track_transaction_info="CHARACTERISTICS";
INSERT INTO t1 VALUES (3);
SELECT f1 FROM t1 WHERE f1 > 2;
SET session_track_transaction_info="STATE";
DROP TABLE t1;
DROP TABLE t2;

SET SESSION session_track_system_variables= @old_track_list;
SET SESSION session_track_state_change=@old_track_enable;
SET SESSION session_track_transaction_info=@old_track_tx;
