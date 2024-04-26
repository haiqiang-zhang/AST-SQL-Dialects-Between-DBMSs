
-- Also we are using SBR to check that statements are executed
-- in proper order.
--source include/force_binlog_format_statement.inc

--source include/count_sessions.inc

--
-- Additional coverage for the main ALTER TABLE case
--
-- We should be sure that table being altered is properly
-- locked during statement execution and in particular that
-- no DDL or DML statement can sneak in and get access to
-- the table when real operation has already taken place
-- but this fact has not been noted in binary log yet.
--disable_warnings
drop table if exists t1, t2, t3;
create table t1 (i int);
set debug_sync='alter_table_before_main_binlog SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t1 values ()";
set debug_sync='now SIGNAL go';
select * from t1;
set debug_sync='alter_table_before_main_binlog SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "rename table t1 to t2";
set debug_sync='now SIGNAL go';
drop table t2;
create table t1 (i int);
set debug_sync='alter_table_before_main_binlog SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
           info = "insert into t2 values()";
set debug_sync='now SIGNAL go';
select * from t2;
drop table t3;
set debug_sync='alter_table_before_main_binlog SIGNAL parked WAIT_FOR go';
set debug_sync='RESET';

-- Check that all statements were logged in correct order
source include/show_binlog_events.inc;
create temporary table t1 (i int) engine=innodb;
set debug= "+d,mysql_lock_tables_kill_query";
alter table t1 add index (i);
set debug= "-d,mysql_lock_tables_kill_query";
SET @old_lock_wait_timeout= @@lock_wait_timeout;
CREATE TABLE t1 (i INT);
ALTER TABLE t1 RENAME TO t2;
SELECT * FROM t2;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t1;
CREATE TABLE t1 (i INT);
ALTER TABLE t2 RENAME TO t3;
SELECT * FROM t1;
INSERT INTO t3 values (1);
ALTER TABLE t3 RENAME TO t4;
SELECT * FROM t4 AS a, t4 AS b;
INSERT INTO t4 VALUES (2);
DELETE a FROM t4 AS a, t4 AS b;
DELETE b FROM t4 AS a, t4 AS b;
DROP TABLES t1, t4;
CREATE TABLE t1 (i INT);
CREATE DATABASE mysqltest;
ALTER TABLE t1 RENAME TO mysqltest.t1;
SELECT * FROM mysqltest.t1;
SET @@lock_wait_timeout= 1;
SELECT * FROM mysqltest.t1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t1;
SET @@lock_wait_timeout= 1;
ALTER DATABASE mysqltest CHARACTER SET latin1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP DATABASE mysqltest;
CREATE TABLE t1 (i INT);
ALTER TABLE t1 ADD COLUMN j INT, RENAME TO t2, ALGORITHM=INPLACE;
SELECT * FROM t2;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t1;
CREATE TABLE t1 (i INT);
ALTER TABLE t2 ADD COLUMN k INT, RENAME TO t3, ALGORITHM=INPLACE;
SELECT * FROM t1;
INSERT INTO t3 values (1, 2, 3);
ALTER TABLE t3 ADD COLUMN l INT, RENAME TO t4, ALGORITHM=INPLACE;
SELECT * FROM t4 AS a, t4 AS b;
INSERT INTO t4 VALUES (2, 3, 4, 5);
DELETE a FROM t4 AS a, t4 AS b;
DELETE b FROM t4 AS a, t4 AS b;
DROP TABLES t1, t4;
CREATE TABLE t1 (i INT);
CREATE DATABASE mysqltest;
ALTER TABLE t1 ADD COLUMN k INT, RENAME TO mysqltest.t1, ALGORITHM=INPLACE;
SELECT * FROM mysqltest.t1;
SET @@lock_wait_timeout= 1;
SELECT * FROM mysqltest.t1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t1;
SET @@lock_wait_timeout= 1;
ALTER DATABASE mysqltest CHARACTER SET latin1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP DATABASE mysqltest;
CREATE TABLE t1 (i INT);
ALTER TABLE t1 ADD COLUMN j INT, RENAME TO t2, ALGORITHM=COPY;
SELECT * FROM t2;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t1;
CREATE TABLE t1 (i INT);
ALTER TABLE t2 ADD COLUMN k INT, RENAME TO t3, ALGORITHM=COPY;
SELECT * FROM t1;
INSERT INTO t3 values (1, 2, 3);
ALTER TABLE t3 ADD COLUMN l INT, RENAME TO t4, ALGORITHM=COPY;
SELECT * FROM t4 AS a, t4 AS b;
INSERT INTO t4 VALUES (2, 3, 4, 5);
DELETE a FROM t4 AS a, t4 AS b;
DELETE b FROM t4 AS a, t4 AS b;
DROP TABLES t1, t4;
CREATE TABLE t1 (i INT);
CREATE DATABASE mysqltest;
ALTER TABLE t1 ADD COLUMN k INT, RENAME TO mysqltest.t1, ALGORITHM=COPY;
SELECT * FROM mysqltest.t1;
SET @@lock_wait_timeout= 1;
SELECT * FROM mysqltest.t1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t1;
SET @@lock_wait_timeout= 1;
ALTER DATABASE mysqltest CHARACTER SET latin1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP DATABASE mysqltest;
