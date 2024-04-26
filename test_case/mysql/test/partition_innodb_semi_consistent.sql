
-- basic tests of semi-consistent reads
-- for verifying Bug#40595: Non-matching rows not released with READ-COMMITTED
--               on tables with partitions

connect (a,localhost,root,,);
set binlog_format=mixed;
set session transaction isolation level repeatable read;
create table t1(a int not null)
engine=innodb
DEFAULT CHARSET=latin1
PARTITION BY RANGE(a)
(PARTITION p0 VALUES LESS THAN (20),
 PARTITION p1 VALUES LESS THAN MAXVALUE);
insert into t1 values (1),(2),(3),(4),(5),(6),(7);
set autocommit=0;
select * from t1 where a=3 lock in share mode;
set binlog_format=mixed;
set session transaction isolation level repeatable read;
set autocommit=0;
update t1 set a=10 where a=5;
set session transaction isolation level read committed;
update t1 set a=10 where a=5;
select * from t1 where a=2 for update;
select * from t1 where a=2 limit 1 for update;
update t1 set a=11 where a=6;
update t1 set a=12 where a=2;
update t1 set a=13 where a=1;
update t1 set a=14 where a=1;
select * from t1;
drop table t1;

--
-- Bug #31310: Locked rows silently skipped in read-committed isolation level.
-- (This also tests the '*_semi_consistent*' functions in partitioning)
-- Copied from include/mix1.inc

connect (con1,localhost,root,,);
SET SESSION AUTOCOMMIT = 0;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
set binlog_format=mixed;
CREATE TABLE t1 (a INT PRIMARY KEY, b VARCHAR(256))
ENGINE = InnoDB
PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (300),
 PARTITION p1 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (1,2);
UPDATE t1 SET b = 12 WHERE a = 1;
SELECT * FROM t1;
UPDATE t1 SET b = 21 WHERE a = 1;
SELECT * FROM t1;

CREATE TABLE t2 (a INT);
INSERT INTO t1 VALUES (1,'init');
CREATE PROCEDURE p1()
BEGIN
  UPDATE t1 SET b = CONCAT(b, '+con2')  WHERE a = 1;
  INSERT INTO t2 VALUES ();
UPDATE t1 SET b = CONCAT(b, '+con1') WHERE a = 1;
SELECT * FROM t1;
SELECT * FROM t1;

let $bug31310 = 1;
{
  let $bug31310= `SELECT 1 - COUNT(*) FROM t2`;

SELECT * FROM t1;
SELECT * FROM t1;
DELETE FROM t2;

INSERT INTO t1 VALUES (1,'init');
UPDATE t1 SET a = 2, b = CONCAT(b, '+con1') WHERE a = 1;
SELECT * FROM t1;
SELECT * FROM t1;

let $bug31310 = 1;
{
  let $bug31310= `SELECT 1 - COUNT(*) FROM t2`;

SELECT * FROM t1;
SELECT * FROM t1;
DROP PROCEDURE p1;
DROP TABLE t1, t2;
