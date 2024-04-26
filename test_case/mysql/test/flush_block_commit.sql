
-- And it requires InnoDB

--echo -- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo -- Establish connection con1 (user=root)
connect (con1,localhost,root,,);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) ENGINE=innodb;

-- blocks COMMIT ?

BEGIN;
INSERT INTO t1 VALUES(1);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and info = "COMMIT";
SELECT * FROM t1;

-- No deadlock ?

--echo -- Switch to connection con1
connection con1;
SELECT * FROM t1 FOR UPDATE;

-- Bug#6732 FLUSH TABLES WITH READ LOCK + COMMIT hangs later FLUSH TABLES
--          WITH READ LOCK

--echo -- Switch to connection con2
connection con2;
INSERT INTO t1 VALUES(10);

-- Bug#7358 SHOW CREATE DATABASE fails if open transaction

BEGIN;
SELECT * FROM t1;
DROP TABLE t1;
