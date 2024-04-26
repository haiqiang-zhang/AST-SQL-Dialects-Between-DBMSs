
-- Skip the test when log-bin is enabled and binlog_format=STATEMENT due to
-- presence of many unsafe statements.
--source include/not_binlog_format_statement.inc

-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

-- MERGE tables require MyISAM tables
--source include/force_myisam_default.inc
--source include/have_myisam.inc

-- Clean up resources used in this test case.
--disable_warnings
drop table if exists t1,t2,t3,t4,t5,t6;
drop database if exists mysqltest;

let $MYSQLD_DATADIR= `select @@datadir`;

create table t1 (a int not null primary key auto_increment, message char(20));
create table t2 (a int not null primary key auto_increment, message char(20));
INSERT INTO t1 (message) VALUES ("Testing"),("table"),("t1");
INSERT INTO t2 (message) VALUES ("Testing"),("table"),("t2");
create table t3 (a int not null, b char(20), key(a)) engine=MERGE UNION=(t1,t2);
select * from t3;
select * from t3 order by a desc;
drop table t3;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
insert into t2 select NULL,message from t1;
insert into t1 select NULL,message from t2;
create table t3 (a int not null, b char(20), key(a)) engine=MERGE UNION=(test.t1,test.t2);
select * from t3 where a = 10;
select * from t3 where a < 10;
select * from t3 where a > 10 and a < 20;
select a from t3 order by a desc limit 10;
select a from t3 order by a desc limit 300,10;
delete from t3 where a=3;
select * from t3 where a < 10;
delete from t3 where a >= 6 and a <= 8;
select * from t3 where a < 10;
update t3 set a=3 where a=9;
select * from t3 where a < 10;
update t3 set a=6 where a=7;
select * from t3 where a < 10;

-- The following should give errors
create table t4 (a int not null, b char(10), key(a)) engine=MERGE UNION=(t1,t2);
select * from t4;
alter table t4 add column c int;
select * from t4;

--
-- Test tables in different databases
--
create database mysqltest;
create table mysqltest.t6 (a int not null primary key auto_increment, message char(20));
create table t5 (a int not null, b char(20), key(a)) engine=MERGE UNION=(test.t1,mysqltest.t6);
alter table t5 engine=myisam;
drop table t5, mysqltest.t6;
drop database mysqltest;

-- Because of windows, it's important that we drop the merge tables first!
drop table t4,t3,t1,t2;
  
create table t1 (c char(10)) engine=myisam;
create table t2 (c char(10)) engine=myisam;
create table t3 (c char(10)) union=(t1,t2) engine=merge;
insert into t1 (c) values ('test1');
insert into t1 (c) values ('test1');
insert into t1 (c) values ('test1');
insert into t2 (c) values ('test2');
insert into t2 (c) values ('test2');
insert into t2 (c) values ('test2');
select * from t3;
select * from t3;
delete from t3 where 1=1;
select * from t3;
select * from t1;
drop table t3,t2,t1;

--
-- Test 2
--

CREATE TABLE t1 (incr int not null, othr int not null, primary key(incr));
CREATE TABLE t2 (incr int not null, othr int not null, primary key(incr));
CREATE TABLE t3 (incr int not null, othr int not null, primary key(incr))
ENGINE=MERGE UNION=(t1,t2);

SELECT * from t3;

INSERT INTO t1 VALUES ( 1,10),( 3,53),( 5,21),( 7,12),( 9,17);
INSERT INTO t2 VALUES ( 2,24),( 4,33),( 6,41),( 8,26),( 0,32);
INSERT INTO t1 VALUES (11,20),(13,43),(15,11),(17,22),(19,37);
INSERT INTO t2 VALUES (12,25),(14,31),(16,42),(18,27),(10,30);

SELECT * from t3 where incr in (1,2,3,4) order by othr;
alter table t3 UNION=(t1);
select count(*) from t3;
alter table t3 UNION=(t1,t2);
select count(*) from t3;
alter table t3 ENGINE=MYISAM;
select count(*) from t3;

-- Test that ALTER TABLE rembers the old UNION

drop table t3;
CREATE TABLE t3 (incr int not null, othr int not null, primary key(incr))
ENGINE=MERGE UNION=(t1,t2);
alter table t3 drop primary key;

drop table t3,t2,t1;

--
-- Test table without unions
--
create table t1 (a int not null, key(a)) engine=merge;
select * from t1;
drop table t1;

--
-- Bug in flush tables combined with MERGE tables
--

create table t1 (a int not null, b int not null, key(a,b));
create table t2 (a int not null, b int not null, key(a,b));
create table t3 (a int not null, b int not null, key(a,b)) ENGINE=MERGE UNION=(t1,t2);
insert into t1 values (1,2),(2,1),(0,0),(4,4),(5,5),(6,6);
insert into t2 values (1,1),(2,2),(0,0),(4,4),(5,5),(6,6);
select * from t3 where a=1 order by b limit 2;
drop table t3,t1,t2;

--
-- [phi] testing INSERT_METHOD stuff
--

-- first testing of common stuff with new parameters
create table t1 (a int not null, b int not null auto_increment, primary key(a,b));
create table t2 (a int not null, b int not null auto_increment, primary key(a,b));
create table t3 (a int not null, b int not null, key(a,b)) UNION=(t1,t2) INSERT_METHOD=NO;
create table t4 (a int not null, b int not null, key(a,b)) ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=NO;
create table t5 (a int not null, b int not null auto_increment, primary key(a,b)) ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=FIRST;
create table t6 (a int not null, b int not null auto_increment, primary key(a,b)) ENGINE=MERGE UNION=(t1,t2) INSERT_METHOD=LAST;
insert into t1 values (1,NULL),(1,NULL),(1,NULL),(1,NULL);
insert into t2 values (2,NULL),(2,NULL),(2,NULL),(2,NULL);
select * from t3 order by b,a limit 3;
select * from t4 order by b,a limit 3;
select * from t5 order by b,a limit 3,3;
select * from t6 order by b,a limit 6,3;
insert into t5 values (5,1),(5,2);
insert into t6 values (6,1),(6,2);
select * from t1 order by a,b;
select * from t2 order by a,b;
select * from t4 order by a,b;
insert into t3 values (3,1),(3,2),(3,3),(3,4);
select * from t3 order by a,b;
alter table t4 UNION=(t1,t2,t3);
select * from t4 order by a,b;
alter table t4 INSERT_METHOD=FIRST;
insert into t4 values (4,1),(4,2);
select * from t1 order by a,b;
select * from t2 order by a,b;
select * from t3 order by a,b;
select * from t4 order by a,b;
select * from t5 order by a,b;
select 1;
insert into t5 values (1,NULL),(5,NULL);
insert into t6 values (2,NULL),(6,NULL);
select * from t1 order by a,b;
select * from t2 order by a,b;
select * from t5 order by a,b;
select * from t6 order by a,b;
insert into t1 values (99,NULL);
select * from t4 where a+0 > 90;
insert t5 values (1,1);
insert t6 values (2,1);
insert t5 values (1,1) on duplicate key update b=b+10;
insert t6 values (2,1) on duplicate key update b=b+20;
select * from t5 where a < 3;
drop table t6, t5, t4, t3, t2, t1;

CREATE TABLE t1 (  a int(11) NOT NULL default '0',  b int(11) NOT NULL default '0',  PRIMARY KEY  (a,b)) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,1), (2,1);
CREATE TABLE t2 (  a int(11) NOT NULL default '0',  b int(11) NOT NULL default '0',  PRIMARY KEY  (a,b)) ENGINE=MyISAM;
INSERT INTO t2 VALUES (1,2), (2,2);
CREATE TABLE t3 (  a int(11) NOT NULL default '0',  b int(11) NOT NULL default '0',  KEY a (a,b)) ENGINE=MRG_MyISAM UNION=(t1,t2);
select max(b) from t3 where a = 2;
select max(b) from t1 where a = 2;
drop table t3,t1,t2;

--
-- temporary merge tables
--
CREATE TABLE t1 (c1 INT NOT NULL);
CREATE TABLE t2 (c1 INT NOT NULL);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
CREATE TEMPORARY TABLE t3 (c1 INT NOT NULL) ENGINE=MRG_MYISAM UNION=(t1,t2);
SELECT * FROM t3;
CREATE TEMPORARY TABLE t4 (c1 INT NOT NULL) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t5 (c1 INT NOT NULL) ENGINE=MyISAM;
INSERT INTO t4 VALUES (4);
INSERT INTO t5 VALUES (5);
CREATE TEMPORARY TABLE t6 (c1 INT NOT NULL) ENGINE=MRG_MYISAM UNION=(t4,t5);
SELECT * FROM t6;
DROP TABLE t6, t3, t1, t2, t4, t5;
create temporary table t1 (a int not null);
create temporary table t2 (a int not null);
insert into t1 values (1);
insert into t2 values (2);
create table t3 (a int not null) ENGINE=MERGE UNION=(t1,t2);
select * from t3;
drop table t3, t2, t1;
create table t1 (a int not null);
create temporary table t2 (a int not null) engine=myisam;
insert into t1 values (1);
insert into t2 values (2);
create table t3 (a int not null) ENGINE=MERGE UNION=(t1,t2);
select * from t3;
drop table t3;
create temporary table t3 (a int not null) ENGINE=MERGE UNION=(t1,t2);
select * from t3;
drop table t3, t2, t1;
CREATE TEMPORARY TABLE t1 (c1 INT NOT NULL) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t2 (c1 INT NOT NULL) ENGINE=MyISAM;
CREATE TABLE t3 (c1 INT NOT NULL);
INSERT INTO t3 VALUES (3), (33);
CREATE TEMPORARY TABLE t4 (c1 INT NOT NULL) ENGINE=MERGE UNION=(t1,t2)
  INSERT_METHOD=LAST SELECT * FROM t3;
SELECT * FROM t4;
CREATE TEMPORARY TABLE t4 (c1 INT NOT NULL) ENGINE=MERGE UNION=(t1,t2)
  INSERT_METHOD=LAST;
INSERT INTO t4 SELECT * FROM t3;
ALTER TABLE t4 UNION=(t1);
ALTER TABLE t4 UNION=(t1,t2);
CREATE FUNCTION f1 () RETURNS INT RETURN (SELECT max(c1) FROM t3);
SELECT * FROM t4 WHERE c1 < f1();
DROP FUNCTION f1;
DROP TABLE t4, t3, t2, t1;

--
-- testing merge::records_in_range and optimizer
--

CREATE TABLE t1 (
  fileset_id tinyint(3) unsigned NOT NULL default '0',
  file_code varchar(32) NOT NULL default '',
  fileset_root_id tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (fileset_id,file_code),
  KEY files (fileset_id,fileset_root_id)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (2, '0000000111', 1), (2, '0000000112', 1), (2, '0000000113', 1),
(2, '0000000114', 1), (2, '0000000115', 1), (2, '0000000116', 1), (2, '0000000117', 1),
(2, '0000000118', 1), (2, '0000000119', 1), (2, '0000000120', 1);
CREATE TABLE t2 (
  fileset_id tinyint(3) unsigned NOT NULL default '0',
  file_code varchar(32) NOT NULL default '',
  fileset_root_id tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (fileset_id,file_code),
  KEY files (fileset_id,fileset_root_id)
) ENGINE=MRG_MyISAM UNION=(t1);
AND file_code BETWEEN '0000000115' AND '0000000120' LIMIT 1;
AND file_code BETWEEN '0000000115' AND '0000000120' LIMIT 1;
AND file_code BETWEEN '0000000115' AND '0000000120' LIMIT 1;
AND file_code = '0000000115' LIMIT 1;
DROP TABLE t2, t1;

--
-- Test of ORDER BY DESC on key (Bug #515)
--

create table t1 (x int, y int, index xy(x, y));
create table t2 (x int, y int, index xy(x, y));
create table t3 (x int, y int, index xy(x, y)) engine=merge union=(t1,t2);
insert into t1 values(1, 2);
insert into t2 values(1, 3);
select * from t3 where x = 1 and y < 5 order by y;
select * from t3 where x = 1 and y < 5 order by y desc;
drop table t1,t2,t3;

--
-- Bug#5232: CREATE TABLE ... SELECT
--

create table t1 (a int);
create table t2 (a int);
insert into t1 values (0);
insert into t2 values (1);
create table t3 engine=merge union=(t1, t2) select * from t1;
create table t3 engine=merge union=(t1, t2) select * from t2;
create table t3 engine=merge union=(t1, t2) select (select max(a) from t2);
drop table t1, t2;

--
-- Bug#9112 - Merge table with composite index producing invalid results with some queries
-- This test case will fail only without the bugfix and some
-- non-deterministic circumstances. It depends on properly initialized
-- "un-initialized" memory. At the time it happens with a standard
-- non-debug build. But there is no guarantee that this will be always so.
--
create table t1 (
 a double(14,4),
 b varchar(10),
 index (a,b)
) engine=merge union=(t2,t3);

create table t2 (
 a double(14,4),
 b varchar(10),
 index (a,b)
) engine=myisam;

create table t3 (
 a double(14,4),
 b varchar(10),
 index (a,b)
) engine=myisam;

insert into t2 values ( null, '');
insert into t2 values ( 9999999999.999, '');
insert into t3 select * from t2;
select min(a), max(a) from t1;
select min(a), max(a) from t1;
drop table t1, t2, t3;
create table t1 (a int,b int,c int, index (a,b,c));
create table t2 (a int,b int,c int, index (a,b,c));
create table t3 (a int,b int,c int, index (a,b,c))
  engine=merge union=(t1 ,t2);
insert into t1 (a,b,c) values (1,1,0),(1,2,0);
insert into t2 (a,b,c) values (1,1,1),(1,2,1);
select a,b,c from t3 force index (a) where a=1 order by a,b,c;

-- this actually wasn't affected:
explain select a,b,c from t3 force index (a) where a=1 order by a desc, b desc, c desc;
select a,b,c from t3 force index (a) where a=1 order by a desc, b desc, c desc;

-- BUG#7377 SHOW index on MERGE table crashes debug server
show index from t3;

drop table t1, t2, t3;

--
-- Bug#10400 - Improperly-defined MERGE table crashes with INSERT ... ON DUPLICATE KEY UPDATE
--
CREATE TABLE t1 ( a INT AUTO_INCREMENT PRIMARY KEY, b VARCHAR(10), UNIQUE (b) )
  ENGINE=MyISAM;
CREATE TABLE t2 ( a INT AUTO_INCREMENT, b VARCHAR(10), INDEX (a), INDEX (b) )
  ENGINE=MERGE UNION (t1) INSERT_METHOD=FIRST;
INSERT INTO t2 (b) VALUES (1) ON DUPLICATE KEY UPDATE b=2;
INSERT INTO t2 (b) VALUES (1) ON DUPLICATE KEY UPDATE b=3;
SELECT b FROM t2;
DROP TABLE t1, t2;


--
-- BUG#5390 - problems with merge tables
-- Problem #1: INSERT...SELECT
--
--drop table if exists t1, t2, t3;
create table t1(a int);
create table t2(a int);
insert into t1 values (1);
insert into t2 values (2);
create table t3 (a int) engine=merge union=(t1, t2) insert_method=first;
select * from t3;
insert t2 select * from t2;
select * from t2;
insert t3 select * from t1;
select * from t3;
insert t1 select * from t3;
select * from t1;
select * from t2;
select * from t3;
drop table t1, t2, t3;

--
-- BUG#21617 - crash when selecting from merge table with inconsistent
-- indexes
--
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(2),(1);
CREATE TABLE t2(a INT, KEY(a)) ENGINE=MERGE UNION=(t1);
SELECT * FROM t2 WHERE a=2;
DROP TABLE t1, t2;

--
-- BUG#10974 - No error message if merge table based on union of innodb,
-- memory
--
CREATE TABLE t1(a INT) ENGINE=MEMORY;
CREATE TABLE t2(a INT) ENGINE=MERGE UNION=(t1);
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t2(a INT) ENGINE=MERGE UNION=(t3);
SELECT * FROM t2;
DROP TABLE t2;

--
-- Underlying table definition conformance tests.
--
CREATE TABLE t1(a INT, b TEXT);
CREATE TABLE tm1(a TEXT, b INT) ENGINE=MERGE UNION=(t1);
SELECT * FROM tm1;
DROP TABLE t1, tm1;

CREATE TABLE t1(a SMALLINT, b SMALLINT);
CREATE TABLE tm1(a INT) ENGINE=MERGE UNION=(t1);
SELECT * FROM tm1;
DROP TABLE t1, tm1;

CREATE TABLE t1(a SMALLINT, b SMALLINT, KEY(a, b));
CREATE TABLE tm1(a SMALLINT, b SMALLINT, KEY(a)) ENGINE=MERGE UNION=(t1);
SELECT * FROM tm1;
DROP TABLE t1, tm1;

CREATE TABLE t1(a SMALLINT, b SMALLINT, KEY(b));
CREATE TABLE tm1(a SMALLINT, b SMALLINT, KEY(a)) ENGINE=MERGE UNION=(t1);
SELECT * FROM tm1;
DROP TABLE t1, tm1;


-- BUG#26881 - Large MERGE tables report incorrect specification when no
--             differences in tables
--
CREATE TABLE t1(c1 VARCHAR(1));
CREATE TABLE m1 LIKE t1;
ALTER TABLE m1 ENGINE=MERGE UNION=(t1);
SELECT * FROM m1;
DROP TABLE t1, m1;

CREATE TABLE t1(c1 VARCHAR(4), c2 TINYINT, c3 TINYINT, c4 TINYINT,
                c5 TINYINT, c6 TINYINT, c7 TINYINT, c8 TINYINT, c9 TINYINT);
CREATE TABLE m1 LIKE t1;
ALTER TABLE m1 ENGINE=MERGE UNION=(t1);
SELECT * FROM m1;
DROP TABLE t1, m1;

--
-- BUG#24342 - Incorrect results with query over MERGE table
--
CREATE TABLE t1 (a VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_german2_ci,
                 b INT, INDEX(a,b));
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
ALTER TABLE t3 ENGINE=MERGE UNION=(t1,t2);
INSERT INTO t1 VALUES ('ss',1);
INSERT INTO t2 VALUES ('ss',2),(0xDF,2);
SELECT COUNT(*) FROM t3 WHERE a=0xDF AND b=2;
DROP TABLE t1,t2,t3;

-- End of 4.1 tests

--
-- BUG#19648 - Merge table does not work with bit types
--
create table t1 (b bit(1));
create table t2 (b bit(1));
create table tm (b bit(1)) engine = merge union = (t1,t2);
select * from tm;
drop table tm, t1, t2;

--
-- Bug #17766: The server accepts to create MERGE tables which cannot work
--
create table t1 (a int) insert_method = last engine = merge;
insert into t1 values (1);
create table t2 (a int) engine = myisam;
alter table t1 union (t2);
insert into t1 values (1);
alter table t1 insert_method = no;
insert into t1 values (1);
drop table t2;
drop table t1;

--
-- BUG#26976 - Missing table in merge not noted in related error msg + SHOW
--             CREATE TABLE fails
--
CREATE TABLE tm1(a INT) ENGINE=MERGE UNION=(t1, t2);
SELECT * FROM tm1;
CREATE TABLE t1(a INT);
SELECT * FROM tm1;
CREATE TABLE t2(a BLOB);
SELECT * FROM tm1;
ALTER TABLE t2 MODIFY a INT;
SELECT * FROM tm1;
DROP TABLE tm1, t1, t2;

--
-- Bug#15522 - create ... select and with merge tables
--
-- This was fixed together with Bug#20662 (Infinite loop in CREATE TABLE
-- IF NOT EXISTS ... SELECT with locked tables).
-- The new behavior for MERGE tables is consistent with the
-- CREATE TABLE SELECT behavior for ordinary tables.
--
CREATE TABLE t1(c1 INT);
CREATE TABLE t2 (c1 INT) ENGINE=MERGE UNION=(t1) INSERT_METHOD=FIRST;
CREATE TABLE IF NOT EXISTS t1 SELECT * FROM t2;
DROP TABLE t1, t2;

--
-- Bug #28837: MyISAM storage engine error (134) doing delete with self-join
--

CREATE TABLE t1 (id INT NOT NULL, ref INT NOT NULL, INDEX (id)) ENGINE=MyISAM;
CREATE TABLE t2 LIKE t1;

INSERT INTO t2 (id, ref) VALUES (1,3), (2,1), (3,2), (4,5), (4,4);
INSERT INTO t1 SELECT * FROM t2;
INSERT INTO t1 SELECT * FROM t2;

CREATE TABLE t3 (id INT NOT NULL, ref INT NOT NULL, INDEX (id)) ENGINE=MERGE
                                                                UNION(t1);

SELECT * FROM t3 AS a INNER JOIN t3 AS b USING (id) WHERE a.ref < b.ref;
SELECT * FROM t3;
DELETE FROM a USING t3 AS a INNER JOIN t3 AS b USING (id) WHERE a.ref < b.ref;
SELECT * FROM t3;

DROP TABLE t1, t2, t3;

--
-- BUG#28248 - mysqldump results with MERGE ... UNION=() cannot be executed
--
CREATE TABLE t1(a INT);
CREATE TABLE m1(a INT) ENGINE=MERGE;
DROP TABLE m1;
CREATE TABLE m1(a INT) ENGINE=MERGE UNION=();
ALTER TABLE m1 UNION=(t1);
ALTER TABLE m1 UNION=();
DROP TABLE t1, m1;

--
-- BUG#35274 - merge table doesn't need any base tables, gives error 124 when
--             key accessed
--
CREATE TABLE t1(a INT, KEY(a)) ENGINE=merge;
SELECT MAX(a) FROM t1;
DROP TABLE t1;

--
-- BUG#32047 - 'Spurious' errors while opening MERGE tables
--
CREATE TABLE t1(a INT);
CREATE TABLE t2(a VARCHAR(10));
CREATE TABLE m1(a INT) ENGINE=MERGE UNION=(t1, t2);
CREATE TABLE m2(a INT) ENGINE=MERGE UNION=(t1);
SELECT * FROM t1;
SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE t1, t2, m1, m2;

--
-- Bug #8306: TRUNCATE leads to index corruption 
--
create table t1 (c1 int, index(c1));
create table t2 (c1 int, index(c1)) engine=merge union=(t1);
insert into t1 values (1);
select * from t2;
insert into t1 values (1);
select * from t2;
insert into t1 values (1);
drop table t1,t2;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1));
CREATE TABLE t3 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1,t2);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
SELECT * FROM t3;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
INSERT INTO t1 VALUES (1);
SELECT * FROM t3;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
DROP TABLE t1, t2, t3;
CREATE TEMPORARY TABLE t1 (c1 INT, INDEX(c1)) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t3 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1,t2);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
SELECT * FROM t3;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
INSERT INTO t1 VALUES (1);
CREATE TABLE t4 (c1 INT, INDEX(c1));
SELECT * FROM t3;
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1, t2, t3, t4;

--
-- Bug#26379 - Combination of FLUSH TABLE and REPAIR TABLE corrupts a MERGE table
-- Preparation
connect (con1,localhost,root,,);
CREATE TABLE t1 (c1 INT) ENGINE= MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE= MRG_MYISAM UNION= (t1) INSERT_METHOD= LAST;
    connection con1;
    sleep 1;
    INSERT INTO t2 VALUES (1);
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 INT) ENGINE= MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE= MRG_MYISAM UNION= (t1) INSERT_METHOD= LAST;
    connection con1;
    send INSERT INTO t2 VALUES (1);
    connection con1;
    reap;
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 INT) ENGINE= MyISAM;
    connection con1;
    send INSERT INTO t1 VALUES (1);
SELECT * FROM t1;
    connection con1;
    reap;
DROP TABLE t1;
CREATE TABLE t1(c1 INT);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
CREATE TABLE t3 ENGINE=MRG_MYISAM INSERT_METHOD=LAST SELECT * FROM t2;
CREATE TABLE t3 ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST
  SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT);
CREATE TABLE t3 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (3);
CREATE TABLE t4 LIKE t3;
INSERT INTO t4 VALUES (4);
DROP TABLE t4;
CREATE TABLE t4 LIKE t3;
INSERT INTO t4 VALUES (4);
CREATE TEMPORARY TABLE t4 LIKE t3;
INSERT INTO t4 VALUES (4);
INSERT INTO t4 VALUES (4);
DROP TABLE t4;
CREATE TABLE t4 (c1 INT);
INSERT INTO t4 VALUES (4);
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t5 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
DROP TABLE t4;
SELECT * FROM t3 ORDER BY c1;
SELECT * FROM t3 ORDER BY c1;
SELECT * FROM t3 ORDER BY c1;
SELECT * FROM t3 ORDER BY c1;
SELECT * FROM t3 ORDER BY c1;
SELECT * FROM t3 ORDER BY c1;
ALTER TABLE t2 RENAME TO t5;
SELECT * FROM t3 ORDER BY c1;
ALTER TABLE t5 RENAME TO t2;
SELECT * FROM t3 ORDER BY c1;
ALTER TABLE t2 RENAME TO t5;
SELECT * FROM t3 ORDER BY c1;
ALTER TABLE t5 RENAME TO t2;
SELECT * FROM t3 ORDER BY c1;
SELECT * FROM t3 ORDER BY c1;
SELECT * FROM t5 ORDER BY c1;
SELECT * FROM t3 ORDER BY c1;
ALTER TABLE t3 RENAME TO t5;
SELECT * FROM t5 ORDER BY c1;
DROP TABLE t1, t2, t5;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
DROP TABLE t2;
SELECT * FROM t2;
SELECT * FROM t1;
CREATE TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
SELECT * FROM t2;
SELECT * FROM t1;
DROP TABLE t2;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1));
CREATE TABLE t3 (c1 INT, INDEX(c1));
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (3);
CREATE TABLE t4 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t3,t2)
  INSERT_METHOD=LAST;
ALTER TABLE t4 UNION=(t3);
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t4 UNION=(t3,t2);
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t4 UNION=(t3);
ALTER TABLE t4 UNION=(t3,t2);
ALTER TABLE t4 UNION=(t3,t2,t1);
SELECT * FROM t4 ORDER BY c1;
DROP TABLE t4;
CREATE TABLE t4 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1,t2,t3)
  INSERT_METHOD=LAST;
ALTER TABLE t4 DROP INDEX c1, ADD UNIQUE INDEX (c1);
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t2 DROP INDEX c1, ADD UNIQUE INDEX (c1);
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t4 DROP INDEX c1, ADD UNIQUE INDEX (c1);
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t2 DROP INDEX c1, ADD UNIQUE INDEX (c1);
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t4 DROP INDEX c1, ADD UNIQUE INDEX (c1);
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t2 DROP INDEX c1, ADD UNIQUE INDEX (c1);
SELECT * FROM t4 ORDER BY c1;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT);
CREATE TABLE t3 (c1 INT);
CREATE TABLE t4 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2,t3)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (3);
ALTER TABLE t4 ALTER COLUMN c1 SET DEFAULT 44;
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t2 ALTER COLUMN c1 SET DEFAULT 22;
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t4 ALTER COLUMN c1 SET DEFAULT 44;
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t2 ALTER COLUMN c1 SET DEFAULT 22;
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t4 ALTER COLUMN c1 SET DEFAULT 44;
SELECT * FROM t4 ORDER BY c1;
ALTER TABLE t2 ALTER COLUMN c1 SET DEFAULT 22;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
DELETE FROM t4 WHERE c1 = 4;
CREATE TRIGGER t4_ai AFTER INSERT ON t4 FOR EACH ROW SET @a=1;
SET @a=0;
INSERT INTO t4 VALUES (4);
SELECT @a;
SELECT * FROM t4 ORDER BY c1;
DROP TRIGGER t4_ai;
CREATE TRIGGER t4_ai AFTER INSERT ON t4 FOR EACH ROW SET @a=1;
SET @a=0;
INSERT INTO t4 VALUES (4);
SELECT @a;
SELECT * FROM t4 ORDER BY c1;
DROP TRIGGER t4_ai;
DELETE FROM t4 WHERE c1 = 4;
CREATE TRIGGER t3_ai AFTER INSERT ON t3 FOR EACH ROW SET @a=1;
SET @a=0;
INSERT INTO t4 VALUES (4);
SELECT @a;
INSERT INTO t3 VALUES (33);
SELECT @a;
SELECT * FROM t4 ORDER BY c1;
DROP TRIGGER t3_ai;
CREATE TRIGGER t3_ai AFTER INSERT ON t3 FOR EACH ROW SET @a=1;
SET @a=0;
INSERT INTO t4 VALUES (4);
SELECT @a;
INSERT INTO t3 VALUES (33);
SELECT @a;
SELECT * FROM t4 ORDER BY c1;
DELETE FROM t4 WHERE c1 = 33;
DROP TRIGGER t3_ai;
DELETE FROM t4 WHERE c1 = 4;
CREATE TRIGGER t3_ai AFTER INSERT ON t3 FOR EACH ROW INSERT INTO t2 VALUES(22);
INSERT INTO t4 VALUES (4);
SELECT * FROM t4 ORDER BY c1;
INSERT INTO t3 VALUES (33);
SELECT * FROM t4 ORDER BY c1;
DELETE FROM t4 WHERE c1 = 22;
DELETE FROM t4 WHERE c1 = 33;
DROP TRIGGER t3_ai;
CREATE TRIGGER t3_ai AFTER INSERT ON t3 FOR EACH ROW INSERT INTO t2 VALUES(22);
INSERT INTO t4 VALUES (4);
SELECT * FROM t4 ORDER BY c1;
INSERT INTO t3 VALUES (33);
SELECT * FROM t4 ORDER BY c1;
DROP TRIGGER t3_ai;
DELETE FROM t4 WHERE c1 = 22;
DELETE FROM t4 WHERE c1 = 33;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
SELECT * FROM t4 ORDER BY c1;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (c1 INT, INDEX(c1));
CREATE TABLE t2 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TABLE t3 (c1 INT, INDEX(c1)) ENGINE=MRG_MYISAM UNION=(t2,t1)
  INSERT_METHOD=LAST;
ALTER TABLE t2 UNION=(t3,t1);
SELECT * FROM t2;
DROP TABLE t1, t2, t3;


--
-- Bug#25038 - Waiting TRUNCATE
-- Truncate failed with error message when table was in use by MERGE.
--
-- Show that truncate of child table after use of parent table works.
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t3 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
SELECT * FROM t3;
SELECT * FROM t3;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (id INTEGER, grp TINYINT, id_rev INTEGER);
SET @rnd_max= 2147483647;
let $1 = 10;
{
  SET @rnd= RAND();
  SET @id = CAST(@rnd * @rnd_max AS UNSIGNED);
  SET @id_rev= @rnd_max - @id;
  SET @grp= CAST(127.0 * @rnd AS UNSIGNED);
  INSERT INTO t1 (id, grp, id_rev) VALUES (@id, @grp, @id_rev);
  dec $1;
set @@read_buffer_size=2*1024*1024;
CREATE TABLE t2 SELECT * FROM t1;
INSERT INTO t1 (id, grp, id_rev) SELECT id, grp, id_rev FROM t2;
INSERT INTO t2 (id, grp, id_rev) SELECT id, grp, id_rev FROM t1;
INSERT INTO t1 (id, grp, id_rev) SELECT id, grp, id_rev FROM t2;
INSERT INTO t2 (id, grp, id_rev) SELECT id, grp, id_rev FROM t1;
INSERT INTO t1 (id, grp, id_rev) SELECT id, grp, id_rev FROM t2;
CREATE TABLE t3 (id INTEGER, grp TINYINT, id_rev INTEGER)
  ENGINE= MRG_MYISAM UNION= (t1, t2);
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t2;
SELECT COUNT(*) FROM t3;
    -- As t3 contains random numbers, results are different from test to test. 
    -- That's okay, because we test only that select doesn't yield an
    -- error. Note, that --disable_result_log doesn't suppress error output.
    --disable_result_log
    send SELECT COUNT(DISTINCT a1.id) FROM t3 AS a1, t3 AS a2
      WHERE a1.id = a2.id GROUP BY a2.grp;
    connection con1;
    reap;
    --enable_result_log
    disconnect con1;
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t2;
SELECT COUNT(*) FROM t3;
DROP TABLE t1, t2, t3;

--
-- Bug#25700 - merge base tables get corrupted by optimize/analyze/repair table
--
-- Using FLUSH TABLES before REPAIR.
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
INSERT INTO t2 VALUES (1);
SELECT * FROM t2;
DROP TABLE t1, t2;

--
-- Bug#26377 - Deadlock with MERGE and FLUSH TABLE
--
CREATE TABLE t1 ( a INT ) ENGINE=MyISAM;
CREATE TABLE m1 ( a INT ) ENGINE=MRG_MYISAM UNION=(t1);
DROP TABLE m1, t1;
CREATE TABLE t1 ( a INT ) ENGINE=MyISAM;
CREATE TABLE m1 ( a INT ) ENGINE=MRG_MYISAM UNION=(t1);
DROP TABLE m1, t1;

--
-- Bug#27660 - Falcon: merge table possible
--
-- Normal MyISAM MERGE operation.
CREATE TABLE t1 (c1 INT, c2 INT) ENGINE= MyISAM;
CREATE TABLE t2 (c1 INT, c2 INT) ENGINE= MyISAM;
CREATE TABLE t3 (c1 INT, c2 INT) ENGINE= MRG_MYISAM UNION(t1, t2);
INSERT INTO t1 VALUES (1, 1);
INSERT INTO t2 VALUES (2, 2);
SELECT * FROM t3;
ALTER TABLE t1 ENGINE= MEMORY;
INSERT INTO t1 VALUES (0, 0);
SELECT * FROM t3;
DROP TABLE t1, t2, t3;

--
-- Bug#30275 - Merge tables: flush tables or unlock tables causes server to crash
--
CREATE TABLE t1 (c1 INT, KEY(c1));
CREATE TABLE t2 (c1 INT, KEY(c1)) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=FIRST;
INSERT INTO t1 VALUES (1);
DROP TABLE t1, t2;

--
-- Test derived from test program for
-- Bug#30273 - merge tables: Can't lock file (errno: 155)
--
CREATE TABLE t1 (ID INT) ENGINE=MYISAM;
CREATE TABLE m1 (ID INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=FIRST;
INSERT INTO t1 VALUES ();
INSERT INTO m1 VALUES ();
DROP TABLE t1, m1;

--
-- Bug#35068 - Assertion fails when reading from i_s.tables
--             and there is incorrect merge table
--

-- Running the I_S query in mode where we get latest statistics
-- which would enable I_S query to contact SE and report any
-- error that might occur.
SET SESSION information_schema_stats_expiry=0;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=FIRST;
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_SCHEMA = 'test' and TABLE_NAME='tm1';

DROP TABLE tm1;
SET SESSION information_schema_stats_expiry=default;

--
-- Bug#36006 - Optimizer does table scan for select count(*)
--
CREATE TABLE t1(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2)) ENGINE=MYISAM;
CREATE TABLE t2(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2)) ENGINE=MYISAM;
CREATE TABLE t3(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2)) ENGINE=MYISAM;
CREATE TABLE t4(C1 INT, C2 INT, KEY C1(C1), KEY C2(C2))
  ENGINE=MRG_MYISAM UNION=(t1, t2, t3);
INSERT INTO t1 VALUES (1,1), (1,2),(1,3), (1,4);
INSERT INTO t2 VALUES (2,1), (2,2),(2,3), (2,4);
INSERT INTO t3 VALUES (3,1), (3,2),(3,3), (3,4);
DROP TABLE t1, t2, t3, t4;

--
-- BUG#39185 - Cardinality for merge tables calculated incorrectly.
--
CREATE TABLE t1(a INT, KEY(a));
INSERT INTO t1 VALUES(0),(1),(2),(3),(4);
CREATE TABLE m1(a INT, KEY(a)) ENGINE=MERGE UNION=(t1);
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
SELECT CARDINALITY FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_SCHEMA='test' AND TABLE_NAME='m1';
DROP TABLE t1, m1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1);
CREATE TABLE t2(a INT, b INT, dummy CHAR(16) DEFAULT '', KEY(a), KEY(b));
INSERT INTO t2(a,b) VALUES
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),(0,0),
(1,2);
CREATE TABLE t3(a INT, b INT, dummy CHAR(16) DEFAULT '', KEY(a), KEY(b))
ENGINE=MERGE UNION=(t2) INSERT_METHOD=FIRST;
INSERT INTO t3(a,b) VALUES(1,2);
SELECT t3.a FROM t1,t3 WHERE t3.b=2 AND t3.a=1;
DROP TABLE t1, t2, t3;

--
-- Bug #41305 server crashes when inserting duplicate row into a merge table
--
--echo -- insert duplicate value in child table while merge table doesn't have key
create table t1 (
        col1 int(10),
        primary key (col1)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE m1 (
  col1 int(10) NOT NULL
) ENGINE=MRG_MyISAM DEFAULT CHARSET=latin1 INSERT_METHOD=LAST UNION=(t1);

insert into m1 (col1) values (1);
insert into m1 (col1) values (1);

drop table m1, t1;
CREATE TABLE t1 (c1 INT PRIMARY KEY) ENGINE=MyISAM;
CREATE TABLE m1 (c1 INT NOT NULL) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
INSERT INTO m1  VALUES (666);
SELECT * FROM m1;
SELECT * FROM m1;
DROP TABLE m1, t1;
CREATE TABLE t1 (c1 INT PRIMARY KEY) ENGINE=MyISAM;
CREATE TABLE m1 (c1 INT NOT NULL) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
INSERT INTO m1  VALUES (666);
SELECT * FROM m1;
INSERT INTO m1 VALUES (666) ON DUPLICATE KEY UPDATE c1=c1+1;
SELECT * FROM m1;
DROP TABLE m1, t1;
CREATE TABLE t1 (c1 INT, c2 INT, UNIQUE (c1), UNIQUE (c2));
CREATE TABLE m1 (c1 INT, c2 INT, UNIQUE (c1)) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
INSERT INTO m1 VALUES (1,2);
INSERT INTO m1 VALUES (3,2);
DROP TABLE m1,t1;
CREATE TABLE t1 (c1 INT, c2 INT, UNIQUE (c1));
CREATE TABLE m1 (c1 INT, c2 INT, UNIQUE (c2)) ENGINE=MRG_MyISAM INSERT_METHOD=LAST UNION=(t1);
INSERT INTO m1 VALUES (1,2);
INSERT INTO m1 VALUES (1,4);
DROP TABLE m1,t1;

--
--Bug #44040   MySQL allows creating a MERGE table upon VIEWs but crashes 
--when using it
--

CREATE TABLE t1 (
        col1 INT(10)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

CREATE VIEW v1 as SELECT * FROM t1;
CREATE TABLE m1 (
        col1 INT(10)
)ENGINE=MRG_MyISAM DEFAULT CHARSET=latin1 INSERT_METHOD=LAST UNION=(v1);
SELECT * FROM m1;

DROP VIEW v1;
DROP TABLE m1, t1;

CREATE TABLE t1(c1 INT) ENGINE=MyISAM;
CREATE TABLE m1(c1 INT) ENGINE=MERGE UNION=(t1);
ALTER TABLE m1 ADD INDEX idx_c1(c1);
SELECT * FROM m1;
ALTER TABLE t1 ADD INDEX idx_c1(c1);
SELECT * FROM m1;

DROP TABLE m1;
DROP TABLE t1;
DROP TABLE IF EXISTS m1,t1;

CREATE TABLE t1(a int)engine=myisam;
CREATE TABLE t2(a int)engine=myisam;
CREATE TABLE t3(a int)engine=myisam;
CREATE TABLE t4(a int)engine=myisam;
CREATE TABLE t5(a int)engine=myisam;
CREATE TABLE t6(a int)engine=myisam;
CREATE TABLE t7(a int)engine=myisam;
CREATE TABLE m1(a int)engine=merge union=(t1,t2,t3,t4,t5,t6,t7);
SELECT 1 FROM m1;
DROP TABLE m1,t1,t2,t3,t4,t5,t6,t7;
SELECT 1 FROM m1;
CREATE TABLE t1(a int);
CREATE TABLE t2(a int);
CREATE TABLE t3(a int) ENGINE = MERGE UNION(t1, t2);
CREATE TRIGGER tr1 AFTER INSERT ON t3 FOR EACH ROW CALL foo();
DROP TRIGGER tr1;
DROP TABLE t1, t2, t3;
CREATE DATABASE `test/1`;

CREATE TABLE `test/1`.`t/1`(a INT);
CREATE TABLE m1(a INT) ENGINE=MERGE UNION=(`test/1`.`t/1`);
SELECT * FROM m1;
DROP TABLE m1;

CREATE TABLE `test/1`.m1(a INT) ENGINE=MERGE UNION=(`test/1`.`t/1`);
SELECT * FROM `test/1`.m1;
DROP TABLE `test/1`.m1;
DROP TABLE `test/1`.`t/1`;

CREATE TEMPORARY TABLE `test/1`.`t/1`(a INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE m1(a INT) ENGINE=MERGE UNION=(`test/1`.`t/1`);
SELECT * FROM m1;
DROP TABLE m1;

CREATE TEMPORARY TABLE `test/1`.m1(a INT) ENGINE=MERGE UNION=(`test/1`.`t/1`);
SELECT * FROM `test/1`.m1;
DROP TABLE `test/1`.m1;
DROP TABLE `test/1`.`t/1`;

DROP DATABASE `test/1`;

CREATE TABLE t1 (a INT) ENGINE=MYISAM;
INSERT INTO t1 VALUES(1);

CREATE TABLE t2 (b INT NOT NULL,c INT,d INT,e BLOB NOT NULL,
KEY idx0 (d, c)) ENGINE=MERGE;

DROP TABLE t2, t1;
DROP TABLE IF EXISTS m1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MYISAM;
CREATE TABLE m1 (c1 INT) ENGINE=MRG_MyISAM UNION=(t1) INSERT_METHOD=LAST;
DROP TABLE m1,t1;
CREATE TABLE m1 (f1 BIGINT) ENGINE=MRG_MyISAM UNION(t1);
CREATE TABLE t1 (f1 BIGINT) ENGINE = MyISAM;
DROP TABLE m1, t1;
CREATE TEMPORARY TABLE m1 (f1 BIGINT) ENGINE=MRG_MyISAM UNION(t1);
CREATE TEMPORARY TABLE t1 (f1 BIGINT) ENGINE=MyISAM;
DROP TABLE m1, t1;
drop table if exists t_parent;
set @save_table_definition_cache=@@global.table_definition_cache;
set @save_table_open_cache=@@global.table_open_cache;
set @@global.table_open_cache=400;
set @@global.table_definition_cache=400;
set @a=null;
let $1 = 400;
  dec $1;
set @a=concat("create table t_parent (a int) union(", @a,
              ") insert_method=first engine=mrg_myisam");
let $1 = 400;
{
  eval drop table t$1;
  dec $1;
drop table t_parent;
set @@global.table_definition_cache=@save_table_definition_cache;
set @@global.table_open_cache=@save_table_open_cache;

--
-- WL#4144 - Lock MERGE engine children
--
-- Test DATA/INDEX DIRECTORY
--
--disable_warnings
DROP DATABASE IF EXISTS mysql_test1;
CREATE DATABASE mysql_test1;
CREATE TABLE m1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,mysql_test1.t2)
  INSERT_METHOD=LAST;
INSERT INTO t1 VALUES (1);
INSERT INTO mysql_test1.t2 VALUES (2);
SELECT * FROM m1;
DROP TABLE t1, mysql_test1.t2, m1;
DROP DATABASE mysql_test1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT);
INSERT INTO t1 (c1) VALUES (1);
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2) INSERT_METHOD=FIRST;
CREATE TABLE t3 (c1 INT);
INSERT INTO t3 (c1) VALUES (1);
CREATE FUNCTION f1() RETURNS INT RETURN (SELECT MAX(c1) FROM t3);
CREATE VIEW v1 AS SELECT foo.c1 c1, f1() c2, bar.c1 c3, f1() c4
                    FROM tm1 foo, tm1 bar, t3;
SELECT * FROM v1;
DROP FUNCTION f1;
DROP VIEW v1;
DROP TABLE tm1, t1, t2, t3;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2)
  INSERT_METHOD=FIRST;
CREATE FUNCTION f1() RETURNS INT RETURN (SELECT MAX(c1) FROM tm1);
INSERT INTO tm1 (c1) VALUES (1);
SELECT f1() FROM (SELECT 1) AS c1;
DROP FUNCTION f1;
DROP TABLE tm1, t1, t2;
CREATE FUNCTION f1() RETURNS INT
BEGIN
  CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
  CREATE TEMPORARY TABLE t2 (c1 INT) ENGINE=MyISAM;
  CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2);
  INSERT INTO t1 (c1) VALUES (1);
SELECT f1() FROM (SELECT 1 UNION SELECT 1) c1;
DROP FUNCTION f1;
DROP TABLE tm1, t1, t2;
CREATE TEMPORARY TABLE t1 (c1 INT);
INSERT INTO t1 (c1) VALUES (1);
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1);
CREATE FUNCTION f1() RETURNS INT
BEGIN
  CREATE TEMPORARY TABLE t2 (c1 INT);
  ALTER TEMPORARY TABLE tm1 UNION=(t1,t2);
  INSERT INTO t2 (c1) VALUES (2);
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TABLE tm1, t1;
CREATE FUNCTION f1() RETURNS INT
BEGIN
  INSERT INTO tm1 VALUES (1);
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
SELECT f1();
DROP FUNCTION f1;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TABLE tm1, t1;
CREATE FUNCTION f1() RETURNS INT
BEGIN
  INSERT INTO tm1 VALUES (1);
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
SELECT f1();
DROP FUNCTION f1;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1) INSERT_METHOD=LAST;
CREATE TRIGGER t2_ai AFTER INSERT ON t2
  FOR EACH ROW INSERT INTO tm1 VALUES(11);
INSERT INTO t2 VALUES (2);
SELECT * FROM tm1;
SELECT * FROM t2;
DROP TRIGGER t2_ai;
DROP TABLE tm1, t1, t2;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TABLE tm1, t1;
CREATE FUNCTION f1() RETURNS INT
BEGIN
  INSERT INTO tm1 VALUES (1);
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
SELECT f1();
DROP FUNCTION f1;
DROP TABLE tm1, t1;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TABLE t9 (c1 INT) ENGINE=MyISAM;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TABLE tm1, t1, t9;
CREATE FUNCTION f1() RETURNS INT
BEGIN
  INSERT INTO tm1 VALUES (1);
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TABLE t9 (c1 INT) ENGINE=MyISAM;
SELECT f1();
DROP FUNCTION f1;
DROP TABLE tm1, t1, t9;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TRIGGER t2_ai AFTER INSERT ON t2
  FOR EACH ROW INSERT INTO tm1 VALUES(11);
INSERT INTO t2 VALUES (2);
SELECT * FROM tm1;
SELECT * FROM t2;
DROP TRIGGER t2_ai;
DROP TABLE tm1, t1, t2;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TRIGGER tm1_ai AFTER INSERT ON tm1
  FOR EACH ROW INSERT INTO t1 VALUES(11);
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TRIGGER tm1_ai;
DROP TABLE tm1, t1;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1)
  INSERT_METHOD=LAST;
CREATE TRIGGER tm1_ai AFTER INSERT ON tm1
  FOR EACH ROW SELECT max(c1) FROM t1 INTO @var;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
INSERT INTO tm1 VALUES (1);
SELECT * FROM tm1;
DROP TRIGGER tm1_ai;
DROP TABLE tm1, t1;

-- Don't resurrect chopped off prelocked tables.
-- The problem is not visible by test results;
CREATE TABLE t1 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t3 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t4 (c1 INT) ENGINE=MyISAM;
CREATE TABLE t5 (c1 INT) ENGINE=MyISAM;
CREATE TABLE tm1 (c1 INT) ENGINE=MRG_MYISAM UNION=(t1,t2,t3,t4,t5)
  INSERT_METHOD=LAST;
CREATE TRIGGER t2_au AFTER UPDATE ON t2
  FOR EACH ROW SELECT MAX(c1) FROM t1 INTO @var;
CREATE FUNCTION f1() RETURNS INT
  RETURN (SELECT MAX(c1) FROM t4);
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(2);
INSERT INTO t3 VALUES(3);
INSERT INTO t4 VALUES(4);
INSERT INTO t5 VALUES(5);
    connect (con1,localhost,root,,);
    send UPDATE t2, tm1 SET t2.c1=f1();
    connection con1;
    reap;
    disconnect con1;
SELECT * FROM tm1;
DROP TRIGGER t2_au;
DROP FUNCTION f1;
DROP TABLE tm1, t1, t2, t3, t4, t5;
CREATE TEMPORARY TABLE t1 (c1 INT);
CREATE TEMPORARY TABLE t2 (c1 INT);
ALTER TABLE t1 ENGINE=MERGE UNION(t_not_exists, t2);
DROP TABLE t1, t2;
DROP TABLE IF EXISTS t1, t2, t3, t4, m1, m2;
CREATE TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
INSERT INTO t1 VALUES (111, 121);
INSERT INTO m1 VALUES (211, 221);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
ALTER TABLE m1 RENAME m2;
SELECT * FROM m2;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
ALTER TABLE m2 RENAME m1;
DROP TABLE m1;
ALTER TABLE m2 RENAME m1;
SELECT * FROM m1;
ALTER TABLE m1 ADD COLUMN c3 INT;
INSERT INTO m1 VALUES (212, 222, 232);
SELECT * FROM m1;
ALTER TABLE t1 ADD COLUMN c3 INT;
ALTER TABLE t2 ADD COLUMN c3 INT;
INSERT INTO m1 VALUES (212, 222, 232);
SELECT * FROM m1;
ALTER TABLE m1 DROP COLUMN c3;
INSERT INTO m1 VALUES (213, 223);
SELECT * FROM m1;
ALTER TABLE t1 DROP COLUMN c3;
ALTER TABLE t2 DROP COLUMN c3;
INSERT INTO m1 VALUES (213, 223);
SELECT * FROM m1;
CREATE TABLE t3 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3);
INSERT INTO m1 VALUES (311, 321);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
CREATE TEMPORARY TABLE t4 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3,t4);
INSERT INTO m1 VALUES (411, 421);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SELECT * FROM t4;
ALTER TABLE m1 ENGINE=MyISAM;
INSERT INTO m1 VALUES (511, 521);
SELECT * FROM m1;
ALTER TABLE m1 ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
CREATE TEMPORARY TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (611, 621);
SELECT * FROM m1;
DROP TABLE t1;
SELECT * FROM m1;
CREATE TABLE m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 ENGINE=MyISAM SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST SELECT * FROM m1;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST SELECT * FROM m1;
CREATE TABLE m2 LIKE m1;
SELECT * FROM m2;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 LIKE m1;
SELECT * FROM m2;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
SELECT * FROM m1,m2 WHERE m1.c1=m2.c1;
DROP TABLE t1, t2, t3, t4, m1, m2;
CREATE TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT, c2 INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
INSERT INTO t1 VALUES (111, 121);
INSERT INTO m1 VALUES (211, 221);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
ALTER TABLE m1 RENAME m2;
SELECT * FROM m2;
CREATE TEMPORARY TABLE m1 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
ALTER TABLE m2 RENAME m1;
DROP TABLE m1;
ALTER TABLE m2 RENAME m1;
SELECT * FROM m1;
ALTER TABLE m1 ADD COLUMN c3 INT;
INSERT INTO m1 VALUES (212, 222, 232);
SELECT * FROM m1;
ALTER TABLE t1 ADD COLUMN c3 INT;
ALTER TABLE t2 ADD COLUMN c3 INT;
INSERT INTO m1 VALUES (212, 222, 232);
SELECT * FROM m1;
ALTER TABLE m1 DROP COLUMN c3;
INSERT INTO m1 VALUES (213, 223);
SELECT * FROM m1;
ALTER TABLE t1 DROP COLUMN c3;
ALTER TABLE t2 DROP COLUMN c3;
INSERT INTO m1 VALUES (213, 223);
SELECT * FROM m1;
CREATE TABLE t3 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3);
INSERT INTO m1 VALUES (311, 321);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
CREATE TEMPORARY TABLE t4 (c1 INT, c2 INT) ENGINE=MyISAM;
ALTER TABLE m1 UNION=(t1,t2,t3,t4);
INSERT INTO m1 VALUES (411, 421);
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;
SELECT * FROM t4;
ALTER TABLE m1 ENGINE=MyISAM;
INSERT INTO m1 VALUES (511, 521);
SELECT * FROM m1;
ALTER TABLE m1 ENGINE=MRG_MyISAM UNION=(t1,t2)
  INSERT_METHOD=LAST;
SELECT * FROM m1;
SELECT * FROM t1;
SELECT * FROM t2;
CREATE TEMPORARY TABLE t1 (c1 INT, c2 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (611, 621);
SELECT * FROM m1;
DROP TABLE t1;
SELECT * FROM m1;
CREATE TABLE m2 SELECT * FROM m1;
CREATE TEMPORARY TABLE m2 ENGINE=MyISAM SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST SELECT * FROM m1;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST SELECT * FROM m1;
CREATE TEMPORARY TABLE m2 LIKE m1;
SELECT * FROM m2;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE m2;
CREATE TEMPORARY TABLE m2 (c1 INT, c2 INT) ENGINE=MRG_MyISAM UNION=(t3,t4)
  INSERT_METHOD=LAST;
INSERT INTO m2 SELECT * FROM m1;
SELECT * FROM m2;
DROP TABLE t1, t2, t3, t4, m1, m2;
DROP TABLE IF EXISTS t1, t2, t3;
CREATE TABLE t1 (c1 int);
CREATE TABLE t2 (c1 int);
CREATE TABLE t3 (c1 int) ENGINE = MERGE UNION (t1,t2);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (c1 int);
CREATE TABLE t2 (c1 int);
CREATE TABLE t3 (c1 int) ENGINE = MERGE UNION (t1,t2);
DROP TABLE t2;
DROP TABLE t1, t3;
create table t1 (c1 int not null);
create table t2 (c1 int not null);
create table t3 (c1 int not null);

create function f1 () returns int return (select max(c1) from t3);

create table t4 (c1 int not null) engine=merge union=(t1,t2) insert_method=last ;

select * from t4 where c1 < f1();
drop function f1;
drop table t4, t3, t2, t1;
DROP TABLE IF EXISTS m1, t1;

CREATE TABLE t1 (c1 INT);
CREATE TABLE m1 (c1 INT) ENGINE=MRG_MyISAM UNION=(t1);
ALTER TABLE m1 ADD INDEX (c1);
DROP TABLE m1, t1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE m1 (c1 INT) ENGINE=MRG_MyISAM UNION=(t1);
ALTER TABLE t1 ADD INDEX (c1);
ALTER TABLE t1 ADD INDEX (c1);
DROP TABLE m1, t1;
drop tables if exists t1, m1, m2;
create table t1 (i int) engine=myisam;
create table m1 (i int) engine=mrg_myisam union=(t1) insert_method=first;
create table m2 like m1;
drop tables m1, m2, t1;
drop table if exists t1, t2, t3, m1, m2;
create table t1 (a int);
create table t2 (a int);
create table t3 (b int);
create view v1 as select * from t3,t1;
create table m1 (a int) engine=merge union (t1, t2) insert_method=last;
create table m2 (a int) engine=merge union (t1, t2) insert_method=first;
create temporary table tmp (b int);
insert into tmp (b) values (1);

insert into t1 (a) values (1);
insert into t3 (b) values (1);
insert into m1 (a) values ((select max(a) from m1));
insert into m1 (a) values ((select max(a) from m2));
insert into m1 (a) values ((select max(a) from t1));
insert into m1 (a) values ((select max(a) from t2));
insert into m1 (a) values ((select max(a) from t3, m1));
insert into m1 (a) values ((select max(a) from t3, m2));
insert into m1 (a) values ((select max(a) from t3, t1));
insert into m1 (a) values ((select max(a) from t3, t2));
insert into m1 (a) values ((select max(a) from tmp, m1));
insert into m1 (a) values ((select max(a) from tmp, m2));
insert into m1 (a) values ((select max(a) from tmp, t1));
insert into m1 (a) values ((select max(a) from tmp, t2));
insert into m1 (a) values ((select max(a) from v1));
insert into m1 (a) values ((select max(a) from tmp, v1));
update m1 set a = ((select max(a) from m1));
update m1 set a = ((select max(a) from m2));
update m1 set a = ((select max(a) from t1));
update m1 set a = ((select max(a) from t2));
update m1 set a = ((select max(a) from t3, m1));
update m1 set a = ((select max(a) from t3, m2));
update m1 set a = ((select max(a) from t3, t1));
update m1 set a = ((select max(a) from t3, t2));
update m1 set a = ((select max(a) from tmp, m1));
update m1 set a = ((select max(a) from tmp, m2));
update m1 set a = ((select max(a) from tmp, t1));
update m1 set a = ((select max(a) from tmp, t2));
update m1 set a = ((select max(a) from v1));
update m1 set a = ((select max(a) from tmp, v1));
delete from m1 where a = (select max(a) from m1);
delete from m1 where a = (select max(a) from m2);
delete from m1 where a = (select max(a) from t1);
delete from m1 where a = (select max(a) from t2);
delete from m1 where a = (select max(a) from t3, m1);
delete from m1 where a = (select max(a) from t3, m2);
delete from m1 where a = (select max(a) from t3, t1);
delete from m1 where a = (select max(a) from t3, t2);
delete from m1 where a = (select max(a) from tmp, m1);
delete from m1 where a = (select max(a) from tmp, m2);
delete from m1 where a = (select max(a) from tmp, t1);
delete from m1 where a = (select max(a) from tmp, t2);
delete from m1 where a = (select max(a) from v1);
delete from m1 where a = (select max(a) from tmp, v1);

drop view v1;
drop temporary table tmp;
drop table t1, t2, t3, m1, m2;
DROP TABLE IF EXISTS t1, t2, t_not_exists;

CREATE TABLE t1(a INT);
ALTER TABLE t1 engine= MERGE UNION (t_not_exists);

-- This caused an assert
REPAIR TABLE t1 USE_FRM;

DROP TABLE t1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT) engine= MERGE UNION (t1);

DROP TABLE t1, t2;
DROP TABLE IF EXISTS t1, m1;

CREATE TABLE t1(a INT) engine=myisam;
CREATE TABLE m1(a INT) engine=merge UNION(t1);

-- This caused an assert
--error ER_TABLE_NOT_LOCKED_FOR_WRITE
ALTER TABLE t1 engine=myisam;
DROP TABLE m1, t1;
drop tables if exists t1, t2, t3, t4, m1;
create table t1(id int) engine=myisam;
create view t3 as select 1 as id;
create table t4(id int) engine=memory;
create table m1(id int) engine=merge union=(t1,t2,t3,t4);
select * from m1;
drop tables m1, t1, t4;
drop view t3;
drop table if exists t1, t2, m1;
drop function if exists f1;
create table t1 (j int);
insert into t1 values (1);
create function f1() returns int return (select count(*) from m1);
create temporary table t2 (a int) engine=myisam;
insert into t2 values (1);
create temporary table m1 (a int) engine=merge union=(t2);
select f1() from t1;
drop tables t2, m1;
create table t2 (a int) engine=myisam;
insert into t2 values (1);
create table m1 (a int) engine=merge union=(t2);
select f1() from t1;
drop table m1;
create temporary table m1 (a int) engine=merge union=(t2);
select f1() from t1;
drop tables t1, t2, m1;
drop function f1;
create table t1 (a int) engine=myisam;
insert into t1 values (1);
create table m1 (a int) engine=merge union=(t1);
drop tables t1, m1;
create temporary table t1 (a int) engine=myisam;
insert into t1 values (1);
create temporary table m1 (a int) engine=merge union=(t1);
drop tables t1, m1;
create table t1 (a int) engine=myisam;
insert into t1 values (1);
create temporary table m1 (a int) engine=merge union=(t1);
drop tables t1, m1;

-- Check effect of Bug#27480-preliminary patch:
-- a merge-table with non-existing children, opened from a prelocked list.

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS m1;
DROP TRIGGER IF EXISTS trg1;
DROP TABLE IF EXISTS q1;
DROP TABLE IF EXISTS q2;

CREATE TABLE t1(a INT);
CREATE TABLE m1(a INT) ENGINE = MERGE UNION (q1, q2);

CREATE TRIGGER trg1 BEFORE DELETE ON t1
FOR EACH ROW
  INSERT INTO m1 VALUES (1);
DELETE FROM t1;

DROP TRIGGER trg1;
DROP TABLE t1;
DROP TABLE m1;
DROP TABLES IF EXISTS t1, t2, t3, t4;
CREATE TEMPORARY TABLE t1(i INT) ENGINE= MyISAM;
CREATE TEMPORARY TABLE t2(i INT) ENGINE= MERGE UNION= (t1) INSERT_METHOD= LAST;
ALTER TABLE t2 INSERT_METHOD= FIRST;

CREATE TABLE t3(i INT) ENGINE= MyISAM;
CREATE TABLE t4(i int) ENGINE= MERGE UNION= (t3) INSERT_METHOD= LAST;
ALTER TABLE t4 INSERT_METHOD= FIRST;
DROP TABLES t1, t2, t3, t4;
