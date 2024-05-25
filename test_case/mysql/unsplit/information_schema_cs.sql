DROP TABLE IF EXISTS t0,t1,t2,t3,t4,t5;
DROP VIEW IF EXISTS v1;
select table_name, data_type, column_type from information_schema.columns  where column_name = 'numeric_precision' and table_schema = 'information_schema';
select * from information_schema.SCHEMATA where schema_name > 'm' ORDER BY SCHEMA_NAME;
select schema_name from information_schema.schemata ORDER BY schema_name;
create table t3(a int, KEY a_data (a));
create table mysqltest.t4(a int);
create table t5 (id int auto_increment primary key);
insert into t5 values (10);
create view v1 (c) as
 SELECT table_name FROM information_schema.TABLES
  WHERE table_schema IN ('mysql', 'information_schema', 'test', 'mysqltest') AND
        table_name COLLATE utf8mb3_general_ci not like 'ndb_%' AND
        table_name COLLATE utf8mb3_general_ci not like 'innodb_%';
select * from v1;
select c,table_name from v1
inner join information_schema.TABLES v2 on (v1.c=v2.table_name)
where v1.c rlike "t[1-5]{1}$" order by c;
select c,table_name from v1
left join information_schema.TABLES v2 on (v1.c=v2.table_name)
where v1.c rlike "t[1-5]{1}$" order by c;
select c, v2.table_name from v1
right join information_schema.TABLES v2 on (v1.c=v2.table_name)
where v1.c rlike "t[1-5]{1}$" order by c;
select table_name from information_schema.TABLES
where table_schema = "mysqltest" and
table_name rlike "t[1-5]{1}$" order by table_name;
select * from information_schema.STATISTICS where TABLE_SCHEMA = "mysqltest" order by table_name, index_name;
select * from information_schema.COLUMNS where table_name="t1"
and column_name= "a" order by table_name;
select table_name, column_name, privileges from information_schema.columns
where table_schema = 'mysqltest' and table_name = 't1' order by table_name, column_name;
select table_name, column_name, privileges from information_schema.columns
where table_schema = 'mysqltest' and table_name = 'v1' order by table_name, column_name;
drop database mysqltest;
select * from information_schema.CHARACTER_SETS
where CHARACTER_SET_NAME like 'latin1%' order by character_set_name;
select * from information_schema.COLLATIONS
where COLLATION_NAME like 'latin1%' order by collation_name;
select * from information_schema.COLLATION_CHARACTER_SET_APPLICABILITY
where COLLATION_NAME like 'latin1%' ORDER BY COLLATION_NAME;
drop procedure if exists sel2;
drop function if exists sub1;
drop function if exists sub2;
select parameter_style, sql_data_access, dtd_identifier
from information_schema.routines where routine_schema='test';
select a.ROUTINE_NAME from information_schema.ROUTINES a,
information_schema.SCHEMATA b where
a.ROUTINE_SCHEMA = b.SCHEMA_NAME AND b.SCHEMA_NAME='test'
ORDER BY a.ROUTINE_NAME;
select count(*) from information_schema.ROUTINES where routine_schema='test';
select * from v1;
drop view v1;
select ROUTINE_NAME, ROUTINE_DEFINITION from information_schema.ROUTINES
WHERE ROUTINE_SCHEMA='test' ORDER BY ROUTINE_NAME;
select ROUTINE_NAME, ROUTINE_DEFINITION from information_schema.ROUTINES
WHERE ROUTINE_SCHEMA='test' ORDER BY ROUTINE_NAME;
select ROUTINE_NAME, ROUTINE_DEFINITION from information_schema.ROUTINES
WHERE ROUTINE_SCHEMA='test' ORDER BY ROUTINE_NAME;
select ROUTINE_NAME, ROUTINE_DEFINITION from information_schema.ROUTINES
WHERE ROUTINE_SCHEMA='test' ORDER BY ROUTINE_NAME;
create view v0 (c) as select schema_name from information_schema.schemata order by schema_name;
select * from v0;
create view v1 (c) as select table_name from information_schema.tables
where table_name="v1" order by table_name;
select * from v1;
create view v2 (c) as select column_name from information_schema.columns
where table_name="v2" order by column_name;
select * from v2;
create view v3 (c) as select CHARACTER_SET_NAME from information_schema.character_sets
where CHARACTER_SET_NAME like "latin1%" order by character_set_name;
select * from v3;
create view v4 (c) as select COLLATION_NAME from information_schema.collations
where COLLATION_NAME like "latin1%" order by collation_name;
select * from v4;
select * from information_schema.views where TABLE_SCHEMA != 'sys' and
TABLE_NAME rlike "v[0-4]{1}$" order by table_name;
drop view v0, v1, v2, v3, v4;
create table t1 (a int);
select * from information_schema.USER_PRIVILEGES where grantee like '%mysqltest_1%';
select * from information_schema.SCHEMA_PRIVILEGES where grantee like '%mysqltest_1%';
select * from information_schema.TABLE_PRIVILEGES where grantee like '%mysqltest_1%';
select * from information_schema.COLUMN_PRIVILEGES where grantee like '%mysqltest_1%';
drop table t1;
create table t1 (a int not null, primary key(a));
alter table t1 add constraint constraint_1 unique (a);
alter table t1 add constraint unique key_1(a);
alter table t1 add constraint constraint_2 unique key_2(a);
select * from information_schema.TABLE_CONSTRAINTS where
TABLE_SCHEMA= "test" order by constraint_name;
select * from information_schema.key_column_usage where
TABLE_SCHEMA= "test" order by constraint_name;
select table_name from information_schema.TABLES where table_schema like "test%" order by table_name;
select table_name,column_name from information_schema.COLUMNS
where table_schema like "test%" order by table_name, column_name;
SELECT ROUTINE_NAME FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA != 'sys' ORDER BY ROUTINE_NAME;
drop table t1;
create table t1(a int);
create view v1 (c) as select a from t1 with check option;
create view v2 (c) as select a from t1 WITH LOCAL CHECK OPTION;
create view v3 (c) as select a from t1 WITH CASCADED CHECK OPTION;
select * from information_schema.views where table_schema !=
'sys' order by table_name;
select * from INFORMATION_SCHEMA.COLUMN_PRIVILEGES WHERE table_schema != 'sys';
select * from INFORMATION_SCHEMA.TABLE_PRIVILEGES WHERE table_schema NOT IN ('sys','mysql');
drop view v1, v2, v3;
drop table t1;
select sql_mode from information_schema.ROUTINES where ROUTINE_SCHEMA != 'sys';
create table t1 (a int not null auto_increment,b int, primary key (a));
insert into t1 values (1,1),(NULL,3),(NULL,4);
select AUTO_INCREMENT from information_schema.tables where table_name = 't1';
drop table t1;
create table t1 (s1 int);
insert into t1 values (0),(9),(0);
select s1 from t1 where s1 in (select version from
information_schema.tables) union select version from
information_schema.tables;
drop table t1;
create table t1 select * from information_schema.CHARACTER_SETS
where CHARACTER_SET_NAME like "latin1" order by character_set_name;
select * from t1;
alter table t1 default character set utf8mb3;
drop table t1;
create view v1 as select * from information_schema.TABLES;
drop view v1;
create table t1(a NUMERIC(5,3), b NUMERIC(5,1), c float(5,2),
 d NUMERIC(6,4), e float, f DECIMAL(6,3), g int(11), h DOUBLE(10,3),
 i DOUBLE);
select COLUMN_NAME,COLUMN_TYPE, CHARACTER_MAXIMUM_LENGTH,
 CHARACTER_OCTET_LENGTH, NUMERIC_PRECISION, NUMERIC_SCALE
from information_schema.columns where table_name= 't1';
drop table t1;
create view v1 as select A1.table_name from information_schema.TABLES A1
where table_name= "user" order by table_name;
select * from v1;
drop view v1;
create view vo as select 'a' union select 'a';
select * from information_schema.TABLE_CONSTRAINTS where
TABLE_NAME= "vo";
select * from information_schema.key_column_usage where
TABLE_NAME= "vo";
drop view vo;
select TABLE_NAME,TABLE_TYPE,ENGINE
from information_schema.tables
where table_schema='information_schema'
order by table_name COLLATE utf8mb3_general_ci limit 2;
create table t1(a int);
create table t4(f1 int, KEY f1_key (f1));
drop table t1;
select table_name from information_schema.views
where table_schema='test' order by table_name;
select table_name from information_schema.views
where table_schema='test' order by table_name;
select column_name from information_schema.columns
where table_schema='test' order by column_name;
select index_name from information_schema.statistics where
table_schema='test' order by index_name;
select constraint_name from information_schema.table_constraints
where table_schema='test' order by constraint_name;
drop table t4;
select column_type from information_schema.columns
where table_schema="information_schema" and table_name="COLUMNS" and
(column_name="character_set_name" or column_name="collation_name");
select TABLE_ROWS from information_schema.tables where
table_schema="information_schema" and table_name="COLUMNS";
select table_type from information_schema.tables
where table_schema="mysql" and table_name="user";
create table t1(f1 int);
create table t2(f2 int);
create view v1 as select * from t1, t2;
drop view v1;
drop table t1, t2;
CREATE TABLE t_crashme ( f1 BIGINT);
CREATE VIEW a1 (t_CRASHME) AS SELECT f1 FROM t_crashme GROUP BY f1;
CREATE VIEW a2 AS SELECT t_CRASHME FROM a1;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;
SELECT count(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='test';
drop view a2, a1;
drop table t_crashme;
select table_schema, table_name, column_name from information_schema.columns
where table_schema not in ('performance_schema', 'sys', 'mysql')
  and data_type = 'longtext' order by table_name, column_name;
select table_name, column_name, data_type from information_schema.columns
where table_schema not in ('performance_schema', 'sys')
  and data_type = 'datetime'
  and table_name COLLATE utf8mb3_general_ci not like 'innodb_%' order by table_name, column_name;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES A
WHERE NOT EXISTS
(SELECT * FROM INFORMATION_SCHEMA.COLUMNS B
  WHERE A.TABLE_SCHEMA = B.TABLE_SCHEMA
  AND A.TABLE_NAME = B.TABLE_NAME);
create table t1
( x_bigint BIGINT,
  x_integer INTEGER,
  x_smallint SMALLINT,
  x_decimal DECIMAL(5,3),
  x_numeric NUMERIC(5,3),
  x_real REAL,
  x_float FLOAT,
  x_double_precision DOUBLE PRECISION );
SELECT COLUMN_NAME, CHARACTER_MAXIMUM_LENGTH, CHARACTER_OCTET_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME= 't1' ORDER BY COLUMN_NAME;
drop table t1;
SELECT TABLE_NAME, COLUMN_NAME, PRIVILEGES FROM INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME='TABLE_NAME' ORDER BY TABLE_NAME COLLATE utf8mb3_GENERAL_CI;
SELECT table_schema, count(*) FROM information_schema.TABLES WHERE
table_schema IN ('mysql', 'information_schema', 'test', 'mysqltest')
AND table_name not like 'ndb%' AND table_name COLLATE utf8mb3_general_ci not like 'innodb_%'
GROUP BY TABLE_SCHEMA;
create table t1 (i int, j int);
select * from information_schema.triggers where trigger_schema in ('mysql', 'information_schema', 'test', 'mysqltest')
order by trigger_name;
drop table t1;
create database mysqltest;
create table mysqltest.t1 (f1 int, f2 int);
create table mysqltest.t2 (f1 int);
select * from information_schema.column_privileges order by grantee;
select * from information_schema.table_privileges order by grantee;
select * from information_schema.schema_privileges order by grantee;
select * from information_schema.user_privileges order by grantee;
select * from information_schema.column_privileges order by grantee;
select * from information_schema.table_privileges order by grantee;
select * from information_schema.schema_privileges order by grantee;
select * from information_schema.user_privileges order by grantee;
select * from information_schema.column_privileges order by grantee;
select * from information_schema.table_privileges order by grantee;
select * from information_schema.schema_privileges order by grantee;
select * from information_schema.user_privileges order by grantee;
select * from information_schema.column_privileges where grantee like '%user%'
order by grantee;
select * from information_schema.table_privileges where grantee like '%user%'
and table_schema !='mysql' order by grantee;
select * from information_schema.schema_privileges where grantee like '%user%'
and table_schema !='performance_schema' order by grantee;
select * from information_schema.user_privileges where grantee like '%user%' and grantee not like '%session%'
order by grantee;
drop database mysqltest;
drop procedure if exists p1;
drop procedure if exists p2;
create procedure p1 () modifies sql data set @a = 5;
create procedure p2 () set @a = 5;
select sql_data_access from information_schema.routines
where specific_name like 'p%' and ROUTINE_SCHEMA != 'sys';
drop procedure p1;
drop procedure p2;
create table t1(f1 LONGBLOB, f2 LONGTEXT);
select column_name,data_type,CHARACTER_OCTET_LENGTH,
       CHARACTER_MAXIMUM_LENGTH
from information_schema.columns
where table_name='t1' order by column_name;
drop table t1;
create table t1(f1 tinyint, f2 SMALLINT, f3 mediumint, f4 int,
                f5 BIGINT, f6 BIT, f7 bit(64));
select column_name, NUMERIC_PRECISION, NUMERIC_SCALE
from information_schema.columns
where table_name='t1' order by column_name;
drop table t1;
create table t1 (f1 integer);
drop table t1;
create table t1 (a int not null, b int);
drop table t1;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
DROP TABLE t1,t2;
create table t1(f1 int);
create view v1 (c) as select f1 from t1;
select database();
drop view v1;
drop table t1;
create temporary table schemata(f1 char(10));
create table t1(id int);
insert into t1(id) values (1);
drop table t1;
create table t1 (f1 int(11));
create view v1 as select * from t1;
drop table t1;
select table_type from information_schema.tables
where table_name="v1";
drop view v1;
create temporary table t1(f1 int, index(f1));
drop table t1;
create table t1(f1 binary(32), f2 varbinary(64));
select character_maximum_length, character_octet_length
from information_schema.columns where table_name='t1';
drop table t1;
CREATE TABLE t1 (f1 BIGINT, f2 VARCHAR(20), f3 BIGINT);
INSERT INTO t1 SET f1 = 1, f2 = 'Schoenenbourg', f3 = 1;
DROP TABLE t1;
SELECT column_type, GROUP_CONCAT(table_schema, '.', table_name ORDER BY table_name), COUNT(*) AS num
FROM information_schema.columns WHERE
table_schema='information_schema' AND
(column_type = 'varchar(7)' OR column_type = 'varchar(20)'
 OR column_type = 'varchar(30)')
GROUP BY column_type ORDER BY num, column_type;
create table t1(f1 char(1) not null, f2 char(9) not null)
default character set utf8mb3;
select CHARACTER_MAXIMUM_LENGTH, CHARACTER_OCTET_LENGTH from
information_schema.columns where table_schema='test' and table_name = 't1';
drop table t1;
create table t1 (id int);
create view v1 as select * from t1;
select * from information_schema.views
where table_name='v1' or table_name='v2';
drop table t1;
create table t1(f1 char(5));
create table t2(f1 char(5));
select concat(@a, table_name), @a, table_name
from information_schema.tables where table_schema = 'test' order by table_name;
drop table t1,t2;
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;
CREATE PROCEDURE p1() SET @a= 1;
SELECT ROUTINE_NAME, ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA='test' ORDER BY ROUTINE_NAME;
SELECT ROUTINE_NAME, ROUTINE_DEFINITION FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA='test' ORDER BY ROUTINE_NAME;
DROP PROCEDURE p1;
SELECT MAX(table_name)
  FROM information_schema.tables
  WHERE table_schema IN ('mysql', 'information_schema', 'test');
SELECT table_name FROM information_schema.tables
  WHERE table_name=(SELECT MAX(table_name)
                      FROM information_schema.tables WHERE
                      table_schema IN ('mysql',
                                       'information_schema',
                                       'test')) order by table_name;
DROP TABLE IF EXISTS bug23037;
DROP FUNCTION IF EXISTS get_value;
SELECT COLUMN_NAME, SHA2(COLUMN_DEFAULT, 0), LENGTH(COLUMN_DEFAULT)
  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='bug23037'
  ORDER BY COLUMN_NAME;
drop view v1;
create table t1 (f1 int(11));
create table t2 (f1 int(11), f2 int(11));
select table_name from information_schema.tables
where table_schema = 'test' and table_name not in
(select table_name from information_schema.columns
 where table_schema = 'test' and column_name = 'f3') order by table_name;
drop table t1,t2;
select 1 as f1 from information_schema.tables  where "COLUMN_PRIVILEGES"=
(select cast(table_name as char)  from information_schema.tables
 where table_schema != 'performance_schema' order by table_name limit 1) limit 1;
select t.table_name, group_concat(t.table_schema, '.', t.table_name),
       count(*) as num1
from information_schema.tables t
inner join information_schema.columns c1
on t.table_schema = c1.table_schema AND t.table_name = c1.table_name
where t.table_name not like 'ndb%' and
      t.table_schema = 'information_schema' and
        c1.ordinal_position =
        (select isnull(c2.column_type) -
         isnull(group_concat(c2.table_schema, '.', c2.table_name)) +
         count(*) as num
         from information_schema.columns c2 where
         c2.table_schema='information_schema' and
         (c2.column_type = 'varchar(7)' or c2.column_type = 'varchar(20)')
          group by c2.column_type order by num limit 1)
        and t.table_name not like 'INNODB_%'
group by t.table_name order by num1, t.table_name COLLATE utf8mb3_general_ci;
create table t1(f1 int);
create view v1 as select f1+1 as a from t1;
create table t2 (f1 int, f2 int);
create view v2 as select f1+1 as a, f2 as b from t2;
select table_name, is_updatable from information_schema.views where table_schema != 'sys' order by table_name;
delete from v1;
drop view v1,v2;
drop table t1,t2;
create database mysqltest;
create table mysqltest.t1(a int, b int, c int);
select trigger_name from information_schema.triggers
where event_object_table='t1';
select column_name from information_schema.columns where table_name='t1' order by column_name;
select trigger_name from information_schema.triggers
where event_object_table='t1';
drop database mysqltest;
create table t1 (
  f1 varchar(50),
  f2 varchar(50) not null,
  f3 varchar(50) default '',
  f4 varchar(50) default NULL,
  f5 bigint not null,
  f6 bigint not null default 10,
  f7 datetime not null,
  f8 datetime default '2006-01-01'
);
select column_default from information_schema.columns where table_name= 't1';
drop table t1;
select * from information_schema.engines WHERE ENGINE="MyISAM";
select user,db from information_schema.processlist;
DROP TABLE IF EXISTS server_status;
DROP EVENT IF EXISTS event_status;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'mysqltest';
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = '';
SELECT * FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'test';
select count(*) from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA='mysql' AND TABLE_NAME='nonexisting';
select count(*) from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA='mysql' AND TABLE_NAME='';
select count(*) from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA='' AND TABLE_NAME='';
select count(*) from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA='' AND TABLE_NAME='nonexisting';
CREATE VIEW v1
AS SELECT *
FROM information_schema.TABLES;
SELECT VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS where TABLE_NAME = 'v1';
DROP VIEW v1;
SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME ='information_schema';
SELECT TABLE_COLLATION FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA='mysql' and TABLE_NAME= 'db';
select * from information_schema.columns where table_schema = NULL;
select * from `information_schema`.`COLUMNS` where `TABLE_NAME` = NULL;
select * from `information_schema`.`key_column_usage` where `TABLE_SCHEMA` = NULL;
select * from `information_schema`.`key_column_usage` where `TABLE_NAME` = NULL;
select * from `information_schema`.`PARTITIONS` where `TABLE_SCHEMA` = NULL;
select * from `information_schema`.`PARTITIONS` where `TABLE_NAME` = NULL;
select * from `information_schema`.`REFERENTIAL_CONSTRAINTS` where `CONSTRAINT_SCHEMA` = NULL;
select * from `information_schema`.`REFERENTIAL_CONSTRAINTS` where `TABLE_NAME` = NULL;
select * from information_schema.schemata where schema_name = NULL;
select * from `information_schema`.`STATISTICS` where `TABLE_SCHEMA` = NULL;
select * from `information_schema`.`STATISTICS` where `TABLE_NAME` = NULL;
select * from information_schema.tables where table_schema = NULL;
select * from information_schema.tables where table_catalog = NULL;
select * from information_schema.tables where table_name = NULL;
select * from `information_schema`.`TABLE_CONSTRAINTS` where `TABLE_SCHEMA` = NULL;
select * from `information_schema`.`TABLE_CONSTRAINTS` where `TABLE_NAME` = NULL;
select * from `information_schema`.`TRIGGERS` where `EVENT_OBJECT_SCHEMA` = NULL;
select * from `information_schema`.`TRIGGERS` where `EVENT_OBJECT_TABLE` = NULL;
select * from `information_schema`.`VIEWS` where `TABLE_SCHEMA` = NULL;
select * from `information_schema`.`VIEWS` where `TABLE_NAME` = NULL;
drop table if exists t1;
drop function if exists f1;
create table t1 (a int);
drop table t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
drop table if exists t1;
select * from performance_schema.global_variables where variable_name='init_connect';
create table t0 select * from performance_schema.global_status where VARIABLE_NAME='COM_SELECT';
SELECT 1;
select a.VARIABLE_VALUE - b.VARIABLE_VALUE from t0 b, performance_schema.global_status a
   where a.VARIABLE_NAME = b.VARIABLE_NAME;
drop table t0;
CREATE TABLE t1(a INT) KEY_BLOCK_SIZE=1;
SELECT CREATE_OPTIONS FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='t1';
DROP TABLE t1;
SELECT 'OK' AS TEST_RESULT FROM INFORMATION_SCHEMA.PROCESSLIST WHERE time < 0;
CREATE DATABASE db1;
CREATE TABLE t1 (id INT);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='t1';
DROP DATABASE db1;
CREATE TABLE variables(f1 INT);
SELECT COLUMN_DEFAULT, TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE information_schema.COLUMNS.TABLE_NAME = 'variables';
DROP TABLE variables;
CREATE TABLE ubig (a BIGINT, b BIGINT UNSIGNED);
SELECT TABLE_NAME, COLUMN_NAME, NUMERIC_PRECISION 
  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='ubig';
INSERT IGNORE INTO ubig VALUES (0xFFFFFFFFFFFFFFFF,0xFFFFFFFFFFFFFFFF);
SELECT length(CAST(b AS CHAR)) FROM ubig;
DROP TABLE ubig;
create procedure p1 (p1 float(8,5), p2 char(32), p3 varchar(10)) begin end;
create procedure p2 (p1 enum('c', 's'), p2 blob, p3 text) begin end;
select * from information_schema.parameters where specific_schema='test';
select data_type, character_maximum_length,
       character_octet_length, numeric_precision,
       numeric_scale, character_set_name,
       collation_name, dtd_identifier
from information_schema.routines where routine_schema='test';
drop procedure p1;
drop procedure p2;
drop tables if exists t1, t2, t3;
create table t1 (i int);
create table t2 (j int primary key auto_increment);
lock table t2 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info like "rename table t2 to t3";
select table_name, column_name, data_type from information_schema.columns
  where table_schema = 'test' and table_name in ('t1', 't2');
select table_name, auto_increment from information_schema.tables
  where table_schema = 'test' and table_name in ('t1', 't2');
unlock tables;
DROP TABLE t1;
select routine_name, routine_type from information_schema.routines
where routine_schema = 'test';
SELECT *
FROM INFORMATION_SCHEMA.key_column_usage
LEFT JOIN INFORMATION_SCHEMA.COLUMNS
USING (TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME)
WHERE COLUMNS.TABLE_SCHEMA = 'test'
AND COLUMNS.TABLE_NAME = 't1';
drop table if exists t1;
drop view if exists v1;
create table t1 (a int, b int);
create view v1 as select t1.a, t1.b from t1;
alter table t1 change b c int;
lock table t1 read;
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table flush" and
          info = "flush tables";
select * from information_schema.views
  where table_schema != 'sys' order by table_schema, table_name;
unlock tables;
drop table t1;
drop view v1;
drop database if exists mysqltest;
create database mysqltest;
create table t0 (i int);
create table t1 (j int);
lock tables t2 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "rename table t1 to t3, t2 to t1, t3 to t2";
select count(*) = 0 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "select event_object_table, trigger_name from information_schema.triggers where event_object_schema='mysqltest'";
unlock tables;
drop database if exists mysqltest;
create database mysqltest;
create table mysqltest.t(a int, b date, c time, d datetime, e timestamp);
create table mysqltest.t0(a int, b date, c time(0), d datetime(0), e timestamp(0));
create table mysqltest.t1(a int, b date, c time(1), d datetime(1), e timestamp(1));
create table mysqltest.t2(a int, b date, c time(2), d datetime(2), e timestamp(2));
create table mysqltest.t3(a int, b date, c time(3), d datetime(3), e timestamp(3));
create table mysqltest.t4(a int, b date, c time(4), d datetime(4), e timestamp(4));
create table mysqltest.t5(a int, b date, c time(5), d datetime(5), e timestamp(5));
create table mysqltest.t6(a int, b date, c time(6), d datetime(6), e timestamp(6));
select TABLE_NAME,COLUMN_NAME,DATA_TYPE,DATETIME_PRECISION from
information_schema.columns where TABLE_SCHEMA='mysqltest' order by table_name, column_name;
drop database mysqltest;
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT VARIABLE_VALUE INTO @val1 FROM performance_schema.global_status WHERE
  VARIABLE_NAME LIKE 'Opened_tables';
SELECT ENGINE FROM INFORMATION_SCHEMA.TABLES;
SELECT VARIABLE_VALUE INTO @val2 FROM performance_schema.global_status WHERE
  VARIABLE_NAME LIKE 'Opened_tables';
SELECT @val1 = @val2;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
SELECT ENGINE, SUPPORT, TRANSACTIONS FROM INFORMATION_SCHEMA.ENGINES
WHERE
SUPPORT IN (
SELECT DISTINCT SUPPORT
FROM INFORMATION_SCHEMA.ENGINES
WHERE
ENGINE IN (
SELECT DISTINCT ENGINE FROM INFORMATION_SCHEMA.ENGINES
WHERE ENGINE IN ('MEMORY')))
ORDER BY ENGINE
LIMIT 1;
SELECT 1
FROM DUAL
WHERE (SELECT 1 FROM information_schema.tables
        WHERE table_schema
        ORDER BY table_name
        LIMIT 1);
SELECT 1 AS F1 FROM information_schema.tables
WHERE "COLUMN_PRIVILEGES"=
      (SELECT CAST(TABLE_NAME AS CHAR)
      FROM information_schema.tables
      WHERE table_schema != 'PERFORMANCE_SCHEMA'
      ORDER BY table_name LIMIT 1)
LIMIT 1;
SELECT user,db FROM information_schema.processlist;
SELECT user,db FROM information_schema.processlist;
CREATE VIEW v1 AS SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME= "users";
LOCK TABLE v1 READ;
SELECT COUNT(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table flush" AND
  info = "flush tables";
SELECT * FROM v1;
UNLOCK TABLES;
DROP VIEW v1;
SELECT schema_name FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'ndbinfo';
SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'ndbinfo';
CREATE TABLE t1 (
c1 INT,
c2 INT,
c3 CHAR(255),
c4 CHAR(255),
c5 CHAR(255),
c6 POINT NOT NULL,
c7 GEOMETRY NOT NULL SRID 0,
SPATIAL INDEX(c7),
KEY c2_key (c2),
FULLTEXT KEY c3_fts (c3),
FULLTEXT KEY c4_fts (c4, c5));
SELECT COLUMN_NAME, IS_NULLABLE,
       DATA_TYPE, COLLATION_NAME, COLUMN_KEY
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA='test' ORDER BY COLUMN_NAME;
DROP TABLE t1;
CREATE TABLE t1(f1 INT);
SELECT * FROM INFORMATION_SCHEMA.TABLES where table_name='t1';
SELECT t.table_schema, t.table_name, c.column_name
  FROM INFORMATION_SCHEMA.TABLES t,
       INFORMATION_SCHEMA.COLUMNS c
       WHERE t.table_schema = c.table_schema
       AND t.table_name = c.table_name
       AND t.table_name = 't1' limit 1;
CREATE VIEW v1 AS
SELECT t.table_schema, t.table_name, c.column_name
  FROM INFORMATION_SCHEMA.TABLES t,
       INFORMATION_SCHEMA.COLUMNS c
       WHERE t.table_schema = c.table_schema
       AND t.table_name = c.table_name
       AND t.table_name = 't1' limit 1;
DROP TABLE t1, t2;
DROP VIEW v1;
SELECT * FROM information_schema.ST_GEOMETRY_COLUMNS
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1';
CREATE TABLE t1(g GEOMETRY, pt POINT, ls LINESTRING, py POLYGON, mpt MULTIPOINT,
  mls MULTILINESTRING, mpy MULTIPOLYGON, gc GEOMETRYCOLLECTION);
SELECT * FROM information_schema.ST_GEOMETRY_COLUMNS
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME='t1'
  ORDER BY COLUMN_NAME;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(200), b TEXT, FULLTEXT (a,b))
ENGINE = InnoDB charset utf8mb4;
SELECT * FROM INFORMATION_SCHEMA.`REFERENTIAL_CONSTRAINTS`;
DROP TABLE t1;
SELECT INDEX_NAME FROM INFORMATION_SCHEMA.`STATISTICS` WHERE `TABLE_NAME` = 'innodb_table_stats' AND Cardinality;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
SELECT * FROM INFORMATION_SCHEMA.CHARACTER_SETS WHERE DESCRIPTION LIKE '%japanese%';
CREATE TABLE t1 (a CHAR(40) NOT NULL, UNIQUE idx1(a(2)))
  COMMENT="testing a fix" MAX_ROWS=10;
SELECT create_options, UPPER(create_options),
       table_comment, UPPER(table_comment)
  FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SELECT privileges, UPPER(privileges)
  FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 't1';
DROP TABLE t1;
SELECT t.table_name, c1.column_name
  FROM information_schema.tables t
       INNER JOIN
       information_schema.columns c1
       ON t.table_schema = c1.table_schema AND
          t.table_name = c1.table_name
  WHERE t.table_schema = 'information_schema' AND
        c1.ordinal_position =
        ( SELECT COALESCE(MIN(c2.ordinal_position),1)
            FROM information_schema.columns c2
            WHERE c2.table_schema = t.table_schema AND
                  c2.table_name = t.table_name AND
                  c2.column_name LIKE '%SCHEMA%'
        )
  AND t.table_name NOT LIKE 'ndb%'
  AND t.table_name NOT LIKE 'INNODB%'
  ORDER BY t.table_name COLLATE utf8mb3_general_ci,
           c1.column_name COLLATE utf8mb3_general_ci;
SELECT t.table_name, c1.column_name
  FROM information_schema.tables t
       INNER JOIN
       information_schema.columns c1
       ON t.table_schema = c1.table_schema AND
          t.table_name = c1.table_name
  WHERE t.table_schema = 'information_schema' AND
        c1.ordinal_position =
        ( SELECT COALESCE(MIN(c2.ordinal_position),1)
            FROM information_schema.columns c2
            WHERE c2.table_schema = 'information_schema' AND
                  c2.table_name = t.table_name AND
                  c2.column_name LIKE '%SCHEMA%'
        )
  AND t.table_name NOT LIKE 'ndb%'
  AND t.table_name NOT LIKE 'INNODB%'
  ORDER BY t.table_name COLLATE utf8mb3_general_ci,
           c1.column_name COLLATE utf8mb3_general_ci;
CREATE TABLE t1(fld1 BINARY(10) NOT NULL DEFAULT 'a',
                fld2 BINARY(10) NOT NULL DEFAULT 0xAA,
                fld3 BINARY(10) NOT NULL DEFAULT 0xA,
                fld4 BINARY(10) NOT NULL DEFAULT b'1001',
                fld5 VARBINARY(5) NOT NULL DEFAULT 'a',
                fld6 VARBINARY(5) NOT NULL DEFAULT 0xAA,
                fld7 VARBINARY(5) NOT NULL DEFAULT 0xA,
                fld8 VARBINARY(5) NOT NULL DEFAULT b'1001');
SELECT COLUMN_DEFAULT FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME= 't1';
DROP TABLE t1;
CREATE TABLE t1(c1 INT);
LOCK TABLES t1 WRITE;
SELECT file_name, initial_size!=0 FROM information_schema.files
  WHERE tablespace_name='test/t1';
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1(c1 int);
SELECT table_rows FROM information_schema.tables
  WHERE table_name='t1';
SELECT table_rows FROM information_schema.tables
  WHERE table_name='t1' AND table_rows>=0;
SELECT table_rows FROM information_schema.tables WHERE table_name='t1';
DROP TABLE t1;
CREATE TABLE t1(c1 INT,c2 CHAR (1)COMMENT'')
COMMENT='abcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghi
jabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefg
hijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcde
fghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabc
defghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghija
bcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghi
jabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefg
hijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcde
fghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabc
defghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghija
bcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghi
jabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefg
hijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcdefghijabcde
fghijabcdefghijabcde';
DROP TABLE t1;
SELECT COUNT(*) = 0
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS rcons
  LEFT OUTER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tcons
  ON tcons.constraint_catalog = rcons.constraint_catalog AND
  tcons.constraint_schema = rcons.constraint_schema AND
  tcons.constraint_name = rcons.unique_constraint_name;
SELECT COUNT(*) > 0 FROM INFORMATION_SCHEMA.KEYWORDS;
CREATE TABLE t1 (col1 BLOB(33), INDEX (col1(8)));
SELECT SUB_PART FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME = "t1";
DROP TABLE t1;
CREATE TABLE t1 (col1 TEXT(33) CHARACTER SET utf8mb4, INDEX (col1(2)));
SELECT SUB_PART FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME = "t1";
DROP TABLE t1;
CREATE TABLE t1 (col1 BLOB(33), INDEX (col1(33)));
SELECT SUB_PART FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME = "t1";
DROP TABLE t1;
CREATE TABLE t1 (col1 TEXT(2) CHARACTER SET utf8mb4, INDEX (col1(2)));
SELECT SUB_PART FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME = "t1";
DROP TABLE t1;
CREATE DATABASE db1;
CREATE TABLE db1.t1 ( id int(11) DEFAULT NULL) ENGINE = INNODB COMMENT =
'123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__100_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__200_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__300_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__400_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__500_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__600_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__700_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__800_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234__900_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1000_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1100_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1200_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1300_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1400_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1500_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1600_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1700_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1800_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_1900_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_123456789_1234_2000_123456789_123456789_123456789_123456789_123_2048';
SELECT TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME = 't1' ORDER BY TABLE_SCHEMA;
DROP DATABASE db1;
CREATE TABLE t1 (f1 TIMESTAMP);
CREATE VIEW v1 AS SELECT 1 FROM t1 WHERE f1;
ALTER TABLE t1 CHANGE COLUMN f1 f0 BINARY;
SELECT TABLE_NAME, LENGTH(VIEW_DEFINITION) > 0
  FROM INFORMATION_SCHEMA.VIEWS
  WHERE TABLE_SCHEMA='test';
SELECT TABLE_NAME, LENGTH(VIEW_DEFINITION) > 0
  FROM INFORMATION_SCHEMA.VIEWS
  WHERE TABLE_SCHEMA='test';
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (f1 TIMESTAMP);
CREATE VIEW v1 AS SELECT 1 FROM t1 WHERE f1;
CREATE VIEW v2 AS SELECT 1 FROM t1 WHERE f1;
ALTER TABLE t1 CHANGE COLUMN f1 f0 BINARY;
SELECT TABLE_NAME, TABLE_COMMENT
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA='test';
SELECT TABLE_NAME, TABLE_COMMENT
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA='test';
DROP VIEW v1, v2;
DROP TABLE t1;
CREATE TABLE t1 (f1 DATE NOT SECONDARY);
SELECT TABLE_NAME, COLUMN_NAME, EXTRA FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME='t1';
DROP TABLE t1;
CREATE TABLE t1 (f1 DATE);
SELECT TABLE_NAME, COLUMN_NAME, EXTRA FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME='t1';
ALTER TABLE  t1 MODIFY f1 DATE NOT SECONDARY;
SELECT TABLE_NAME, COLUMN_NAME, EXTRA FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_NAME='t1';
DROP TABLE t1;
CREATE TABLE t1 (f1 INT) SECONDARY_ENGINE=myisam;
SELECT TABLE_NAME, CREATE_OPTIONS
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME = 't1';
DROP TABLE t1;
CREATE TABLE t1 (f1 INT);
SELECT TABLE_NAME, CREATE_OPTIONS FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME = 't1';
ALTER TABLE t1 SECONDARY_ENGINE=myisam;
SELECT TABLE_NAME, CREATE_OPTIONS FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME = 't1';
DROP TABLE t1;
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE, TABLE_COMMENT
  FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA = 'sys' AND TABLE_NAME = 'sys_config';
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 'v1';
DROP VIEW v1;
DROP TABLE t1;
SELECT * FROM information_schema.ST_GEOMETRY_COLUMNS;
UNLOCK TABLES;
CREATE TABLE t1 (f1 INT);
SELECT * FROM INFORMATION_SCHEMA.APPLICABLE_ROLES;
UNLOCK TABLES;
DROP TABLE t1;
SELECT * FROM information_schema.CHARACTER_SETS
WHERE CHARACTER_SET_NAME LIKE 'utf8%'
ORDER BY character_set_name;
SELECT * FROM information_schema.COLLATIONS
WHERE COLLATION_NAME LIKE "utf8\_%"
ORDER BY collation_name;
SELECT * FROM information_schema.COLLATIONS
WHERE COLLATION_NAME LIKE "utf8mb3\_%"
ORDER BY collation_name;
