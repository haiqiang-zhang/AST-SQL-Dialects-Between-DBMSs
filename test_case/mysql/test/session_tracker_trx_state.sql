
-- Skip unless --xa_detach_on_prepare as this affects session tracking output
--let $option_name = xa_detach_on_prepare
--let $option_value = 1
--source include/only_with_option.inc

--echo --
--echo -- WL#6631: Detect transaction boundaries
--echo --

--##############################################################################
-- The main functionality implemented by WL#6631 is enhanced reporting
-- on transaction state. Historically, the server has already reported
-- with a flag whether we're inside a transaction, but on one hand,
-- BEGIN..COMMIT AND CHAIN..COMMIT AND CHAIN..COMMIT AND RELEASE would
-- look like a single very long transaction to users of that flag;
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

SET SESSION session_track_transaction_info="STATE";
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
DROP TABLE t1;
SET @dummy=0;
SET autocommit=0;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
INSERT INTO t1 VALUES (1);
SELECT f1 FROM t1 LIMIT 1 INTO @dummy;
SELECT f1 FROM t1;
DROP TABLE t1;
SELECT RAND(22) INTO @dummy;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
SET TRANSACTION READ ONLY;
SET TRANSACTION READ WRITE;
SELECT RAND(22) INTO @dummy;
SET TRANSACTION READ WRITE;
INSERT INTO t1 VALUES (1);
SET TRANSACTION READ WRITE;
DROP TABLE t1;

-- change back to autocommit mode.
-- Axiom: This should reset state as the implicit transaction, if any, ends.
-- transition: implicit trx -> no trx
SET autocommit=1;
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
CREATE TABLE t2 (f1 INT) ENGINE="InnoDB";
INSERT INTO  t1 VALUES (123);
SELECT f1 FROM t1;
INSERT INTO t2 SELECT f1 FROM t1;

DROP TABLE t1;
DROP TABLE t2;

SET SESSION session_track_transaction_info="CHARACTERISTICS";

-- We can't set characteristics one-shots with an explicit transaction ongoing:
--error ER_CANT_CHANGE_TX_CHARACTERISTICS
SET TRANSACTION   READ ONLY;


-- Let's try the characteristics one-shots again, outside a transaction:
--echo -- chistics: READ ONLY
SET TRANSACTION   READ ONLY;
SET TRANSACTION              ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION   READ ONLY;
SET TRANSACTION   READ WRITE;
SET TRANSACTION              ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION   READ ONLY, ISOLATION LEVEL SERIALIZABLE;



-- Show how the characteristics one-shots interact with the session values:

SET SESSION transaction_read_only=0;
SET TRANSACTION READ ONLY;
SET TRANSACTION READ WRITE;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION READ ONLY;
SET SESSION TRANSACTION READ ONLY;
SET TRANSACTION READ ONLY;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET SESSION TRANSACTION READ ONLY;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET SESSION TRANSACTION READ WRITE;
SET TRANSACTION READ ONLY;
SET TRANSACTION READ ONLY;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET session_track_transaction_info="STATE";
SET session_track_transaction_info="CHARACTERISTICS";
CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
SET autocommit=0;
SET TRANSACTION READ ONLY;
INSERT INTO t1 VALUES(1);
SET TRANSACTION READ WRITE;
SET TRANSACTION READ ONLY;
SET TRANSACTION READ WRITE;
INSERT INTO t1 VALUES(1);
SET TRANSACTION READ WRITE;
DROP TABLE t1;

CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO t1 VALUES(1);
ALTER TABLE t1 ADD COLUMN f2 INT;
INSERT INTO t1 VALUES(2,2);
ALTER TABLE t1 ADD COLUMN f3 INT;
DROP TABLE t1;

SET autocommit=1;

-- cleanup
SET session_track_transaction_info="STATE";

CREATE TABLE t1 (f1 INT) ENGINE="InnoDB";
INSERT INTO t1 VALUES (1);
CREATE FUNCTION func1()
  RETURNS INTEGER
BEGIN
  SET @dummy = 0;
  IF (SELECT * FROM t1) THEN
    SET @dummy = 1;
  END IF;
SELECT func1();
DROP TABLE t1;
DROP FUNCTION func1;

SET @old_log_output=          @@global.log_output;
SET @old_general_log=         @@global.general_log;
SET @old_general_log_file=    @@global.general_log_file;

SET GLOBAL log_output =       'TABLE';
SET GLOBAL general_log=       'ON';
SELECT 1 FROM DUAL;
SELECT " -> ", argument FROM mysql.general_log WHERE argument LIKE '% DUAL' AND (command_type!='Prepare');

SET GLOBAL general_log_file=  @old_general_log_file;
SET GLOBAL general_log=       @old_general_log;
SET GLOBAL log_output=        @old_log_output;

CREATE TABLE t1 (f1 int) ENGINE="InnoDB";
SET SESSION session_track_transaction_info="CHARACTERISTICS";
INSERT t1 VALUES (1);
INSERT t1 VALUES (2);
SET SESSION xa_detach_on_prepare = false;
INSERT t1 VALUES (1);
INSERT t1 VALUES (2);
INSERT t1 VALUES (3);

SET SESSION session_track_transaction_info="OFF";
DROP TABLE t1;

SET SESSION session_track_system_variables= @old_track_list;
SET SESSION session_track_state_change=@old_track_enable;
SET SESSION session_track_transaction_info=@old_track_tx;
