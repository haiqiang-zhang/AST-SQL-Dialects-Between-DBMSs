
--
-- Test of flush table
--

--disable_warnings
drop table if exists t1,t2;
create table t1 (a int not null auto_increment primary key);
insert into t1 values(0);

-- Test for with read lock + flush

lock table t1 read;

-- Test for with write lock + flush

lock table t1 write;

-- Test for with a write lock and a waiting read lock + flush

lock table t1 write;
select * from t1;

-- Test for with a write lock and a waiting write lock + flush

lock table t1 write;
select * from t1;
select * from t1;
drop table t1;

--
-- In the following test FLUSH TABLES produces a deadlock
-- (hang forever) if the fix for BUG #3565 is missing.
-- And it shows that handler tables are re-opened after flush (BUG #4286).
--
create table t1(table_id char(20) primary key);
create table t2(table_id char(20) primary key);
insert into t1 values ('test.t1');
insert into t1 values ('');
insert into t2 values ('test.t2');
insert into t2 values ('');
drop table t1;
drop table t2;

--
-- The fix for BUG #4286 cannot restore the position after a flush.
--
create table t1(table_id char(20) primary key);
insert into t1 values ('Record-01');
insert into t1 values ('Record-02');
insert into t1 values ('Record-03');
insert into t1 values ('Record-04');
insert into t1 values ('Record-05');
drop table t1;

--
-- Bug #11934 Two sequential FLUSH TABLES WITH READ LOCK hangs client
--
FLUSH TABLES WITH READ LOCK ;

-- End of 4.1 tests

--echo
--echo --
--echo -- WL#6168: FLUSH TABLES ... FOR EXPORT -- parser
--echo --
--echo

--echo -- Requires innodb_file_per_table
SET @old_innodb_file_per_table= @@GLOBAL.innodb_file_per_table;
SET GLOBAL innodb_file_per_table= 1;

SET @export = 10;

CREATE PROCEDURE p1(export INT) BEGIN END;
DROP PROCEDURE p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE export INT;
DROP PROCEDURE p1;

CREATE PROCEDURE export() BEGIN END;
DROP PROCEDURE export;


CREATE TABLE t1 (i INT) engine=InnoDB;
CREATE TABLE t2 LIKE t1;

DROP TABLES t1, t2;

CREATE TABLE export (i INT) engine=InnoDB;

DROP TABLE export;

CREATE VIEW v1 AS SELECT 1;
CREATE TEMPORARY TABLE t1 (a INT);

DROP TEMPORARY TABLE t1;
DROP VIEW v1;

CREATE TABLE t1 (a INT PRIMARY KEY, b INT) engine= InnoDB;
CREATE TABLE t2 (a INT) engine= InnoDB;
INSERT INTO t1 VALUES (1, 1);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH TABLES t1 FOR EXPORT";
INSERT INTO t2 VALUES (1);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "INSERT INTO t1 VALUES (2, 2)";
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER TABLE t1 ADD INDEX i1(b)";
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH TABLE t1 FOR EXPORT";
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "DROP TABLE t1";
DROP TABLE t2;

CREATE TABLE t1(a INT) engine= InnoDB;
DROP TABLE t1;

CREATE DATABASE db1;
CREATE TABLE db1.t1 (a INT) engine= InnoDB;
CREATE USER user1@localhost, user2@localhost,
            user3@localhost, user4@localhost,
            user5@localhost;
DROP USER user1@localhost, user2@localhost, user3@localhost,
          user4@localhost, user5@localhost;
DROP TABLE db1.t1;
DROP DATABASE db1;

CREATE TABLE t1 (a INT) engine= InnoDB;
CREATE TABLE t2 (a INT) engine= InnoDB;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH TABLE t1 FOR EXPORT";
DROP TABLE t1, t2;

CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
DROP TABLE t1;
CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
INSERT INTO t1 VALUES (100),(200);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH LOCAL TABLES t1 FOR EXPORT";
SELECT * FROM t1 ORDER BY i;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "FLUSH NO_WRITE_TO_BINLOG TABLES test.t1 FOR EXPORT";
SELECT * FROM t1 ORDER BY i;
DROP TABLE t1;
CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
INSERT INTO t1 VALUES (100),(200);
INSERT INTO t1 VALUES (300);
SELECT * FROM t1 ORDER BY i;
INSERT INTO t1 VALUES (400);
SELECT * FROM t1 ORDER BY i;
DROP TABLE t1;
CREATE TABLE t1 ( i INT ) ENGINE = Innodb;
DROP TABLE t1;
SET GLOBAL innodb_file_per_table= @old_innodb_file_per_table;
