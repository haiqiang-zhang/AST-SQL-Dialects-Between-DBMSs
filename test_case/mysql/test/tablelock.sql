
--
-- Test of lock tables
--

--disable_warnings
drop table if exists t1,t2;

create table t1 ( n int auto_increment primary key);
insert into t1 values(NULL);
insert into t1 values(NULL);
insert into t1 values(NULL);
insert into t1 values(NULL);
insert into t1 values(NULL);
insert into t1 values(NULL);
drop table t1;

--
-- Test of locking and delete of files
--

CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
drop table t1,t2;

CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
drop table t2,t1;

-- End of 4.1 tests

--
-- Bug#23588 SHOW COLUMNS on a temporary table causes locking issues
--
create temporary table t1(f1 int);
insert into t1 values (1);
insert into t1 values(2);
drop table t1;

-- End of 5.0 tests

--echo --
--echo -- Bug#19988193 ASSERTION `(*TABLES)->REGINFO.LOCK_TYPE >= TL_READ'
--echo -- FAILED IN LOCK_EXTERNAL
--echo --

CREATE TABLE t1(a INT);
CREATE PROCEDURE p1() CREATE VIEW v1 AS SELECT * FROM t1;
CREATE TRIGGER trg_p1_t1 AFTER INSERT ON t1 FOR EACH ROW CALL p1();
INSERT INTO t1 VALUES (1);
CREATE VIEW v1 AS SELECT a+1 FROM t1;
INSERT INTO t1 VALUES (1);
DROP TRIGGER trg_p1_t1;
DROP PROCEDURE p1;
DROP VIEW v1;
DROP TABLE t1;

CREATE TABLE t2(a INT);
CREATE PROCEDURE p1() RENAME TABLE t2 TO t3;
CREATE FUNCTION f1() RETURNS INT BEGIN CALL p1();
SELECT f1();
DROP PROCEDURE p1;
DROP FUNCTION f1;
DROP TABLE t2;
