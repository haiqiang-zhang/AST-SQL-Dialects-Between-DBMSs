
-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

--echo --
--echo -- Bug #22876 Four-way deadlock
--echo --

--disable_warnings
DROP TABLE IF EXISTS t1;
set @@autocommit=0;
CREATE TABLE t1(s1 INT UNIQUE) ENGINE=innodb;
INSERT INTO t1 VALUES (1);
set @@autocommit=0;
INSERT INTO t1 VALUES (2);
set @@autocommit=0;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.innodb_trx
  WHERE trx_query = 'INSERT INTO t1 VALUES (1)' AND
  trx_operation_state = 'inserting' AND
  trx_state = 'LOCK WAIT';
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE info = "DROP TABLE t1" and 
  state = "Waiting for table metadata lock";
INSERT INTO t1 VALUES (2);
set @@autocommit=1;
set @@autocommit=1;
set @@autocommit=1;
drop table if exists t1;
create table t1 (c1 int primary key, c2 int, c3 int) engine=InnoDB;
insert into t1 values (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0);
update t1 set c3=c3+1 where c2=3;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c4 int";
update t1 set c3=c3+1 where c2=4;
drop table t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT) engine=innodb;
INSERT INTO t1 VALUES (1), (2), (3);
SELECT * FROM t1;
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for table metadata lock' AND info='OPTIMIZE TABLE t1';
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1, t2;
DROP VIEW IF EXISTS v2;

CREATE TABLE t1 ( f1 INTEGER ) ENGINE = innodb;
CREATE TABLE t2 ( f1 INTEGER );
CREATE VIEW v1 AS SELECT 1 FROM t1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND info = "SELECT * FROM v1";
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER VIEW v1 AS SELECT 2 FROM t2";
SELECT * FROM v1;
DROP TABLE t1, t2;
DROP VIEW v1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT PRIMARY KEY, value INT) ENGINE = InnoDB;
INSERT INTO t1 VALUES (1, 12345);
SELECT * FROM t1;
SET lock_wait_timeout=1;
ALTER TABLE t1 ADD INDEX idx(value);
ALTER TABLE t1 ADD INDEX idx(value);
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT, b VARCHAR(250), PRIMARY KEY(a,b))
  engine=innodb default charset=utf8mb3;
INSERT INTO t1 VALUES (1, 'a'), (2, 'b');

-- Check that 0 rows are affected
--enable_info
CREATE INDEX t1ba ON t1(b,a);

DROP TABLE t1;
