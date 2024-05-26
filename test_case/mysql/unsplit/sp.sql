drop table if exists t1,t2,t3,t4;
drop view if exists v1;
drop procedure if exists p1;
drop procedure if exists p2;
drop function if exists f1;
drop function if exists f2;
create table t1 (
	id   char(16) not null default '',
        data int not null
) engine=myisam;
create table t2 (
	s   char(16),
        i   int,
	d   double
) engine=myisam;
drop procedure if exists foo42;
create procedure foo42()
  insert into test.t1 values ("foo", 42);
select * from t1;
delete from t1;
drop procedure foo42;
drop procedure if exists bar;
create procedure bar(x char(16), y int)
  insert into test.t1 values (x, y);
select * from t1;
delete from t1;
insert into t1 (id, data) values ("foo", 1);
update t1 set id = "kaka", data = 3 where t1.data = data;
select * from t2 order by s;
insert into t1 values ("a", 1), ("b", 2), ("c", 3);
drop temporary table if exists t3;
create temporary table t3 (id int);
insert into t3 values (1), (2), (3);
insert into t3 values (1), (2), (3);
insert into t3 values (1), (2), (3);
select 'Inner (good)' as 'h_ee';
insert into t3 values (1);
select 'Inner (good)' as 'h_es';
insert into t3 values (1);
select 'Inner (good)' as 'h_en';
select 'Inner (good)' as 'h_ew';
delete from t3;
insert into t3 values (1);
select 'Inner (good)' as 'h_ex';
insert into t3 values (1);
select 'Inner (good)' as 'h_se';
insert into t3 values (1);
select 'Inner (good)' as 'h_ss';
insert into t3 values (1);
select 'Outer (bad)' as 'h_sn';
select 'Inner (good)' as 'h_sn';
select 'Inner (good)' as 'h_sw';
delete from t3;
insert into t3 values (1);
select 'Inner (good)' as 'h_sx';
insert into t3 values (1);
select 'Inner (good)' as 'h_ne';
select 'Inner (good)' as 'h_ns';
select 'Inner (good)' as 'h_nn';
select 'Inner (good)' as 'h_we';
delete from t3;
insert into t3 values (1);
select 'Inner (good)' as 'h_ws';
delete from t3;
insert into t3 values (1);
select 'Inner (good)' as 'h_ww';
delete from t3;
insert into t3 values (1);
select 'Inner (good)' as 'h_xe';
insert into t3 values (1);
select 'Inner (good)' as 'h_xs';
insert into t3 values (1);
select 'Inner (good)' as 'h_xx';
insert into t3 values (1);
create table t3 (id int default '0' not null);
insert into t3 select 12;
insert into t3 values (0);
drop temporary table if exists temp_t1;
create temporary table temp_t1 (
    f1 int auto_increment, f2 varchar(20), primary key (f1)
  );
insert into t3 select 1 union select 1;
select 'Ok';
insert into t3 values (1);
insert into t3 values (1);
select sleep(1.1);
drop procedure if exists bug8762;
select * from t3;
insert into t3 values (1);
insert into t3 values (1);
insert into t3 values (42);
select 'Missed it' as 'Result';
select 'Missed it' as 'Result';
insert into t3 values (42);
DROP PROCEDURE IF EXISTS bug13095;
DROP TABLE IF EXISTS bug13095_t1;
DROP VIEW IF EXISTS bug13095_v1;
SELECT @str;
SELECT @str;
SELECT @str;
SELECT @str;
DROP PROCEDURE IF EXISTS bug13095;
DROP VIEW IF EXISTS bug13095_v1;
DROP TABLE IF EXISTS bug13095_t1;
select 42;
select * from t3;
select * from t3;
select * from t3;
select 1;
select 1;
select 2;
select * from t3;
select * from t3;
select * from t3;
select 'yes' as 'v';
select 'no' as 'v';
select 'done' as 'End';
select 'yes' as 'v';
select 'done' as 'End';
select 'maybe' as 'v';
select 'done' as 'End';
select '1' as 'v';
select '2' as 'v';
select '?' as 'v';
select 'done' as 'End';
select '1' as 'v';
select '2' as 'v';
select '?' as 'v';
select 'done' as 'End';
select "After NOT FOUND condtition is triggered" as '2';
select 'Missed it (correct)' as 'Result';
select 'Missed it (correct)' as 'Result';
select id from t3;
select 'Inner' as 'Handler';
insert into t3 values (1);
SELECT 1;
select 'statement after update';
select 'reachable code a1';
select 'reachable code a2';
select 'unreachable code b2';
select 'reachable code a1';
select 'reachable code a2';
select 'unreachable code b2';
drop function if exists pi;
select pi(), pi ();
create database nowhere;
drop database nowhere;
select database(), database ();
select current_user(), current_user ();
select sha2("aaa", 0), sha2 ("aaa", 0);
select 'caught something';
select 'dead code';
select 'leaving handler';
select 'do something';
select 'do something again';
select 'caught something';
select 'dead code';
select 'leaving handler';
select 'do something';
select 'do something again';
select 'caught something';
select 'dead code';
select 'leaving handler';
select 'do something';
select 'do something again';
select 'caught something';
select 'dead code';
select 'leaving handler';
select 'do something';
select 'do something again';
drop table t1,t2;
CREATE TABLE t1 (a int auto_increment primary key) engine=MyISAM;
CREATE TABLE t2 (a int auto_increment primary key, b int) engine=innodb;
select count(t_1.a),count(t_2.a) from t1 as t_1, t2 as t_2 /* must be 0,0 */;
insert into t2 values (1,1),(2,2),(3,3);
select * from t2 /* must return 1,-1 ... */;
drop table t1,t2;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2);
DROP TABLE t1;
CREATE TABLE t1 (c1 INT);
CREATE VIEW v1 AS SELECT * FROM t1;
PREPARE s1 FROM 'SELECT c1 FROM v1';
DROP VIEW v1;
DROP TABLE t1;
create database mysqltest_db1;
drop database mysqltest_db1;
drop database if exists mysqltest_db1;
drop table if exists test.t1;
create database mysqltest_db1;
drop database mysqltest_db1;
drop procedure if exists proc_25411_a;
drop procedure if exists proc_25411_b;
drop procedure if exists proc_25411_c;
select 3;
select 1/*! ,2*//*!00000 ,3*//*!99999 ,4*/;
select 1/*!,2 *//*!00000,3 *//*!99999,4 */;
select 1/*! ,2 *//*!00000 ,3 *//*!99999 ,4 */;
select 1 /*!,2*/ /*!00000,3*/ /*!99999,4*/;
select routine_name, routine_definition from information_schema.routines where routine_name like '%25411%';
select parameter_name from information_schema.parameters where SPECIFIC_NAME= '%25411%';
drop procedure if exists proc_26302;
create procedure proc_26302()
select 1 /* testing */;
select ROUTINE_NAME, ROUTINE_DEFINITION from information_schema.ROUTINES
where ROUTINE_NAME = "proc_26302";
drop procedure proc_26302;
CREATE TABLE t1 (c1 INT, INDEX(c1));
INSERT INTO t1 VALUES (1), (2), (3), (4), (5);
CREATE VIEW v1 AS SELECT c1 FROM t1;
DROP VIEW v1;
DROP TABLE t1;
select column_name from information_schema.columns
where table_name='v1' and table_schema='test' order by column_name;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP TABLE IF EXISTS t1;
CREATE PROCEDURE p1(v DATETIME) CREATE TABLE t1 SELECT v;
CREATE PROCEDURE p2(v INT) CREATE TABLE t1 SELECT v;
DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP FUNCTION IF EXISTS f3;
DROP FUNCTION IF EXISTS f4;
CREATE TABLE t1(c1 INT);
INSERT INTO t1 VALUES (1), (2), (3);
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP FUNCTION IF EXISTS f1;
CREATE TABLE t1 (
   id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
   barcode INT(8) UNSIGNED ZEROFILL nOT NULL,
   PRIMARY KEY  (id),
   UNIQUE KEY barcode (barcode)
);
INSERT INTO t1 (id, barcode) VALUES (1, 12345678);
INSERT INTO t1 (id, barcode) VALUES (2, 12345679);
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS f1;
CREATE TABLE t1(id INT);
INSERT INTO t1 VALUES (1), (2), (3);
DROP TABLE t1;
DROP DATABASE IF EXISTS db28318_a;
DROP DATABASE IF EXISTS db28318_b;
CREATE DATABASE db28318_a;
CREATE DATABASE db28318_b;
DROP DATABASE db28318_a;
DROP DATABASE db28318_b;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS bug29770;
CREATE TABLE t1(a int);
SELECT @state, @exception;
DROP TABLE t1;
drop table if exists t_33618;
drop procedure if exists proc_33618;
create table t_33618 (`a` int, unique(`a`), `b` varchar(30)) engine=myisam;
insert into t_33618 (`a`,`b`) values (1,'1'),(2,'2');
drop table t_33618;
drop function if exists func30787;
create table t1(f1 int);
insert into t1 values(1),(2);
drop table t1;
CREATE TABLE t1 (id INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
CREATE PROCEDURE test_sp()
  SELECT t1.* FROM t1 RIGHT JOIN t1 t2 ON t1.id=t2.id;
DROP PROCEDURE test_sp;
DROP TABLE t1;
create table t1(c1 INT);
drop table t1;
drop table if exists t1;
drop procedure if exists p1;
DROP VIEW IF EXISTS v1;
DROP VIEW IF EXISTS v2;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v1';
SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'v2';
DROP FUNCTION IF EXISTS f1;
drop procedure if exists p;
select @@sql_mode into @full_mode;
create procedure p() begin end;
select routine_name from information_schema.routines where routine_name = 'p' and sql_mode = @full_mode;
drop procedure p;
CREATE TABLE t1 (f1 INT);
DROP TABLE t1;
CREATE TABLE t1 ( f1 integer, primary key (f1));
CREATE TABLE t2 LIKE t1;
DROP TABLE t3;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT, b INT PRIMARY KEY);
DROP TABLE t1, t2;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP PROCEDURE IF EXISTS p3;
SELECT @@SESSION.IDENTITY;
SELECT @@GLOBAL.init_connect;
CREATE DATABASE mixedCaseDbName;
DROP DATABASE mixedCaseDbName;
CREATE TABLE t1 (a INT, b INT, KEY(b));
CREATE TABLE t2 (c INT, d INT, KEY(c));
INSERT INTO t1 VALUES (1,1),(1,1),(1,2);
INSERT INTO t2 VALUES (1,1),(1,2);
DROP TABLE t1, t2;
DROP FUNCTION IF EXISTS f1;
DROP TABLE IF EXISTS t_non_existing;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) ENGINE = myisam;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
DROP PROCEDURE IF EXISTS p1;
SELECT 1;
DROP PROCEDURE IF EXISTS p1;
SELECT CAST('10x' as UNSIGNED INTEGER);
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP PROCEDURE IF EXISTS p3;
DROP PROCEDURE IF EXISTS p4;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP FUNCTION IF EXISTS f3;
DROP FUNCTION IF EXISTS f4;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a CHAR(2));
INSERT INTO t1 VALUES ('aa');
DROP TABLE t1;
DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1 ()
COMMENT
'12345678901234567890123456789012345678901234567890123456789012345678901234567890'
BEGIN
END;
SELECT routine_comment FROM information_schema.routines WHERE routine_name = "p1";
DROP PROCEDURE p1;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS t1, t2_unrelated;
DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1(IN x INT) INSERT INTO t1 VALUES (x);
CREATE VIEW t1 AS SELECT 10 AS f1;
CREATE TEMPORARY TABLE t1 (f1 INT);
DROP VIEW t1;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
DROP PROCEDURE p1;
CREATE PROCEDURE p1(IN x INT) INSERT INTO t1 VALUES (x);
CREATE VIEW t1 AS SELECT 10 AS f1;
CREATE VIEW v2_unrelated AS SELECT 1 AS r1;
CREATE TEMPORARY TABLE t1 (f1 int);
ALTER VIEW v2_unrelated AS SELECT 2 AS r1;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
DROP VIEW t1, v2_unrelated;
DROP PROCEDURE p1;
CREATE PROCEDURE p1(IN x INT) INSERT INTO t1 VALUES (x);
CREATE TEMPORARY TABLE t1 (f1 INT);
CREATE VIEW t1 AS SELECT 10 AS f1;
DROP VIEW t1;
SELECT * FROM t1;
DROP TEMPORARY TABLE t1;
DROP PROCEDURE p1;
drop table if exists t1;
drop procedure if exists p1;
create table t1 (c1 int);
insert into t1 (c1) values (1), (2), (3), (4), (5);
drop table t1;
create table t1 (a int);
insert into t1 (a) values (1), (2), (3), (4), (5);
drop table t1;
create table t1 (c1 int);
insert into t1 (c1) values (1), (2), (3), (4), (5);
create procedure p1(p1 integer, p2 integer)
  select * from t1 limit p1, p2;
drop table t1;
drop procedure p1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);
CREATE VIEW v1 AS SELECT a FROM t2;
CREATE PROCEDURE proc() SELECT * FROM t1 NATURAL JOIN v1;
ALTER TABLE t2 CHANGE COLUMN a b CHAR;
DROP TABLE t1,t2;
DROP VIEW v1;
DROP PROCEDURE proc;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
DROP PROCEDURE IF EXISTS p1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
CREATE TABLE t3(a INT);
CREATE PROCEDURE p1()
  INSERT INTO t1(a) VALUES (1);
DROP TABLE t1, t2, t3;
DROP PROCEDURE p1;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;
CREATE TABLE t1 (s1 CHAR(5) CHARACTER SET utf8mb3);
INSERT INTO t1 VALUES ('a');
SELECT
    CASE _latin1'a'
      WHEN _utf8mb3'a' THEN 'A'
    END AS x2;
SELECT
    CASE _utf8mb3'a'
      WHEN _latin1'a' THEN _utf8mb3'A'
    END AS x3;
SELECT
    CASE s1
      WHEN _latin1'a' THEN _latin1'b'
      ELSE _latin1'c'
    END AS x4
  FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
DROP FUNCTION IF EXISTS f1;
CREATE TABLE t1 (a INT) ENGINE=myisam;
INSERT INTO t1 VALUES (1);
CREATE VIEW v1 AS SELECT a FROM t1;
CREATE PROCEDURE p1()
SELECT 1 FROM v1 JOIN t1 ON v1.a
WHERE (SELECT 1 FROM t1 WHERE v1.a);
DROP PROCEDURE p1;
prepare s from 'select 1 from `v1` join `t1` on `v1`.`a`
where (select 1 from `t1` where `v1`.`a`)';
prepare s from 'select 1 from `v1` join `t1` on `v1`.`a`';
prepare s from 'select 1 from `v1` join `t1` on `v1`.`a` join t1 as t2
on v1.a';
create view v2 as select 0 as a from t1;
prepare s from 'select 1 from `v2` join `t1` on `v2`.`a` join v1 on `v1`.`a`';
prepare s from 'select 1 from `v2` join `t1` on `v2`.`a`, v1 where `v1`.`a`';
DROP TABLE t1;
DROP VIEW v1,v2;
DROP PROCEDURE IF EXISTS p1;
SELECT row_count();
DROP FUNCTION if exists f1;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP FUNCTION IF EXISTS f3;
DROP FUNCTION IF EXISTS f4;
CREATE TABLE t1(a INT);
CREATE PROCEDURE p1()
  SET @@default_storage_engine = DEFAULT;
SELECT @@default_storage_engine;
SELECT @@default_storage_engine;
SELECT @@default_storage_engine;
DROP PROCEDURE p1;
DROP TABLE t1;
CREATE TABLE t1(a INT) ENGINE= InnoDB;
INSERT INTO t1 VALUES (123456);
DROP TABLE t1;
CREATE TABLE t1 ( a INT, b INT );
CREATE TABLE t2 ( a INT );
DROP TABLE t1, t2;
CREATE TABLE t1 ( a INT );
PREPARE stmt FROM 'CREATE TABLE t2 AS SELECT ? FROM t1';
DROP DATABASE db1;
CREATE PROCEDURE p1(IN a INT, INOUT b INT, OUT c INT) select 1;
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'f1';
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'f1';
SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'p1';
SELECT * FROM INFORMATION_SCHEMA.PARAMETERS WHERE SPECIFIC_NAME = 'p1';
DROP PROCEDURE p1;
drop table if exists t1,t3;
select 'Not reached';
drop procedure if exists bug15298_1;
drop procedure if exists bug15298_2;
create procedure 15298_1 () sql security definer show grants for current_user;
create procedure 15298_2 () sql security definer show grants;
drop procedure 15298_1;
drop procedure 15298_2;
drop table if exists t1;
drop procedure if exists p1;
create table t1 (value varchar(15)) engine=Myisam;
create procedure p1() update t1 set value='updated' where value='old';
insert into t1 (value) values ("old");
select get_lock('b26162',120);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
  info = "select 'rl_acquirer', value from t1 where get_lock('b26162',120)";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and
  info = "update t1 set value='updated' where value='old'";
select 'rl_contender', value from t1;
select release_lock('b26162');
drop procedure p1;
drop table t1;
CREATE PROCEDURE p1(i INT) BEGIN END;
DROP PROCEDURE p1;
SELECT GET_LOCK('Bug44521', 0);
SELECT 2;
SELECT count(*) = 1 FROM information_schema.processlist
  WHERE state = "User lock" AND info = "SELECT GET_LOCK('Bug44521', 100)";
SELECT RELEASE_LOCK('Bug44521');
CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1);
SELECT count(*) = 1 FROM information_schema.processlist
  WHERE state = "User lock" AND info = "SELECT * FROM v1";
DROP TABLE t1;
DROP DATABASE IF EXISTS `my.db`;
create database `my.db`;
DROP DATABASE `my.db`;
CREATE TABLE t1 (a INT, b INT);
CREATE TABLE t2 (a INT, b INT);
CREATE TABLE t3 (a INT);
INSERT INTO t1 VALUES (1, 2);
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
INSERT INTO t2 SELECT * FROM t1;
ALTER TABLE t1 ADD COLUMN (c INT);
DROP TABLE t1, t2, t3;
CREATE DATABASE test1;
CREATE TABLE test1.t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);
DROP DATABASE test1;
CREATE TABLE t1(y INT);
INSERT INTO t1 VALUES (5),(7),(9),(11),(15);
DROP TABLE t1;
CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(1, 10);
CREATE TABLE t2(c INTEGER, d INTEGER);
INSERT INTO t2 VALUES(2, 20);
SELECT t1.a, t1.b FROM t1
      UNION DISTINCT
      SELECT t2.c, t2.d FROM t2;
SELECT t1.a, t1.b FROM t1
      UNION ALL
      SELECT t2.c, t2.d FROM t2;
SELECT @sa, @sb;
DROP TABLE t1, t2;
CREATE TABLE t1( f1 INT NOT NULL PRIMARY KEY, f2 INT);
INSERT INTO t1 VALUES (1, 1);
DROP TABLE t1;
CREATE TABLE t1(a INTEGER);
CREATE TABLE t2(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(0), (1), (2);
INSERT INTO t2 VALUES(1, 10), (2, 20), (2, 21);
DROP TABLE t1, t2;
CREATE TABLE foo (
  id INTEGER NOT NULL AUTO_INCREMENT,
  fld INTEGER NOT NULL,
  PRIMARY KEY(id),
  UNIQUE KEY fld(fld)
);
SELECT @exist;
DROP TABLE foo;
CREATE TEMPORARY TABLE tmp(name VARCHAR(64), value VARCHAR(64));
SELECT 'then';
SELECT 'else';
SELECT 'while';
SELECT 'repeat';
DROP TEMPORARY TABLE tmp;
