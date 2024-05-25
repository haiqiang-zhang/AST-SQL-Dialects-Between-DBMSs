drop database if exists mysqltest;
drop view if exists v1;
create table t1 (b char(0));
insert into t1 values (""),(null);
select * from t1;
drop table if exists t1;
create table t1 (b char(0) not null);
create table if not exists t1 (b char(0) not null);
select * from t1;
drop table t1;
create table t1 (a int not null auto_increment,primary key (a)) engine=heap;
drop table t1;
drop table if exists t1,t2;
drop table if exists t1;
create table `a/a` (a int);
create table t1 like `a/a`;
drop table `a/a`;
drop table `t1`;
create table t1 (a varchar(5) default 'abcde');
insert into t1 values();
select * from t1;
drop table t1;
create table 1ea10 (1a20 int,1e int);
insert into 1ea10 values(1,1);
select 1ea10.1a20,1e+ 1e+10 from 1ea10;
drop table 1ea10;
create table t1 (`index` int);
drop table t1;
drop database if exists mysqltest;
create database mysqltest;
create table mysqltest.`$test1` (a$1 int, `$b` int, c$ int);
create table mysqltest.test2$ (a int);
drop table mysqltest.test2$;
drop database mysqltest;
create table t1 (i int);
lock tables t1 read;
create temporary table t2 (j int);
drop temporary table t2;
unlock tables;
drop table t1;
create table t1 (a int auto_increment not null primary key, B CHAR(20));
insert into t1 (b) values ("hello"),("my"),("world");
create table t2 (key (b)) select * from t1;
select * from t2 where b="world";
drop table t1,t2;
create table t1(x varchar(50) );
create table t2 select x from t1 where 1=2;
drop table t2;
create table t2 select now() as a , curtime() as b, curdate() as c , 1+1 as d , 1.0 + 1 as e , 33333333333333333 + 3 as f;
drop table t2;
create table t2 select CAST("2001-12-29" AS DATE) as d, CAST("20:45:11" AS TIME) as t, CAST("2001-12-29  20:45:11" AS DATETIME) as dt;
drop table t1,t2;
create table t1 (a tinyint);
create table t2 (a int) select * from t1;
drop table if exists t2;
drop table if exists t2;
drop table if exists t2;
drop table if exists t1,t2;
CREATE TABLE t1 (a int not null);
INSERT INTO t1 values (1),(2),(1);
DROP TABLE t1;
DROP TABLE IF EXISTS t2;
create table t1 (a int not null, b int, primary key(a), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b), key (b));
drop table t1;
create table t1 select if(1,'1','0'), month("2002-08-02");
drop table t1;
create table t1 select if('2002'='2002','Y','N');
select * from t1;
drop table if exists t1;
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
drop table t1;
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
drop table t1;
create table t1 ( k1 varchar(2), k2 int, primary key(k1,k2));
insert into t1 values ("a", 1), ("b", 2);
drop table t1;
create table t1 select x'4132';
drop table t1;
create table t1 select 1,2,3;
create table if not exists t1 select 1,2;
create table if not exists t1 select 1,2,3,4;
create table if not exists t1 select 1;
select * from t1;
drop table t1;
create table t1 (a int not null, b int, primary key (a));
insert into t1 values (1,1);
create table if not exists t1 select 2;
select * from t1;
create table if not exists t1 select 3 as 'a',4 as 'b';
select * from t1;
drop table t1;
create table t1 (a int, key(a));
create table t2 (b int, foreign key(b) references t1(a), key(b));
drop table if exists t2,t1;
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
create table t3 like t1;
create temporary table t3 like t1;
drop table t3;
drop database mysqltest;
create table t2 (j int);
lock tables t1 read;
create temporary table t3 like t1;
drop temporary table t3;
unlock tables;
drop tables t1, t2;
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
drop table t1;
SELECT @@default_storage_engine;
CREATE TABLE t1 (a int not null);
drop table t1;
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
create table t1(str varchar(10) default 'def',strnull varchar(10),intg int default '10',rel double default '3.14');
insert into t1 values ('','',0,0.0);
create table t2 select default(str) as str, default(strnull) as strnull, default(intg) as intg, default(rel) as rel from t1;
drop table t1, t2;
create table t1(name varchar(10), age smallint default -1);
create table t2(name varchar(10), age smallint default - 1);
drop table t1, t2;
create table t1(cenum enum('a'), cset set('b'));
create database mysqltest;
select database();
drop database mysqltest;
select database();
select database(), user();
create table t2 (`PRIMARY` int, index(`PRIMARY`));
create table t4 (`primary` int);
alter table t4 add index(`primary`);
create table t5 (`PRIMARY` int);
alter table t5 add index(`PRIMARY`);
drop table t1, t2, t3, t4, t5;
CREATE TABLE t1(id varchar(10) NOT NULL PRIMARY KEY, dsc longtext);
INSERT INTO t1 VALUES ('5000000001', NULL),('5000000003', 'Test'),('5000000004', NULL);
CREATE TABLE t2(id varchar(15) NOT NULL, proc varchar(100) NOT NULL, runID varchar(16) NOT NULL, start datetime NOT NULL, PRIMARY KEY  (id,proc,runID,start));
INSERT INTO t2 VALUES ('5000000001', 'proc01', '20031029090650', '2003-10-29 13:38:40'),('5000000001', 'proc02', '20031029090650', '2003-10-29 13:38:51'),('5000000001', 'proc03', '20031029090650', '2003-10-29 13:38:11'),('5000000002', 'proc09', '20031024013310', '2003-10-24 01:33:11'),('5000000002', 'proc09', '20031024153537', '2003-10-24 15:36:04'),('5000000004', 'proc01', '20031024013641', '2003-10-24 01:37:29'),('5000000004', 'proc02', '20031024013641', '2003-10-24 01:37:39');
CREATE TABLE t3  SELECT t1.dsc,COUNT(DISTINCT t2.id) AS countOfRuns  FROM t1 LEFT JOIN t2 ON (t1.id=t2.id) GROUP BY t1.id;
SELECT * FROM t3;
drop table t1, t2, t3;
create table t1 (b bool not null default false);
create table t2 (b bool not null default true);
insert into t1 values ();
insert into t2 values ();
select * from t1;
select * from t2;
drop table t1,t2;
create table t1 (a int);
unlock tables;
drop table t1;
CREATE TABLE t1 (f1 VARCHAR(255) CHARACTER SET utf8mb3);
CREATE TABLE t2 AS SELECT LEFT(f1,171) AS f2 FROM t1 UNION SELECT LEFT(f1,171) AS f2 FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t12913 (f1 ENUM ('a','b')) AS SELECT 'a' AS f1;
SELECT * FROM t12913;
DROP TABLE t12913;
create database mysqltest;
drop database mysqltest;
drop table if exists test.t1;
create database mysqltest;
create view v1 as select 'foo' from dual;
drop view v1;
drop database mysqltest;
create database mysqltest;
create database if not exists mysqltest character set latin2;
drop database mysqltest;
create table t1 (a int);
create table if not exists t1 (a int);
drop table t1;
create table t1 (
  a varchar(112) charset utf8mb3 COLLATE utf8mb3_bin not null,
  primary key (a)
) select 'test' as a;
drop table t1;
CREATE TABLE t2 (
  a int(11) default NULL
);
insert into t2 values(111);
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null, 
  b int not null, primary key (a)
) select a, 1 as b from t2;
drop table t1;
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null, 
  b int null, primary key (a)
) select a, 1 as c from t2;
drop table t1;
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin not null,
  b int not null, primary key (a)
) select 'a' as a , 1 as b from t2;
drop table t1;
create table t1 ( 
  a varchar(12) charset utf8mb3 COLLATE utf8mb3_bin,
  b int not null, primary key (a)
) select 'a' as a , 1 as b from t2;
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
) select a1,a2,a3,a4,a5,a6,a7,a8,a9 from t1;
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
) select a1,a2,a3,a4,a5,a6,a7,a8,a9 from t1;
drop table t2;
create table t2 ( a int default 3, b int default 3)
  select a1,a2 from t1;
drop table t1, t2;
create table t1 (a int);
create table if not exists t1 select 1 as a, 2 as b;
drop table t1;
create table t1 (i int);
create table if not exists t1 select 1 as i;
select * from t1;
create table if not exists t1 select * from t1;
select * from t1;
drop table t1;
create temporary table t1 (j int);
create table if not exists t1 select 1;
select * from t1;
drop temporary table t1;
select * from t1;
drop table t1;
create table t1 (i int);
insert into t1 values (1), (2);
lock tables t1 read;
unlock tables;
create table t2 (j int);
lock tables t1 read;
unlock tables;
lock table t1 read, t2 read;
create table if not exists t2 select * from t1;
unlock tables;
lock table t1 read, t2 write;
create table if not exists t2 select * from t1;
select * from t1;
unlock tables;
drop table t2;
lock tables t1 read;
create temporary table t2 select * from t1;
create temporary table if not exists t2 select * from t1;
select * from t2;
unlock tables;
drop table t1, t2;
create table t1 (upgrade int);
drop table t1;
drop table if exists t1,t2;
create table t1(a int not null, b int not null, primary key (a, b));
drop table t1;
create table t1(f1 int,f2 int);
insert into t1 value(1,1),(1,2),(1,3),(2,1),(2,2),(2,3);
create table t2 select sql_big_result f1,count(f2) from t1 group by f1;
drop table t1,t2;
CREATE TABLE t1(c1 VARCHAR(33), KEY USING BTREE (c1));
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(33), KEY (c1) USING BTREE);
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(33), KEY USING BTREE (c1) USING HASH) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(33), KEY USING HASH (c1) USING BTREE) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER AUTO_INCREMENT PRIMARY KEY, b INTEGER NOT NULL);
INSERT IGNORE INTO t1 (b) VALUES (5);
CREATE TABLE IF NOT EXISTS t2 (a INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY)
  SELECT a FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (1),(2),(3);
CREATE VIEW v1 AS SELECT t1.a FROM t1, t2;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a int, b int);
insert into t1 values (1,1),(1,2);
drop table if exists t2;
drop table if exists t2;
CREATE TABLE t2 (a int, b int, primary key (a));
SELECT * from t2;
SELECT * from t2;
drop table t2;
CREATE TEMPORARY TABLE t2 (a int, b int, primary key (a)) ENGINE=InnoDB;
SELECT * from t2;
drop table t1,t2;
select database();
select SCHEMA_NAME from information_schema.schemata
where schema_name='ÃÂÃÂ¸ÃÂÃÂ¼ÃÂÃÂ_ÃÂÃÂ±ÃÂÃÂ°ÃÂÃÂ·ÃÂÃÂ_ÃÂÃÂ²_ÃÂÃÂºÃÂÃÂ¾ÃÂÃÂ´ÃÂÃÂ¸ÃÂÃÂÃÂÃÂ¾ÃÂÃÂ²ÃÂÃÂºÃÂÃÂµ_ÃÂÃÂÃÂÃÂÃÂÃÂ8_ÃÂÃÂ´ÃÂÃÂ»ÃÂÃÂ¸ÃÂÃÂ½ÃÂÃÂ¾ÃÂÃÂ¹_ÃÂÃÂ±ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂÃÂÃÂÃÂÃÂµ_ÃÂÃÂÃÂÃÂµÃÂÃÂ¼_45';
select TABLE_NAME from information_schema.tables where
table_schema='test' order by TABLE_NAME;
select COLUMN_NAME from information_schema.columns where
table_schema='test' order by COLUMN_NAME;
select INDEX_NAME from information_schema.statistics where
table_schema='test' order by INDEX_NAME;
select TABLE_NAME from information_schema.views where
table_schema='test' order by TABLE_NAME;
select TRIGGER_NAME from information_schema.triggers where
trigger_schema='test';
select ROUTINE_NAME from information_schema.routines where
routine_schema='test';
select ROUTINE_NAME from information_schema.routines where
routine_schema='test';
drop table if exists t1,t2,t3;
drop function if exists f1;
create temporary table t3 select 1 i;
drop temporary table t3;
create table t1 as select 1;
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
CREATE TABLE t2(c1 TIMESTAMP NULL);
DROP TABLE t2;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(c1 YEAR DEFAULT 2008, c2 YEAR DEFAULT 0);
INSERT INTO t1 VALUES();
SELECT * FROM t1;
ALTER TABLE t1 MODIFY c1 YEAR DEFAULT 0;
INSERT INTO t1 VALUES();
SELECT * FROM t1;
DROP TABLE t1;
create table `me:i`(id int);
drop table `me:i`;
drop table if exists t1,t2,t3;
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
) SELECT `pk` , `int_key` FROM B;
DROP TABLE t1;
DROP TABLE B;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(f1 integer);
CREATE TABLE t2(f1 integer);
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
CREATE TEMPORARY TABLE t1 (ID INT);
CREATE TABLE IF NOT EXISTS t1 (ID INT);
INSERT INTO t1 SELECT * FROM t2;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TEMPORARY TABLE t1 (ID INT);
CREATE TABLE IF NOT EXISTS t1 SELECT * FROM t2;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TEMPORARY TABLE t1 (ID INT);
CREATE TABLE t1 SELECT * FROM t2;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
SELECT * FROM t1;
DROP TABLE t1;
DROP TEMPORARY TABLE t2;
drop tables if exists t1, t2;
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
select * from t1;
create table if not exists t1 (a int) select 2 as a;
select * from t1;
drop table t1;
create temporary table if not exists t1 (a int) select 1 as a;
select * from t1;
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
create table if not exists t1 (a int);
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
create table if not exists t1 (a int);
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
create table if not exists t1 (a int);
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
create table t1 (a int) select 1 as b, 2 as c;
select * from t1;
drop table t1;
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
create table t2(c1 int);
drop table t2;
create table t3(c1 int);
create view t2 as select c1 from t3;
drop view t2;
create table t4(c1 int);
create view t2 as select t3.c1 as c1 from t3, t4;
drop view t2;
drop tables t3, t4;
create view t2 as select 1;
drop view t2;
CREATE DATABASE db_with_no_tables_and_an_unrelated_file_in_data_directory;
DROP DATABASE db_with_no_tables_and_an_unrelated_file_in_data_directory;
CREATE DATABASE db_with_tables_and_an_unrelated_file_in_data_directory;
DROP DATABASE db_with_tables_and_an_unrelated_file_in_data_directory;
SELECT @@global.innodb_default_row_format;
SELECT @@session.show_create_table_verbosity;
CREATE TABLE t1(fld1 INT) ENGINE= InnoDB;
CREATE TABLE t2(fld1 INT) ENGINE= InnoDB, ROW_FORMAT= DEFAULT;
CREATE TABLE t3(fld1 INT) ENGINE= InnoDB;
CREATE TABLE t4(fl1 INT) ENGINE= InnoDB, ROW_FORMAT= COMPRESSED;
CREATE TEMPORARY TABLE t1(fld1 INT) ENGINE= InnoDB;
CREATE TEMPORARY TABLE t2(fld1 INT) ENGINE= InnoDB, ROW_FORMAT= DEFAULT;
CREATE TEMPORARY TABLE t3(fld1 INT) ENGINE= InnoDB;
CREATE TEMPORARY TABLE t4(fl1 INT) ENGINE= InnoDB, ROW_FORMAT= REDUNDANT;
DROP TABLE t1, t2, t3, t4;
DROP TABLE t1, t2, t3, t4;
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
SELECT @@global.sql_require_primary_key;
SELECT @@session.sql_require_primary_key;
CREATE TABLE t1(i INT);
CREATE TABLE t2(i INT PRIMARY KEY, j INT);
ALTER TABLE t2 DROP COLUMN i;
DROP TABLE t2;
DROP TABLE t1;
SELECT @@session.sql_require_primary_key;
CREATE TABLE t1(i INT);
DROP TABLE t1;
SELECT @@session.sql_require_primary_key;
CREATE TABLE t1(i INT);
CREATE TABLE t2(i INT PRIMARY KEY, j INT);
ALTER TABLE t2 DROP COLUMN i;
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1(i INT);
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 (I INT PRIMARY KEY);
CREATE TABLE t4 AS SELECT 1;
CREATE TABLE t5(i INT PRIMARY KEY, j INT);
ALTER TABLE t5 DROP PRIMARY KEY, ADD CONSTRAINT PRIMARY KEY (j);
CREATE TEMPORARY TABLE t6(i INT);
DROP TABLE t5;
DROP TABLE t4;
DROP TABLE t3;
DROP TABLE t1;
CREATE TABLE t1(fld1 int);
CREATE TABLE t3 AS SELECT now();
DROP TABLE t2, t3;
CREATE TABLE t2 SELECT fld1, CURDATE() fld2 FROM t1;
CREATE TABLE t3 AS SELECT now();
DROP TABLE t1, t2, t3;
CREATE TABLE t1(fld1 DATETIME NOT NULL DEFAULT '1111:11:11');
CREATE TABLE t2 AS SELECT * FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (fld1 INT, fld2 DATETIME DEFAULT '1211:1:1');
INSERT INTO t1 VALUES (1, '1111:11:11');
DROP TABLE t1;
CREATE TABLE t1(i INT);
CREATE TABLE IF NOT EXISTS t1(i INT);
DROP TABLE t1;
CREATE TABLE types(id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(100));
INSERT INTO types(name) VALUES
('TINYINT'), ('SMALLINT'), ('MEDIUMINT'), ('INT'), ('BIGINT'),
('TINYINT(10)'), ('SMALLINT(10)'), ('MEDIUMINT(10)'), ('INT(10)'), ('BIGINT(10)'),
('DOUBLE'), ('FLOAT'), ('DECIMAL(5, 2)'), ('YEAR');
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
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f2';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f2';
CREATE PROCEDURE p1(a INT, b INT ZEROFILL) BEGIN END;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'p1';
DROP PROCEDURE p1;
CREATE TABLE t1(a BOOLEAN, b TINYINT(1), c TINYINT(1) UNSIGNED, d TINYINT(1) ZEROFILL);
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 't1';
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v1';
DROP VIEW v1;
DROP TABLE t1;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f1';
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f1';
CREATE PROCEDURE p1(a BOOLEAN, b TINYINT(1), c TINYINT(1) UNSIGNED,
                    d TINYINT(1) ZEROFILL) BEGIN END;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'p1';
DROP PROCEDURE p1;
CREATE TABLE t1(a INT) ENGINE=myisam key_block_size=65535;
DROP TABLE t1;
CREATE TABLE t1(a INT) avg_row_length=4294967295;
DROP TABLE t1;
CREATE TABLE t1(a INT) max_rows=18446744073709551615;
DROP TABLE t1;
CREATE TABLE t1(a INT) min_rows=18446744073709551615;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT @max_error_count UNION SELECT 'a';
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
