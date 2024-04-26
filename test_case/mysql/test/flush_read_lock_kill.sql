
-- This test needs transactional engine as otherwise COMMIT
-- won't block FLUSH TABLES WITH GLOBAL READ LOCK.

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (con1,localhost,root,,);
DROP TABLE IF EXISTS t1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLE t1 (kill_id INT) engine = InnoDB;
INSERT INTO t1 VALUES(connection_id());
INSERT INTO t1 VALUES(connection_id());
SET DEBUG_SYNC='ha_commit_trans_after_acquire_commit_lock SIGNAL acquired WAIT_FOR go';
SET DEBUG_SYNC='now WAIT_FOR acquired';
SELECT ((@id := kill_id) - kill_id) FROM t1 LIMIT 1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock"
  and info = "flush tables with read lock";
SET DEBUG_SYNC='now SIGNAL go';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';
