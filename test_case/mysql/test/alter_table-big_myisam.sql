
-- Start the server with MyISAM as default storage engine
--source include/force_myisam_default.inc
-- Test need MyISAM to support disable key feature
--source include/have_myisam.inc
-- This test takes rather long time so let us run it only in --big-test mode
--source include/big_test.inc
-- We are using some debug-only features in this test
--source include/have_debug.inc
-- Also we are using SBR to check that statements are executed
-- in proper order.
--source include/force_binlog_format_statement.inc

--source include/count_sessions.inc

--echo --
--echo -- 1.5) ALTER TABLE RENAME which fails at the late stage for SEs
--echo --      supporting and not supporting atomic DDL.
--echo --
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (i INT) ENGINE=MyISAM;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t1 RENAME TO t3;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t1;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SELECT * FROM t3;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t2 RENAME TO t4;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t2;
SELECT * FROM t4;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t4;
DROP TABLES t1, t4;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (i INT) ENGINE=MyISAM;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t1 ADD COLUMN j INT, RENAME TO t3, ALGORITHM=INPLACE;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t1;
SELECT * FROM t3;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t2 RENAME COLUMN i TO j, RENAME TO t4, ALGORITHM=INPLACE;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t2;
SELECT * FROM t4;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t4;
DROP TABLES t1, t4;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (i INT) ENGINE=MyISAM;
CREATE DATABASE mysqltest;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t1 ADD COLUMN j INT, RENAME TO t3, ALGORITHM=COPY;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t1;
SELECT * FROM t3;
DROP TABLE t1;

SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t2 RENAME COLUMN i TO j, RENAME TO t4, ALGORITHM=COPY;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t2;
SELECT * FROM t4;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SELECT * FROM t4;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t4 RENAME COLUMN j TO i, RENAME TO mysqltest.t4, ALGORITHM=COPY;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t4;
SELECT * FROM mysqltest.t4;
SET @@lock_wait_timeout= 1;
SELECT * FROM t4;
SELECT * FROM mysqltest.t4;
ALTER DATABASE mysqltest CHARACTER SET latin1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP DATABASE mysqltest;
CREATE TABLE t1 (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t2 (fk INT) ENGINE=MyISAM;
SET @@debug='+d,injecting_fault_writing';
ALTER TABLE t2 ADD FOREIGN KEY (fk) REFERENCES t1(pk), ENGINE=InnoDB, RENAME TO t3, ALGORITHM=COPY;
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t2;
SELECT * FROM t3;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SELECT * FROM t3;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DELETE FROM t1;
DROP TABLES t3, t1;

CREATE TABLE t1(a INT) ENGINE=MyISAM;

SET debug="+d,exit_after_alter_table_before_rename";
ALTER TABLE t1 modify column a varchar(30);
SET debug="-d,exit_after_alter_table_before_rename";
SELECT COUNT(TABLE_NAME) FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME like '--sql%';
let $value=
  query_get_value(SHOW EXTENDED TABLES FROM test, Tables_in_test, 1);
let $stmt = DROP TABLE `$value`;
DROP TABLE t1;

--
-- Test for Bug#25044 ALTER TABLE ... ENABLE KEYS acquires global
--                    'opening tables' lock
--
-- ALTER TABLE ... ENABLE KEYS should not acquire LOCK_open mutex for
-- the whole its duration as it prevents other queries from execution.
--disable_warnings
drop table if exists t1, t2;
set debug_sync='RESET';
create table t1 (n1 int, n2 int, n3 int,
                key (n1, n2, n3),
                key (n2, n3, n1),
                key (n3, n1, n2));
create table t2 (i int) engine=innodb;

alter table t1 disable keys;
insert into t1 values (1, 2, 3);

-- Later we use binlog to check the order in which statements are
-- executed so let us reset it first.
reset binary logs and gtids;
set debug_sync='alter_table_enable_indexes SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
insert into t2 values (1);
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t1 values (1, 1, 1)";
set debug_sync='now SIGNAL go';

-- Clean up
drop tables t1, t2;
set debug_sync='RESET';
