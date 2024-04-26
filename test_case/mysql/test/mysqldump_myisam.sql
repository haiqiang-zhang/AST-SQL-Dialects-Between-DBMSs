
--
-- Bug #16502: mysqlcheck tries to check views
--
create table t1 (a int) engine=myisam;
create view v1 as select * from t1;
drop view v1;
drop table t1;

--
-- Bug #30654: mysqlcheck fails during upgrade of tables whose names include backticks
--
create table `t``1`(a int) engine=myisam;
create table `t 1`(a int) engine=myisam;
drop table `t``1`, `t 1`;

--
-- Bug#25347: mysqlcheck -A -r doesn't repair table marked as crashed
--
create database d_bug25347;
use d_bug25347;
create table t_bug25347 (a int) engine=myisam;
create view v_bug25347 as select * from t_bug25347;
insert into t_bug25347 values (1),(2),(3);
let $MYSQLD_DATADIR= `select @@datadir`;
EOF
--exec $MYSQL_CHECK --repair --databases d_bug25347
--error 130
insert into t_bug25347 values (4),(5),(6);
insert into t_bug25347 values (7),(8),(9);
select * from t_bug25347;
select * from v_bug25347;
drop view v_bug25347;
drop table t_bug25347;
drop database d_bug25347;
use test;
CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE TABLE db1.t1 (a INT) ENGINE=MYISAM;
EOF
CREATE TABLE db2.t2 (a INT);
DROP DATABASE db1;
DROP DATABASE db2;
DROP TABLE IF EXISTS `t1`;
CREATE TABLE `t1` (
  `a b` INT,
  `c"d` INT,
  `e``f` INT,
  PRIMARY KEY (`a b`, `c"d`, `e``f`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
insert into t1 values (0815, 4711, 2006);
DROP TABLE `t1`;

DROP TABLE IF EXISTS `test1`;
CREATE TABLE `test1` (
  `a1` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `test2`;
CREATE TABLE `test2` (
  `a2` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
CREATE TRIGGER `testref` BEFORE INSERT ON `test1` FOR EACH ROW BEGIN
INSERT INTO test2 SET a2 = NEW.a1;

INSERT INTO `test1` VALUES (1);
SELECT * FROM `test2`;

-- dump
--exec $MYSQL_DUMP --skip-comments --databases test > $MYSQLTEST_VARDIR/tmp/mysqldump.sql

--DROP TRIGGER testref;
SELECT * FROM `test1`;
SELECT * FROM `test2`;

DROP TRIGGER testref;
DROP TABLE test1;
DROP TABLE test2;
DROP TABLE IF EXISTS `t1 test`;
DROP TABLE IF EXISTS `t2 test`;

CREATE TABLE `t1 test` (
  `a1` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `t2 test` (
  `a2` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
CREATE TRIGGER `test trig` BEFORE INSERT ON `t1 test` FOR EACH ROW BEGIN
INSERT INTO `t2 test` SET a2 = NEW.a1;

INSERT INTO `t1 test` VALUES (1);
INSERT INTO `t1 test` VALUES (2);
INSERT INTO `t1 test` VALUES (3);
SELECT * FROM `t2 test`;

DROP TRIGGER `test trig`;
DROP TABLE `t1 test`;
DROP TABLE `t2 test`;


--
-- Bug#25993 crashes with a merge table and -c
--

CREATE TABLE t2 (a INT) ENGINE=MYISAM;
CREATE TABLE t3 (a INT) ENGINE=MYISAM;
CREATE TABLE t1 (a INT) ENGINE=merge UNION=(t2, t3);
DROP TABLE t1, t2, t3;

CREATE DATABASE `test-database`;
USE `test-database`;
CREATE TABLE `test` (`c1` VARCHAR(10)) ENGINE=MYISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
CREATE TRIGGER `trig` BEFORE INSERT ON `test` FOR EACH ROW BEGIN
END |
DELIMITER ;

ALTER DATABASE `test-database` CHARACTER SET latin1 COLLATE latin1_swedish_ci;
ALTER DATABASE `test-database` CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci ;

DROP DATABASE `test-database`;
USE test;
CREATE DATABASE BUG52792;
USE BUG52792;
CREATE TABLE t1 (c1 INT, c2 VARCHAR(20)) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1, 'aaa'), (2, 'bbb'), (3, 'ccc');
INSERT INTO t2 VALUES (1),(2),(3);
CREATE PROCEDURE simpleproc1 (OUT param1 INT)
BEGIN
  SELECT COUNT(*) INTO param1 FROM t1;
CREATE PROCEDURE simpleproc2 (OUT param1 INT)
BEGIN
  SELECT COUNT(*) INTO param1 FROM t2;
SET GLOBAL EVENT_SCHEDULER = OFF;

CREATE EVENT e1 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE BUG52792;
CREATE EVENT e2 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE BUG52792;

CREATE FUNCTION `hello1` (s CHAR(20))
  RETURNS CHAR(50) DETERMINISTIC
RETURN CONCAT('Hello, ' ,s ,'!');

CREATE FUNCTION `hello2` (s CHAR(20))
    RETURNS CHAR(50) DETERMINISTIC
RETURN CONCAT(']]>, ' , s ,'!');
CREATE TRIGGER trig1 BEFORE INSERT ON t2
  FOR EACH ROW BEGIN
    INSERT INTO t2 VALUES(1);
CREATE TRIGGER trig2 AFTER INSERT ON t2
  FOR EACH ROW BEGIN
    INSERT INTO t2 VALUES(1, ']]>');
    INSERT INTO t2 VALUES(2, '<![CDATA]]>');
    INSERT INTO t2 VALUES(3, '<![CDATA[');
    INSERT INTO t2 VALUES(4, '< > & \ " _');

CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;

CREATE USER user1;

DROP USER user1;
DROP DATABASE BUG52792;
SET NAMES default;

USE test;
SET GLOBAL EVENT_SCHEDULER = ON;
