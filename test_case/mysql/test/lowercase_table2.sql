DROP TABLE IF EXISTS t1,t2,t3,t2aA,t1Aa;
DROP DATABASE IF EXISTS `TEST_$1`;
DROP DATABASE IF EXISTS `test_$1`;
DROP DATABASE IF EXISTS mysqltest_LC2;

CREATE TABLE T1 (a int) ENGINE=MyISAM;
INSERT INTO T1 VALUES (1);
SELECT * FROM t2;
ALTER TABLE T1 add b int;
ALTER TABLE T1 RENAME T2;
ALTER TABLE T2 drop b;
SELECT * from T1;
DROP TABLE T1;

--
-- Test database level
--

CREATE DATABASE `TEST_$1`;
DROP DATABASE `test_$1`;

--
-- Test of innodb tables with lower_case_table_names=2
--

CREATE TABLE T1 (a int) engine=innodb;
INSERT INTO T1 VALUES (1);
SELECT * FROM t2;
ALTER TABLE T1 add b int;
ALTER TABLE T1 RENAME T2;
ALTER TABLE T2 drop b;
SELECT * from T1;
DROP TABLE T1;

--
-- Test problem with temporary tables (Bug #2858)
--

create table T1 (EVENT_ID int auto_increment primary key,  LOCATION char(20));
insert into T1 values (NULL,"Mic-4"),(NULL,"Mic-5"),(NULL,"Mic-6");
SELECT LOCATION FROM T1 WHERE EVENT_ID=2 UNION ALL  SELECT LOCATION FROM T1 WHERE EVENT_ID=3;
SELECT LOCATION FROM T1 WHERE EVENT_ID=2 UNION ALL  SELECT LOCATION FROM T1 WHERE EVENT_ID=3;
SELECT LOCATION FROM T1 WHERE EVENT_ID=2 UNION ALL  SELECT LOCATION FROM T1 WHERE EVENT_ID=3;
drop table T1;

--
-- Test name conversion with ALTER TABLE / CREATE INDEX (Bug #3109)
--

create table T1 (A int);
alter table T1 add index (A);
alter table t1 add index (A);
drop table t1;

--
-- Bug #7261: Alter table loses temp table
--

create temporary table T1(a int(11), b varchar(8));
insert into T1 values (1, 'abc');
select * from T1;
alter table T1 add index (a);
select * from T1;
drop table T1;

--
-- Bug #8355: Tables not dropped from table cache on drop db
--
create database mysqltest_LC2;
use mysqltest_LC2;
create table myUC (i int);
insert into myUC values (1),(2),(3);
select * from myUC;
use test;
drop database mysqltest_LC2;
create database mysqltest_LC2;
use mysqltest_LC2;
create table myUC (i int);
select * from myUC;
use test;
drop database mysqltest_LC2;

--
-- Bug #9500: Problem with WHERE clause
--
create table t2aA (col1 int);
create table t1Aa (col1 int);
select t1Aa.col1 from t1aA,t2Aa where t1Aa.col1 = t2aA.col1;
drop table t2aA, t1Aa;

-- End of 4.1 tests

--
-- Bug#17661 information_schema.SCHEMATA returns uppercase with lower_case_table_names = 1
--
create database mysqltest_LC2;
use mysqltest_LC2;
create table myUC (i int);
select TABLE_SCHEMA,TABLE_NAME FROM information_schema.TABLES
where TABLE_SCHEMA ='mysqltest_LC2';
use test;
drop database mysqltest_LC2;

CREATE DATABASE BUP_XPFM_COMPAT_DB2;

CREATE TABLE BUP_XPFM_COMPAT_DB2.TABLE2 (c13 INT) DEFAULT CHARSET latin1;
CREATE TABLE BUP_XPFM_COMPAT_DB2.table1 (c13 INT) DEFAULT CHARSET latin1;
CREATE TABLE bup_xpfm_compat_db2.table3 (c13 INT) DEFAULT CHARSET latin1;
CREATE TRIGGER BUP_XPFM_COMPAT_DB2.trigger1 AFTER INSERT
  ON BUP_XPFM_COMPAT_DB2.table1 FOR EACH ROW
  update BUP_XPFM_COMPAT_DB2.table1 set c13=12;
CREATE TRIGGER BUP_XPFM_COMPAT_DB2.TRIGGER2 AFTER INSERT
  ON BUP_XPFM_COMPAT_DB2.TABLE2 FOR EACH ROW
  update BUP_XPFM_COMPAT_DB2.table1 set c13=12;
CREATE TRIGGER BUP_XPFM_COMPAT_DB2.TrigGer3 AFTER INSERT
  ON BUP_XPFM_COMPAT_DB2.TaBle3 FOR EACH ROW
  update BUP_XPFM_COMPAT_DB2.table1 set c13=12;

SELECT trigger_schema, trigger_name, event_object_table FROM
INFORMATION_SCHEMA.TRIGGERS
  WHERE trigger_schema COLLATE utf8mb3_bin = 'BUP_XPFM_COMPAT_DB2'
  ORDER BY trigger_schema, trigger_name;

DROP DATABASE BUP_XPFM_COMPAT_DB2;
drop database if exists mysqltest_UPPERCASE;
drop table if exists t_bug44738_UPPERCASE;
create database mysqltest_UPPERCASE;
use mysqltest_UPPERCASE;
create table t_bug44738_UPPERCASE (i int) comment='Old comment';
create table t_bug44738_lowercase (i int) comment='Old comment';
select table_schema, table_name, table_comment from information_schema.tables
  where table_schema like 'mysqltest_%' and table_name like 't_bug44738_%'
  order by table_name;
alter table t_bug44738_UPPERCASE comment='New comment';
alter table t_bug44738_lowercase comment='New comment';
select table_schema, table_name, table_comment from information_schema.tables
  where table_schema like 'mysqltest_%' and table_name like 't_bug44738_%'
  order by table_name;
drop database mysqltest_UPPERCASE;
use test;
create table t_bug44738_UPPERCASE (i int);
select table_schema, table_name, table_comment from information_schema.tables
  where table_schema = 'test' and table_name like 't_bug44738_%';
drop table t_bug44738_UPPERCASE;
create table t_bug44738_UPPERCASE (i int);
drop table t_bug44738_UPPERCASE;

CREATE TABLE TestTable1 (a int);
CREATE TABLE TestTable2 LIKE TestTable1;
DROP TABLE TestTable1, TestTable2;

CREATE SCHEMA S1;
DROP SCHEMA S1;
CREATE SCHEMA S1;
CREATE TABLE S1.t1(i INT);
DROP TABLE S1.t1;
DROP SCHEMA S1;

CREATE TABLE T1 (i INT);
SELECT * FROM T1;
DROP TABLE T1;

CREATE TABLE T1 (i INT) ENGINE= MyISAM;
CREATE TABLE T2 LIKE T1;
ALTER TABLE T2 ENGINE= InnoDB;
DROP TABLE T2;
SELECT * FROM T2;
DROP TABLE T2;

-- Additional coverage for FK name generation with LCTN=2

CREATE TABLE t1(a INT PRIMARY KEY);

CREATE TABLE T2(a INT, FOREIGN KEY(a) REFERENCES t1(a));
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 'T2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 'T2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 'T3' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 'T3' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 'T4' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 'T4' ORDER BY constraint_name;

DROP TABLE T4;

CREATE TABLE T2(a INT, CONSTRAINT T2_ibfk_1 FOREIGN KEY(a) REFERENCES t1(a));
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 'T2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 'T2' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.referential_constraints
  WHERE table_name = 'T3' ORDER BY constraint_name;
SELECT constraint_name FROM information_schema.table_constraints
  WHERE table_name = 'T3' ORDER BY constraint_name;

ALTER TABLE T3 DROP FOREIGN KEY t2_ibfk_1;

DROP TABLE T3, t1;
CREATE TABLE `T1` (
`id` INT NOT NULL AUTO_INCREMENT,
`creation_utc` DATETIME NOT NULL,
PRIMARY KEY (`id`));
CREATE TRIGGER `test`.`test_table_t1_before_insert` BEFORE INSERT ON `T1`
FOR EACH ROW
BEGIN
  SET NEW.creation_utc = UTC_TIMESTAMP();
END
$$
DELIMITER ;
DROP TABLE `T1`;
