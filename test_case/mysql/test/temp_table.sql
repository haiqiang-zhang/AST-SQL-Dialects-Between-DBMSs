--

--disable_warnings
drop table if exists t1,t2;
drop view if exists v1;

CREATE TABLE t1 (c int not null, d char (10) not null);
insert into t1 values(1,""),(2,"a"),(3,"b");
CREATE TEMPORARY TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(4,"e"),(5,"f"),(6,"g");
alter table t1 rename t2;
select * from t1;
select * from t2;
CREATE TABLE t2 (x int not null, y int not null);
alter table t2 rename t1;
select * from t1;
create TEMPORARY TABLE t2 engine=heap select * from t1;
create TEMPORARY TABLE IF NOT EXISTS t2 (a int) engine=heap;

-- This should give errors
--error 1050
CREATE TEMPORARY TABLE t1 (a int not null, b char (10) not null);
ALTER TABLE t1 RENAME t2;

select * from t2;
alter table t2 add primary key (a,b);
drop table t1,t2;
select * from t1;
drop table t2;
create temporary table t1 select *,2 as "e" from t1;
select * from t1;
drop table t1;
drop table t1;

--
-- Test CONCAT_WS with temporary tables
--

CREATE TABLE t1 (pkCrash INTEGER PRIMARY KEY,strCrash VARCHAR(255));
INSERT INTO t1 ( pkCrash, strCrash ) VALUES ( 1, '1');
SELECT CONCAT_WS(pkCrash, strCrash) FROM t1;
drop table t1;
create temporary table t1 select 1 as 'x';
drop table t1;
CREATE TABLE t1 (x INT);
INSERT INTO t1 VALUES (1), (2), (3);
CREATE TEMPORARY TABLE tmp SELECT *, NULL FROM t1;
drop table t1;

--
-- Problem with ELT
--
create temporary table t1 (id int(10) not null unique);
create temporary table t2 (id int(10) not null primary key,
val int(10) not null);

-- put in some initial values
insert into t1 values (1),(2),(4);
insert into t2 values (1,1),(2,1),(3,1),(4,2);

-- do a query using ELT, a join and an ORDER BY.
select one.id, two.val, elt(two.val,'one','two') from t1 one, t2 two where two.id=one.id order by one.id;
drop table t1,t2;

--
-- Test of failed ALTER TABLE on temporary table
--
create temporary table t1 (a int not null);
insert into t1 values (1),(1);
alter table t1 add primary key (a);
drop table t1;

-- Fix for BUG#8921: Check that temporary table is ingored by view commands.
create temporary table v1 as select 'This is temp. table' A;
create view v1 as select 'This is view' A;
select * from v1;
drop view v1;
select * from v1;
create view v1 as select 'This is view again' A;
select * from v1;
drop table v1;
select * from v1;
drop view v1;

-- Bug #8497: tmpdir with extra slashes would cause failures
--
create table t1 (a int, b int, index(a), index(b));
create table t2 (c int auto_increment, d varchar(255), primary key (c));
insert into t1 values (3,1),(3,2);
insert into t2 values (NULL, 'foo'), (NULL, 'bar');
select d, c from t1 left join t2 on b = c where a = 3 order by d;
drop table t1, t2;


--
-- BUG#21096: locking issue ;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT);

CREATE TEMPORARY TABLE t1 (i INT);
DROP TEMPORARY TABLE t1;

DROP TABLE t1;

--
-- Check that it's not possible to drop a base table with
-- DROP TEMPORARY statement.
--
CREATE TABLE t1 (i INT);
CREATE TEMPORARY TABLE t2 (i INT);
DROP TEMPORARY TABLE t2, t1;

-- Table t2 should be still there too.
SELECT * FROM t2;
SELECT * FROM t1;

DROP TABLE t1;

--
-- Bug #24791: Union with AVG-groups generates wrong results
--
CREATE TABLE t1 ( c FLOAT( 20, 14 ) );
INSERT INTO t1 VALUES( 12139 );

CREATE TABLE t2 ( c FLOAT(30,18) );
INSERT INTO t2 VALUES( 123456 );

SELECT AVG( c ) FROM t1 UNION SELECT 1;
SELECT 1 UNION SELECT AVG( c ) FROM t1;
SELECT 1 UNION SELECT * FROM t2 UNION SELECT 1;
SELECT c/1 FROM t1 UNION SELECT 1;

DROP TABLE t1, t2;

--
-- Test truncate with temporary tables
--

create temporary table t1 (a int);
insert into t1 values (4711);
select * from t1;
insert into t1 values (42);
select * from t1;
drop table t1;

--
-- Bug #35392: Delete all statement does not execute properly after
-- few delete statements
--
CREATE TEMPORARY TABLE t1(a INT, b VARCHAR(20));
INSERT INTO t1 VALUES(1, 'val1'), (2, 'val2'), (3, 'val3');
DELETE FROM t1 WHERE a=1;
SELECT count(*) FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug#41348: INSERT INTO tbl SELECT * FROM temp_tbl overwrites locking type of temp table
--

--disable_warnings
DROP TABLE IF EXISTS t1,t2;
DROP FUNCTION IF EXISTS f1;

CREATE TEMPORARY TABLE t1 (a INT);
CREATE TEMPORARY TABLE t2 LIKE t1;
CREATE FUNCTION f1() RETURNS INT
 BEGIN
     return 1;

INSERT INTO t2 SELECT * FROM t1;
INSERT INTO t1 SELECT f1();

CREATE TABLE t3 SELECT * FROM t1;
INSERT INTO t1 SELECT f1();

UPDATE t1,t2 SET t1.a = t2.a;
INSERT INTO t2 SELECT f1();

DROP TABLE t1,t2,t3;
DROP FUNCTION f1;
DROP TEMPORARY TABLE IF EXISTS bug48067.t1;
DROP DATABASE IF EXISTS bug48067;
CREATE DATABASE bug48067;
CREATE TABLE bug48067.t1 (c1 int);
INSERT INTO bug48067.t1 values (1);
CREATE TEMPORARY TABLE bug48067.t1 (c1 int);
DROP DATABASE bug48067;
DROP TEMPORARY table bug48067.t1;
DROP TABLE IF EXISTS t1,t2;
CREATE TEMPORARY TABLE t1(a INT);
CREATE TEMPORARY TABLE t2(b INT);
CREATE TEMPORARY TABLE t3(c INT);

INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (11), (12), (13);
INSERT INTO t3 VALUES (101), (102), (103);

INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (11), (12), (13);
INSERT INTO t3 VALUES (101), (102), (103);

INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (11), (12), (13);
INSERT INTO t3 VALUES (101), (102), (103);

INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (11), (12), (13);
INSERT INTO t3 VALUES (101), (102), (103);

INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (11), (12), (13);
INSERT INTO t3 VALUES (101), (102), (103);

DROP TABLES t1, t2, t3;
CREATE TABLE t1 (
   a VARCHAR(255) NOT NULL,
   b VARCHAR(255) NOT NULL,
   c1 VARCHAR(255) DEFAULT NULL,
   d VARCHAR(255) NOT NULL,
    PRIMARY KEY (a,b,d)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 (a,b,d) VALUES(1,4,3),(2,5,4);
UPDATE t1 AS t2 STRAIGHT_JOIN t1 SET t1.c1=t1.c1+1;
DROP TABLE t1;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES(1,2),(3,4);
CREATE TABLE t2(a INT, b INT);
INSERT INTO t2 VALUES(1,2);
INSERT INTO t2 VALUES(4,5);
SELECT * FROM (SELECT COUNT(DISTINCT t1.a), t1.b FROM t1 RIGHT JOIN t2 ON
t1.a=t2.a GROUP BY t1.b) as tt;

DROP TABLE t1,t2;

CREATE DATABASE db1;
CREATE TABLE t1(a INT);
CREATE TEMPORARY TABLE t1(c1 INT);
ALTER TABLE t1 RENAME TO db1.t1;
DROP DATABASE db1;
DROP TABLE t1;
CREATE TEMPORARY TABLE bogus.t1(a INT);

CREATE SCHEMA bogus;
CREATE TEMPORARY TABLE bogus.t1(a INT);
CREATE TEMPORARY TABLE bogus.t2(a INT);
DROP SCHEMA bogus;
SELECT * FROM bogus.t1;
ALTER TABLE bogus.t1 ADD COLUMN (b INT);
DROP TEMPORARY TABLE bogus.t1;
DROP TABLE bogus.t2;
SELECT * FROM bogus.t1;
SELECT * FROM bogus.t2;

CREATE TABLE t1(a LONGTEXT);

SELECT (EXISTS (SELECT 1 FROM t1
GROUP BY (NOT EXISTS (SELECT 1 FROM (SELECT 1 FROM t1 GROUP BY a)r))))
FROM t1;

DROP TABLE t1;
CREATE TEMPORARY TABLE t1 (a TEXT NOT NULL) REPLACE AS SELECT total_allocated FROM sys.memory_by_thread_by_current_bytes;
CREATE TABLE IF NOT EXISTS t2 (a INT);
DROP TABLE t2;

-- The original bug report.
CREATE TEMPORARY TABLE v0 ( v1 INT UNIQUE ) ;
SELECT 'x' , -1 , 54703121.000000 FROM v0 AS v3 , v0 AS v2 , v0 NATURAL JOIN
v0 AS v5 NATURAL JOIN v0 AS v4 ;

DROP TABLE v0;

-- Simplified version of the above.
-- It should not crash. It should not return "Empty set".
-- It should report an error, because v0's resursive definition produces an
-- infinite set, giving raise to an infinite result set for the whole query.
--error ER_CTE_MAX_RECURSION_DEPTH
WITH RECURSIVE v0 ( c1 ) AS (
	SELECT 0
	UNION
	SELECT c1 + 1 FROM v0
)
SELECT *
FROM
	v0,
	v0 AS v1
	NATURAL JOIN v0 AS v2;

-- A finite version of the above query.
-- It should not crash. It should not return "Empty set"
-- It should return just 2*2=4 rows.
--sorted_result
WITH RECURSIVE v0 ( c1 ) AS (
	SELECT 0
	UNION
	SELECT 1 FROM v0
)
SELECT *
FROM
	v0,
	v0 AS v1
	NATURAL JOIN v0 AS v2;
CREATE TEMPORARY TABLE tt1(c1 INT);
DROP TABLE tt1;

CREATE TEMPORARY TABLE tt1 LIKE performance_schema.setup_consumers;
DROP TABLE tt1;

SET default_tmp_storage_engine=MYISAM;
CREATE TEMPORARY TABLE tt1(c1 INT);
DROP TABLE tt1;

CREATE TEMPORARY TABLE tt1 LIKE performance_schema.setup_consumers;
DROP TABLE tt1;
