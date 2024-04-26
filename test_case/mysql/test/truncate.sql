drop table if exists t1, t2;

create table t1 (a integer, b integer,c1 CHAR(10));
insert into t1 (a) values (1),(2);
select count(*) from t1;
insert into t1 values(1,2,"test");
select count(*) from t1;
delete from t1;
select * from t1;
drop table t1;
select count(*) from t1;
create temporary table t1 (n int);
insert into t1 values (1),(2),(3);
select * from t1;
drop table t1;

--
-- test autoincrement with TRUNCATE;
--

create table t1 (a integer auto_increment primary key);
insert into t1 (a) values (NULL),(NULL);
insert into t1 (a) values (NULL),(NULL);
SELECT * from t1;
delete from t1;
insert into t1 (a) values (NULL),(NULL);
SELECT * from t1;
drop table t1;

-- Verifying that temp tables are handled the same way

create temporary table t1 (a integer auto_increment primary key);
insert into t1 (a) values (NULL),(NULL);
insert into t1 (a) values (NULL),(NULL);
SELECT * from t1;
delete from t1;
insert into t1 (a) values (NULL),(NULL);
SELECT * from t1;
drop table t1;

-- End of 4.1 tests

-- Test for Bug#5507 "TRUNCATE should work with views"
--
-- when it'll be fixed, the error should become 1347
-- (test.v1' is not BASE TABLE)
--

create table t1 (s1 int);
insert into t1 (s1) values (1), (2), (3), (4), (5);
create view v1 as select * from t1;
drop view v1;
drop table t1;

-- End of 5.0 tests

--echo --
--echo -- Bug#20667 - Truncate table fails for a write locked table
--echo --
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (1);
SELECT * FROM t1;
SELECT * FROM t1;
CREATE TABLE t2 (c1 INT);
CREATE VIEW v1 AS SELECT t1.c1 FROM t1,t2 WHERE t1.c1 = t2.c1;
INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (1), (3), (4);
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1, t2;
CREATE PROCEDURE p1() SET @a = 5;
DROP PROCEDURE p1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 AS SELECT 1 AS f1;

-- Cleanup
DROP TABLE t1;

CREATE TABLE t1(a INT);
CREATE SCHEMA s1;
CREATE VIEW s1.v1 AS SELECT * FROM t1;
DROP VIEW s1.v1;
DROP TABLE t1;
DROP SCHEMA s1;
