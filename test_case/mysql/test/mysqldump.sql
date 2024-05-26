select '------ Testing with illegal table names ------' as test_sequence;
select '------ Testing with illegal database names ------' as test_sequence;
drop table t1, t2, t3;
drop database mysqldump_test_db;
create table t1 (a int(10));
create table t2 (pk int primary key auto_increment,
a int(10), b varchar(30), c datetime, d blob, e text);
insert into t1 values (NULL), (10), (20);
insert into t2 (a, b) values (NULL, NULL),(10, NULL),(NULL, "twenty"),(30, "thirty");
drop table t1, t2;
create table t1 (a text character set utf8mb3, b text character set latin1);
insert t1 values (0x4F736E616272C3BC636B, 0x4BF66C6E);
select * from t1;
select * from t1;
drop table t1;
create table `t1` (
    t1_name varchar(255) default null,
    t1_id int(10) unsigned not null auto_increment,
    key (t1_name),
    primary key (t1_id)
) auto_increment = 1000 default charset=latin1;
insert into t1 (t1_name) values('bla');
insert into t1 (t1_name) values('bla');
insert into t1 (t1_name) values('bla');
select * from t1;
DROP TABLE `t1`;
create table t1(a int);
create table t2(a int);
create table t3(a int);
drop table t1, t2, t3;
create table t1 (a int);
drop table t1;
DROP TABLE IF EXISTS `t1`;
CREATE TABLE `t1` (
  `a b` INT,
  `c"d` INT,
  `e``f` INT,
  PRIMARY KEY (`a b`, `c"d`, `e``f`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
insert into t1 values (0815, 4711, 2006);
DROP TABLE `t1`;
create database db1;
CREATE TABLE t2 (
  a varchar(30) default NULL,
  KEY a (a(5))
);
INSERT INTO t2 VALUES ('alfred');
INSERT INTO t2 VALUES ('angie');
INSERT INTO t2 VALUES ('bingo');
INSERT INTO t2 VALUES ('waffle');
INSERT INTO t2 VALUES ('lemon');
create view v2 as select * from t2 where a like 'a%' with check option;
drop table t2;
drop view v2;
drop database db1;
create database db2;
create table t1 (a int);
create table t2 (a int, b varchar(10), primary key(a));
insert into t2 values (1, "on"), (2, "off"), (10, "pol"), (12, "meg");
insert into t1 values (289), (298), (234), (456), (789);
create view v1 as select * from t2;
create view v2 as select * from t1;
drop table t1, t2;
drop view v1, v2;
drop database db2;
create database db1;
drop database db1;
create table t1(a int, b int);
create view v1 as select * from t1;
create view v2 (c, d) as select * from t1;
drop view v1, v2;
drop table t1;
create database mysqldump_test_db;
CREATE TABLE t2 (
  a varchar(30) default NULL,
  KEY a (a(5))
);
INSERT INTO t2 VALUES ('alfred');
INSERT INTO t2 VALUES ('angie');
INSERT INTO t2 VALUES ('bingo');
INSERT INTO t2 VALUES ('waffle');
INSERT INTO t2 VALUES ('lemon');
create view v2 as select * from t2 where a like 'a%' with check option;
drop table t2;
drop view v2;
drop database mysqldump_test_db;
CREATE TABLE t1 (a char(10));
INSERT INTO t1 VALUES ('\'');
DROP TABLE t1;
create table t1(a int, b int, c varchar(30));
insert into t1 values(1, 2, "one"), (2, 4, "two"), (3, 6, "three");
create view v3 as
select * from t1;
create  view v1 as
select * from v3 where b in (1, 2, 3, 4, 5, 6, 7);
create  view v2 as
select v3.a from v3, v1 where v1.a=v3.a and v3.b=3 limit 1;
drop view v1, v2, v3;
drop table t1;
CREATE TABLE t1 (a int, b bigint default NULL);
CREATE TABLE t2 (a int);
INSERT INTO t1 (a) VALUES (1),(2),(3),(22);
update t1 set a = 4 where a=3;
drop table t1;
DROP TABLE IF EXISTS `test1`;
CREATE TABLE `test1` (
  `a1` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
DROP TABLE IF EXISTS `test2`;
CREATE TABLE `test2` (
  `a2` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `test1` VALUES (1);
SELECT * FROM `test2`;
SELECT * FROM `test1`;
SELECT * FROM `test2`;
DROP TABLE test1;
DROP TABLE test2;
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS bug9056_func1;
DROP FUNCTION IF EXISTS bug9056_func2;
DROP PROCEDURE IF EXISTS bug9056_proc1;
DROP PROCEDURE IF EXISTS bug9056_proc2;
DROP PROCEDURE IF EXISTS `a'b`;
CREATE TABLE t1 (id int);
INSERT INTO t1 VALUES(1), (2), (3), (4), (5);
create procedure `a'b` () select 1;
DROP PROCEDURE `a'b`;
drop table t1;
drop table if exists t1;
create table t1 (`d` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, unique (`d`));
insert into t1 values ('2003-10-25 22:00:00'),('2003-10-25 23:00:00');
select * from t1;
select * from t1;
drop table t1;
DROP TABLE IF EXISTS `t1 test`;
DROP TABLE IF EXISTS `t2 test`;
CREATE TABLE `t1 test` (
  `a1` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
CREATE TABLE `t2 test` (
  `a2` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `t1 test` VALUES (1);
INSERT INTO `t1 test` VALUES (2);
INSERT INTO `t1 test` VALUES (3);
SELECT * FROM `t2 test`;
DROP TABLE `t1 test`;
DROP TABLE `t2 test`;
drop table if exists t1;
create table t1 (a int, b varchar(32), c varchar(32));
insert into t1 values (1, 'first value', 'xxxx');
insert into t1 values (2, 'second value', 'tttt');
insert into t1 values (3, 'third value', 'vvv vvv');
create view v1 as select * from t1;
create view v0 as select * from v1;
create view v2 as select * from v0;
select * from v2;
drop view v2;
drop view v0;
drop view v1;
drop table t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
create table t1 (a binary(1), b blob);
insert into t1 values ('','');
drop table t1;
create table t1 (a int);
insert into t1 values (289), (298), (234), (456), (789);
create definer = CURRENT_USER view v1 as select * from t1;
create SQL SECURITY INVOKER view v2 as select * from t1;
create view v3 as select * from t1 with local check option;
create algorithm=merge view v4 as select * from t1 with cascaded check option;
create algorithm =temptable view v5 as select * from t1;
drop table t1;
drop view v1, v2, v3, v4, v5;
create table t1 (a int, created datetime);
drop table t1, t2;
create table t (qty int, price int);
insert into t values(3, 50);
insert into t values(5, 51);
create view v1 as select qty, price, qty*price as value from t;
create view v2 as select qty from v1;
drop view v1;
drop view v2;
drop table t;
create table t1 ( id serial );
create view v1 as select * from t1;
drop table t1;
drop view v1;
create database mysqldump_test_db;
create table t1 (id int);
create view v1 as select * from t1;
insert into t1 values (1232131);
insert into t1 values (4711);
insert into t1 values (3231);
insert into t1 values (0815);
drop view v1;
drop table t1;
drop database mysqldump_test_db;
create database mysqldump_tables;
create table basetable ( id serial, tag varchar(64) );
create database mysqldump_views;
drop database mysqldump_views;
drop database mysqldump_tables;
create database mysqldump_dba;
create table t1 (f1 int, f2 int);
insert into t1 values (1,1);
create view v1 as select f1, f2 from t1;
create database mysqldump_dbb;
insert into t1 values (2,2);
drop view v1;
drop table t1;
drop database mysqldump_dbb;
drop database mysqldump_dba;
create table t1(a int, b varchar(34));
drop table t1;
create database mysqldump_myDB;
create table t1 (c1 int);
insert into t1 values (3);
create table u1 (f1 int);
insert into u1 values (4);
create view v1 (c1) as select * from t1;
drop view v1;
drop table t1;
drop table u1;
drop database mysqldump_myDB;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (f1 int(10), data MEDIUMBLOB);
INSERT INTO t1 VALUES(1, 0xff00fef0);
DROP TABLE t1;
CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1), (2);
DROP TABLE t1;
CREATE TABLE t2 (a INT) ENGINE=MYISAM;
CREATE TABLE t3 (a INT) ENGINE=MYISAM;
CREATE TABLE t1 (a INT) ENGINE=merge UNION=(t2, t3);
DROP TABLE t1, t2, t3;
create database bug23491_original;
create database bug23491_restore;
create table t1 (c1 int);
create view v1 as select * from t1;
create procedure p1() select 1;
drop database bug23491_original;
drop database bug23491_restore;
create database mysqldump_test_db;
drop database mysqldump_test_db;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c1 INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
SELECT * FROM t2;
SELECT * FROM t2;
DROP TABLE t1,t2;
create database db42635;
create table t1 (id int);
drop database db42635;
drop table if exists t1;
CREATE TABLE t1(a int, b int);
INSERT INTO t1 VALUES (1,1);
INSERT INTO t1 VALUES (2,3);
INSERT INTO t1 VALUES (3,4), (4,5);
DROP TABLE t1;
create table t1 (a text , b text);
create table t2 (a text , b text);
insert t1 values ("Duck, Duck", "goose");
insert t1 values ("Duck, Duck", "pidgeon");
insert t2 values ("We the people", "in order to perform");
insert t2 values ("a more perfect", "union");
select * from t1;
select * from t2;
select * from t1;
select * from t2;
create table words(a varchar(255));
create table words2(b varchar(255));
select * from t1;
select * from t2;
select * from words;
select * from words2;
drop table words;
drop table t1;
drop table t2;
drop table words2;
create database first;
create event ee1 on schedule at '2035-12-31 20:01:23' do set @a=5;
drop database first;
create database second;
create event ee2 on schedule at '2029-12-31 21:01:23' do set @a=5;
create event ee3 on schedule at '2030-12-31 22:01:23' do set @a=5;
drop database second;
create database third;
drop database third;
create database mysqldump_test_db;
create table t1 (id int);
create view v1 as select * from t1;
insert into t1 values (1232131);
insert into t1 values (4711);
insert into t1 values (3231);
insert into t1 values (0815);
drop view v1;
drop table t1;
drop database mysqldump_test_db;
DROP DATABASE IF EXISTS mysqldump_test_db;
CREATE DATABASE mysqldump_test_db;
DROP DATABASE mysqldump_test_db;
CREATE event e29938 ON SCHEDULE AT '2035-12-31 20:01:23' DO SET @bug29938=29938;
DROP EVENT e29938;
create database `test-database`;
create table test (a int);
drop database `test-database`;
DROP DATABASE IF EXISTS mysqldump_test_db;
CREATE DATABASE mysqldump_test_db;
CREATE VIEW v1(x, y) AS SELECT 'a', 'a';
SELECT view_definition
FROM INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'mysqldump_test_db' AND table_name = 'v1';
DROP DATABASE mysqldump_test_db;
SELECT view_definition
FROM INFORMATION_SCHEMA.VIEWS
WHERE table_schema = 'mysqldump_test_db' AND table_name = 'v1';
create table t1 (a int);
drop view v1;
drop table t1;
drop table if exists `load`;
create table `load` (a varchar(255));
select count(*) from `load`;
drop table `load`;
CREATE TABLE t1 (f1 INT);
CREATE PROCEDURE pr1 () SELECT "Meow";
CREATE EVENT ev1 ON SCHEDULE AT '2030-01-01 00:00:00' DO SELECT "Meow";
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.routines
WHERE routine_name = 'pr1';
DROP EVENT ev1;
DROP TABLE t1;
DROP PROCEDURE pr1;
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.routines
WHERE routine_name = 'pr1';
SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.routines
WHERE routine_name = 'pr1';
DROP EVENT IF EXISTS ev1;
DROP PROCEDURE IF EXISTS pr1;
DROP TRIGGER IF EXISTS tr1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT, b CHAR(10) CHARSET koi8r, c CHAR(10) CHARSET latin1);
CREATE TABLE t2 LIKE t1;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a, b, c;
DROP TABLE t1, t2;
CREATE TABLE t1 (a BLOB) CHARSET latin1;
CREATE TABLE t2 LIKE t1;
SELECT LENGTH(a) FROM t2;
DROP TABLE t1, t2;
create table t1 (first char(28) , last varchar(37));
drop table t1;
CREATE TABLE `comment_table` (i INT COMMENT 'FIELD COMMENT') COMMENT = 'TABLE COMMENT';
DROP TABLE `comment_table`;
CREATE DATABASE `test-database`;
ALTER DATABASE `test-database` CHARACTER SET latin1 COLLATE latin1_swedish_ci;
ALTER DATABASE `test-database` CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci;
DROP DATABASE `test-database`;
CREATE DATABASE BUG52792;
CREATE TABLE t1 (c1 INT, c2 VARCHAR(20)) ENGINE=MyISAM;
CREATE TABLE t2 (c1 INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1, 'aaa'), (2, 'bbb'), (3, 'ccc');
INSERT INTO t2 VALUES (1),(2),(3);
CREATE EVENT e1 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE BUG52792;
CREATE EVENT e2 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE BUG52792;
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
DROP TABLE t1;
DROP DATABASE IF EXISTS b12809202_db;
CREATE DATABASE b12809202_db;
CREATE TABLE b12809202_db.t1 (c1 INT);
CREATE TABLE b12809202_db.t2 (c1 INT);
DROP TABLE b12809202_db.t1;
DROP TABLE b12809202_db.t2;
DROP DATABASE b12809202_db;
DROP DATABASE IF EXISTS b12688860_db;
CREATE DATABASE b12688860_db;
DROP DATABASE b12688860_db;
DROP VIEW v1;
CREATE DATABASE `a\\k`;
CREATE TABLE `a\\k`.t1(i INT);
DROP DATABASE `a\\k`;
CREATE DATABASE dump_gis;
CREATE TABLE t1 (a GEOMETRY);
INSERT INTO t1 VALUES(ST_GeomFromText('LineString(1 1, 2 1, 2 2, 1 2, 1 1)'));
SELECT HEX(a) FROM t1;
DROP DATABASE dump_gis;
CREATE DATABASE db_20772273;
INSERT INTO t2 VALUES (3), (4);
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1;
DROP TABLE t2;
DROP DATABASE db_20772273;
CREATE DATABASE dump_json;
CREATE TABLE t1 (j JSON);
INSERT INTO t1 VALUES (JSON_ARRAY(1, 2, 3, "one", "two", "three"));
SELECT * FROM t1;
DROP DATABASE dump_json;
CREATE DATABASE dump_generated;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DELETE FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t2 (pk INTEGER, a INTEGER, b INTEGER,
                 sum INTEGER GENERATED ALWAYS AS (a+b),
                 c VARCHAR(16),
                 key k1(sum)
) engine=innodb;
INSERT INTO t2(pk, a, b, c) VALUES (1, 11, 12, 'oneone'), (2, 21, 22, 'twotwo');
SELECT * FROM t2;
DELETE FROM t2;
SELECT * FROM t2;
DELETE FROM t2;
SELECT * FROM t2;
DROP TABLE t2;
DROP DATABASE dump_generated;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.routines WHERE routine_schema = 'sys';
CREATE DATABASE bug25717383;
CREATE TABLE `tab
one` (a int);
CREATE VIEW `view
one` as SELECT * FROM `tab
one`;
CREATE PROCEDURE `proc
one`() SELECT * from `tab
one`;
CREATE TEMPORARY TABLE `temp
one` (id INT);
CREATE EVENT `event
one` ON SCHEDULE AT '2030-01-01 00:00:00' DO SET @a=5;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='bug25717383' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='bug25717383' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
DROP DATABASE bug25717383;
CREATE SCHEMA column_statistics_dump;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (1), (2);
SELECT schema_name, table_name, column_name,
       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')
FROM information_schema.COLUMN_STATISTICS;
DROP SCHEMA column_statistics_dump;
CREATE DATABASE bug26171967;
INSERT INTO t1 VALUES (1000000), (1000001);
DROP DATABASE bug26171967;
CREATE TABLE t2(f1 INT, f2 INT INVISIBLE);
INSERT INTO t2(f1, f2) VALUES (10, 20), (20, 30);
DROP TABLE t1, t2;
CREATE TABLE t1 (my_row_id bigint unsigned NOT NULL AUTO_INCREMENT INVISIBLE, f INT,
                 PRIMARY KEY(my_row_id));
INSERT INTO t1 VALUES (1), (3), (7), (8), (4);
CREATE TABLE t2 (f1 INT, f2 INT INVISIBLE DEFAULT 10);
INSERT INTO t2 VALUES (1), (3), (7), (8), (4);
CREATE TABLE t3 AS SELECT * FROM t2;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (f INT NOT NULL PRIMARY KEY, my_row_id INT DEFAULT 580030);
SELECT * FROM t1;
CREATE TABLE t2 (f1 INT NOT NULL PRIMARY KEY, f2 INT, my_row_id INT DEFAULT 580030);
SELECT * FROM t2;
CREATE TABLE t3 (f1 INT NOT NULL PRIMARY KEY, my_row_id INT DEFAULT 580030);
SELECT * FROM t3;
SELECT my_row_id, f FROM t1;
SELECT my_row_id, f1, f2 FROM t2;
SELECT my_row_id, f1 FROM t3;
DROP TABLE t1, t2, t3;
CREATE DATABASE init_command_db;
CREATE TABLE init_command_db.t(a INT);
DROP DATABASE init_command_db;
CREATE DATABASE skip_views_db;
CREATE TABLE skip_views_db.t(a INT);
CREATE DATABASE skip_views_db2;
CREATE TABLE skip_views_db2.t(a INT);
DROP DATABASE skip_views_db;
DROP DATABASE skip_views_db2;
