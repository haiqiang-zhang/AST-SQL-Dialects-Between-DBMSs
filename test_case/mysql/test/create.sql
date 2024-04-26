SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
drop table if exists t1,t2,t3,t4,t5;
drop database if exists mysqltest;
drop view if exists v1;

create table t1 (b char(0));
insert into t1 values (""),(null);
select * from t1;
drop table if exists t1;

create table t1 (b char(0) not null);
create table if not exists t1 (b char(0) not null);
insert into t1 values (""),(null);
select * from t1;
drop table t1;

create table t1 (a int not null auto_increment,primary key (a)) engine=heap;
drop table t1;

--
-- Test of some CREATE TABLE'S that should fail
--

--error 1146
create table t2 engine=heap select * from t1;
create table t2 select auto+1 from t1;
drop table if exists t1,t2;
create table t1 (b char(0) not null, index(b));
create table t1 (a int not null,b text) engine=heap;
drop table if exists t1;
create table t1 (ordid int(8) not null auto_increment, ord  varchar(50) not null, primary key (ord,ordid)) engine=heap;
create table not_existing_database.test (a int);
create temporary table not_existing_database.test (a int);
create table `a/a` (a int);
create table t1 like `a/a`;
drop table `a/a`;
drop table `t1`;
create table `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` (aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa int);
create table a (`aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` int);

--
-- Some wrong defaults, so these creates should fail too (Bug #5902)
--
--error 1067
create table t1 (a int default 100 auto_increment);
create table t1 (a tinyint default 1000);
create table t1 (a varchar(5) default 'abcdef');

create table t1 (a varchar(5) default 'abcde');
insert into t1 values();
select * from t1;
alter table t1 alter column a set default 'abcdef';
drop table t1;

--
-- test of dummy table names
--

create table 1ea10 (1a20 int,1e int);
insert into 1ea10 values(1,1);
select 1ea10.1a20,1e+ 1e+10 from 1ea10;
drop table 1ea10;
create table t1 (`index` int);
drop table t1;
drop database if exists mysqltest;
create database mysqltest;
create table mysqltest.`$test1` (a$1 int, `$b` int, c$ int);
insert into mysqltest.`$test1` values (1,2,3);
select a$1, `$b`, c$ from mysqltest.`$test1`;
create table mysqltest.test2$ (a int);
drop table mysqltest.test2$;
drop database mysqltest;
create table `` (a int);
drop table if exists ``;
create table t1 (`` int);
create table t1 (i int, index `` (i));

--
-- CREATE TABLE under LOCK TABLES
--
-- We don't allow creation of non-temporary tables under LOCK TABLES
-- as following meta-data locking protocol in this case can lead to
-- deadlock.
create table t1 (i int);
create table t2 (j int);
create temporary table t2 (j int);
drop temporary table t2;
drop table t1;

--
-- Test of CREATE ... SELECT with indexes
--

create table t1 (a int auto_increment not null primary key, B CHAR(20));
insert into t1 (b) values ("hello"),("my"),("world");
create table t2 (key (b)) select * from t1;
select * from t2 where b="world";
drop table t1,t2;

--
-- Test types after CREATE ... SELECT
--

create table t1(x varchar(50) );
create table t2 select x from t1 where 1=2;
drop table t2;
create table t2 select now() as a , curtime() as b, curdate() as c , 1+1 as d , 1.0 + 1 as e , 33333333333333333 + 3 as f;
drop table t2;
create table t2 select CAST("2001-12-29" AS DATE) as d, CAST("20:45:11" AS TIME) as t, CAST("2001-12-29  20:45:11" AS DATETIME) as dt;
drop table t1,t2;

--
-- Test of CREATE ... SELECT with duplicate fields
--

create table t1 (a tinyint);
create table t2 (a int) select * from t1;
drop table if exists t2;
create table t2 (a int, a float) select * from t1;
drop table if exists t2;
create table t2 (a int) select a as b, a+1 as b from t1;
drop table if exists t2;
create table t2 (b int) select a as b, a+1 as b from t1;
drop table if exists t1,t2;

--
-- Test CREATE ... SELECT when insert fails
--

CREATE TABLE t1 (a int not null);
INSERT INTO t1 values (1),(2),(1);
CREATE TABLE t2 (primary key(a)) SELECT * FROM t1;
SELECT * from t2;
DROP TABLE t1;
DROP TABLE IF EXISTS t2;

--
-- Test of primary key with 32 index
--

create table t1 (a int not null, b int, primary key(a), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b));
drop table t1;
create table t1 select if(1,'1','0'), month("2002-08-02");
drop table t1;
create table t1 select if('2002'='2002','Y','N');
select * from t1;
drop table if exists t1;

--
-- Test default table type
--
SET SESSION default_storage_engine="heap";
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
drop table t1;
SET SESSION default_storage_engine="gemini";
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
SET SESSION default_storage_engine=default;
drop table t1;


--
-- ISO requires that primary keys are implicitly NOT NULL
--
create table t1 ( k1 varchar(2), k2 int, primary key(k1,k2));
insert into t1 values ("a", 1), ("b", 2);
insert into t1 values ("c", NULL);
insert into t1 values (NULL, 3);
insert into t1 values (NULL, NULL);
drop table t1;

--
-- Bug # 801
--

create table t1 select x'4132';
drop table t1;

--
-- bug #1434
--

create table t1 select 1,2,3;
create table if not exists t1 select 1,2;
create table if not exists t1 select 1,2,3,4;
create table if not exists t1 select 1;
select * from t1;
drop table t1;

--
-- Test create table if not exists with duplicate key error
--

flush status;
create table t1 (a int not null, b int, primary key (a));
insert into t1 values (1,1);
create table if not exists t1 select 2;
select * from t1;
create table if not exists t1 select 3 as 'a',4 as 'b';
select * from t1;
drop table t1;

--
-- Test for Bug #2985 
--   "Table truncated when creating another table name with Spaces"
--

--error 1103
create table `t1 `(a int);
create database `db1 `;
create table t1(`a ` int);

--
-- Test for Bug #3481 
--   "Parser permits multiple commas without syntax error"
--

--error 1064
create table t1 (a int,);
create table t1 (a int,,b int);
create table t1 (,b int);

--
-- Test create with foreign keys
--

create table t1 (a int, key(a));
create table t2 (b int, foreign key(b) references t1(a), key(b));
drop table if exists t2,t1;

--
-- Test for CREATE TABLE .. LIKE ..
--

create table t1(id int not null, name char(20));
insert into t1 values(10,'mysql'),(20,'monty- the creator');
create table t2(id int not null);
insert into t2 values(10),(20);
create table t3 like t1;
select * from t3;
create table if not exists t3 like t1;
select @@warning_count;
create temporary table t3 like t2;
select * from t3;
drop table t3;
select * from t3;
drop table t2, t3;
create database mysqltest;
create table mysqltest.t3 like t1;
create temporary table t3 like mysqltest.t3;
create table t2 like t3;
select * from t2;
create table t3 like t1;
create table t3 like mysqltest.t3;
create table non_existing_database.t1 like t1;
create table t3 like non_existing_table;
create temporary table t3 like t1;
drop table t1, t2, t3;
drop table t3;
drop database mysqltest;

--
-- CREATE TABLE LIKE under LOCK TABLES
--
-- Similarly to ordinary CREATE TABLE we don't allow creation of
-- non-temporary tables under LOCK TABLES. Also we require source
-- table to be locked.
create table t1 (i int);
create table t2 (j int);
create table t3 like t1;
create temporary table t3 like t1;
drop temporary table t3;
create temporary table t3 like t2;
drop tables t1, t2;

--
-- Test default table type
--
SET SESSION default_storage_engine="heap";
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
drop table t1;
SET SESSION default_storage_engine="gemini";
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
SET SESSION default_storage_engine=default;
drop table t1;

--
-- Test types of data for create select with functions
--

create table t1(a int,b int,c int unsigned,d date,e char,f datetime,g time,h blob);
insert into t1(a)values(1);
insert into t1(a,b,c,d,e,f,g,h)
values(2,-2,2,'1825-12-14','a','2003-1-1 3:2:1','4:3:2','binary data');
select * from t1;
select a, 
    ifnull(b,cast(-7 as signed)) as b, 
    ifnull(c,cast(7 as unsigned)) as c, 
    ifnull(d,cast('2000-01-01' as date)) as d, 
    ifnull(e,cast('b' as char)) as e,
    ifnull(f,cast('2000-01-01' as datetime)) as f, 
    ifnull(g,cast('5:4:3' as time)) as g,
    ifnull(h,cast('yet another binary data' as binary)) as h,
    addtime(cast('1:0:0' as time),cast('1:0:0' as time)) as dd 
from t1;

create table t2
select
    a, 
    ifnull(b,cast(-7                        as signed))   as b,
    ifnull(c,cast(7                         as unsigned)) as c,
    ifnull(d,cast('2000-01-01'              as date))     as d,
    ifnull(e,cast('b'                       as char))     as e,
    ifnull(f,cast('2000-01-01'              as datetime)) as f,
    ifnull(g,cast('5:4:3'                   as time))     as g,
    ifnull(h,cast('yet another binary data' as binary))   as h,
    addtime(cast('1:0:0' as time),cast('1:0:0' as time))  as dd
from t1;
select * from t2;
drop table t1, t2;

create table t1 (a tinyint, b smallint, c mediumint, d int, e bigint, f float(3,2), g double(4,3), h decimal(5,4), i year, j date, k timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, l datetime, m enum('a','b'), n set('a','b'), o char(10));
create table t2 select ifnull(a,a), ifnull(b,b), ifnull(c,c), ifnull(d,d), ifnull(e,e), ifnull(f,f), ifnull(g,g), ifnull(h,h), ifnull(i,i), ifnull(j,j), ifnull(k,k), ifnull(l,l), ifnull(m,m), ifnull(n,n), ifnull(o,o) from t1;
drop table t1,t2;

--
-- Test of default()
--
create table t1(str varchar(10) default 'def',strnull varchar(10),intg int default '10',rel double default '3.14');
insert into t1 values ('','',0,0.0);
create table t2 select default(str) as str, default(strnull) as strnull, default(intg) as intg, default(rel) as rel from t1;
drop table t1, t2;

--
-- Bug #2075
--

create table t1(name varchar(10), age smallint default -1);
create table t2(name varchar(10), age smallint default - 1);
drop table t1, t2;

--
-- test for bug #1427 "enum allows duplicate values in the list"
--

create table t1(cenum enum('a'), cset set('b'));
create table t2(cenum enum('a','a'), cset set('b','b'));
create table t3(cenum enum('a','A','a','c','c'), cset set('b','B','b','d','d'));
drop table t1, t2, t3;

--
-- Bug #1209
--

create database mysqltest;
use mysqltest;
select database();
drop database mysqltest;
select database();

-- Connect without a database as user mysqltest_1
create user mysqltest_1;
select database(), user();
drop user mysqltest_1;
use test;

--
-- Test for Bug 856 'Naming a key "Primary" causes trouble'
--

--error 1280
create table t1 (a int, index `primary` (a));
create table t1 (a int, index `PRIMARY` (a));

create table t1 (`primary` int, index(`primary`));
create table t2 (`PRIMARY` int, index(`PRIMARY`));

create table t3 (a int);
alter table t3 add index `primary` (a);
alter table t3 add index `PRIMARY` (a);

create table t4 (`primary` int);
alter table t4 add index(`primary`);
create table t5 (`PRIMARY` int);
alter table t5 add index(`PRIMARY`);

drop table t1, t2, t3, t4, t5;

--
-- bug #3266 TEXT in CREATE TABLE SELECT
--

CREATE TABLE t1(id varchar(10) NOT NULL PRIMARY KEY, dsc longtext);
INSERT INTO t1 VALUES ('5000000001', NULL),('5000000003', 'Test'),('5000000004', NULL);
CREATE TABLE t2(id varchar(15) NOT NULL, proc varchar(100) NOT NULL, runID varchar(16) NOT NULL, start datetime NOT NULL, PRIMARY KEY  (id,proc,runID,start));

INSERT INTO t2 VALUES ('5000000001', 'proc01', '20031029090650', '2003-10-29 13:38:40'),('5000000001', 'proc02', '20031029090650', '2003-10-29 13:38:51'),('5000000001', 'proc03', '20031029090650', '2003-10-29 13:38:11'),('5000000002', 'proc09', '20031024013310', '2003-10-24 01:33:11'),('5000000002', 'proc09', '20031024153537', '2003-10-24 15:36:04'),('5000000004', 'proc01', '20031024013641', '2003-10-24 01:37:29'),('5000000004', 'proc02', '20031024013641', '2003-10-24 01:37:39');

CREATE TABLE t3  SELECT t1.dsc,COUNT(DISTINCT t2.id) AS countOfRuns  FROM t1 LEFT JOIN t2 ON (t1.id=t2.id) GROUP BY t1.id;
SELECT * FROM t3;
drop table t1, t2, t3;

--
-- Bug#9666: Can't use 'DEFAULT FALSE' for column of type bool
--
create table t1 (b bool not null default false);
create table t2 (b bool not null default true);
insert into t1 values ();
insert into t2 values ();
select * from t1;
select * from t2;
drop table t1,t2;

--
-- Bug#10224 - ANALYZE TABLE crashing with simultaneous
-- CREATE ... SELECT statement.
-- This tests two additional possible errors and a hang if 
-- an improper fix is present.
--
create table t1 (a int);
create table t1 select * from t1;
create table t2 union = (t1) select * from t1;
drop table t1;

--
-- Bug#10413: Invalid column name is not rejected
--
--error ER_PARSE_ERROR
create table t1(column.name int);
create table t1(test.column.name int);
create table t1(xyz.t1.name int);
create table t1(t1.name int);
create table t2(test.t2.name int);

--
-- Bug #12537: UNION produces longtext instead of varchar
--
CREATE TABLE t1 (f1 VARCHAR(255) CHARACTER SET utf8mb3);
CREATE TABLE t2 AS SELECT LEFT(f1,171) AS f2 FROM t1 UNION SELECT LEFT(f1,171) AS f2 FROM t1;
DROP TABLE t1,t2;

--
-- Bug#12913 Simple SQL can crash server or connection
--
CREATE TABLE t12913 (f1 ENUM ('a','b')) AS SELECT 'a' AS f1;
SELECT * FROM t12913;
DROP TABLE t12913;

--
-- Bug#11028: Crash on create table like
--
create database mysqltest;
use mysqltest;
drop database mysqltest;
create table test.t1 like x;
drop table if exists test.t1;

--
-- Bug #6859: Bogus error message on attempt to CREATE TABLE t LIKE view
--
create database mysqltest;
use mysqltest;
create view v1 as select 'foo' from dual;
create table t1 like v1;
drop view v1;
drop database mysqltest;
create database mysqltest;
create database if not exists mysqltest character set latin2;
drop database mysqltest;
use test;
create table t1 (a int);
create table if not exists t1 (a int);
drop table t1;

-- BUG#14139
create table t1 (
  a varchar(112) charset utf8mb3 COLLATE utf8mb3_bin not null,
  primary key (a)
) select 'test' as a ;
drop table t1;

--
-- BUG#14480: assert failure in CREATE ... SELECT because of wrong
--            calculation of number of NULLs.
--
CREATE TABLE t2 (
  a int(11) default NULL
);
insert into t2 values(111);
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null, 
  b int not null, primary key (a)
) select a, 1 as b from t2 ;
drop table t1;
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null, 
  b int not null, primary key (a)
) select a, 1 as c from t2 ;
drop table t1;
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null, 
  b int null, primary key (a)
) select a, 1 as c from t2 ;
drop table t1;
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null,
  b int not null, primary key (a)
) select 'a' as a , 1 as b from t2 ;
drop table t1;
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin,
  b int not null, primary key (a)
) select 'a' as a , 1 as b from t2 ;
drop table t1, t2;

create table t1 ( 
  a1 int not null,
  a2 int, a3 int, a4 int, a5 int, a6 int, a7 int, a8 int, a9 int
);
insert into t1 values (1,1,1, 1,1,1, 1,1,1);
create table t2 ( 
  a1 varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null,
  a2 int, a3 int, a4 int, a5 int, a6 int, a7 int, a8 int, a9 int,
  primary key (a1)
) select a1,a2,a3,a4,a5,a6,a7,a8,a9 from t1 ;
drop table t2;
create table t2 ( 
  a1 varchar(12) charset utf8mb3 COLLATE utf8mb3_bin,
  a2 int, a3 int, a4 int, a5 int, a6 int, a7 int, a8 int, a9 int
) select a1,a2,a3,a4,a5,a6,a7,a8,a9 from t1;

drop table t1, t2;
create table t1 ( 
  a1 int, a2 int, a3 int, a4 int, a5 int, a6 int, a7 int, a8 int, a9 int
);
insert into t1 values (1,1,1, 1,1,1, 1,1,1);
create table t2 ( 
  a1 varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null,
  a2 int, a3 int, a4 int, a5 int, a6 int, a7 int, a8 int, a9 int,
  primary key (a1)
) select a1,a2,a3,a4,a5,a6,a7,a8,a9 from t1 ;

-- Test the default value
drop table t2;

create table t2 ( a int default 3, b int default 3)
  select a1,a2 from t1;

drop table t1, t2;

--
-- Bug #15316 SET value having comma not correctly handled
--
--error 1367
create table t1(a set("a,b","c,d") not null);

-- End of 4.1 tests


--
-- Tests for errors happening at various stages of CREATE TABLES ... SELECT
--
-- (Also checks that it behaves atomically in the sense that in case
--  of error it is automatically dropped if it has not existed before.)
--
-- Error during open_and_lock_tables() of tables
--error ER_NO_SUCH_TABLE
create table t1 select * from t2;
create table t1 select * from t1;
create table t1 select coalesce(_latin1 'a' collate latin1_swedish_ci,_latin1 'b' collate latin1_bin);
create table t1 (primary key(a)) select "b" as b;
create table t1 (a int);
create table if not exists t1 select 1 as a, 2 as b;
drop table t1;
create table t1 (primary key (a)) (select 1 as a) union all (select 1 as a);
create table t1 (i int);
create table t1 select 1 as i;
create table if not exists t1 select 1 as i;
select * from t1;
create table if not exists t1 select * from t1;
select * from t1;
drop table t1;
create table t1 select coalesce(_latin1 'a' collate latin1_swedish_ci,_latin1 'b' collate latin1_bin);


-- Base vs temporary tables dillema (a.k.a. bug#24508 "Inconsistent
-- results of CREATE TABLE ... SELECT when temporary table exists").
-- In this situation we either have to create non-temporary table and
-- insert data in it or insert data in temporary table without creation of
-- permanent table. After patch for Bug#47418, we create the base table and
-- instert data into it, even though a temporary table exists with the same
-- name.
create temporary table t1 (j int);
create table if not exists t1 select 1;
select * from t1;
drop temporary table t1;
select * from t1;
drop table t1;


--
-- CREATE TABLE ... SELECT and LOCK TABLES
--
-- There is little sense in using CREATE TABLE ... SELECT under
-- LOCK TABLES as it mostly does not work. At least we check that
-- the server doesn't crash, hang and produces sensible errors.
-- Includes test for bug #20662 "Infinite loop in CREATE TABLE
-- IF NOT EXISTS ... SELECT with locked tables".
create table t1 (i int);
insert into t1 values (1), (2);
create table t2 select * from t1;
create table if not exists t2 select * from t1;
create table t2 (j int);
create table t2 select * from t1;
create table if not exists t2 select * from t1;
create table t2 select * from t1;
create table if not exists t2 select * from t1;
create table t2 select * from t1;
create table if not exists t2 select * from t1;
select * from t1;
drop table t2;

-- OTOH CREATE TEMPORARY TABLE ... SELECT should work
-- well under LOCK TABLES.
lock tables t1 read;
create temporary table t2 select * from t1;
create temporary table if not exists t2 select * from t1;
select * from t2;
drop table t1, t2;


--
-- Bug#21772: can not name a column 'upgrade' when create a table
--
create table t1 (upgrade int);
drop table t1;
drop table if exists t1,t2;

create table t1(a int not null, b int not null, primary key (a, b));
create table t2(a int not null, b int not null, c int not null, primary key (a),
                constraint fk_bug26104 foreign key (b,c) references t1(a));
drop table t1;

-- HANDLER_READ_KEY count differs when using ps protocol because of prepare
-- phase of ps protocol results in call to innodb storage engine apis to check
-- for table existence.
--disable_ps_protocol
--
-- Bug#15130:CREATE .. SELECT was denied to use advantages of the SQL_BIG_RESULT.
--
create table t1(f1 int,f2 int);
insert into t1 value(1,1),(1,2),(1,3),(2,1),(2,2),(2,3);
create table t2 select sql_big_result f1,count(f2) from t1 group by f1;
drop table t1,t2;

--
-- Bug #25162: Backing up DB from 5.1 adds 'USING BTREE' to KEYs on table creates
--

-- Show that the old syntax for index type is supported
CREATE TABLE t1(c1 VARCHAR(33), KEY USING BTREE (c1));
DROP TABLE t1;

-- Show that the new syntax for index type is supported
CREATE TABLE t1(c1 VARCHAR(33), KEY (c1) USING BTREE);
DROP TABLE t1;

-- Show that in case of multiple index type definitions, the last one takes 
-- precedence

CREATE TABLE t1(c1 VARCHAR(33), KEY USING BTREE (c1) USING HASH) ENGINE=MEMORY;
DROP TABLE t1;

CREATE TABLE t1(c1 VARCHAR(33), KEY USING HASH (c1) USING BTREE) ENGINE=MEMORY;
DROP TABLE t1;

--
-- Bug#35924 DEFINER should be stored 'quoted' in I_S
--
--error ER_UNKNOWN_ERROR
create user mysqltest_1@'test@test';

--
-- Bug#38821: Assert table->auto_increment_field_not_null failed in open_table()
--
CREATE TABLE t1 (a INTEGER AUTO_INCREMENT PRIMARY KEY, b INTEGER NOT NULL);
INSERT IGNORE INTO t1 (b) VALUES (5);

CREATE TABLE IF NOT EXISTS t2 (a INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY)
  SELECT a FROM t1;
INSERT INTO t2 SELECT a FROM t1;
INSERT INTO t2 SELECT a FROM t1;

DROP TABLE t1, t2;

CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);

INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (1),(2),(3);

CREATE VIEW v1 AS SELECT t1.a FROM t1, t2;
CREATE TABLE v1 AS SELECT * FROM t1;

DROP VIEW v1;
DROP TABLE t1,t2;

--
-- Test of behaviour with CREATE ... SELECT
--

CREATE TABLE t1 (a int, b int);
insert into t1 values (1,1),(1,2);
CREATE TABLE t2 (primary key (a)) select * from t1;
drop table if exists t2;
CREATE TEMPORARY TABLE t2 (primary key (a)) select * from t1;
drop table if exists t2;
CREATE TABLE t2 (a int, b int, primary key (a));
INSERT INTO t2 select * from t1;
SELECT * from t2;
INSERT INTO t2 select * from t1;
SELECT * from t2;
drop table t2;

CREATE TEMPORARY TABLE t2 (a int, b int, primary key (a)) ENGINE=InnoDB;
INSERT INTO t2 SELECT * FROM t1;
SELECT * from t2;
drop table t1,t2;


--
-- Test incorrect database names
--

--error ER_TOO_LONG_IDENT
CREATE DATABASE aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
DROP DATABASE aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;

-- TODO: enable these tests when RENAME DATABASE is implemented.
-- --error 1049
-- RENAME DATABASE aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa TO a;
USE aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;

-- Bug#21432 Database/Table name limited to 64 bytes, not chars, problems with multi-byte
--
set names utf8mb3;

create database имя_базы_в_кодировке_утф8_длиной_больше_чем_45;
use имя_базы_в_кодировке_утф8_длиной_больше_чем_45;
select database();
use test;

select SCHEMA_NAME from information_schema.schemata
where schema_name='имя_базы_в_кодировке_утф8_длиной_больше_чем_45';

drop database имя_базы_в_кодировке_утф8_длиной_больше_чем_45;
create table имя_таблицы_в_кодировке_утф8_длиной_больше_чем_48
(
  имя_поля_в_кодировке_утф8_длиной_больше_чем_45 int,
  index имя_индекса_в_кодировке_утф8_длиной_больше_чем_48 (имя_поля_в_кодировке_утф8_длиной_больше_чем_45)
);

create view имя_вью_кодировке_утф8_длиной_больше_чем_42 as
select имя_поля_в_кодировке_утф8_длиной_больше_чем_45
from имя_таблицы_в_кодировке_утф8_длиной_больше_чем_48;

-- database, table, field, key, view
select * from имя_таблицы_в_кодировке_утф8_длиной_больше_чем_48;

select TABLE_NAME from information_schema.tables where
table_schema='test' order by TABLE_NAME;

select COLUMN_NAME from information_schema.columns where
table_schema='test' order by COLUMN_NAME;

select INDEX_NAME from information_schema.statistics where
table_schema='test' order by INDEX_NAME;

select TABLE_NAME from information_schema.views where
table_schema='test' order by TABLE_NAME;

create trigger имя_триггера_в_кодировке_утф8_длиной_больше_чем_49
before insert on имя_таблицы_в_кодировке_утф8_длиной_больше_чем_48 for each row set @a:=1;
select TRIGGER_NAME from information_schema.triggers where
trigger_schema='test';
drop trigger имя_триггера_в_кодировке_утф8_длиной_больше_чем_49;
create trigger
очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_66
before insert on имя_таблицы_в_кодировке_утф8_длиной_больше_чем_48 for each row set @a:=1;
drop trigger очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_66;

create procedure имя_процедуры_в_кодировке_утф8_длиной_больше_чем_50()
begin
end;
select ROUTINE_NAME from information_schema.routines where
routine_schema='test';
drop procedure имя_процедуры_в_кодировке_утф8_длиной_больше_чем_50;
create procedure очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_66()
begin
end;

create function имя_функции_в_кодировке_утф8_длиной_больше_чем_49()
   returns int
return 0;
select ROUTINE_NAME from information_schema.routines where
routine_schema='test';
drop function имя_функции_в_кодировке_утф8_длиной_больше_чем_49;
create function очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_66()
   returns int
return 0;

drop view имя_вью_кодировке_утф8_длиной_больше_чем_42;
drop table имя_таблицы_в_кодировке_утф8_длиной_больше_чем_48;
set names default;

--
-- Bug#21136 CREATE TABLE SELECT within CREATE TABLE SELECT causes server crash
--

--disable_warnings
drop table if exists t1,t2,t3;
drop function if exists f1;
create function f1() returns int
begin
  declare res int;
  create temporary table t3 select 1 i;
  set res:= (select count(*) from t1);
  drop temporary table t3;
create table t1 as select 1;
create table t2 as select f1() from t1;
drop table t1,t2;
drop function f1;

-- WL6599_CREATE_LIKE_IS_VIEW
-- Bug#25629 CREATE TABLE LIKE does not work with INFORMATION_SCHEMA
--
create table t1 like information_schema.processlist;
drop table t1;
create temporary table t1 like information_schema.processlist;
drop table t1;
create table t1 as select * from information_schema.character_sets;
drop table t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1(
  c1 INT DEFAULT 12 COMMENT 'column1',
  c2 INT NULL COMMENT 'column2',
  c3 INT NOT NULL COMMENT 'column3',
  c4 VARCHAR(255) CHARACTER SET utf8mb3 NOT NULL DEFAULT 'a',
  c5 VARCHAR(255) COLLATE utf8mb3_unicode_ci NULL DEFAULT 'b',
  c6 VARCHAR(255))
  COLLATE latin1_bin;

CREATE TABLE t2 AS SELECT * FROM t1;

DROP TABLE t2;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;

CREATE TABLE t1(c1 TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, c2 TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00');

SET sql_mode = 'NO_ZERO_DATE';
CREATE TABLE t2(c1 TIMESTAMP, c2 TIMESTAMP DEFAULT 0);
DROP TABLE t2;
CREATE TABLE t2(c1 TIMESTAMP NULL);
ALTER TABLE t1 ADD INDEX(c1);
SET sql_mode = '';

SET sql_mode = '';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(c1 YEAR DEFAULT 2008, c2 YEAR DEFAULT 0);
INSERT INTO t1 VALUES();
SELECT * FROM t1;
ALTER TABLE t1 MODIFY c1 YEAR DEFAULT 0;
INSERT INTO t1 VALUES();
SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug#40104 regression with table names?
--
create table `me:i`(id int);
drop table `me:i`;

--
-- Bug#45829 CREATE TABLE TRANSACTIONAL PAGE_CHECKSUM ROW_FORMAT=PAGE accepted, does nothing
--

--echo
--echo -- --
--echo -- -- Bug#45829: CREATE TABLE TRANSACTIONAL PAGE_CHECKSUM ROW_FORMAT=PAGE accepted, does nothing
--echo -- --
--echo

--disable_warnings
drop table if exists t1,t2,t3;
create table t1 (a int) transactional=0;
create table t2 (a int) page_checksum=1;
create table t3 (a int) row_format=page;

CREATE TABLE B (
  pk INTEGER AUTO_INCREMENT,
  int_key INTEGER NOT NULL,
  PRIMARY KEY (pk),
  KEY (int_key)
);

INSERT IGNORE INTO B VALUES ('9', '9');

CREATE TABLE IF NOT EXISTS t1 ( 
  `pk` INTEGER NOT NULL AUTO_INCREMENT , 
  `int` INTEGER ,
   PRIMARY KEY ( `pk` ) 
) SELECT `pk` , `int_key` FROM B ;

CREATE TRIGGER f BEFORE INSERT ON t1 FOR EACH ROW 
BEGIN 
  INSERT INTO t1 ( `int` ) VALUES (4 ),( 8 ),( 2 ) ;
END ;
INSERT INTO t1 (pk, int_key) SELECT `pk` , `int_key` FROM B ;
CREATE TRIGGER f BEFORE INSERT ON t1 FOR EACH ROW 
BEGIN 
  UPDATE A SET `pk`=1 WHERE `pk`=0 ;
END ;

DROP TABLE t1;
DROP TABLE B;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(f1 integer);
CREATE TABLE t1 SELECT 1 AS f2;
CREATE TABLE t1(f1 integer);

CREATE TABLE t2(f1 integer);
CREATE TABLE t1 LIKE t2;

DROP TABLE t2;
DROP TABLE t1;

CREATE TEMPORARY TABLE t1 (a INT);
CREATE TABLE t1 (a INT);

CREATE TEMPORARY TABLE t2 (a INT);
CREATE VIEW t2 AS SELECT 1;

CREATE TABLE t3 (a INT);
CREATE TEMPORARY TABLE t3 SELECT 1;

CREATE TEMPORARY TABLE t4 (a INT);
CREATE TABLE t4 AS SELECT 1;

DROP TEMPORARY TABLE t1, t2, t3, t4;
DROP TABLE t1, t3, t4;
DROP VIEW t2;

CREATE TEMPORARY TABLE t2 (ID INT);
INSERT INTO t2 VALUES (1),(2),(3);

-- Case 1 -- did not fail
CREATE TEMPORARY TABLE t1 (ID INT);
CREATE TABLE IF NOT EXISTS t1 (ID INT);
INSERT INTO t1 SELECT * FROM t2;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
SELECT * FROM t1;

DROP TABLE t1;

-- Case 2 -- The DROP TABLE t1 failed with 
--  Table 'test.t1' doesn't exist in the SELECT *
-- as the (permanent) table was not created
CREATE TEMPORARY TABLE t1 (ID INT);
CREATE TABLE IF NOT EXISTS t1 SELECT * FROM t2;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
SELECT * FROM t1;

DROP TABLE t1;

-- Case 3 -- The CREATE TABLE failed with
--  Table 't1' already exists
CREATE TEMPORARY TABLE t1 (ID INT);
CREATE TABLE t1 SELECT * FROM t2;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
SELECT * FROM t1;
 
DROP TABLE t1;
 
DROP TEMPORARY TABLE t2;
drop tables if exists t1, t2;
create table t1 (dt datetime default '2008-02-31 00:00:00');
set @old_mode= @@sql_mode;
set @@sql_mode='ALLOW_INVALID_DATES';
create table t1 (dt datetime default '2008-02-31 00:00:00');
set @@sql_mode= @old_mode;
create table t2 like t1;
set @@sql_mode='ALLOW_INVALID_DATES';
create table t2 like t1;
set @@sql_mode= @old_mode;
drop tables t1, t2;
--

CREATE TABLE t1 (id int);
CREATE TABLE t2 (id int);
INSERT INTO t1 VALUES (1), (1);
INSERT INTO t2 VALUES (2), (2);

CREATE VIEW v1 AS SELECT id FROM t2;
CREATE TABLE IF NOT EXISTS v1(a int, b int) SELECT id, id FROM t1;
SELECT * FROM t2;
SELECT * FROM v1;
DROP VIEW v1;

CREATE TEMPORARY TABLE tt1 AS SELECT id FROM t2;
CREATE TEMPORARY TABLE IF NOT EXISTS tt1(a int, b int) SELECT id, id FROM t1;
SELECT * FROM t2;
SELECT * FROM tt1;
DROP TEMPORARY TABLE tt1;

DROP TABLE t1, t2;

create table if not exists t1 (a int) select 1 as a;
select * from t1;
create table t1 (a int) select 2 as a;
select * from t1;
create table if not exists t1 (a int) select 2 as a;
select * from t1;
drop table t1;

create temporary table if not exists t1 (a int) select 1 as a;
select * from t1;
create temporary table t1 (a int) select 2 as a;
select * from t1;
create temporary table if not exists t1 (a int) select 2 as a;
select * from t1;
drop temporary table t1;

create table t1 (a int);
create view v1 as select a from t1;
drop table t1;
create temporary table t1 (a int) select 1 as a;
create table if not exists t1 (a int) select 2 as a;
select * from t1;
select * from v1;
create table if not exists t1 (a int) select 3 as a;
select * from t1;
select * from v1;
drop temporary table t1;
select * from t1;
drop view v1;
drop table t1;

create table t1 (a int) select 1 as a;
create temporary table if not exists t1 select 2 as a;
select * from t1;
create temporary table if not exists t1 select 3 as a;
select * from t1;
drop temporary table t1;
select * from t1;
drop table t1;
create table t2 (a int unique);
create view t1 as select a from t2;
insert into t1 (a) values (1);
create table t1 (a int);
create table if not exists t1 (a int);
create table t1 (a int) select 2 as a;
select * from t1;
create table if not exists t1 (a int) select 2 as a;
select * from t1;
select * from t2;
create temporary table if not exists t1 (a int) select 3 as a;
select * from t1;
select * from t2;
create temporary table if not exists t1 (a int) select 4 as a;
select * from t1;
select * from t2;
drop temporary table t1;
drop view t1;
create view t1 as select a + 5 as a from t2;
insert into t1 (a) values (1);
update t1 set a=3 where a=2;
create table t1 (a int);
create table if not exists t1 (a int);
create table t1 (a int) select 2 as a;
select * from t1;
create table if not exists t1 (a int) select 2 as a;
select * from t1;
select * from t2;
create temporary table if not exists t1 (a int) select 3 as a;
select * from t1;
select * from t2;
create temporary table if not exists t1 (a int) select 4 as a;
select * from t1;
select * from t2;
drop temporary table t1;
drop view t1;
drop table t2;
create view t1 as select 1 as a;
insert into t1 (a) values (1);
update t1 set a=3 where a=2;
create table t1 (a int);
create table if not exists t1 (a int);
create table t1 (a int) select 2 as a;
select * from t1;
create table if not exists t1 (a int) select 2 as a;
select * from t1;
create temporary table if not exists t1 (a int) select 3 as a;
select * from t1;
create temporary table if not exists t1 (a int) select 4 as a;
select * from t1;
drop temporary table t1;
drop view t1;

create table t1 (a int) select 1 as a;
create temporary table if not exists t1 (a int) select * from t1;
create temporary table if not exists t1 (a int) select * from t1;
select * from t1;
drop temporary table t1;
select * from t1;
drop table t1;
create temporary table t1 (a int) select 1 as a;
create table if not exists t1 (a int) select * from t1;
create table if not exists t1 (a int) select * from t1;
select * from t1;
drop temporary table t1;
select * from t1;
drop table t1;
create table if not exists t1 (a int) select * from t1;

create table t1 (a int) select 1 as b, 2 as c;
select * from t1;
drop table t1;
create table if not exists t1 (a int, b date, c date) select 1 as b, 2 as c;
select * from t1;
drop table t1;
set @@session.sql_mode=default;
create table if not exists t1 (a int, b date, c date) select 1 as b, 2 as c;
select * from t1;
create table if not exists t1 (a int, b date, c date) 
  replace select 1 as b, 2 as c;
select * from t1;

create table if not exists t1 (a int, b date, c date) 
  ignore select 1 as b, 2 as c;
select * from t1;
drop table t1;

create table if not exists t1 (a int unique, b int)
  replace select 1 as a, 1 as b union select 1 as a, 2 as b;
select * from t1;
drop table t1;
create table if not exists t1 (a int unique, b int)
  ignore select 1 as a, 1 as b union select 1 as a, 2 as b;
select * from t1;
drop table t1;
create function f()
returns int
begin
insert into t2 values(1);
create table t2(c1 int);
create table t1 select f();
create temporary table t1 select f();


drop table t2;
create table t3(c1 int);
create view t2 as select c1 from t3;
create table t1 select f();
create temporary table t1 select f();

drop view t2;
create table t4(c1 int);
create view t2 as select t3.c1 as c1 from t3, t4;
create table t1 select f();
create temporary table t1 select f();

drop view t2;
drop tables t3, t4;
create view t2 as select 1;
create table t1 select f();
create temporary table t1 select f();

drop view t2;
drop function f;
CREATE TABLE t1 (v varchar(65535) CHARACTER SET latin1);
CREATE TABLE t01234567890123456789012345678901234567890123456789012345678901234567890123456789(a int);
CREATE DATABASE t01234567890123456789012345678901234567890123456789012345678901234567890123456789;
let $MYSQLD_DATADIR= `SELECT @@datadir`;
--         directory. Dropping such database should throw ER_DB_DROP_RMDIR
--         error.
CREATE DATABASE db_with_no_tables_and_an_unrelated_file_in_data_directory;
EOF
--replace_result $MYSQLD_DATADIR ./ \\ /
--replace_regex /errno: [0-9]+ - .*\)/errno: --# - ...)/
--error ER_DB_DROP_RMDIR
DROP DATABASE db_with_no_tables_and_an_unrelated_file_in_data_directory;
DROP DATABASE db_with_no_tables_and_an_unrelated_file_in_data_directory;

-- Case 2: A database with tables in it and has an unrelated file in it's database
--         directory. Dropping such database should throw ER_DB_DROP_RMDIR
--         error.
CREATE DATABASE db_with_tables_and_an_unrelated_file_in_data_directory;
EOF
--replace_result $MYSQLD_DATADIR ./ \\ /
--replace_regex /errno: [0-9]+ - .*\)/errno: --# - ...)/
--error ER_DB_DROP_RMDIR
DROP DATABASE db_with_tables_and_an_unrelated_file_in_data_directory;
DROP DATABASE db_with_tables_and_an_unrelated_file_in_data_directory;

-- Case 3: A database (fakely created using mkdir) and has an unrelated file in it's database
--         directory. Dropping such database should throw ER_SCHEMA_DIR_UNKNOWN
--         error (creating a database with mkdir is not supported with new DD).
--mkdir $MYSQLD_DATADIR/db_created_with_mkdir_and_an_unrelated_file_in_data_directory
--write_file $MYSQLD_DATADIR/db_created_with_mkdir_and_an_unrelated_file_in_data_directory/intruder.txt
EOF
--replace_result $MYSQLD_DATADIR ./ \\ /
--error ER_SCHEMA_DIR_UNKNOWN
DROP DATABASE db_created_with_mkdir_and_an_unrelated_file_in_data_directory;
CREATE TABLE t1 (id INT) INDEX DIRECTORY = 'a--######################################################b#######################################################################################b#####################################################################################b######################################################################################b######################################################################################b#############################################################################################################';
CREATE TABLE t2 (id INT NOT NULL, name VARCHAR(30))
ENGINE = InnoDB
PARTITION BY RANGE (id) (
PARTITION p0 VALUES LESS THAN (10) INDEX DIRECTORY = 'a--######################################################b#######################################################################################b#####################################################################################b######################################################################################b######################################################################################b#############################################################################################################'
);
CREATE TABLE t3 (id INT) INDEX DIRECTORY = 'test';
CREATE TABLE t4 (id INT NOT NULL, name VARCHAR(30))
ENGINE = InnoDB
PARTITION BY RANGE (id) (
PARTITION p0 VALUES LESS THAN (10) INDEX DIRECTORY = 'test'
);


-- TODO : Enable following once shared tablespaces are allowed in Partitioned
--	 Tables (wl#12034).
----echo #
----echo # Bug #27331588: ASSERTION `THD->MDL_CONTEXT.OWNS_EQUAL_OR_STRONGER_LOCK
----echo # MDL_KEY::TABLESPACE
----echo #
--
--SET GLOBAL innodb_file_per_table= 0;
SET @saved_innodb_default_row_format= @@global.innodb_default_row_format;
SET @saved_show_create_table_verbosity= @@session.show_create_table_verbosity;
SELECT @@global.innodb_default_row_format;
SELECT @@session.show_create_table_verbosity;

CREATE TABLE t1(fld1 INT) ENGINE= InnoDB;
CREATE TABLE t2(fld1 INT) ENGINE= InnoDB, ROW_FORMAT= DEFAULT;
SET GLOBAL innodb_default_row_format= 'COMPACT';
CREATE TABLE t3(fld1 INT) ENGINE= InnoDB;
CREATE TABLE t4(fl1 INT) ENGINE= InnoDB, ROW_FORMAT= COMPRESSED;
SET SESSION show_create_table_verbosity= ON;

SET GLOBAL innodb_default_row_format= 'DYNAMIC';
SET SESSION show_create_table_verbosity= OFF;
CREATE TEMPORARY TABLE t1(fld1 INT) ENGINE= InnoDB;
CREATE TEMPORARY TABLE t2(fld1 INT) ENGINE= InnoDB, ROW_FORMAT= DEFAULT;
SET GLOBAL innodb_default_row_format= 'COMPACT';
CREATE TEMPORARY TABLE t3(fld1 INT) ENGINE= InnoDB;
CREATE TEMPORARY TABLE t4(fl1 INT) ENGINE= InnoDB, ROW_FORMAT= REDUNDANT;
SET SESSION show_create_table_verbosity= ON;
DROP TABLE t1, t2, t3, t4;
DROP TABLE t1, t2, t3, t4;
SET GLOBAL innodb_default_row_format= @saved_innodb_default_row_format;
SET SESSION show_create_table_verbosity= @saved_show_create_table_verbosity;

CREATE TABLE t0(a ENUM('aaa', 'bbb', 'ccc') BYTE);
CREATE TABLE t1(a ENUM( b'1001001'));

CREATE TABLE t2(a ENUM( b'1001001') BYTE);
CREATE TABLE t3(a ENUM( b'10010010') BYTE);

CREATE TABLE t4(a ENUM( b'1001001101101111') BYTE);

CREATE TABLE t5(a ENUM( b'10010011011011111111011000011') BYTE);

CREATE TABLE t6 (a INT);
ALTER TABLE t6
MODIFY COLUMN a ENUM( b'10010011011011111111011000011') BYTE UNIQUE FIRST;

DROP TABLE t6;
DROP TABLE t5;
DROP TABLE t4;
DROP TABLE t3;
DROP TABLE t2;
DROP TABLE t1;
DROP TABLE t0;

SET GLOBAL sql_require_primary_key= ON;
SELECT @@global.sql_require_primary_key;
SELECT @@session.sql_require_primary_key;
CREATE TABLE t1(i INT);
CREATE TABLE t2(i INT PRIMARY KEY, j INT);
ALTER TABLE t2 DROP COLUMN i;

DROP TABLE t2;
DROP TABLE t1;

SELECT @@session.sql_require_primary_key;
CREATE TABLE t1(i INT);
CREATE TABLE t1(i INT PRIMARY KEY, j INT);
ALTER TABLE t1 DROP COLUMN i;

DROP TABLE t1;
SET SESSION sql_require_primary_key= OFF;

SELECT @@session.sql_require_primary_key;
CREATE TABLE t1(i INT);
CREATE TABLE t2(i INT PRIMARY KEY, j INT);
ALTER TABLE t2 DROP COLUMN i;

DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1(i INT);

SET SESSION sql_require_primary_key= ON;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 (I INT PRIMARY KEY);
CREATE TABLE t4 AS SELECT 1;
CREATE TABLE t4 AS SELECT * FROM t1;
CREATE TABLE t4 AS SELECT * FROM t3;
CREATE TABLE t4(i INT PRIMARY KEY) AS SELECT * FROM t3;
CREATE TABLE t5(i INT PRIMARY KEY, j INT);
ALTER TABLE t5 DROP PRIMARY KEY, ADD CONSTRAINT PRIMARY KEY (j);
CREATE TEMPORARY TABLE t6(i INT);
DROP TABLE t5;
DROP TABLE t4;
DROP TABLE t3;
DROP TABLE t1;
CREATE USER subuser@localhost;
SET SESSION sql_require_primary_key= OFF;
SET GLOBAL sql_require_primary_key= OFF;
DROP USER subuser@localhost;

SET GLOBAL sql_require_primary_key= OFF;

SET @saved_mode= @@sql_mode;

CREATE TABLE t1(fld1 int);

CREATE TABLE t2 SELECT fld1, CURDATE() fld2 FROM t1;
CREATE TABLE t3 AS SELECT now();
DROP TABLE t2, t3;

SET SQL_MODE= "NO_ZERO_DATE";
CREATE TABLE t2 SELECT fld1, CURDATE() fld2 FROM t1;
CREATE TABLE t3 AS SELECT now();
DROP TABLE t1, t2, t3;

SET SQL_MODE= DEFAULT;

CREATE TABLE t1(fld1 DATETIME NOT NULL DEFAULT '1111:11:11');
CREATE TABLE t2 AS SELECT * FROM t1;

DROP TABLE t1, t2;
CREATE TABLE t1 (fld1 INT, fld2 DATETIME DEFAULT '1211:1:1');
CREATE TRIGGER t1_bi BEFORE INSERT ON t1
FOR EACH ROW
BEGIN
  CREATE TEMPORARY TABLE t2 AS SELECT NEW.fld1, NEW.fld2;
END
|
DELIMITER ;

INSERT INTO t1 VALUES (1, '1111:11:11');

DROP TABLE t1;
DROP TEMPORARY TABLE t2;
SET SQL_MODE= @saved_mode;
CREATE TABLE t1(i INT);

SET SESSION sql_require_primary_key=1;
CREATE TABLE IF NOT EXISTS t1(i INT);
SET SESSION sql_require_primary_key=DEFAULT;
DROP TABLE t1;

CREATE TABLE types(id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100));
INSERT INTO types(name) VALUES
('TINYINT'), ('SMALLINT'), ('MEDIUMINT'), ('INT'), ('BIGINT'),
('TINYINT(10)'), ('SMALLINT(10)'), ('MEDIUMINT(10)'), ('INT(10)'), ('BIGINT(10)'),
('DOUBLE'), ('FLOAT'), ('DECIMAL(5, 2)'), ('YEAR');
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
ALTER TABLE t1 ADD COLUMN col2 VARCHAR(10);
DROP TABLE t1, t2, t3;
DROP FUNCTION f1;
DROP FUNCTION f2;
DROP FUNCTION f3;
DROP TABLE types;

CREATE TABLE t1(
  a TINYINT,
  b SMALLINT,
  c MEDIUMINT,
  d INT,
  e BIGINT,
  f TINYINT(1),
  g SMALLINT(1),
  h MEDIUMINT(1),
  i INT(1),
  j BIGINT(1),
  k TINYINT ZEROFILL,
  l SMALLINT ZEROFILL,
  m MEDIUMINT ZEROFILL,
  n INT ZEROFILL,
  o BIGINT ZEROFILL
);
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 't1';

CREATE VIEW v1 AS SELECT * FROM t1;
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v1';
DROP VIEW v1;
DROP TABLE t1;

CREATE FUNCTION f1(a INT) RETURNS INT RETURN 1;
CREATE FUNCTION f2(a INT ZEROFILL) RETURNS INT ZEROFILL RETURN 1;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f2';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f2';

DROP FUNCTION f1;
DROP FUNCTION f2;

CREATE PROCEDURE p1(a INT, b INT ZEROFILL) BEGIN END;

-- Not part of SHOW CREATE output ...
SHOW CREATE PROCEDURE p1;

-- ... but part of I_S.PARAMETERS
--sorted_result
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'p1';

DROP PROCEDURE p1;

CREATE TABLE t1(a BOOLEAN, b TINYINT(1), c TINYINT(1) UNSIGNED, d TINYINT(1) ZEROFILL);
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 't1';

CREATE VIEW v1 AS SELECT * FROM t1;
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v1';
DROP VIEW v1;
DROP TABLE t1;

CREATE FUNCTION f1(a BOOLEAN, b TINYINT(1), c TINYINT(1) UNSIGNED,
                   d TINYINT(1) ZEROFILL) RETURNS BOOLEAN RETURN 1;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f1';
DROP FUNCTION f1;

CREATE PROCEDURE p1(a BOOLEAN, b TINYINT(1), c TINYINT(1) UNSIGNED,
                    d TINYINT(1) ZEROFILL) BEGIN END;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'p1';
DROP PROCEDURE p1;
CREATE TABLE t1(i INT PRIMARY KEY) KEY_BLOCK_SIZE = 2147483647;
CREATE TABLE t1(i INT PRIMARY KEY) KEY_BLOCK_SIZE = -2147483647;
CREATE TABLE t1(i INT PRIMARY KEY) KEY_BLOCK_SIZE = 2147483648;
CREATE TABLE t1(i INT PRIMARY KEY) KEY_BLOCK_SIZE = -2147483648;
CREATE TABLE t2(i INT PRIMARY KEY) KEY_BLOCK_SIZE = 4294967295;
CREATE TABLE t3(i INT PRIMARY KEY) KEY_BLOCK_SIZE = 4294967296;
CREATE TABLE t4(
c0 DECIMAL ZEROFILL  UNIQUE KEY STORAGE MEMORY,
c1 DECIMAL ZEROFILL  PRIMARY KEY COLUMN_FORMAT DYNAMIC UNIQUE KEY STORAGE MEMORY NOT NULL,
c2 FLOAT ZEROFILL  COMMENT 'asdf'  COLUMN_FORMAT FIXED NULL STORAGE MEMORY,
c3 TINYINT(120) ZEROFILL   STORAGE DISK UNIQUE KEY NULL COMMENT 'asdf'
) CHECKSUM = 1, AUTO_INCREMENT = 1093400439, KEY_BLOCK_SIZE = 3927749503218772669, COMPRESSION = 'NONE';
CREATE TABLE t1(a INT) ENGINE=myisam key_block_size=65535;
DROP TABLE t1;
CREATE TABLE t1(a INT) avg_row_length=18446744073709551615;
CREATE TABLE t1(a INT) avg_row_length=4294967296;
CREATE TABLE t1(a INT) avg_row_length=4294967295;
DROP TABLE t1;
CREATE TABLE t1(a INT) max_rows=18446744073709551615;
DROP TABLE t1;
CREATE TABLE t1(a INT) min_rows=18446744073709551615;
DROP TABLE t1;

CREATE TABLE t1 AS SELECT @max_error_count UNION SELECT 'a';

-- The testcase produces different results when binlogging is turned
-- off, cf. Bug#35328161 Inconsequent type derivation when using
-- @variable and binlog off.
-- Accept both results until the bug is fixed.
CREATE TABLE t2 AS SELECT @max_error_count UNION SELECT 'a';
DROP TABLE t1, t2;

CREATE TABLE t1 (x INT);
INSERT INTO t1 VALUES (1), (2), (3);
CREATE TABLE t2 (pk INT PRIMARY KEY);
INSERT INTO t2 VALUES (1), (2), (3);
CREATE TABLE t3 AS
  SELECT 1 FROM t1 LEFT JOIN t2
  ON t1.x IN (SELECT it1.pk FROM t2 AS it1, t2 AS it2);
SELECT COUNT(*) FROM t3;
DROP TABLE t1, t2, t3;
