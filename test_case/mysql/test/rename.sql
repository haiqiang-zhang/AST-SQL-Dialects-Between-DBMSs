
--
-- Test of rename table
--

--source include/count_sessions.inc

--disable_warnings
drop table if exists t0,t1,t2,t3,t4;
drop table if exists t0,t5,t6,t7,t8,t9,t1_1,t1_2,t9_1,t9_2;

create table t0 SELECT 1,"table 1";
create table t2 SELECT 2,"table 2";
create table t3 SELECT 3,"table 3";
select * from t1;
select * from t1;

-- The following should give errors
--error ER_TABLE_EXISTS_ERROR,ER_TABLE_EXISTS_ERROR
rename table t1 to t2;

select * from t1;
select * from t2;
select * from t3;

-- This should give a warning for t4
drop table if exists t1,t2,t3,t4;

--
-- Bug #2397 RENAME TABLES is not blocked by
-- FLUSH TABLES WITH READ LOCK
--

connect (con1,localhost,root,,);
CREATE TABLE t1 (a int);
CREATE TABLE t3 (a int);

-- Wait for the the tables to be renamed
-- i.e the query below succeds
let $query= select * from t2, t4;

drop table t2, t4;
create table t1(f1 int);
create view v1 as select * from t1;
alter table v1 rename to v2;
drop view v1;
drop table t1;
SET @orig_innodb_file_per_table= @@innodb_file_per_table;
SET GLOBAL innodb_file_per_table = 0;
create table t1(f1 int) engine=innodb;
drop table t1;
SET GLOBAL innodb_file_per_table = @orig_innodb_file_per_table;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
CREATE TABLE t1 (i INT);
CREATE TABLE t2 (j INT);
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE t1 (fk INT, FOREIGN KEY(fk) REFERENCES t3(pk));
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE t0 (pk INT PRIMARY KEY);
DROP TABLES t1, t3;
SELECT * FROM t4;
SET @@lock_wait_timeout= 1;
SELECT * FROM t4;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t5;
SELECT * FROM t2;
INSERT INTO t5 values (1);
SELECT * FROM t4 AS a, t4 AS b;
INSERT INTO t4 VALUES (2);
DELETE a FROM t4 AS a, t4 AS b;
DELETE b FROM t4 AS a, t4 AS b;
SELECT * FROM t2;
SELECT * FROM t4;
SET @@lock_wait_timeout= 1;
SELECT * FROM t2;
SELECT * FROM t4;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t0;
SELECT * FROM t5;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SET @@lock_wait_timeout= 1;
SELECT * FROM t5;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
CREATE TABLE t6(k INT);
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t4;
SELECT * FROM t5;
SELECT * FROM t6;
SET @@lock_wait_timeout= 1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t6;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t4;
SELECT * FROM t5;
DROP TABLES t1, t2, t6;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (j INT) ENGINE=InnoDB;
CREATE TABLE t3 (k INT) ENGINE=InnoDB;
CREATE TABLE t4 (l INT) ENGINE=InnoDB;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SELECT * FROM t0;
SELECT * FROM t4;
SET @@lock_wait_timeout= 1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM t0;
SELECT * FROM t4;
DROP TABLES t1, t2, t3, t4;
CREATE TABLE t1 (i INT);
CREATE TABLE t2 (j INT);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
INSERT INTO v3 VALUES (1);
SELECT * FROM v1;
SET @@lock_wait_timeout= 1;
SELECT * FROM v3;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM v1;
SELECT * FROM v2;
SELECT * FROM v3;
SET @@lock_wait_timeout= 1;
SELECT * FROM v2;
SELECT * FROM v3;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SELECT * FROM v0;
DROP VIEW v2;
DROP VIEW v3;
DROP TABLES t1, t2;
CREATE TABLE t1 (pk INT PRIMARY KEY);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (pk));
INSERT INTO t2 VALUES (1);
CREATE TABLE t3 (fk INT);
CREATE TABLE t4 (pk INT NOT NULL, UNIQUE(pk));
INSERT INTO t4 VALUES (2);
DELETE FROM t1;
INSERT INTO t3 VALUES (2);
SELECT unique_constraint_name FROM information_schema.referential_constraints WHERE table_name = 't3';
SET foreign_key_checks = 0;
DROP TABLES t1, t2, t4;
SET foreign_key_checks = 1;
CREATE TABLE t1 (pk INT NOT NULL, UNIQUE(pk));
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t3 VALUES (2);
INSERT INTO t3 VALUES (3);
SELECT unique_constraint_name FROM information_schema.referential_constraints WHERE table_name = 't3';
DELETE FROM t4;
DROP TABLE t3, t4;
