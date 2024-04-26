
-- Clean gtid_executed so that test can execute after other tests
RESET BINARY LOGS AND GTIDS;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 (a INT PRIMARY KEY);

CREATE TRIGGER trigger_1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;
SET DEBUG_SYNC='trigger_ddl_stmt_before_write_to_binlog SIGNAL drop_trigger_ready_to_write_to_binlog WAIT_FOR second_create_trigger_end';

SET @start_session_value= @@session.lock_wait_timeout;
SET @@session.lock_wait_timeout= 1;
SET DEBUG_SYNC='now WAIT_FOR drop_trigger_ready_to_write_to_binlog';

-- We deliberately consider both cases -- success and failure
-- with error code ER_LOCK_WAIT_TIMEOUT. First case takes place
-- for the server without mdl locking for trigger name,
-- the second one is for case when mdl lock for trigger name is acquired.
--error 0,ER_LOCK_WAIT_TIMEOUT
CREATE TRIGGER trigger_1 BEFORE INSERT ON t2 FOR EACH ROW BEGIN END;
SET DEBUG_SYNC='now SIGNAL second_create_trigger_end';

DROP TABLE t1,t2;

CREATE TABLE t1 (a INT);
SET DEBUG_SYNC='create_trigger_has_acquired_mdl SIGNAL trigger_creation_cont WAIT_FOR second_create_trigger_wait_on_lock';
SET DEBUG_SYNC='now WAIT_FOR trigger_creation_cont';

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con2_id;

SET DEBUG_SYNC='now SIGNAL second_create_trigger_wait_on_lock';

-- Mask a value of the column Created to make test reproducible
--replace_column 6 --
SHOW TRIGGERS LIKE 't1';

DROP TABLE t1;

CREATE TABLE t1 (a INT);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;
SET lock_wait_timeout = 1;

SET DEBUG_SYNC='drop_trigger_has_acquired_mdl SIGNAL drop_trigger_took_mdl WAIT_FOR drop_trigger_cont';

SET DEBUG_SYNC='now WAIT_FOR drop_trigger_took_mdl';
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;

SET DEBUG_SYNC='now SIGNAL drop_trigger_cont';
DROP TABLE t1;
SET NAMES utf8mb3;
CREATE TABLE t1 (f1 INT);

CREATE TRIGGER cafe BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
SET DEBUG_SYNC='after_acquiring_mdl_lock_on_trigger SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'DROP TRIGGER%' AND
                     state LIKE 'Waiting for % metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';
CREATE TRIGGER cafe BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
SET DEBUG_SYNC='after_acquiring_mdl_lock_on_trigger SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'SHOW CREATE TRIGGER%' AND
                     state LIKE 'Waiting for % metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';
DROP TABLE t1;
SET NAMES default;

-- Restore original value for lock_wait_timeout
SET @@session.lock_wait_timeout= @start_session_value;
