
--
-- LOAD DATA with view and CHECK OPTION
--
-- fixed length fields
-- Following scenario is to test the functionality of MyISAM

create table t1 (a int, b char(10)) charset latin1 engine=Myisam;
create view v1 as select * from t1 where a != 0 with check option;
select * from t1;
select * from v1;
delete from t1;
select * from t1 order by a,b;
select * from v1 order by a,b;
drop view v1;
drop table t1;

--
-- inserting/deleting join view
--

-- Following scenario is to test the functionality of MyISAM

create table t1 (a int, primary key (a), b int) engine=myisam;
create table t2 (a int, primary key (a), b int) engine=myisam;
insert into t2 values (1000, 2000);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1, t2;
insert into v3 values (1,2);
insert into v3 select * from t2;
insert into v3(a,b) values (1,2);
insert into v3(a,b) select * from t2;
insert into v3(a) values (1);
insert into v3(b) values (10);
insert into v3(a) select a from t2;
insert into v3(b) select b from t2;
insert into v3(a) values (1) on duplicate key update a=a+10000+VALUES(a);
select * from t1 ;
select * from t2 ;
delete from v3;
delete v3,t1 from v3,t1;
delete t1,v3 from t1,v3;
delete from t1;
set @a= 100;
set @a= 300;
set @a= 101;
set @a= 301;
select * from v3 ;

drop view v3;
drop tables t1,t2;

-- Tables are created using MyISAM since this is test for a bug that is specific to MyISAM.

--echo --
--echo -- Bug#11757397 49437: CANNOT DO SHOW FIELDS FOR BIG VIEW
--echo --

--disable_warnings
DROP TABLE IF EXISTS t1, t2, t3, table_broken;
DROP VIEW IF EXISTS view_broken;

let $colnum= 1500;
let $str= a text;
{
  let $str= a$colnum int, $str;
  dec $colnum;

let $colnum= 1500;
let $str= b text;
{
  let $str= b$colnum int, $str;
  dec $colnum;

let $colnum= 1500;
let $str= c text;
{
  let $str= c$colnum int, $str;
  dec $colnum;

-- New behavior
--error ER_TOO_MANY_FIELDS
CREATE VIEW view_broken AS SELECT * FROM t1, t2, t3;

-- Existing behavior
--error ER_TOO_MANY_FIELDS
CREATE TABLE table_broken AS SELECT * FROM t1, t2, t3;

DROP TABLE t1, t2, t3;

-- Coverage for case of non-atomic RENAME TABLES which is also renaming a view.
CREATE TABLE t1(a INT) ENGINE=MyISAM;
CREATE TABLE t2(b INT);
CREATE TABLE t3(c INT);
CREATE TABLE t4(d INT);
CREATE VIEW v1 AS SELECT * FROM t2;
SELECT * FROM v2;
SELECT * FROM v2;
DROP VIEW v2;
DROP TABLES t2, t3, t4, t5;
