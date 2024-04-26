drop table if exists t1,t2,t3,t4,t9,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop view if exists t1,t2,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop database if exists mysqltest;
use test;

-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

--
-- some basic test of views and its functionality
--

-- create view on nonexistent table
-- error ER_NO_SUCH_TABLE
create view v1 (c,d) as select a,b from t1;

create temporary table t1 (a int, b int);
create view v1 (c) as select b+1 from t1;
drop table t1;

create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);

-- view with variable
-- error ER_VIEW_SELECT_VARIABLE
create view v1 (c,d) as select a,b+@@global.max_user_connections from t1;
create view v1 (c,d) as select a,b from t1
  where a = @@global.max_user_connections;
CREATE VIEW v1 AS SELECT @a=1 FROM DUAL;
CREATE VIEW v1 AS SELECT 1 FROM DUAL WHERE @a>1;
CREATE VIEW v1 AS SELECT (@a:= 1) AS one FROM DUAL;
CREATE VIEW v1 AS SELECT 1 FROM DUAL WHERE (@a:= 1);

-- simple view
create view v1 (c) as select b+1 from t1;
select c from v1;
select is_updatable from information_schema.views where table_name='v1';

-- temporary table should not hide table of view
create temporary table t1 (a int, b int);
select * from t1;
select c from v1;
drop table t1;

-- try to use fields from underlying table
-- error ER_BAD_FIELD_ERROR
select a from v1;
select v1.a from v1;
select b from v1;
select v1.b from v1;

-- view with different algorithms (explain output differs)
--replace_column 10 -- 11 #
explain select c from v1;
create algorithm=temptable view v2 (c) as select b+1 from t1;
select c from v2;

-- try to use underlying table fields in VIEW creation process
-- error ER_BAD_FIELD_ERROR
create view v3 (c) as select a+1 from v1;
create view v3 (c) as select b+1 from v1;


-- VIEW on VIEW test with mixing different algorithms on different order
create view v3 (c) as select c+1 from v1;
select c from v3;
create algorithm=temptable view v4 (c) as select c+1 from v2;
select c from v4;
create view v5 (c) as select c+1 from v2;
select c from v5;
create algorithm=temptable view v6 (c) as select c+1 from v1;
select c from v6;

-- show table/table status test
show tables;

drop view v1,v2,v3,v4,v5,v6;

--
-- alter/create view test
--

-- view with subqueries of different types
create view v1 (c,d,e,f) as select a,b,
a in (select a+2 from t1), a = all (select a from t1) from t1;
create view v2 as select c, d from v1;
select * from v1;
select * from v2;

-- try to create VIEW with name of existing VIEW
-- error ER_TABLE_EXISTS_ERROR
create view v1 (c,d,e,f) as select a,b, a in (select a+2 from t1), a = all (select a from t1) from t1;

-- 'or replace' should work in this case
create or replace view v1 (c,d,e,f) as select a,b, a in (select a+2 from t1), a = all (select a from t1) from t1;

-- try to ALTER unexisting VIEW
drop view v2;
alter view v2 as select c, d from v1;

-- 'or replace' on unexisting view
create or replace view v2 as select c, d from v1;

-- alter view on existing view
alter view v1 (c,d) as select a,max(b) from t1 group by a;

-- check that created view works
select * from v1;
select * from v2;

-- try to drop nonexistent VIEW
-- error ER_BAD_TABLE_ERROR
drop view v100;

-- try to drop table with DROP VIEW
-- error ER_WRONG_OBJECT
drop view t1;

-- try to drop VIEW with DROP TABLE
-- error ER_BAD_TABLE_ERROR
drop table v1;

-- try to drop table with DROP VIEW

drop view v1,v2;
drop table t1;

--
-- outer left join with merged views
--
create table t1 (a int);
insert into t1 values (1), (2), (3);

create view v1 (a) as select a+1 from t1;
create view v2 (a) as select a-1 from t1;
select * from t1 natural left join v1;
select * from v2 natural left join t1;
select * from v2 natural left join v1;

drop view v1, v2;
drop table t1;


--
-- DISTINCT option for VIEW
--
create table t1 (a int);
insert into t1 values (1), (2), (3), (1), (2), (3);
create view v1 as select distinct a from t1;
select * from v1;
select * from t1;
drop view v1;
drop table t1;

--
-- syntax compatibility
--
create table t1 (a int);
create view v1 as select distinct a from t1 WITH CHECK OPTION;
create view v1 as select a from t1 WITH CHECK OPTION;
create view v2 as select a from t1 WITH CASCADED CHECK OPTION;
create view v3 as select a from t1 WITH LOCAL CHECK OPTION;
drop view v3 RESTRICT;
drop view v2 CASCADE;
drop view v1;
drop table t1;

--
-- aliases
--
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1 (c) as select b+1 from t1;
select test.c from v1 test;
create algorithm=temptable view v2 (c) as select b+1 from t1;
select test.c from v2 test;
select test1.* from v1 test1, v2 test2 where test1.c=test2.c;
select test2.* from v1 test1, v2 test2 where test1.c=test2.c;
drop table t1;
drop view v1,v2;

--
-- LIMIT clause test
--
create table t1 (a int);
insert into t1 values (1), (2), (3), (4);
create view v1 as select a+1 from t1 order by 1 desc limit 2;
select * from v1;
drop view v1;
drop table t1;

--
-- CREATE ... SELECT view test
--
create table t1 (a int);
insert into t1 values (1), (2), (3), (4);
create view v1 as select a+1 from t1;
create table t2 select * from v1;
select * from t2;
drop view v1;
drop table t1,t2;

--
-- simple view + simple update
--
create table t1 (a int, b int, primary key(a));
insert into t1 values (10,2), (20,3), (30,4), (40,5), (50,10);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
select is_updatable from information_schema.views where table_name='v2';
select is_updatable from information_schema.views where table_name='v1';
update v1 set c=a+c;
update v2 set a=a+c;
update v1 set a=a+c;
select * from v1;
select * from t1;
drop table t1;
drop view v1,v2;

--
-- simple view + simple multi-update
--
create table t1 (a int, b int, primary key(a));
insert into t1 values (10,2), (20,3), (30,4), (40,5), (50,10);
create table t2 (x int);
insert into t2 values (10), (20);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
update t2,v1 set v1.c=v1.a+v1.c where t2.x=v1.a;
update t2,v2 set v2.a=v2.a+c where t2.x=v2.a;
update t2,v1 set v1.a=v1.a+v1.c where t2.x=v1.a;
select * from v1;
select * from t1;
drop table t1,t2;
drop view v1,v2;

--
-- MERGE VIEW with WHERE clause
--
create table t1 (a int, b int, primary key(b));
insert into t1 values (1,20), (2,30), (3,40), (4,50), (5,100);
create view v1 (c) as select b from t1 where a<3;
select * from v1;
update v1 set c=c+1;
select * from t1;
create view v2 (c) as select b from t1 where a>=3;
select * from v1, v2;
drop view v1, v2;
drop table t1;

--
-- simple view + simple delete
--
create table t1 (a int, b int, primary key(a));
insert into t1 values (1,2), (2,3), (3,4), (4,5), (5,10);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
delete from v2 where c < 4;
delete from v1 where c < 4;
select * from v1;
select * from t1;
drop table t1;
drop view v1,v2;

--
-- simple view + simple multi-delete
--
create table t1 (a int, b int, primary key(a));
insert into t1 values (1,2), (2,3), (3,4), (4,5), (5,10);
create table t2 (x int);
insert into t2 values (1), (2), (3), (4);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
delete v2 from t2,v2 where t2.x=v2.a;
delete v1 from t2,v1 where t2.x=v1.a;
select * from v1;
select * from t1;
drop table t1,t2;
drop view v1,v2;

--
-- key presence check
--
create table t1 (a int, b int, c int, primary key(a,b));
insert into t1 values (10,2,-1), (20,3,-2), (30,4,-3), (40,5,-4), (50,10,-5);
create view v1 (x,y) as select a, b from t1;
create view v2 (x,y) as select a, c from t1;
set updatable_views_with_limit=NO;
update v1 set x=x+1;
update v2 set x=x+1;
update v1 set x=x+1 limit 1;
update v2 set x=x+1 limit 1;
delete from v2 limit 1;
set updatable_views_with_limit=YES;
update v1 set x=x+1 limit 1;
update v2 set x=x+1 limit 1;
set updatable_views_with_limit=DEFAULT;
select * from t1;
drop table t1;
drop view v1,v2;

--
-- simple insert
--
create table t1 (a int, b int, c int, primary key(a,b));
insert into t1 values (10,2,-1), (20,3,-2);
create view v1 (x,y,z) as select c, b, a from t1;
create view v2 (x,y) as select b, a from t1;
create view v3 (x,y,z) as select b, a, b from t1;
create view v4 (x,y,z) as select c+1, b, a from t1;
create algorithm=temptable view v5 (x,y,z) as select c, b, a from t1;
insert into v3 values (-60,4,30);
insert into v4 values (-60,4,30);
insert into v5 values (-60,4,30);
insert into v1 values (-60,4,30);
insert into v1 (z,y,x) values (50,6,-100);
insert into v2 values (5,40);
select * from t1;
drop table t1;
drop view v1,v2,v3,v4,v5;

--
-- insert ... select
--
create table t1 (a int, b int, c int, primary key(a,b));
insert into t1 values (10,2,-1), (20,3,-2);
create table t2 (a int, b int, c int, primary key(a,b));
insert into t2 values (30,4,-60);
create view v1 (x,y,z) as select c, b, a from t1;
create view v2 (x,y) as select b, a from t1;
create view v3 (x,y,z) as select b, a, b from t1;
create view v4 (x,y,z) as select c+1, b, a from t1;
create algorithm=temptable view v5 (x,y,z) as select c, b, a from t1;
insert into v3 select c, b, a from t2;
insert into v4 select c, b, a from t2;
insert into v5 select c, b, a from t2;
insert into v1 select c, b, a from t2;
insert into v1 (z,y,x) select a+20,b+2,-100 from t2;
insert into v2 select b+1, a+10 from t2;
select * from t1;
drop table t1, t2;
drop view v1,v2,v3,v4,v5;

--
-- outer join based on VIEW with WHERE clause
--
create table t1 (a int, primary key(a));
insert into t1 values (1), (2), (3);
create view v1 (x) as select a from t1 where a > 1;
select t1.a, v1.x from t1 left join v1 on (t1.a= v1.x);
drop table t1;
drop view v1;

--
-- merging WHERE condition on VIEW on VIEW
--
create table t1 (a int, primary key(a));
insert into t1 values (1), (2), (3), (200);
create view v1 (x) as select a from t1 where a > 1;
create view v2 (y) as select x from v1 where x < 100;
select * from v2;
drop table t1;
drop view v1,v2;

--
-- VIEW on non-updatable view
--
create table t1 (a int, primary key(a));
insert into t1 values (1), (2), (3), (200);
create ALGORITHM=TEMPTABLE view v1 (x) as select a from t1;
create view v2 (y) as select x from v1;
update v2 set y=10 where y=2;
drop table t1;
drop view v1,v2;

--
-- auto_increment field out of VIEW
--
create table t1 (a int not null auto_increment, b int not null, primary key(a), unique(b));
create view v1 (x) as select b from t1;
insert into v1 values (1);
select last_insert_id();
insert into t1 (b) values (2);
select last_insert_id();
select * from t1;
drop view v1;
drop table t1;

--
-- VIEW fields quoting
--
set sql_mode='ansi';
create table t1 ("a*b" int);
create view v1 as select "a*b" from t1;
drop view v1;
drop table t1;
set sql_mode=default;

--
-- VIEW without tables
--
create table t1 (t_column int);
create view v1 as select 'a';
select * from v1, t1;
drop view v1;
drop table t1;

--
-- quote mark inside table name
--
create table `t1a``b` (col1 char(2));
create view v1 as select * from `t1a``b`;
select * from v1;
drop view v1;
drop table `t1a``b`;

--
-- Changing of underlying table
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (col1 char(5),col2 char(5));
create view v1 as select * from t1;
drop table t1;
create table t1 (col1 char(5),newcol2 char(5));
insert into v1 values('a','aa');
drop table t1;
select * from v1;
drop view v1;
SET sql_mode = default;
create view v1 (a,a) as select 'a','a';

--
-- updatablity should be transitive
--
create table t1 (col1 int,col2 char(22));
insert into t1 values(5,'Hello, world of views');
create view v1 as select * from t1;
create view v2 as select * from v1;
update v2 set col2='Hello, view world';
select is_updatable from information_schema.views where
table_schema != 'sys' and table_schema != 'information_schema';
select * from t1;
drop view v2, v1;
drop table t1;

--
-- check 'use index' on view with temporary table
--
create table t1 (a int, b int);
create view v1 as select a, sum(b) from t1 group by a;
select b from v1 use index (some_index) where b=1;
drop view v1;
drop table t1;

--
-- using VIEW fields several times in query resolved via temporary tables
--
create table t1 (col1 char(5),col2 char(5));
create view v1 (col1,col2) as select col1,col2 from t1;
insert into v1 values('s1','p1'),('s1','p2'),('s1','p3'),('s1','p4'),('s2','p1'),('s3','p2'),('s4','p4');
select distinct first.col2 from t1 first where first.col2 in (select second.col2 from t1 second where second.col1<>first.col1);
select distinct first.col2 from v1 first where first.col2 in (select second.col2 from t1 second where second.col1<>first.col1);
drop view v1;
drop table t1;

--
-- Test of view updatability in prepared statement
--
create table t1 (a int);
create view v1 as select a from t1;
insert into t1 values (1);
SET @v0 = '2';
SET @v0 = '3';
SET @v0 = '4';

select * from t1;

drop view v1;
drop table t1;

--
-- error on preparation
--
-- error ER_NO_TABLES_USED
CREATE VIEW v02 AS SELECT * FROM DUAL;

--
-- EXISTS with UNION VIEW
--
CREATE VIEW v1 AS SELECT EXISTS (SELECT 1 UNION SELECT 2);
select * from v1;
drop view v1;

--
-- using VIEW where table is required
--
create table t1 (col1 int,col2 char(22));
create view v1 as select * from t1;
create index i1 on v1 (col1);
drop view v1;
drop table t1;

--
-- connection_id(), pi(), current_user(), version() representation test
--
CREATE VIEW v1 (f1,f2,f3,f4) AS SELECT connection_id(), pi(), current_user(), version();
drop view v1;

--
-- VIEW built over UNION
--
create table t1 (s1 int);
create table t2 (s2 int);
insert into t1 values (1), (2);
insert into t2 values (2), (3);
create view v1 as select * from t1,t2 union all select * from t1,t2;
select * from v1;
drop view v1;
drop tables t1, t2;

--
-- Aggregate functions in view list
--
create table t1 (col1 int);
insert into t1 values (1);
create view v1 as select count(*) from t1;
insert into t1 values (null);
select * from v1;
drop view v1;
drop table t1;

--
-- Showing VIEW with VIEWs in subquery
--
create table t1 (a int);
create table t2 (a int);
create view v1 as select a from t1;
create view v2 as select a from t2 where a in (select a from v1);
drop view v2, v1;
drop table t1, t2;

--
-- SHOW VIEW view with name with spaces
--
CREATE VIEW `v 1` AS select 5 AS `5`;
drop view `v 1`;

--
-- Removing database with .frm archives
--
create database mysqltest;
create table mysqltest.t1 (a int, b int);
create view mysqltest.v1 as select a from mysqltest.t1;
alter view mysqltest.v1 as select b from mysqltest.t1;
alter view mysqltest.v1 as select a from mysqltest.t1;
drop database mysqltest;

--
-- VIEW with full text
--
CREATE TABLE t1 (c1 int not null auto_increment primary key, c2 varchar(20), fulltext(c2));
insert into t1 (c2) VALUES ('real Beer'),('Water'),('Kossu'),('Coca-Cola'),('Vodka'),('Wine'),('almost real Beer');
select * from t1 WHERE match (c2) against ('Beer');
CREATE VIEW v1 AS SELECT  * from t1 WHERE match (c2) against ('Beer');
select * from v1;
drop view v1;
drop table t1;

--
-- distinct in temporary table with a VIEW
--
create table t1 (a int);
insert into t1 values (1),(1),(2),(2),(3),(3);
create view v1 as select a from t1;
select distinct a from v1;
select distinct a from v1 limit 2;
select distinct a from t1 limit 2;
drop view v1;
drop table t1;

--
-- aggregate function of aggregate function
--
create table t1 (tg_column bigint);
create view v1 as select count(tg_column) as vg_column from t1;
select avg(vg_column) from v1;
drop view v1;
drop table t1;

--
-- VIEW of VIEW with column renaming
--
create table t1 (col1 bigint not null, primary key (col1));
create table t2 (col1 bigint not null, key (col1));
create view v1 as select * from t1;
create view v2 as select * from t2;
insert into v1 values (1);
insert into v2 values (1);
create view v3 (a,b) as select v1.col1 as a, v2.col1 as b from v1, v2 where v1.col1 = v2.col1;
select * from v3;
drop view v3, v2, v1;
drop table t2, t1;

--
-- VIEW based on functions with  complex names
--
create function `f``1` () returns int return 5;
create view v1 as select test.`f``1` ();
select * from v1;
drop view v1;
drop function `f``1`;

--
-- tested problem when function name length close to ALIGN_SIZE
--
create function a() returns int return 5;
create view v1 as select a();
select * from v1;
drop view v1;
drop function a;

--
-- VIEW with collation
--
create table t2 (col1 char collate latin1_german2_ci);
create view v2 as select col1 collate latin1_german1_ci from t2;
drop view v2;
drop table t2;

--
-- order by refers on integer field
--
create table t1 (a int);
insert into t1 values (1), (2);
create view v1 as select 5 from t1 order by 1;
select * from v1;
drop view v1;
drop table t1;

--
-- VIEW over dropped function
--
create function x1 () returns int return 5;
create table t1 (s1 int);
create view v1 as select x1() from t1;
drop function x1;
select * from v1;
drop view v1;
drop table t1;

--
-- VIEW with floating point (long number) as column
--
create view v1 as select 99999999999999999999999999999999999999999999999999999 as col1;
drop view v1;

--
-- VIEWs with national characters
--

SET @old_cs_client = @@character_set_client;
SET @old_cs_results = @@character_set_results;
SET @old_cs_connection = @@character_set_connection;

set names utf8mb3;
create table tü (cü char);
create view vü as select cü from tü;
insert into vü values ('ü');
select * from vü;
drop view vü;
drop table tü;

SET character_set_client = @old_cs_client;
SET character_set_results = @old_cs_results;
SET character_set_connection = @old_cs_connection;

--
-- problem with used_tables() of outer reference resolved in VIEW
--
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1(c) as select a+1 from t1 where b >= 4;
select c from v1 where exists (select * from t1 where a=2 and b=c);
drop view v1;
drop table t1;

--
-- view with cast operation
--
create view v1 as select cast(1 as char(3));
select * from v1;
drop view v1;

--
-- renaming views
--
create table t1 (a int);
create view v1 as select a from t1;
create view v3 as select a from t1;
create database mysqltest;
drop table t1;
drop view v2,v3;
drop database mysqltest;

--
-- bug handling from VIEWs
--
create view v1 as select 'a',1;
create view v2 as select * from v1 union all select * from v1;
create view v3 as select * from v2 where 1 = (select `1` from v2);
create view v4 as select * from v3;
select * from v4;
drop view v4, v3, v2, v1;

--
-- VIEW over SELECT with prohibited clauses
--
-- error ER_VIEW_SELECT_CLAUSE
create view v1 as select 5 into @w;
create view v1 as select 5 into outfile 'ttt';
create table t1 (a int);
create view v1 as select 1 from (select 1) as d1;
drop view v1;
drop table t1;

--
-- INSERT into VIEW with ON DUPLICATE
--
create table t1 (s1 int, primary key (s1));
create view v1 as select * from t1;
insert into v1 values (1) on duplicate key update s1 = 7;
insert into v1 values (1) on duplicate key update s1 = 7;
select * from t1;
drop view v1;
drop table t1;

--
-- test of updating and fetching from the same table check
--
create table t1 (col1 int);
create table t2 (col1 int);
create table t3 (col1 datetime not null);
create view v1 as select * from t1;
create view v2 as select * from v1;
create view v3 as select v2.col1 from v2,t2 where v2.col1 = t2.col1;
update v2 set col1 = (select max(col1) from v1);
update v2 set col1 = (select max(col1) from t1);
update v2 set col1 = (select max(col1) from v2);
update v2,t2 set v2.col1 = (select max(col1) from v1) where v2.col1 = t2.col1;
update t1,t2 set t1.col1 = (select max(col1) from v1) where t1.col1 = t2.col1;
update v1,t2 set v1.col1 = (select max(col1) from v1) where v1.col1 = t2.col1;
update t2,v2 set v2.col1 = (select max(col1) from v1) where v2.col1 = t2.col1;
update t2,t1 set t1.col1 = (select max(col1) from v1) where t1.col1 = t2.col1;
update t2,v1 set v1.col1 = (select max(col1) from v1) where v1.col1 = t2.col1;
update v2,t2 set v2.col1 = (select max(col1) from t1) where v2.col1 = t2.col1;
update t1,t2 set t1.col1 = (select max(col1) from t1) where t1.col1 = t2.col1;
update v1,t2 set v1.col1 = (select max(col1) from t1) where v1.col1 = t2.col1;
update t2,v2 set v2.col1 = (select max(col1) from t1) where v2.col1 = t2.col1;
update t2,t1 set t1.col1 = (select max(col1) from t1) where t1.col1 = t2.col1;
update t2,v1 set v1.col1 = (select max(col1) from t1) where v1.col1 = t2.col1;
update v2,t2 set v2.col1 = (select max(col1) from v2) where v2.col1 = t2.col1;
update t1,t2 set t1.col1 = (select max(col1) from v2) where t1.col1 = t2.col1;
update v1,t2 set v1.col1 = (select max(col1) from v2) where v1.col1 = t2.col1;
update t2,v2 set v2.col1 = (select max(col1) from v2) where v2.col1 = t2.col1;
update t2,t1 set t1.col1 = (select max(col1) from v2) where t1.col1 = t2.col1;
update t2,v1 set v1.col1 = (select max(col1) from v2) where v1.col1 = t2.col1;
update v3 set v3.col1 = (select max(col1) from v1);
update v3 set v3.col1 = (select max(col1) from t1);
update v3 set v3.col1 = (select max(col1) from v2);
update v3 set v3.col1 = (select max(col1) from v3);
delete from v2 where col1 = (select max(col1) from v1);
delete from v2 where col1 = (select max(col1) from t1);
delete from v2 where col1 = (select max(col1) from v2);
delete v2 from v2,t2 where (select max(col1) from v1) > 0 and v2.col1 = t2.col1;
delete t1 from t1,t2 where (select max(col1) from v1) > 0 and t1.col1 = t2.col1;
delete v1 from v1,t2 where (select max(col1) from v1) > 0 and v1.col1 = t2.col1;
delete v2 from v2,t2 where (select max(col1) from t1) > 0 and v2.col1 = t2.col1;
delete t1 from t1,t2 where (select max(col1) from t1) > 0 and t1.col1 = t2.col1;
delete v1 from v1,t2 where (select max(col1) from t1) > 0 and v1.col1 = t2.col1;
delete v2 from v2,t2 where (select max(col1) from v2) > 0 and v2.col1 = t2.col1;
delete t1 from t1,t2 where (select max(col1) from v2) > 0 and t1.col1 = t2.col1;
delete v1 from v1,t2 where (select max(col1) from v2) > 0 and v1.col1 = t2.col1;
insert into v2 values ((select max(col1) from v1));
insert into t1 values ((select max(col1) from v1));
insert into v2 values ((select max(col1) from v1));
insert into v2 values ((select max(col1) from t1));
insert into t1 values ((select max(col1) from t1));
insert into v2 values ((select max(col1) from t1));
insert into v2 values ((select max(col1) from v2));
insert into t1 values ((select max(col1) from v2));
insert into v2 values ((select max(col1) from v2));
insert into v3 (col1) values ((select max(col1) from v1));
insert into v3 (col1) values ((select max(col1) from t1));
insert into v3 (col1) values ((select max(col1) from v2));
insert into v3 (col1) values ((select CONVERT_TZ('20050101000000','UTC','MET') from v2));
insert into v3 (col1) values ((select CONVERT_TZ('20050101000000','UTC','MET') from t2));
insert into t3 values ((select CONVERT_TZ('20050101000000','UTC','MET') from t2));
create algorithm=temptable view v4 as select * from t1;
insert into t1 values (1),(2),(3);
insert into t1 (col1) values ((select max(col1) from v4));
select * from t1;

drop view v4,v3,v2,v1;
drop table t1,t2,t3;

--
-- HANDLER with VIEW
--
create table t1 (s1 int);
create view v1 as select * from t1;
drop view v1;
drop table t1;

--
-- view with WHERE in nested join
--
create table t1(a int);
insert into t1 values (0), (1), (2), (3);
create table t2 (a int);
insert into t2 select a from t1 where a > 1;
create view v1 as select a from t1 where a > 1;
select * from t1 left join (t2 as t, v1) on v1.a=t1.a;
select * from t1 left join (t2 as t, t2) on t2.a=t1.a;
drop view v1;
drop table t1, t2;

--
-- Collation with view update
--
create table t1 (s1 char) charset latin1;
create view v1 as select s1 collate latin1_german1_ci as s1 from t1;
insert into v1 values ('a');
select * from v1;
update v1 set s1='b';
select * from v1;
update v1,t1 set v1.s1='c' where t1.s1=v1.s1;
select * from v1;
set @arg='d';
select * from v1;
set @arg='e';
select * from v1;
drop view v1;
drop table t1;

--
-- test view with LOCK TABLES (work around)
--
create table t1 (a int);
create table t2 (a int);
create view v1 as select * from t1;
select * from v1;
select * from t2;
drop view v1;
drop table t1, t2;

--
-- WITH CHECK OPTION insert/update test
--
create table t1 (a int);
create view v1 as select * from t1 where a < 2 with check option;
insert into v1 values(1);
insert into v1 values(3);
insert ignore into v1 values (2),(3),(0);
select * from t1;
delete from t1;
insert into v1 SELECT 1;
insert into v1 SELECT 3;
create table t2 (a int);
insert into t2 values (2),(3),(0);
insert ignore into v1 SELECT a from t2;
select * from t1 order by a desc;
update v1 set a=-1 where a=0;
update v1 set a=2 where a=1;
select * from t1 order by a desc;
update v1 set a=0 where a=0;
insert into t2 values (1);
update v1,t2 set v1.a=v1.a-1 where v1.a=t2.a;
select * from t1 order by a desc;
update v1 set a=a+1;
update ignore v1,t2 set v1.a=v1.a+1 where v1.a=t2.a;
select * from t1;

drop view v1;
drop table t1, t2;

--
-- CASCADED/LOCAL CHECK OPTION test
--
create table t1 (a int);
create view v1 as select * from t1 where a < 2 with check option;
create view v2 as select * from v1 where a > 0 with local check option;
create view v3 as select * from v1 where a > 0 with cascaded check option;
insert into v2 values (1);
insert into v3 values (1);
insert into v2 values (0);
insert into v3 values (0);
insert into v2 values (2);
insert into v3 values (2);
select * from t1;
drop view v3,v2,v1;
drop table t1;

--
-- CHECK OPTION with INSERT ... ON DUPLICATE KEY UPDATE
--
create table t1 (a int, primary key (a));
create view v1 as select * from t1 where a < 2 with check option;
insert into v1 values (1) on duplicate key update a=2;
insert into v1 values (1) on duplicate key update a=2;
insert ignore into v1 values (1) on duplicate key update a=2;
select * from t1;
drop view v1;
drop table t1;

--
-- check cyclic referencing protection on altering view
--
create table t1 (s1 int);
create view v1 as select * from t1;
create view v2 as select * from v1;
alter view v1 as select * from v2;
alter view v1 as select * from v1;
create or replace view v1 as select * from v2;
create or replace view v1 as select * from v1;
drop view v2,v1;
drop table t1;

--
-- check altering differ options
--
create table t1 (a int);
create view v1 as select * from t1;
alter algorithm=undefined view v1 as select * from t1 with check option;
alter algorithm=merge view v1 as select * from t1 with cascaded check option;
alter algorithm=temptable view v1 as select * from t1;
drop view v1;
drop table t1;

--
-- updating view with subquery in the WHERE clause
--
create table t1 (s1 int);
create table t2 (s1 int);
create view v2 as select * from t2 where s1 in (select s1 from t1);
insert into v2 values (5);
insert into t1 values (5);
select * from v2;
update v2 set s1 = 0;
select * from v2;
select * from t2;
alter view v2 as select * from t2 where s1 in (select s1 from t1) with check option;
insert into v2 values (5);
update v2 set s1 = 1;
insert into t1 values (1);
update v2 set s1 = 1;
select * from v2;
select * from t2;
insert into t1 values (0);
drop view v2;
drop table t1, t2;

--
-- test of substring_index with view
--
create table t1 (t time);
create view v1 as select substring_index(t,':',2) as t from t1;
insert into t1 (t) values ('12:24:10');
select substring_index(t,':',2) from t1;
select substring_index(t,':',2) from v1;
drop view v1;
drop table t1;

--
-- test of cascaded check option for whiew without WHERE clause
--
create table t1 (s1 tinyint);
create view v1 as select * from t1 where s1 <> 0 with local check option;
create view v2 as select * from v1 with cascaded check option;
insert into v2 values (0);
drop view v2, v1;
drop table t1;

--
-- inserting single value with check option failed always get error
--
create table t1 (s1 int);
create view v1 as select * from t1 where s1 < 5 with check option;
insert ignore into v1 values (6);
insert ignore into v1 values (6),(3);
select * from t1;
drop view v1;
drop table t1;

--
-- changing value by trigger and CHECK OPTION
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (s1 tinyint);
create trigger t1_bi before insert on t1 for each row set new.s1 = 500;
create view v1 as select * from t1 where s1 <> 127 with check option;
insert into v1 values (0);
select * from v1;
select * from t1;
drop trigger t1_bi;
drop view v1;
drop table t1;
SET sql_mode = default;
create table t1 (s1 tinyint);
create view v1 as select * from t1 where s1 <> 0;
create view v2 as select * from v1 where s1 <> 1 with cascaded check option;
insert into v2 values (0);
select * from v2;
select * from t1;
drop view v2, v1;
drop table t1;

--
-- LOAD DATA with view and CHECK OPTION
--
-- fixed length fields

-- variable length fields
create table t1 (a text, b text);
create view v1 as select * from t1 where a <> 'Field A' with check option;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
delete from t1;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
drop view v1;
drop table t1;

-- Following scenario is to test the functionality of InnoDB

create table t1 (a int, b char(10)) charset latin1;
create view v1 as select * from t1 where a != 0 with check option;
select * from t1;
select * from v1;
delete from t1;
select * from t1;
select * from v1;
drop view v1;
drop table t1;
create table t1 (a text, b text) ;
create view v1 as select * from t1 where a <> 'Field A' with check option;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
delete from t1;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
drop view v1;
drop table t1;

--
-- Trys update table from which we select using views and subqueries
--
create table t1 (s1 smallint);
create view v1 as select * from t1 where 20 < (select (s1) from t1);
insert into v1 values (30);
create view v2 as select * from t1;
create view v3 as select * from t1 where 20 < (select (s1) from v2);
insert into v3 values (30);
create view v4 as select * from v2 where 20 < (select (s1) from t1);
insert into v4 values (30);
drop view v4, v3, v2, v1;
drop table t1;

--
-- CHECK TABLE with VIEW
--
create table t1 (a int);
create view v1 as select * from t1;
drop table t1;
drop view v1;

--
-- merge of VIEW with several tables
--
create table t1 (a int);
create table t2 (a int);
create table t3 (a int);
insert into t1 values (1), (2), (3);
insert into t2 values (1), (3);
insert into t3 values (1), (2), (4);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1 left join t2 on (t1.a=t2.a);
select * from t3 left join v3 on (t3.a = v3.a);
create view v1 (a) as select a from t1;
create view v2 (a) as select a from t2;
create view v4 (a,b) as select v1.a as a, v2.a as b from v1 left join v2 on (v1.a=v2.a);
select * from t3 left join v4 on (t3.a = v4.a);
drop view v4,v3,v2,v1;
drop tables t1,t2,t3;

--
-- updating of join view
--
create table t1 (a int, primary key (a), b int);
create table t2 (a int, primary key (a));
insert into t1 values (1,100), (2,200);
insert into t2 values (1), (3);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1, t2;
update v3 set a= 10 where a=1;
select * from t1;
select * from t2;
create view v2 (a,b) as select t1.b as a, t2.a as b from t1, t2;
set updatable_views_with_limit=NO;
update v2 set a= 10 where a=200 limit 1;
set updatable_views_with_limit=DEFAULT;
select * from v3;
select * from v2;
set @a= 10;
set @b= 100;
select * from v3;
set @a= 300;
set @b= 10;
select * from v3;
drop view v3,v2;
drop tables t1,t2;

-- Following scenario is to test the functionality of InnoDB

create table t1 (a int, primary key (a), b int);
create table t2 (a int, primary key (a), b int);
insert into t2 values (1000, 2000);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1, t2;
insert into v3 values (1,2);
insert into v3 select * from t2;
insert into v3(a,b) values (1,2);
insert into v3(a,b) select * from t2;
update v3 set a=1,b=2;
insert into v3(a) values (1);
insert into v3(b) values (10);
insert into v3(a) select a from t2;
insert into v3(b) select b from t2;
insert into v3(a) values (1) on duplicate key update a=a+10000+VALUES(a);
select * from t1;
select * from t2;
delete from v3;
delete v3,t1 from v3,t1;
delete t1,v3 from t1,v3;
delete from t1;
set @a= 100;
set @a= 300;
set @a= 101;
set @a= 301;
select * from v3;

drop view v3;
drop tables t1,t2;

--
-- View field names should be case insensitive
--
create table t1(f1 int);
create view v1 as select f1 from t1;
select * from v1 where F1 = 1;
drop view v1;
drop table t1;

--
-- Resolving view fields in subqueries in VIEW (Bug#6394)
--
create table t1(c1 int);
create table t2(c2 int);
insert into t1 values (1),(2),(3);
insert into t2 values (1);
SELECT c1 FROM t1 WHERE c1 IN (SELECT c2 FROM t2);
SELECT c1 FROM t1 WHERE EXISTS (SELECT c2 FROM t2 WHERE c2 = c1);
create view v1 as SELECT c1 FROM t1 WHERE c1 IN (SELECT c2 FROM t2);
create view v2 as SELECT c1 FROM t1 WHERE EXISTS (SELECT c2 FROM t2 WHERE c2 = c1);
select * from v1;
select * from v2;
select * from (select c1 from v2) X;
drop view v2, v1;
drop table t1, t2;

--
-- view over other view setup (Bug#7433)
--
CREATE TABLE t1 (C1 INT, C2 INT);
CREATE TABLE t2 (C2 INT);
CREATE VIEW v1 AS SELECT C2 FROM t2;
CREATE VIEW v2 AS SELECT C1 FROM t1 LEFT OUTER JOIN v1 USING (C2);
SELECT * FROM v2;
drop view v2, v1;
drop table t1, t2;

--
-- view and group_concat() (Bug#7116)
--
create table t1 (col1 char(5),col2 int,col3 int);
insert into t1 values ('one',10,25), ('two',10,50), ('two',10,50), ('one',20,25), ('one',30,25);
create view v1 as select * from t1;
select col1,group_concat(col2,col3) from t1 group by col1;
select col1,group_concat(col2,col3) from v1 group by col1;
drop view v1;
drop table t1;

--
-- Item_ref resolved as view field (Bug#6894)
--
create table t1 (s1 int, s2 char);
create view v1 as select s1, s2 from t1;
select s2 from v1 vq1 where 2 = (select count(*) from v1 vq2 having vq1.s2 = vq2.s2);
select s2 from v1 vq1 where 2 = (select count(*) aa from v1 vq2 having vq1.s2 = aa);
drop view v1;
drop table t1;

--
-- Test case for Bug#9398 CREATE TABLE with SELECT from a multi-table view
--
CREATE TABLE t1 (a1 int);
CREATE TABLE t2 (a2 int);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t2 VALUES (1), (2), (3);
CREATE VIEW v1(a,b) AS SELECT a1,a2 FROM t1 JOIN t2 ON a1=a2 WHERE a1>1;

SELECT * FROM v1;
CREATE TABLE t3 SELECT * FROM v1;
SELECT * FROM t3;

DROP VIEW v1;
DROP TABLE t1,t2,t3;

--
-- Test for Bug#8703 insert into table select from view crashes
--
create table t1 (a int);
create table t2 like t1;
create table t3 like t1;
create view v1 as select t1.a x, t2.a y from t1 join t2 where t1.a=t2.a;
insert into t3 select x from v1;
insert into t2 select x from v1;
drop view v1;
drop table t1,t2,t3;

--
-- Test for Bug#6106 query over a view using subquery for the underlying table
--

CREATE TABLE t1 (col1 int PRIMARY KEY, col2 varchar(10));
INSERT INTO t1 VALUES(1,'trudy');
INSERT INTO t1 VALUES(2,'peter');
INSERT INTO t1 VALUES(3,'sanja');
INSERT INTO t1 VALUES(4,'monty');
INSERT INTO t1 VALUES(5,'david');
INSERT INTO t1 VALUES(6,'kent');
INSERT INTO t1 VALUES(7,'carsten');
INSERT INTO t1 VALUES(8,'ranger');
INSERT INTO t1 VALUES(10,'matt');
CREATE TABLE t2 (col1 int, col2 int, col3 char(1));
INSERT INTO t2 VALUES (1,1,'y');
INSERT INTO t2 VALUES (1,2,'y');
INSERT INTO t2 VALUES (2,1,'n');
INSERT INTO t2 VALUES (3,1,'n');
INSERT INTO t2 VALUES (4,1,'y');
INSERT INTO t2 VALUES (4,2,'n');
INSERT INTO t2 VALUES (4,3,'n');
INSERT INTO t2 VALUES (6,1,'n');
INSERT INTO t2 VALUES (8,1,'y');

CREATE VIEW v1 AS SELECT * FROM t1;
SELECT a.col1,a.col2,b.col2,b.col3
  FROM t1 a LEFT JOIN t2 b ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM t2 b WHERE b.col1=a.col1);
SELECT a.col1,a.col2,b.col2,b.col3
  FROM v1 a LEFT JOIN t2 b ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM t2 b WHERE b.col1=a.col1);

CREATE VIEW v2 AS SELECT * FROM t2;
SELECT a.col1,a.col2,b.col2,b.col3
  FROM v2 b RIGHT JOIN v1 a ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM v2 b WHERE b.col1=a.col1);

-- Tests from the report for Bug#6107

SELECT a.col1,a.col2,b.col2,b.col3
  FROM v2 b RIGHT JOIN v1 a ON a.col1=b.col1
    WHERE a.col1 IN (1,5,9) AND
         (b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM v2 b WHERE b.col1=a.col1));

CREATE VIEW v3 AS SELECT * FROM t1 WHERE col1 IN (1,5,9);

SELECT a.col1,a.col2,b.col2,b.col3
  FROM v2 b RIGHT JOIN v3 a ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM v2 b WHERE b.col1=a.col1);

DROP VIEW v1,v2,v3;
DROP TABLE t1,t2;

--
-- Bug#8490 Select from views containing subqueries causes server to hang
--          forever.
--
create table t1 as select 1 A union select 2 union select 3;
create table t2 as select * from t1;
create view v1 as select * from t1 where a in (select * from t2);
select * from v1 A, v1 B where A.a = B.a;
create table t3 as select a a,a b from t2;
create view v2 as select * from t3 where
  a in (select * from t1) or b in (select * from t2);
select * from v2 A, v2 B where A.a = B.b;
drop view v1, v2;
drop table t1, t2, t3;

--
-- Test case for Bug#8528 select from view over multi-table view
--
CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t2 VALUES (4), (2);

CREATE VIEW v1 AS SELECT * FROM t1,t2 WHERE t1.a=t2.b;
SELECT * FROM v1;
CREATE VIEW v2 AS SELECT * FROM v1;
SELECT * FROM v2;

DROP VIEW v2,v1;

DROP TABLE t1, t2;
create table t1 (a int);
create view v1 as select sum(a) from t1 group by a;
create procedure p1()
begin
select * from v1;
drop procedure p1;
drop view v1;
drop table t1;

--
-- Bug#7422 "order by" doesn't work
--
CREATE TABLE t1(a char(2) primary key, b char(2));
CREATE TABLE t2(a char(2), b char(2), index i(a));
INSERT INTO t1 VALUES ('a','1'), ('b','2');
INSERT INTO t2 VALUES ('a','5'), ('a','6'), ('b','5'), ('b','6');
CREATE VIEW v1 AS
  SELECT t1.b as c, t2.b as d FROM t1,t2 WHERE t1.a=t2.a;
SELECT d, c FROM v1 ORDER BY d,c;
DROP VIEW v1;
DROP TABLE t1, t2;
create table t1 (s1 int);
create view  v1 as select sum(distinct s1) from t1;
select * from v1;
drop view v1;
create view  v1 as select avg(distinct s1) from t1;
select * from v1;
drop view v1;
drop table t1;

--
-- using cast(... as decimal) in views (Bug#11387);
create view v1 as select cast(1 as decimal);
select * from v1;
drop view v1;

--
-- Bug#11298 insert into select from VIEW produces incorrect result when
--           using ORDER BY
create table t1(f1 int);
create table t2(f2 int);
insert into t1 values(1),(2),(3);
insert into t2 values(1),(2),(3);
create view v1 as select * from t1,t2 where f1=f2;
create table t3 (f1 int, f2 int);
insert into t3 select * from v1 order by 1;
select * from t3;
drop view v1;
drop table t1,t2,t3;

--
-- Generation unique names for columns, and correct names check (Bug#7448)
--
-- names with ' and \
create view v1 as select '\\','\\shazam';
select * from v1;
drop view v1;
create view v1 as select '\'','\shazam';
select * from v1;
drop view v1;
create view v1 as select 'k','K';
select * from v1;
drop view v1;
create table t1 (s1 int);
create view v1 as select s1, 's1' from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', s1 from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', s1, 1 as Name_exp_s1 from t1;
select * from v1;
drop view v1;
create view v1 as select 1 as Name_exp_s1, 's1', s1  from t1;
select * from v1;
drop view v1;
create view v1 as select 1 as s1, 's1', 's1' from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', 's1', 1 as s1 from t1;
select * from v1;
drop view v1;
create view v1 as select s1, 's1', 's1' from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', 's1', s1 from t1;
select * from v1;
drop view v1;
create view v1 as select 1 as s1, 's1', s1 from t1;
create view v1 as select 's1', s1, 1 as s1 from t1;
drop table t1;
create view v1(k, K) as select 1,2;

--
-- using time_format in view (Bug#7521)
--
create view v1 as SELECT TIME_FORMAT(SEC_TO_TIME(3600),'%H:%i') as t;
select * from v1;
drop view v1;

--
-- evaluation constant functions in WHERE (Bug#4663)
--
create table t1 (a timestamp default now());
create table t2 (b timestamp default now());
create view v1 as select a,b,t1.a < now() from t1,t2 where t1.a < now();
drop view v1;
drop table t1, t2;
CREATE TABLE t1 ( a varchar(50) );
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a = CURRENT_USER();
DROP VIEW v1;
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a = VERSION();
DROP VIEW v1;
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a = DATABASE();
DROP VIEW v1;
DROP TABLE t1;

--
-- checking views after some view with error (Bug#11337)
--
CREATE TABLE t1 (col1 time);
CREATE TABLE t2 (col1 time);
CREATE VIEW v1 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t1;
CREATE VIEW v2 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t2;
CREATE VIEW v3 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t1;
CREATE VIEW v4 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t2;
CREATE VIEW v5 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t1;
CREATE VIEW v6 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t2;
DROP TABLE t1;
drop view v1, v2, v3, v4, v5, v6;
drop table t2;
drop function if exists f1;
drop function if exists f2;
CREATE TABLE t1 (col1 time);
CREATE TABLE t2 (col1 time);
CREATE TABLE t3 (col1 time);
create function f1 () returns int return (select max(col1) from t1);
create function f2 () returns int return (select max(col1) from t2);
CREATE VIEW v1 AS SELECT f1() FROM t3;
CREATE VIEW v2 AS SELECT f2() FROM t3;
CREATE VIEW v3 AS SELECT f1() FROM t3;
CREATE VIEW v4 AS SELECT f2() FROM t3;
CREATE VIEW v5 AS SELECT f1() FROM t3;
CREATE VIEW v6 AS SELECT f2() FROM t3;
drop function f1;
create function f1 () returns int return (select max(col1) from t1);
DROP TABLE t1;
drop function f1;
drop function f2;
drop view v1, v2, v3, v4, v5, v6;
drop table t2,t3;

--
-- Bug#11325 Wrong date comparison in views
--
create table t1 (f1 date);
insert into t1 values ('2005-01-01'),('2005-02-02');
create view v1 as select * from t1;
select * from v1 where f1='2005.02.02';
select * from v1 where '2005.02.02'=f1;
drop view v1;
drop table t1;

--
-- using encrypt & substring_index in view (Bug#7024)
--
CREATE VIEW v1 AS SELECT SUBSTRING_INDEX("dkjhgd:kjhdjh", ":", 1);
SELECT * FROM v1;
drop view v1;

--
-- hide underlying tables names in case of imposibility to update (Bug#10773)
--
create table t1 (f59 int, f60 int, f61 int);
insert into t1 values (19,41,32);
create view v1 as select f59, f60 from t1 where f59 in
         (select f59 from t1);
update v1 set f60=2345;
update t1 set f60=(select max(f60) from v1);
drop view v1;
drop table t1;

--
-- Using var_samp with view (Bug#10651)
--
create table t1 (s1 int);
create view v1 as select var_samp(s1) from t1;
drop view v1;
drop table t1;


--
-- Correct inserting data check (absence of default value) for view
-- underlying tables (Bug#6443)
--
CREATE TABLE t1 (col1 INT NOT NULL, col2 INT NOT NULL);
CREATE VIEW v1 (vcol1) AS SELECT col1 FROM t1;
CREATE VIEW v2 (vcol1) AS SELECT col1 FROM t1 WHERE col2 > 2;
INSERT INTO t1 (col1) VALUES(12);
INSERT INTO v1 (vcol1) VALUES(12);
INSERT INTO v2 (vcol1) VALUES(12);
drop view v2,v1;
drop table t1;


--
-- Bug#11399 Use an alias in a select statement on a view
--
create table t1 (f1 int);
insert into t1 values (1);
create view v1 as select f1 from t1;
select f1 as alias from v1;
drop view v1;
drop table t1;


--
-- Test for Bug#6120 SP cache to be invalidated when altering a view
--

CREATE TABLE t1 (s1 int, s2 int);
INSERT  INTO t1 VALUES (1,2);
CREATE VIEW v1 AS SELECT s2 AS s1, s1 AS s2 FROM t1;
SELECT * FROM v1;
CREATE PROCEDURE p1 () SELECT * FROM v1;
ALTER VIEW v1 AS SELECT s1 AS s1, s2 AS s2 FROM t1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT s2 AS s1, s1 AS s2 FROM t1;

DROP PROCEDURE p1;
DROP VIEW v1;
DROP TABLE t1;


--
-- Test for Bug#11709 View was ordered by wrong column
--
create table t1 (f1 int, f2 int);
create view v1 as select f1 as f3, f2 as f1 from t1;
insert into t1 values (1,3),(2,1),(3,2);
select * from v1 order by f1;
drop view v1;
drop table t1;


--
-- Test for Bug#11771 wrong query_id in SELECT * FROM <view>
--
CREATE TABLE t1 (f1 char);
INSERT INTO t1 VALUES ('A');
CREATE VIEW  v1 AS SELECT * FROM t1;

INSERT INTO t1 VALUES('B');
SELECT * FROM v1;
SELECT * FROM t1;

DROP VIEW v1;
DROP TABLE t1;


--
-- opening table in correct locking mode (Bug#9597)
--
CREATE TABLE t1 ( bug_table_seq   INTEGER NOT NULL);
CREATE OR REPLACE VIEW v1 AS SELECT * from t1;
DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1 ( )
BEGIN
        DO (SELECT  @next := IFNULL(max(bug_table_seq),0) + 1 FROM v1);
        INSERT INTO t1 VALUES (1);
END //
delimiter ;
DROP PROCEDURE p1;
DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#11760 Typo in Item_func_add_time::print() results in NULLs returned
--             subtime() in view
create table t1(f1 datetime);
insert into t1 values('2005.01.01 12:0:0');
create view v1 as select f1, subtime(f1, '1:1:1') as sb from t1;
select * from v1;
drop view v1;
drop table t1;


--
-- Test for Bug#11412 query over a multitable view with GROUP_CONCAT
--
CREATE TABLE t1 (
  aid int PRIMARY KEY,
  fn varchar(20) NOT NULL,
  ln varchar(20) NOT NULL
);
CREATE TABLE t2 (
  aid int NOT NULL,
  pid int NOT NULL
);
INSERT INTO t1 VALUES(1,'a','b'), (2,'c','d');
INSERT INTO t2 values (1,1), (2,1), (2,2);

CREATE VIEW v1 AS SELECT t1.*,t2.pid FROM t1,t2 WHERE t1.aid = t2.aid;

SELECT pid,GROUP_CONCAT(CONCAT(fn,' ',ln) ORDER BY 1) FROM t1,t2
  WHERE t1.aid = t2.aid GROUP BY pid;
SELECT pid,GROUP_CONCAT(CONCAT(fn,' ',ln) ORDER BY 1) FROM v1 GROUP BY pid;

DROP VIEW v1;
DROP TABLE t1,t2;


--
-- Test for Bug#12382 SELECT * FROM view after INSERT command
--

CREATE TABLE t1 (id int PRIMARY KEY, f varchar(255));
CREATE VIEW v1 AS SELECT id, f FROM t1 WHERE id <= 2;
INSERT INTO t1 VALUES (2, 'foo2');
INSERT INTO t1 VALUES (1, 'foo1');
SELECT * FROM v1;
SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;


--
-- Test for Bug#12470 crash for a simple select from a view defined
--                    as a join over 5 tables

CREATE TABLE t1 (pk int PRIMARY KEY, b int);
CREATE TABLE t2 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE TABLE t3 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE TABLE t4 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE TABLE t5 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE VIEW v1 AS
  SELECT t1.pk as a FROM t1,t2,t3,t4,t5
    WHERE t1.b IS NULL AND
          t1.pk=t2.fk AND t2.pk=t3.fk AND t3.pk=t4.fk AND t4.pk=t5.fk;

SELECT a FROM v1;

DROP VIEW v1;
DROP TABLE t1,t2,t3,t4,t5;


--
-- Bug#12298 Typo in function name results in erroneous view being created.
--
create view v1 as select timestampdiff(day,'1997-01-01 00:00:00','1997-01-02 00:00:00') as f1;
select * from v1;
drop view v1;

--
-- repeatable CREATE VIEW statement Bug#12468
--
create table t1(a int);
create procedure p1() create view v1 as select * from t1;
drop table t1;
drop procedure p1;


--
-- Bug#10624 Views with multiple UNION and UNION ALL produce incorrect results
--
create table t1 (f1 int);
create table t2 (f1 int);
insert into t1 values (1);
insert into t2 values (2);
create view v1 as select * from t1 union select * from t2 union all select * from t2;
select * from v1;
drop view v1;
drop table t1,t2;


--
-- Test for Bug#10970 view referring a temporary table indirectly
--

CREATE TEMPORARY TABLE t1 (a int);
CREATE FUNCTION f1 () RETURNS int RETURN (SELECT COUNT(*) FROM t1);
CREATE VIEW v1 AS SELECT f1();

DROP FUNCTION f1;
DROP TABLE t1;


--
-- Bug#12533 (crash on DESCRIBE <view> after renaming base table column)
--
--disable_warnings
DROP TABLE IF EXISTS t1;
DROP VIEW  IF EXISTS v1;

CREATE TABLE t1 (f4 CHAR(5));
CREATE VIEW v1 AS SELECT * FROM t1;

ALTER TABLE t1 CHANGE COLUMN f4 f4x CHAR(5);
DROP TABLE t1;
DROP VIEW v1;


--
-- Bug#12489 wrongly printed strcmp() function results in creation of broken
--            view
create table t1 (f1 char);
create view v1 as select strcmp(f1,'a') from t1;
select * from v1;
drop view v1;
drop table t1;


--
-- Bug#12922 if(sum(),...) with group from view returns wrong results
--
create table t1 (f1 int, f2 int,f3 int);
insert into t1 values (1,10,20),(2,0,0);
create view v1 as select * from t1;
select if(sum(f1)>1,f2,f3) from v1 group by f1;
drop view v1;
drop table t1;


-- Bug#12941
--
--disable_warnings
create table t1 (
  r_object_id char(16) NOT NULL,
  group_name varchar(32) NOT NULL
) engine = InnoDB;

create table t2 (
  r_object_id char(16) NOT NULL,
  i_position int(11) NOT NULL,
  users_names varchar(32) default NULL
) Engine = InnoDB;

create view v1 as select r_object_id, group_name from t1;
create view v2 as select r_object_id, i_position, users_names from t2;

create unique index r_object_id on t1(r_object_id);
create index group_name on t1(group_name);
create unique index r_object_id_i_position on t2(r_object_id,i_position);
create index users_names on t2(users_names);

insert into t1 values('120001a080000542','tstgroup1');
insert into t2 values('120001a080000542',-1, 'guser01');
insert into t2 values('120001a080000542',-2, 'guser02');

select v1.r_object_id, v2.users_names from v1, v2
where (v1.group_name='tstgroup1') and v2.r_object_id=v1.r_object_id
order by users_names;

drop view v1, v2;
drop table t1, t2;


--
-- Bug#6808 Views: CREATE VIEW v ... FROM t AS v fails
--

create table t1 (s1 int);
create view abc as select * from t1 as abc;
drop table t1;
drop view abc;


--
-- Bug#12993 View column rename broken in subselect
--
create table t1(f1 char(1));
create view v1 as select * from t1;
select * from (select f1 as f2 from v1) v where v.f2='a';
drop view v1;
drop table t1;


--
-- Bug#11416 Server crash if using a view that uses function convert_tz
--
create view v1 as SELECT CONVERT_TZ('2004-01-01 12:00:00','GMT','MET');
select * from v1;
drop view v1;


--
-- Bugs#12963, #13000 wrong creation of VIEW with DAYNAME, DAYOFWEEK, and WEEKDAY
--

CREATE TABLE t1 (date DATE NOT NULL);
INSERT INTO  t1 VALUES ('2005-09-06');

CREATE VIEW v1 AS SELECT DAYNAME(date) FROM t1;

CREATE VIEW v2 AS SELECT DAYOFWEEK(date) FROM t1;

CREATE VIEW v3 AS SELECT WEEKDAY(date) FROM t1;

SELECT DAYNAME('2005-09-06');
SELECT DAYNAME(date) FROM t1;
SELECT * FROM v1;

SELECT DAYOFWEEK('2005-09-06');
SELECT DAYOFWEEK(date) FROM t1;
SELECT * FROM v2;

SELECT WEEKDAY('2005-09-06');
SELECT WEEKDAY(date) FROM t1;
SELECT * FROM v3;

DROP TABLE t1;
DROP VIEW  v1, v2, v3;


--
-- Bug#13411 crash when using non-qualified view column in HAVING clause
--

CREATE TABLE t1 ( a int, b int );
INSERT INTO t1 VALUES (1,1),(2,2),(3,3);
CREATE VIEW v1 AS SELECT a,b FROM t1;
SELECT t1.a FROM t1 GROUP BY t1.a HAVING a > 1;
SELECT v1.a FROM v1 GROUP BY v1.a HAVING a > 1;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#13410 failed name resolution for qualified view column in HAVING
--

CREATE TABLE t1 ( a int, b int );
INSERT INTO t1 VALUES (1,1),(2,2),(3,3);
CREATE VIEW v1 AS SELECT a,b FROM t1;
SELECT t1.a FROM t1 GROUP BY t1.a HAVING t1.a > 1;
SELECT v1.a FROM v1 GROUP BY v1.a HAVING v1.a > 1;
SELECT t_1.a FROM t1 AS t_1 GROUP BY t_1.a HAVING t_1.a IN (1,2,3);
SELECT v_1.a FROM v1 AS v_1 GROUP BY v_1.a HAVING v_1.a IN (1,2,3);

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#13327 view wasn't using index for const condition
--

CREATE TABLE t1 (a INT, b INT, INDEX(a,b));
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 (a INT);
INSERT INTO t1 VALUES (1,1),(2,2),(3,3);
INSERT INTO t2 VALUES (1,1),(2,2),(3,3);
INSERT INTO t3 VALUES (1),(2),(3);
CREATE VIEW v1 AS SELECT t1.* FROM t1,t2 WHERE t1.a=t2.a AND t1.b=t2.b;
CREATE VIEW v2 AS SELECT t3.* FROM t1,t3 WHERE t1.a=t3.a;
DROP VIEW v1,v2;
DROP TABLE t1,t2,t3;


--
-- Bug#13622 Wrong view .frm created if some field's alias contain \n
--
create table t1 (f1 int);
create view v1 as select t1.f1 as '123
456' from t1;
select * from v1;
drop view v1;
drop table t1;


-- Bug#14466 lost sort order in GROUP_CONCAT() in a view
--
create table t1 (f1 int, f2 int);
insert into t1 values(1,1),(1,2),(1,3);
create view v1 as select f1 ,group_concat(f2 order by f2 asc) from t1 group by f1;
create view v2 as select f1 ,group_concat(f2 order by f2 desc) from t1 group by f1;
select * from v1;
select * from v2;
drop view v1,v2;
drop table t1;


--
-- Bug#14026 Crash on second PS execution when using views
--
create table t1 (x int, y int);
create table t2 (x int, y int, z int);
create table t3 (x int, y int, z int);
create table t4 (x int, y int, z int);

create view v1 as
select t1.x
from (
  (t1 join t2 on ((t1.y = t2.y)))
  join
  (t3 left join t4 on (t3.y = t4.y) and (t3.z = t4.z))
);
set @parm1=1;
drop view v1;
drop table t1,t2,t3,t4;


--
-- Bug#14540 OPTIMIZE, ANALYZE, REPAIR applied to not a view
--

CREATE TABLE t1(id INT);
CREATE VIEW v1 AS SELECT id FROM t1;

DROP TABLE t1;

DROP VIEW v1;


--
-- Bug#14719 Views DEFINER grammar is incorrect
--

create definer = current_user() sql security invoker view v1 as select 1;
drop view v1;

create definer = current_user sql security invoker view v1 as select 1;
drop view v1;


--
-- Bug#14816 test_if_order_by_key() expected only Item_fields.
--
create table t1 (id INT, primary key(id));
insert into t1 values (1),(2);
create view v1 as select * from t1;
drop view v1;
drop table t1;


--
-- Bug#14850 Item_ref's values wasn't updated
--
create table t1(f1 int, f2 int);
insert into t1 values (null, 10), (null,2);
select f1, sum(f2) from t1 group by f1;
create view v1 as select * from t1;
select f1, sum(f2) from v1 group by f1;
drop view v1;
drop table t1;


--
-- Bug#14885 incorrect SOURCE in view created in a procedure
-- TODO: here SOURCE string must be shown when it will be possible
--
--disable_warnings
drop procedure if exists p1;
create procedure p1 () deterministic
begin
create view v1 as select 1;
drop view v1;
drop procedure p1;


--
-- Bug#15096 using function with view for view creation
--
CREATE VIEW v1 AS SELECT 42 AS Meaning;
DROP FUNCTION IF EXISTS f1;
CREATE FUNCTION f1() RETURNS INTEGER
BEGIN
  DECLARE retn INTEGER;
  SELECT Meaning FROM v1 INTO retn;
END
//
DELIMITER ;
CREATE VIEW v2 AS SELECT f1();
select * from v2;
drop view v2,v1;
drop function f1;


--
-- Bug#14861 aliased column names are not preserved.
--
create table t1 (id numeric, warehouse_id numeric);
create view v1 as select id from t1;
create view v2 as
select t1.warehouse_id, v1.id as receipt_id
from t1, v1 where t1.id = v1.id;

insert into t1 (id, warehouse_id) values(3, 2);
insert into t1 (id, warehouse_id) values(4, 2);
insert into t1 (id, warehouse_id) values(5, 1);

select v2.receipt_id as alias1, v2.receipt_id as alias2 from v2
order by v2.receipt_id;

drop view v2, v1;
drop table t1;


--
-- Bug#16016 MIN/MAX optimization for views
--

CREATE TABLE t1 (a int PRIMARY KEY, b int);
INSERT INTO t1 VALUES (2,20), (3,10), (1,10), (0,30), (5,10);

CREATE VIEW v1 AS SELECT * FROM t1;

SELECT MAX(a) FROM t1;
SELECT MAX(a) FROM v1;

SELECT MIN(a) FROM t1;
SELECT MIN(a) FROM v1;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#16382 grouping name is resolved against a view column name
--           which coincides with a select column name

CREATE TABLE t1 (x varchar(10));
INSERT INTO t1 VALUES (null), ('foo'), ('bar'), (null);
CREATE VIEW v1 AS SELECT * FROM t1;

SELECT IF(x IS NULL, 'blank', 'not blank') FROM v1 GROUP BY x;
SELECT IF(x IS NULL, 'blank', 'not blank') AS x FROM t1 GROUP BY x;
SELECT IF(x IS NULL, 'blank', 'not blank') AS x FROM v1;
SELECT IF(x IS NULL, 'blank', 'not blank') AS y FROM v1 GROUP BY y;
SELECT IF(x IS NULL, 'blank', 'not blank') AS x FROM v1 GROUP BY x;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#15943 mysql_next_result hangs on invalid SHOW CREATE VIEW
--

delimiter //;
drop table if exists t1;
drop view if exists v1;
create table t1 (id int);
create view v1 as select * from t1;
drop table t1;
drop view v1;


--
-- Bug#17726 Not checked empty list caused endless loop
--
create table t1(f1 int, f2 int);
create view v1 as select ta.f1 as a, tb.f1 as b from t1 ta, t1 tb where ta.f1=tb
.f1 and ta.f2=tb.f2;
insert into t1 values(1,1),(2,2);
create view v2 as select * from v1 where a > 1 with local check option;
select * from v2;
update v2 set b=3 where a=2;
select * from v2;
drop view v2, v1;
drop table t1;


--
-- Bug#18386 select from view over a table with ORDER BY view_col clause
--           given view_col is not an image of any column from the base table

CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2);

CREATE VIEW v1 AS SELECT SQRT(a) my_sqrt FROM t1;

SELECT my_sqrt FROM v1 ORDER BY my_sqrt;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#18237 invalid count optimization applied to an outer join with a view
--

CREATE TABLE t1 (id int PRIMARY KEY);
CREATE TABLE t2 (id int PRIMARY KEY);

INSERT INTO t1 VALUES (1), (3);
INSERT INTO t2 VALUES (1), (2), (3);

CREATE VIEW v2 AS SELECT * FROM t2;

SELECT COUNT(*) FROM t1 LEFT JOIN t2 ON t1.id=t2.id;
SELECT * FROM t1 LEFT JOIN t2 ON t1.id=t2.id;

SELECT COUNT(*) FROM t1 LEFT JOIN v2 ON t1.id=v2.id;

DROP VIEW v2;

DROP TABLE t1, t2;


--
-- Bug#16069 VIEW does return the same results as underlying SELECT
--           with WHERE condition containing BETWEEN over dates
-- Dates as strings should be casted to date type

CREATE TABLE t1 (id int NOT NULL PRIMARY KEY,
                 td date DEFAULT NULL, KEY idx(td));

INSERT INTO t1 VALUES
 (1, '2005-01-01'), (2, '2005-01-02'), (3, '2005-01-02'),
 (4, '2005-01-03'), (5, '2005-01-04'), (6, '2005-01-05'),
 (7, '2005-01-05'), (8, '2005-01-05'), (9, '2005-01-06');

CREATE VIEW v1 AS SELECT * FROM t1;

SELECT * FROM t1 WHERE td BETWEEN CAST('2005.01.02' AS DATE) AND CAST('2005.01.04' AS DATE);
SELECT * FROM v1 WHERE td BETWEEN CAST('2005.01.02' AS DATE) AND CAST('2005.01.04' AS DATE);

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#14308 Recursive view definitions
--
-- using view only
create table t1 (a int);
create view v1 as select * from t1;
create view v2 as select * from v1;
drop table t1;
select * from v1;
drop view t1, v1;
create table t1 (a int);
create function f1() returns int
begin
  declare mx int;
  select max(a) from t1 into mx;
create view v1 as select f1() as a;
create view v2 as select * from v1;
drop table t1;
select * from v1;
drop function f1;
drop view t1, v1;


--
-- Bug#15153 CONVERT_TZ() is not allowed in all places in VIEWs
--
-- Error was reported when one tried to use CONVERT_TZ() function
-- select list of view which was processed using MERGE algorithm.
-- (Also see additional test in timezone_grant.test)
create table t1 (dt datetime);
insert into t1 values (20040101000000), (20050101000000), (20060101000000);
create view v1 as select convert_tz(dt, 'UTC', 'Europe/Moscow') as ldt from t1;
select * from v1;
drop view v1;
create view v1 as select * from t1 where convert_tz(dt, 'UTC', 'Europe/Moscow') >= 20050101000000;
select * from v1;
create view v2 as select * from v1 where dt < 20060101000000;
select * from v2;
drop view v2;
create view v2 as select convert_tz(dt, 'UTC', 'Europe/Moscow') as ldt from v1;
select * from v2;
drop view v1, v2;
drop table t1;


--
-- Bug#19490 usage of view specified by a query with GROUP BY
--           an expression containing non-constant interval

CREATE TABLE t1 (id int NOT NULL PRIMARY KEY, d datetime);

CREATE VIEW v1 AS
SELECT id, date(d) + INTERVAL TIME_TO_SEC(d) SECOND AS t, COUNT(*)
  FROM t1 GROUP BY id, t;
SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#19077 A nested materialized view is used before being populated.
--
CREATE TABLE t1 (i INT, j BIGINT);
INSERT INTO t1 VALUES (1, 2), (2, 2), (3, 2);
CREATE VIEW v1 AS SELECT MIN(j) AS j FROM t1;
CREATE VIEW v2 AS SELECT MIN(i) FROM t1 WHERE j = ( SELECT * FROM v1 );
SELECT * FROM v2;
DROP VIEW v2, v1;
DROP TABLE t1;


--
-- Bug#19573 VIEW with HAVING that refers an alias name
--

CREATE TABLE t1(
  fName varchar(25) NOT NULL,
  lName varchar(25) NOT NULL,
  DOB date NOT NULL,
  test_date date NOT NULL,
  uID int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY);

INSERT INTO t1(fName, lName, DOB, test_date) VALUES
  ('Hank', 'Hill', '1964-09-29', '2007-01-01'),
  ('Tom', 'Adams', '1908-02-14', '2007-01-01'),
  ('Homer', 'Simpson', '1968-03-05', '2007-01-01');

CREATE VIEW v1 AS
  SELECT (year(test_date)-year(DOB)) AS Age
    FROM t1 HAVING Age < 75;

SELECT (year(test_date)-year(DOB)) AS Age FROM t1 HAVING Age < 75;
SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#19089 wrong inherited dafault values in temp table views
--

CREATE TABLE t1 (id int NOT NULL PRIMARY KEY, a char(6) DEFAULT 'xxx');
INSERT INTO t1(id) VALUES (1), (2), (3), (4);
INSERT INTO t1 VALUES (5,'yyy'), (6,'yyy');
SELECT * FROM t1;

CREATE VIEW v1(a, m) AS SELECT a, MIN(id) FROM t1 GROUP BY a;
SELECT * FROM v1;

CREATE TABLE t2 SELECT * FROM v1;
INSERT INTO t2(m) VALUES (0);
SELECT * FROM t2;

DROP VIEW v1;
DROP TABLE t1,t2;

CREATE TABLE t1 (id int PRIMARY KEY, e ENUM('a','b') NOT NULL DEFAULT 'b');
INSERT INTO t1(id) VALUES (1), (2), (3);
INSERT INTO t1 VALUES (4,'a');
SELECT * FROM t1;

CREATE VIEW v1(m, e) AS SELECT MIN(id), e FROM t1 GROUP BY e;
CREATE TABLE t2 SELECT * FROM v1;
SELECT * FROM t2;

DROP VIEW v1;
DROP TABLE t1,t2;


--
-- Bug#16110 insert permitted into view col w/o default value
--
CREATE TABLE t1 (a INT NOT NULL, b INT NULL DEFAULT NULL);
CREATE VIEW v1 AS SELECT a, b FROM t1;

INSERT IGNORE INTO v1 (b) VALUES (2);

SET SQL_MODE = STRICT_ALL_TABLES;
INSERT INTO v1 (b) VALUES (4);
SET SQL_MODE = '';

SELECT * FROM t1;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#18243 expression over a view column that with the REVERSE function
--

CREATE TABLE t1 (firstname text, surname text);
INSERT INTO t1 VALUES
  ("Bart","Simpson"),("Milhouse","van Houten"),("Montgomery","Burns");

CREATE VIEW v1 AS SELECT CONCAT(firstname," ",surname) AS name FROM t1;
SELECT CONCAT(LEFT(name,LENGTH(name)-INSTR(REVERSE(name)," ")),
              LEFT(name,LENGTH(name)-INSTR(REVERSE(name)," "))) AS f1
 FROM v1;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#19714 wrong type of a view column specified by an expressions over ints
--

CREATE TABLE t1 (i int, j int);
CREATE VIEW v1 AS SELECT COALESCE(i,j) FROM t1;
CREATE TABLE t2 SELECT COALESCE(i,j) FROM t1;

DROP VIEW v1;
DROP TABLE t1,t2;


--
-- Bug#17526 views with TRIM functions
--

CREATE TABLE t1 (s varchar(10));
INSERT INTO t1 VALUES ('yadda'), ('yady');

SELECT TRIM(BOTH 'y' FROM s) FROM t1;
CREATE VIEW v1 AS SELECT TRIM(BOTH 'y' FROM s) FROM t1;
SELECT * FROM v1;
DROP VIEW v1;

SELECT TRIM(LEADING 'y' FROM s) FROM t1;
CREATE VIEW v1 AS SELECT TRIM(LEADING 'y' FROM s) FROM t1;
SELECT * FROM v1;
DROP VIEW v1;

SELECT TRIM(TRAILING 'y' FROM s) FROM t1;
CREATE VIEW v1 AS SELECT TRIM(TRAILING 'y' FROM s) FROM t1;
SELECT * FROM v1;
DROP VIEW v1;

DROP TABLE t1;


--
-- Bug#21080 ALTER VIEW makes user restate SQL SECURITY mode, and ALGORITHM
--
CREATE TABLE t1 (x INT, y INT);
CREATE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW v1 AS SELECT x FROM t1;

ALTER VIEW v1 AS SELECT x, y FROM t1;

DROP VIEW v1;
DROP TABLE t1;


-- Bug#21086 server crashes when VIEW defined with a SELECT with COLLATE
--           clause is called
--
CREATE TABLE t1 (s1 char) charset latin1;
INSERT INTO t1 VALUES ('Z');

CREATE VIEW v1 AS SELECT s1 collate latin1_german1_ci AS col FROM t1;

CREATE VIEW v2 (col) AS SELECT s1 collate latin1_german1_ci FROM t1;

-- either of these statements will cause crash
INSERT INTO v1 (col) VALUES ('b');
INSERT INTO v2 (col) VALUES ('c');

SELECT s1 FROM t1;
DROP VIEW v1, v2;
DROP TABLE t1;


--
-- Bug#11551 Asymmetric + undocumented behaviour of DROP VIEW and DROP TABLE
--
CREATE TABLE t1 (id INT);
CREATE VIEW v1 AS SELECT id FROM t1;
DROP VIEW v2,v1;
DROP VIEW t1,v1;

DROP TABLE t1;
DROP VIEW IF EXISTS v1;


--
-- Bug#21261 Wrong access rights was required for an insert to a view
--
CREATE DATABASE bug21261DB;
USE bug21261DB;

CREATE TABLE t1 (x INT);
CREATE SQL SECURITY INVOKER VIEW v1 AS SELECT x FROM t1;
CREATE USER 'user21261'@'localhost';
CREATE TABLE t2 (y INT);
INSERT INTO v1 (x) VALUES (5);
UPDATE v1 SET x=1;
UPDATE v1,t2 SET x=1 WHERE x=y;
SELECT * FROM t1;
DROP USER 'user21261'@'localhost';
DROP VIEW v1;
DROP TABLE t1;
DROP DATABASE bug21261DB;
USE test;


--
-- Bug#15950 NOW() optimized away in VIEWs
--
create table t1 (f1 datetime);
create view v1 as select * from t1 where f1 between now() and now() + interval 1 minute;
drop view v1;
drop table t1;


--
-- Test for Bug#16899 Possible buffer overflow in handling of DEFINER-clause.
--

-- Prepare.

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP VIEW IF EXISTS v2;

CREATE TABLE t1(a INT, b INT);
CREATE DEFINER=1234567890abcdefGHIKL1234567890abcdefGHIKL@localhost
  VIEW v1 AS SELECT a FROM t1;
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X
  VIEW v2 AS SELECT b FROM t1;

-- Cleanup.

DROP TABLE t1;


--
-- Bug#17591 Updatable view not possible with trigger or stored function
--
-- During prelocking phase we didn't update lock type of view tables,
-- hence READ lock was always requested.
--
--disable_warnings
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP VIEW IF EXISTS v1, v2;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT);

CREATE VIEW v1 AS SELECT * FROM t1;
CREATE FUNCTION f1() RETURNS INT
BEGIN
  INSERT INTO v1 VALUES (0);
END |
delimiter ;

SELECT f1();

CREATE ALGORITHM=TEMPTABLE VIEW v2 AS SELECT * FROM t1;
CREATE FUNCTION f2() RETURNS INT
BEGIN
  INSERT INTO v2 VALUES (0);
END |
delimiter ;
SELECT f2();

DROP FUNCTION f1;
DROP FUNCTION f2;
DROP VIEW v1, v2;
DROP TABLE t1;


--
-- Bug#5500 wrong select_type in EXPLAIN output for queries over views
--

CREATE TABLE t1 (s1 int);
CREATE VIEW v1 AS SELECT * FROM t1;

INSERT INTO t1 VALUES (1), (3), (2);

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#5505 Wrong error message on INSERT into a view
--
create table t1 (s1 int);
create view v1 as select s1 as a, s1 as b from t1;
insert into v1 values (1,1);
update v1 set a = 5;
drop view v1;
drop table t1;


--
-- Bug#21646 view qith a subquery in ON expression
--

CREATE TABLE t1(pk int PRIMARY KEY);
CREATE TABLE t2(pk int PRIMARY KEY, fk int, ver int, org int);

CREATE ALGORITHM=MERGE VIEW v1 AS
SELECT t1.*
  FROM t1 JOIN t2
       ON t2.fk = t1.pk AND
          t2.ver = (SELECT MAX(t.ver) FROM t2 t WHERE t.org = t2.org);

DROP VIEW v1;
DROP TABLE t1, t2;


--
-- Bug#19111 TRIGGERs selecting from a VIEW on the firing base table fail
--
-- Allow to select from a view on a table being modified in a trigger
-- and stored function, since plain select is allowed there.
--
--disable_warnings
DROP FUNCTION IF EXISTS f1;
DROP VIEW IF EXISTS v1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);

CREATE VIEW v1 AS SELECT MAX(i) FROM t1;

-- Plain 'SET NEW.i = (SELECT MAX(i) FROM t1) + 1' works, so select
-- from a view should work too.
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  SET NEW.i = (SELECT * FROM v1) + 1;
INSERT INTO t1 VALUES (1);

-- Plain 'RETURN (SELECT MAX(i) FROM t1)' works in INSERT, so select
-- from a view should work too.
CREATE FUNCTION f1() RETURNS INT RETURN (SELECT * FROM v1);
UPDATE t1 SET i= f1();

DROP FUNCTION f1;
DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#16813 (WITH CHECK OPTION doesn't work with UPDATE)
--
CREATE TABLE t1(id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, val INT UNSIGNED NOT NULL);
CREATE VIEW v1 AS SELECT id, val FROM t1 WHERE val >= 1 AND val <= 5 WITH CHECK OPTION;
INSERT INTO v1 (val) VALUES (2);
INSERT INTO v1 (val) VALUES (4);
INSERT INTO v1 (val) VALUES (6);
UPDATE v1 SET val=6 WHERE id=2;
DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#22584 last_insert_id not updated after inserting a record
-- through a updatable view
--
-- We still do not update LAST_INSERT_ID if AUTO_INCREMENT column is
-- not accessible through a view.  However, we do not reset the value
-- of LAST_INSERT_ID, but keep it unchanged.
--
--disable_warnings
DROP VIEW IF EXISTS v1, v2;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT AUTO_INCREMENT PRIMARY KEY, j INT);
CREATE VIEW v1 AS SELECT j FROM t1;
CREATE VIEW v2 AS SELECT * FROM t1;

INSERT INTO t1 (j) VALUES (1);
SELECT LAST_INSERT_ID();

INSERT INTO v1 (j) VALUES (2);
SELECT LAST_INSERT_ID();

INSERT INTO v2 (j) VALUES (3);
SELECT LAST_INSERT_ID();

INSERT INTO v1 (j) SELECT j FROM t1;
SELECT LAST_INSERT_ID();

SELECT * FROM t1;

DROP VIEW v1, v2;
DROP TABLE t1;


--
-- Bug#25580 !0 as an operand in a select expression of a view
--

CREATE VIEW v AS SELECT !0 * 5 AS x FROM DUAL;

SELECT !0 * 5 AS x FROM DUAL;
SELECT * FROM v;

DROP VIEW v;


--
-- Bug#24293 '\Z' token is not handled correctly in views
--

--disable_warnings
DROP VIEW IF EXISTS v1;

CREATE VIEW v1 AS SELECT 'The\ZEnd';
SELECT * FROM v1;

DROP VIEW v1;


--
-- Bug#26124 BETWEEN over a view column of the DATETIME type
--

CREATE TABLE t1 (mydate DATETIME);
INSERT INTO t1 VALUES
  ('2007-01-01'), ('2007-01-02'), ('2007-01-30'), ('2007-01-31');

CREATE VIEW v1 AS SELECT mydate from t1;

SELECT * FROM t1 WHERE mydate BETWEEN '2007-01-01' AND '2007-01-31';
SELECT * FROM v1 WHERE mydate BETWEEN '2007-01-01' AND '2007-01-31';

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#25931 update of a multi-table view with check option
--

CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1), (2);

CREATE VIEW v1 AS
  SELECT t2.b FROM t1,t2 WHERE t1.a = t2.b WITH CHECK OPTION;

SELECT * FROM v1;
UPDATE v1 SET b=3;
SELECT * FROM v1;
SELECT * FROM t1;
SELECT * FROM t2;

DROP VIEW v1;
DROP TABLE t1,t2;


--
-- Bug#12122 Views with ORDER BY can't be resolved using MERGE algorithm.
--
create table t1(f1 int, f2 int);
insert into t1 values(1,2),(1,3),(1,1),(2,3),(2,1),(2,2);
select * from t1;
create view v1 as select * from t1 order by f2;
select * from v1;
select * from v1 order by f1;
drop view v1;
drop table t1;

--
-- Bug#26209 queries with GROUP BY and ORDER BY using views
--

CREATE TABLE t1 (
  id int(11) NOT NULL PRIMARY KEY,
  country varchar(32),
  code int(11) default NULL
);
INSERT INTO t1 VALUES
  (1,'ITALY',100),(2,'ITALY',200),(3,'FRANCE',100), (4,'ITALY',100);

CREATE VIEW v1 AS SELECT * FROM t1;

SELECT code, COUNT(DISTINCT country) FROM t1 GROUP BY code ORDER BY MAX(id);
SELECT code, COUNT(DISTINCT country) FROM v1 GROUP BY code ORDER BY MAX(id);

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#25897 Some queries are no longer possible after a CREATE VIEW fails
--
--disable_warnings
DROP VIEW IF EXISTS v1;

let $query = SELECT * FROM (SELECT 1) AS t;
DROP VIEW v1;


--
-- Bug#24532 The return data type of IS TRUE is different from similar operations
--

--disable_warnings
drop view if exists view_24532_a;
drop view if exists view_24532_b;
drop table if exists table_24532;

create table table_24532 (
  a int,
  b bigint,
  c int(4),
  d bigint(48)
);

create view view_24532_a as
select
  a IS TRUE,
  a IS NOT TRUE,
  a IS FALSE,
  a IS NOT FALSE,
  a IS UNKNOWN,
  a IS NOT UNKNOWN,
  a is NULL,
  a IS NOT NULL,
  ISNULL(a),
  b IS TRUE,
  b IS NOT TRUE,
  b IS FALSE,
  b IS NOT FALSE,
  b IS UNKNOWN,
  b IS NOT UNKNOWN,
  b is NULL,
  b IS NOT NULL,
  ISNULL(b),
  c IS TRUE,
  c IS NOT TRUE,
  c IS FALSE,
  c IS NOT FALSE,
  c IS UNKNOWN,
  c IS NOT UNKNOWN,
  c is NULL,
  c IS NOT NULL,
  ISNULL(c),
  d IS TRUE,
  d IS NOT TRUE,
  d IS FALSE,
  d IS NOT FALSE,
  d IS UNKNOWN,
  d IS NOT UNKNOWN,
  d is NULL,
  d IS NOT NULL,
  ISNULL(d)
from table_24532;

create view view_24532_b as
select
  a IS TRUE,
  if(ifnull(a, 0), 1, 0) as old_istrue,
  a IS NOT TRUE,
  if(ifnull(a, 0), 0, 1) as old_isnottrue,
  a IS FALSE,
  if(ifnull(a, 1), 0, 1) as old_isfalse,
  a IS NOT FALSE,
  if(ifnull(a, 1), 1, 0) as old_isnotfalse
from table_24532;

insert into table_24532 values (0, 0, 0, 0);
select * from view_24532_b;
update table_24532 set a=1;
select * from view_24532_b;
update table_24532 set a=NULL;
select * from view_24532_b;

drop view view_24532_a;
drop view view_24532_b;
drop table table_24532;


--
-- Bug#26560 view using subquery with a reference to an outer alias
--

CREATE TABLE t1 (
  lid int NOT NULL PRIMARY KEY,
  name char(10) NOT NULL
);
INSERT INTO t1 (lid, name) VALUES
  (1, 'YES'), (2, 'NO');

CREATE TABLE t2 (
  id int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  lid int NOT NULL,
  dt date
);
CREATE TABLE t3 (
  id int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  lid int NOT NULL,
  dt date
);

INSERT INTO t2 (id, gid, lid, dt) VALUES
 (1, 1, 1, '2007-01-01'),(2, 1, 2, '2007-01-02'),
 (3, 2, 2, '2007-02-01'),(4, 2, 1, '2007-02-02');
INSERT INTO t3 (id, gid, lid, dt) VALUES
 (1, 1, 1, '2007-01-01'),(2, 1, 2, '2007-01-02'),
 (3, 2, 2, '2007-02-01'),(4, 2, 1, '2007-02-02');

SELECT DISTINCT t2.gid AS lgid,
                (SELECT t1.name FROM t1, t3
                   WHERE t1.lid  = t3.lid AND t3.gid = t2.gid
                     ORDER BY t3.dt DESC LIMIT 1
                ) as clid
  FROM t2;

CREATE VIEW v1 AS
SELECT DISTINCT t2.gid AS lgid,
                (SELECT t1.name FROM t1, t3
                   WHERE t1.lid  = t3.lid AND t3.gid = t2.gid
                   ORDER BY t3.dt DESC LIMIT 1
                ) as clid
  FROM t2;
SELECT * FROM v1;

DROP VIEW v1;
DROP table t1,t2,t3;


--
-- Bug#27786 Inconsistent Operation Performing UNION On View With ORDER BY
--
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT a FROM t1 ORDER BY a;

SELECT * FROM t1 UNION SELECT * FROM v1;
SELECT * FROM v1 UNION SELECT * FROM t1;
SELECT * FROM t1 UNION SELECT * FROM v1 ORDER BY a;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#27921 View ignores precision for CAST()
--
CREATE VIEW v1 AS SELECT CAST( 1.23456789 AS DECIMAL( 7,5 ) ) AS col;
SELECT * FROM v1;
DROP VIEW v1;

CREATE VIEW v1 AS SELECT CAST(1.23456789 AS DECIMAL(8,0)) AS col;
DROP VIEW v1;


--
-- Bug#28716 CHECK OPTION expression is evaluated over expired record buffers
--           when VIEW is updated via temporary tables
--
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (b INT, c INT DEFAULT 0);
INSERT INTO t1 (a) VALUES (1), (2);
INSERT INTO t2 (b) VALUES (1), (2);
CREATE VIEW v1 AS SELECT t2.b,t2.c FROM t1, t2
  WHERE t1.a=t2.b AND t2.b < 3 WITH CHECK OPTION;
SELECT * FROM v1;
UPDATE v1 SET c=1 WHERE b=1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1,t2;


--
-- Bug#28561 update on multi-table view with CHECK OPTION and a subquery
--           in WHERE condition
--

CREATE TABLE t1 (id int);
CREATE TABLE t2 (id int, c int DEFAULT 0);
INSERT INTO t1 (id) VALUES (1);
INSERT INTO t2 (id) VALUES (1);

CREATE VIEW v1 AS
  SELECT t2.c FROM t1, t2
    WHERE t1.id=t2.id AND 1 IN (SELECT id FROM t1) WITH CHECK OPTION;

UPDATE v1 SET c=1;

DROP VIEW v1;
DROP TABLE t1,t2;


--
-- Bug#27827 CHECK OPTION ignores ON conditions when updating
--           a multi-table view with CHECK OPTION.
--

CREATE TABLE t1 (a1 INT, c INT DEFAULT 0);
CREATE TABLE t2 (a2 INT);
CREATE TABLE t3 (a3 INT);
CREATE TABLE t4 (a4 INT);
INSERT INTO t1 (a1) VALUES (1),(2);
INSERT INTO t2 (a2) VALUES (1),(2);
INSERT INTO t3 (a3) VALUES (1),(2);
INSERT INTO t4 (a4) VALUES (1),(2);

CREATE VIEW v1 AS
  SELECT t1.a1, t1.c FROM t1 JOIN t2 ON t1.a1=t2.a2 AND t1.c < 3
    WITH CHECK OPTION;
SELECT * FROM v1;
UPDATE v1 SET c=3;
INSERT INTO v1(a1, c) VALUES (3, 3);
UPDATE v1 SET c=1 WHERE a1=1;
SELECT * FROM v1;
SELECT * FROM t1;

CREATE VIEW v2 AS SELECT t1.a1, t1.c
  FROM (t1 JOIN t2 ON t1.a1=t2.a2 AND t1.c < 3)
  JOIN (t3 JOIN t4 ON t3.a3=t4.a4)
    ON t2.a2=t3.a3 WITH CHECK OPTION;
SELECT * FROM v2;
UPDATE v2 SET c=3;
INSERT INTO v2(a1, c) VALUES (3, 3);
UPDATE v2 SET c=2 WHERE a1=1;
SELECT * FROM v2;
SELECT * FROM t1;

DROP VIEW v1,v2;
DROP TABLE t1,t2,t3,t4;


--
-- Bug#29104 assertion abort for a query with a view column reference
--           in the GROUP BY list and a condition requiring the value
--           of another view column to be equal to a constant
--

CREATE TABLE t1 (a int, b int);
INSERT INTO t1 VALUES (1,2), (2,2), (1,3), (1,2);

CREATE VIEW v1 AS SELECT a, b+1 as b FROM t1;


SELECT b, SUM(a) FROM v1 WHERE b=3 GROUP BY b;

SELECT a, SUM(b) FROM v1 WHERE b=3 GROUP BY a;

SELECT a, SUM(b) FROM v1 WHERE a=1 GROUP BY a;

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#29392 SELECT over a multi-table view with ORDER BY
--           selecting the same view column with two different aliases
--

CREATE TABLE t1 (
  person_id int NOT NULL PRIMARY KEY,
  username varchar(40) default NULL,
  status_flg char(1) NOT NULL default 'A'
);

CREATE TABLE t2 (
  person_role_id int NOT NULL auto_increment PRIMARY KEY,
  role_id int NOT NULL,
  person_id int NOT NULL,
  INDEX idx_person_id (person_id),
  INDEX idx_role_id (role_id)
);

CREATE TABLE t3 (
  role_id int NOT NULL auto_increment PRIMARY KEY,
  role_name varchar(100) default NULL,
  app_name varchar(40) NOT NULL,
  INDEX idx_app_name(app_name)
);

CREATE VIEW v1 AS
SELECT profile.person_id AS person_id
  FROM t1 profile, t2 userrole, t3 `role`
    WHERE userrole.person_id = profile.person_id AND
          role.role_id = userrole.role_id AND
          profile.status_flg = 'A'
  ORDER BY profile.person_id,role.app_name,role.role_name;

INSERT INTO  t1 VALUES
 (6,'Sw','A'), (-1136332546,'ols','e'), (0,'    *\n','0'),
 (-717462680,'ENTS Ta','0'), (-904346964,'ndard SQL\n','0');
INSERT INTO t2 VALUES
  (1,3,6),(2,4,7),(3,5,8),(4,6,9),(5,1,6),(6,1,7),(7,1,8),(8,1,9),(9,1,10);

INSERT INTO t3 VALUES
  (1,'NUCANS_APP_USER','NUCANSAPP'),(2,'NUCANS_TRGAPP_USER','NUCANSAPP'),
  (3,'IA_INTAKE_COORDINATOR','IACANS'),(4,'IA_SCREENER','IACANS'),
  (5,'IA_SUPERVISOR','IACANS'),(6,'IA_READONLY','IACANS'),
  (7,'SOC_USER','SOCCANS'),(8,'CAYIT_USER','CAYITCANS'),
  (9,'RTOS_DCFSPOS_SUPERVISOR','RTOS');
SELECT t.person_id AS a, t.person_id AS b FROM v1 t WHERE t.person_id=6;

DROP VIEW v1;
DROP TABLE t1,t2,t3;


--
-- Bug#30020 Insufficient check led to a wrong info provided by the
--           information schema table.
--
create table t1 (i int);
insert into t1 values (1), (2), (1), (3), (2), (4);
create view v1 as select distinct i from t1;
select * from v1;
select table_name, is_updatable from information_schema.views
   where table_name = 'v1';
drop view v1;
drop table t1;


--
-- Bug#28701 SELECTs from VIEWs completely ignore USE/FORCE KEY, allowing
--           invalid statements
--

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT * FROM v1 USE KEY(non_existant);
SELECT * FROM v1 FORCE KEY(non_existant);
SELECT * FROM v1 IGNORE KEY(non_existant);

DROP VIEW v1;
DROP TABLE t1;


--
-- Bug#28702 VIEWs defined with USE/FORCE KEY ignore that request
--
CREATE TABLE t1 (a INT NOT NULL AUTO_INCREMENT, b INT NOT NULL DEFAULT 0,
                 PRIMARY KEY(a), KEY (b));
INSERT INTO t1 VALUES (),(),(),(),(),(),(),(),(),(),(),(),(),(),();
CREATE VIEW v1 AS SELECT * FROM t1 FORCE KEY (PRIMARY,b) ORDER BY a;
CREATE VIEW v2 AS SELECT * FROM t1 USE KEY () ORDER BY a;
CREATE VIEW v3 AS SELECT * FROM t1 IGNORE KEY (b) ORDER BY a;

DROP VIEW v1;
DROP VIEW v2;
DROP VIEW v3;
DROP TABLE t1;
create table t1(f1 int, f2 int not null);
create view v1 as select f1 from t1;
insert into v1 values(1);
set @old_mode=@@sql_mode;
set @@sql_mode=traditional;
insert into v1 values(1);
set @@sql_mode=@old_mode;
drop view v1;
drop table t1;


--
-- Bug#33389 Selecting from a view into a table from within SP or trigger
--           crashes server
--

create table t1 (a int, key(a));
create table t2 (c int);

create view v1 as select a b from t1;
create view v2 as select 1 a from t2, v1 where c in
                  (select 1 from t1 where b = a);

insert into t1 values (1), (1);
insert into t2 values (1), (1);

drop view v1, v2;
drop table t1, t2;


--
-- Bug#33049 Assert while running test-as3ap test(mysql-bench suite)
--

CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT p.a AS a FROM t1 p, t1 q;

INSERT INTO t1 VALUES (1), (1);
SELECT MAX(a), COUNT(DISTINCT a) FROM v1 GROUP BY a;

DROP VIEW v1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(c1 INT);

SELECT * FROM t1;
ALTER ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW t1 (c2) AS SELECT (1);

DROP TABLE t1;

CREATE VIEW v1 AS SELECT 1 FROM DUAL WHERE 1;

SELECT * FROM v1;

DROP VIEW v1;

--
-- Bug#39040 valgrind errors/crash when creating views with binlog logging
--           enabled
--
-- Bug is visible only when running in valgrind with binary logging.
CREATE VIEW v1 AS SELECT 1;
DROP VIEW v1;


--
-- Bug#33461 SELECT ... FROM <view> USE INDEX (...) throws an error
--

CREATE TABLE t1 (c1 INT PRIMARY KEY, c2 INT, INDEX (c2));
INSERT INTO t1 VALUES (1,1), (2,2), (3,3);
SELECT * FROM t1 USE INDEX (PRIMARY) WHERE c1=2;
SELECT * FROM t1 USE INDEX (c2) WHERE c2=2;

CREATE VIEW v1 AS SELECT c1, c2 FROM t1;
SELECT * FROM v1 USE INDEX (PRIMARY) WHERE c1=2;
SELECT * FROM v1 FORCE INDEX (PRIMARY) WHERE c1=2;
SELECT * FROM v1 IGNORE INDEX (PRIMARY) WHERE c1=2;
SELECT * FROM v1 USE INDEX (c2) WHERE c2=2;
SELECT * FROM v1 FORCE INDEX (c2) WHERE c2=2;
SELECT * FROM v1 IGNORE INDEX (c2) WHERE c2=2;

DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1(a INT UNIQUE);
CREATE VIEW v1 AS SELECT t1.a FROM t1, t1 AS a;
INSERT INTO t1 VALUES (1), (2);
SELECT * FROM v1;
SELECT * FROM v1;
DELETE FROM t1 WHERE a=3;
INSERT INTO v1(a) SELECT 1 FROM t1,t1 AS c
ON DUPLICATE KEY UPDATE `v1`.`a`= 1;
SELECT * FROM v1;

CREATE VIEW v2 AS SELECT t1.a FROM t1, v1 AS a;
SELECT * FROM v2;
SELECT * FROM v2;
INSERT INTO v2(a) SELECT 1 FROM t1,t1 AS c
ON DUPLICATE KEY UPDATE `v2`.`a`= 1;
SELECT * FROM v2;

DROP VIEW v1;
DROP VIEW v2;
DROP TABLE t1;

CREATE TABLE t1 (c INT);

CREATE VIEW v1 (view_column) AS SELECT c AS alias FROM t1 HAVING alias;
SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;

--
-- Bug#21370 View renaming lacks tablename_to_filename encoding
--
--disable_warnings
DROP DATABASE IF EXISTS `d-1`;
CREATE DATABASE `d-1`;
USE `d-1`;
CREATE TABLE `t-1` (c1 INT);
CREATE VIEW  `v-1` AS SELECT c1 FROM `t-1`;
DROP TABLE `t-2`;
DROP VIEW  `v-2`;
DROP DATABASE `d-1`;
USE test;
DROP VIEW IF EXISTS v1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(c1 INT, c2 INT);
INSERT INTO t1 VALUES (1, 2), (3, 4);

SELECT * FROM t1;

CREATE VIEW v1 AS SELECT * FROM t1;

SELECT * FROM v1;

ALTER TABLE t1 ADD COLUMN c3 INT AFTER c2;

SELECT * FROM t1;

SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;
DROP VIEW IF EXISTS v1;

SET collation_connection = latin1_general_ci;
CREATE VIEW v1 AS SELECT _latin1 'text1' AS c1, 'text2' AS c2;

SELECT COLLATION(c1), COLLATION(c2) FROM v1;
SELECT * FROM v1 WHERE c1 = 'text1';

SELECT * FROM v1 WHERE c2 = 'text2';

use test;
SET names latin1;

SELECT COLLATION(c1), COLLATION(c2) FROM v1;

SELECT * FROM v1 WHERE c1 = 'text1';
SELECT * FROM v1 WHERE c2 = 'text2';

DROP VIEW v1;
SET NAMES DEFAULT;

--
-- Bug#34587 Creating a view inside a stored procedure leads to a server crash
--

--disable_warnings
drop view if exists a;
drop procedure if exists p;
create procedure p()
begin
  declare continue handler for sqlexception begin end;
  create view a as select 1;
drop view a;
drop procedure p;
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT a FROM t1;
ALTER TABLE v1;
DROP VIEW v1;
DROP TABLE t1;

--
-- Bug#48294 assertion when creating a view based on some row() construct in select query
--
CREATE TABLE t1(f1 INT);
INSERT INTO t1 VALUES ();

CREATE VIEW v1 AS SELECT 1 FROM t1 WHERE
ROW(1,1) >= ROW(1, (SELECT 1 FROM t1 WHERE  f1 >= ANY ( SELECT '1' )));

DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a CHAR(1) CHARSET latin1, b CHAR(1) CHARSET utf8mb3);
CREATE VIEW v1 AS SELECT 1 from t1
WHERE t1.b <=> (SELECT a FROM t1 WHERE a < SOME(SELECT '1'));
DROP VIEW v1;
DROP TABLE t1;

CREATE TABLE t1(a int);
CREATE VIEW v1 AS SELECT 1 FROM t1 GROUP BY
SUBSTRING(1 FROM (SELECT 3 FROM t1 WHERE a >= ANY(SELECT 1)));
DROP VIEW v1;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT 1 IN (1 LIKE 2,0) AS f;
DROP VIEW v1;

CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT s.* FROM t1 s, t1 b HAVING a;

SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;

--
-- Bug#9801 (Views: imperfect error message)
--

--disable_warnings
drop table if exists t_9801;
drop view if exists v_9801;

create table t_9801 (s1 int);
create view v_9801 as
  select sum(s1) from t_9801 with check option;
create view v_9801 as
  select sum(s1) from t_9801 group by s1 with check option;
create view v_9801 as
  select sum(s1) from t_9801 group by s1 with rollup with check option;

drop table t_9801;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;

CREATE TEMPORARY TABLE t1 (id INT);
ALTER VIEW t1 AS SELECT 1 AS f1;
DROP TABLE t1;

CREATE VIEW v1 AS SELECT 1 AS f1;
CREATE TEMPORARY TABLE v1 (id INT);
ALTER VIEW v1 AS SELECT 2 AS f1;
DROP TABLE v1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE IF EXISTS t1, t2;
DROP VIEW IF EXISTS t2;

CREATE TABLE t1 (f1 integer);
CREATE TEMPORARY TABLE IF NOT EXISTS t1 (f1 integer);
CREATE TEMPORARY TABLE t2 (f1 integer);
DROP TABLE t1;
CREATE VIEW t2 AS SELECT * FROM t1;
DROP TABLE t1, t2;
DROP VIEW IF EXISTS v1;
DROP PROCEDURE IF EXISTS p1;

CREATE VIEW v1 AS SELECT schema_name FROM information_schema.schemata;
CREATE PROCEDURE p1() SELECT COUNT(*), GET_LOCK('blocker', 100) FROM v1;
SELECT RELEASE_LOCK('blocker');
SELECT GET_LOCK('blocker', 100);
let $wait_condition=
  SELECT COUNT(*) = 1 from information_schema.processlist
  WHERE state = "User lock" AND
        info = "SELECT COUNT(*), GET_LOCK('blocker', 100) FROM v1";
let $wait_condition=
  SELECT COUNT(*) = 1 from information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND info = "DROP VIEW v1";
SELECT RELEASE_LOCK('blocker');
SELECT RELEASE_LOCK('blocker');
DROP PROCEDURE p1;

CREATE TABLE t1 (a INT);
CREATE FUNCTION f1 () RETURNS INTEGER RETURN 1;
CREATE FUNCTION f2 (i INTEGER) RETURNS INTEGER RETURN 1;
CREATE VIEW v1 AS SELECT f1() AS a FROM t1;
CREATE VIEW v2 AS SELECT f2(a) AS a FROM v1;
DROP FUNCTION f1;
SELECT f2(a) FROM v2;
DROP VIEW v2;
DROP VIEW v1;
DROP FUNCTION f2;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TEMPORARY TABLE t1 (a INT) engine=InnoDB;
CREATE VIEW t1 AS SELECT 1;

DROP VIEW t1;
DROP TEMPORARY TABLE t1;
DROP DATABASE IF EXISTS nodb;
CREATE VIEW nodb.a AS SELECT 1;

CREATE TABLE t1 (
  pk        INT AUTO_INCREMENT,
  c_int_key INT,
  PRIMARY KEY (pk),
  KEY (c_int_key)
) 
ENGINE=innodb;

CREATE VIEW v_t1 AS SELECT * FROM t1;

CREATE TABLE t2 (
  pk              INT auto_increment,
  c_varchar_600_x VARCHAR(600),
  c_int_key       INT,
  c_varchar_600_y VARCHAR(600),
  c_varchar_600_z VARCHAR(600),
  PRIMARY KEY (pk),
  KEY (c_int_key)
) 
ENGINE=innodb;

CREATE VIEW v_t2 AS SELECT * FROM t2;
INSERT INTO t2 VALUES
(
  NULL,
  repeat('x', 600),
  3,
  repeat('y', 600),
  repeat('z', 600)
);

SELECT a1.pk AS f1
FROM v_t1 AS a1 LEFT JOIN v_t2 AS a2 ON a1.pk=a2.c_int_key
WHERE 
  a1.pk > 8
  OR ((a1.pk BETWEEN 9 AND 13) AND a1.pk = 90)
ORDER BY f1 ;

DROP TABLE t1, t2;
DROP VIEW v_t1, v_t2;

CREATE TABLE t1 (
  pk INTEGER,
  PRIMARY KEY (pk)
);

INSERT INTO t1 VALUES (1), (2);

CREATE VIEW v_t1 AS SELECT * FROM t1;

-- Query directly against the table (correct result)
SELECT pk
FROM t1
WHERE
  pk > 8
  OR ((pk BETWEEN 9 AND 13) AND pk = 90)
;

-- Query against a view (wrong result)
SELECT pk
FROM v_t1
WHERE
  pk > 8
  OR ((pk BETWEEN 9 AND 13) AND pk = 90)
;

DROP VIEW v_t1;
DROP TABLE t1;

CREATE TABLE t1(a INTEGER, b INTEGER);
CREATE TABLE t2(a INTEGER, b INTEGER);

INSERT INTO t1 VALUES(1, 10), (2, 20);
INSERT INTO t2 VALUES(1, 100), (2, 200);

CREATE VIEW v2 AS SELECT * FROM t2;
CREATE VIEW v2_sj AS SELECT * FROM t2
                     WHERE a IN (SELECT a FROM t1);
CREATE VIEW v12_1 AS SELECT t2.a, t2.b FROM t1 JOIN t2 USING (a);
CREATE VIEW v12_2 AS SELECT t1.a, t2.b FROM t1 JOIN t2 USING (a);
CREATE VIEW v12_3 AS SELECT t2.a, t2.b FROM t1 JOIN t2 USING (a)
                     WHERE t1.b > 15;
CREATE VIEW vu_1 AS SELECT * FROM t2 UNION SELECT * FROM t2;
CREATE VIEW vu_2 AS SELECT * FROM t2 UNION ALL SELECT * FROM t2;
CREATE VIEW vd_1 AS SELECT DISTINCT a, b FROM t2;
CREATE VIEW va_1 AS SELECT SUM(a) AS a, SUM(b) AS b FROM t2;
CREATE VIEW vg_1 AS SELECT a, SUM(b) AS b FROM t2 GROUP BY a;
CREATE VIEW vh_1 AS SELECT 1 AS a FROM t2 HAVING COUNT(*) > 1;
CREATE VIEW vl_1 AS SELECT * FROM t2 LIMIT 1;
CREATE VIEW vlo_1 AS SELECT * FROM t2 LIMIT 2 OFFSET 1;
CREATE VIEW vrow AS SELECT 1 AS a;
CREATE VIEW vo_1 AS SELECT * FROM t2 ORDER BY a;
CREATE VIEW vo_2 AS SELECT * FROM t2 ORDER BY a DESC;
CREATE VIEW vx AS SELECT a, (SELECT b) AS b FROM t2;

-- Check allowed merge scenarios

-- Allowed: Simple selection, joins, WHERE clause

ANALYZE TABLE t1,t2;

let $query=
SELECT *
FROM t1 JOIN v2 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1, v2 AS dt WHERE t1.a=dt.a;

let $query=
SELECT *
FROM (t1 JOIN t2 ON t1.a=t2.a) JOIN v2 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN v12_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM (t1 JOIN t2 USING (a))
     JOIN v12_1 AS dt
     ON t1.a=dt.a;

let $query=
SELECT *
FROM (t1 JOIN t2 USING (a))
     JOIN v12_2 AS dt1
     ON t1.a=dt1.a AND t2.b=dt1.b
     JOIN v12_1 AS dt2
     ON dt1.a=dt2.a;

let $query=
SELECT *
FROM t1 JOIN v12_3 AS dt ON t1.a=dt.a;

-- Allowed: Subqueries in WHERE clause

let $query=
SELECT *
FROM t1 JOIN v2_sj AS dt ON t1.a=dt.a;

-- Disallowed: UNION, aggregated queries, LIMIT, OFFSET, table-less, variables:

let $query=
SELECT *
FROM t1 JOIN vu_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vu_2 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vd_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN va_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vg_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vh_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vl_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vlo_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vrow AS dt ON t1.a=dt.a;

-- Allowed: ORDER BY list

-- Simple outer query: ORDER BY is propagated to outer level

let $query=
SELECT *
FROM vo_1 AS dt;

let $query=
SELECT *
FROM vo_2 AS dt;

let $query=
SELECT *
FROM vo_1 AS dt
WHERE dt.a > 0;

let $query=
SELECT *
FROM vo_2 AS dt
WHERE dt.a > 0;

-- Joined outer query: Inner ORDER BY is discarded

let $query=
SELECT *
FROM t1 JOIN vo_1 AS dt ON t1.a=dt.a;

let $query=
SELECT *
FROM t1 JOIN vo_2 AS dt ON t1.a=dt.a;

-- Grouped outer query: Inner ORDER BY is discarded

let $query=
SELECT dt.a, COUNT(*)
FROM vo_1 AS dt
GROUP BY dt.a;

let $query=
SELECT dt.a, COUNT(*)
FROM vo_2 AS dt
GROUP BY dt.a;

let $query=
SELECT COUNT(*)
FROM vo_1 AS dt;

let $query=
SELECT COUNT(*)
FROM vo_2 AS dt;

let $query=
SELECT DISTINCT *
FROM vo_1 AS dt;

let $query=
SELECT DISTINCT *
FROM vo_2 AS dt;

-- Ordered outer query: Inner ORDER BY is discarded

let $query=
SELECT *
FROM t1 JOIN vo_1 AS dt ON t1.a=dt.a
ORDER BY t1.b;

let $query=
SELECT *
FROM t1 JOIN vo_2 AS dt ON t1.a=dt.a
ORDER BY t1.b;

-- Disallowed: Subquery in SELECT list:

let $query=
SELECT *
FROM t1 JOIN vx AS dt ON t1.a=dt.a;

-- Enable and disable derived table merging:

SET @optimizer_switch_saved= @@optimizer_switch;
SET @@optimizer_switch="derived_merge=off";

let $query=
SELECT *
FROM (t1 JOIN t2 USING (a))
     JOIN v12_1 AS dt
     ON t1.a=dt.a;

SET @@optimizer_switch="derived_merge=on";

SET @@optimizer_switch= @optimizer_switch_saved;

DROP VIEW v2, v2_sj, v12_1, v12_2, v12_3;
DROP VIEW vu_1, vu_2, vd_1, va_1, vg_1, vh_1, vl_1;
DROP VIEW vlo_1, vrow, vo_1, vo_2, vx;

DROP TABLE t1, t2;

-- Views with derived tables
-- =========================

CREATE TABLE t1(a INTEGER, b INTEGER);
CREATE TABLE t2(a INTEGER);

INSERT INTO t1 VALUES
 (1, 10),
 (2, 20), (2, 21),
 (3, NULL),
 (4, 40), (4, 41), (4, 42), (4, 43), (4, 44);

INSERT INTO t2 VALUES (1), (2), (3), (4), (5), (NULL);

-- Simple derived table:

let $derived=
(SELECT * FROM t2) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with WHERE clause:

let $derived=
(SELECT * FROM t1 WHERE b=a*10) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with GROUP BY clause:

let $derived=
(SELECT a, SUM(b) AS s, COUNT(*) AS c FROM t1 GROUP BY a ORDER BY a) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with DISTINCT clause:

let $derived=
(SELECT DISTINCT a FROM t1) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with LIMIT and OFFSET:

let $derived=
(SELECT * FROM t1 LIMIT 3 OFFSET 3) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with UNION clause:

let $derived=
(SELECT DISTINCT a FROM t1 UNION ALL SELECT a FROM t2) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with scalar subquery in WHERE clause:

let $derived=
(SELECT * FROM t1 WHERE (SELECT a FROM t1 LIMIT 1) = b/10) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with IN subquery in WHERE clause:

let $derived=
(SELECT * FROM t1 WHERE a IN (SELECT a FROM t2 WHERE a % 2 = 0)) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with scalar subquery in SELECT list:

let $derived=
(SELECT a, (SELECT a FROM t2 WHERE a=t1.a)
 FROM t1 WHERE b IN (SELECT a*10 FROM t2)) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table with scalar subquery, cardinality violation:

let $derived=
(SELECT a, (SELECT a FROM t2) FROM t1 WHERE b=a*10) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1;

let $q=
SELECT * FROM $derived;

DROP VIEW v1;

-- Derived table that is joined:

let $derived=
(SELECT a, b FROM t1 WHERE b IN (SELECT a*10 FROM t2)) AS dt;
SELECT * FROM $derived;

let $qv=
SELECT * FROM v1 JOIN t2 ON v1.a=t2.a;

let $q=
SELECT * FROM $derived JOIN t2 ON dt.a=t2.a;

DROP VIEW v1;

DROP TABLE t1, t2;

-- Views with subqueries in select list
-- ====================================

CREATE TABLE t1(a INTEGER, b INTEGER);
CREATE TABLE t2(a INTEGER);

INSERT INTO t1 VALUES
 (1, 10),
 (2, 20), (2, 21),
 (3, NULL),
 (4, 40), (4, 41), (4, 42), (4, 43), (4, 44);

INSERT INTO t2 VALUES (1), (2), (3), (4), (5), (NULL);

let $qv=
SELECT * FROM v1;

let $qva=
SELECT a FROM v1;

-- Non-correlated scalar subquery:

let $q=
SELECT a, b, (SELECT 1 FROM t2 WHERE a=3) AS s
FROM t1;

DROP VIEW v1;

-- Non-correlated scalar subquery, empty result:

let $q=
SELECT a, b, (SELECT 1 FROM t2 WHERE a=6) AS s
FROM t1;

DROP VIEW v1;

-- Non-correlated scalar subquery, multiple rows:

let $q=
SELECT a, b, (SELECT 1 FROM t2 WHERE a>=3) AS s
FROM t1;

DROP VIEW v1;

-- Non-correlated table subquery:

let $q=
SELECT a, b, a IN (SELECT 1 FROM t2 WHERE a=6) AS s
FROM t1;

DROP VIEW v1;

-- Aggregated scalar subquery:

let $q=
SELECT a, b, (SELECT COUNT(*) FROM t2) AS c
FROM t1;

DROP VIEW v1;

-- Aggregated table subquery:

let $q=
SELECT a, b, a IN (SELECT COUNT(*) FROM t2) AS c
FROM t1;

DROP VIEW v1;

-- Scalar subquery with outer reference:

let $q=
SELECT a, b, (SELECT a*2 FROM t2 WHERE a=t1.a) AS s
FROM t1;

DROP VIEW v1;

-- Table subquery with outer reference:

let $q=
SELECT a, b, EXISTS (SELECT a*2 FROM t2 WHERE a=t1.a) AS s
FROM t1;

DROP VIEW v1;

-- Aggregated scalar subquery with outer reference:

let $q=
SELECT a, b, (SELECT COUNT(*) FROM t1 AS t2 WHERE a=t1.a) AS s
FROM t1;

DROP VIEW v1;

-- Aggregated table subquery with outer reference:

let $q=
SELECT a, b, EXISTS (SELECT COUNT(*) FROM t1 AS t2 WHERE a=t1.a) AS s
FROM t1;

DROP VIEW v1;

-- Outer aggregated query with scalar subquery:

let $q=
SELECT (SELECT a FROM t2 WHERE a=FLOOR(COUNT(t1.a)/2)) AS s
FROM t1;

DROP VIEW v1;

let $q=
SELECT COUNT(*) AS a, (SELECT a FROM t2 WHERE a=FLOOR(COUNT(t1.a)/2)) AS s
FROM t1;

DROP VIEW v1;

-- Outer aggregated query with table subquery:

let $q=
SELECT a IN (SELECT a FROM t2 WHERE a=FLOOR(COUNT(t1.a)/2)) AS s
FROM t1;

DROP VIEW v1;

let $q=
SELECT COUNT(*) AS a, a IN (SELECT a FROM t2 WHERE a=FLOOR(COUNT(t1.a)/2)) AS s
FROM t1;

DROP VIEW v1;

-- Outer grouped query with scalar subquery:

let $q=
SELECT a, COUNT(*) AS c, (SELECT a FROM t2 WHERE a=COUNT(t1.a)) AS s
FROM t1
GROUP BY a;

DROP VIEW v1;

-- Outer grouped query with table subquery:

let $q=
SELECT a, COUNT(*) AS c, a IN (SELECT a FROM t2 WHERE a=COUNT(t1.a)) AS s
FROM t1
GROUP BY a;

DROP VIEW v1;

DROP TABLE t1, t2;

CREATE TABLE t1 (
  pk int NOT NULL,
  col_date_key date DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key)
) ;

CREATE TABLE t2 (
  pk int NOT NULL,
  col_time_key time DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key)
);

CREATE ALGORITHM=MERGE VIEW v1 AS 
SELECT col_date_key
FROM t1 WHERE (pk, pk, col_date_key) IN
       (SELECT col_datetime_key,
               col_time_key,
               col_time_key
        FROM t2
        WHERE pk <= 7);

SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1, t2;

CREATE VIEW v1 AS (SELECT '' FROM DUAL);
CREATE VIEW v2 AS (SELECT 'BUG--14117018' AS col1 FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL);
CREATE VIEW v3 AS (SELECT 'BUG--14117018' AS col1 FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL);
CREATE VIEW v4 AS (SELECT 'BUG--14117018' AS col1 FROM DUAL) UNION ALL
                  (SELECT '' AS col2 FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL);

DROP VIEW v1, v2, v3, v4;

CREATE TABLE t1 (
  pk int NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  PRIMARY KEY (pk)
);

CREATE TABLE t2 (
  pk int NOT NULL,
  col_varchar_key varchar(1) NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk)
);

CREATE TABLE t3 (
  pk int NOT NULL,
  col_int_key int NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk)
);

CREATE VIEW v2 AS SELECT * FROM t2;

let $query=
SELECT STRAIGHT_JOIN alias1.pk
FROM t2 AS alias1
     RIGHT JOIN
     (SELECT sq1_alias2.*
      FROM t1 AS sq1_alias1
           RIGHT OUTER JOIN
           v2 AS sq1_alias2
           ON sq1_alias2.col_varchar_key = sq1_alias1.col_varchar_key AND
              sq1_alias2.col_varchar_nokey IN
             (SELECT c_sq1_alias1.col_varchar_nokey AS c_sq1_field1
              FROM t3 AS c_sq1_alias1
              WHERE c_sq1_alias1.col_int_key <> c_sq1_alias1.col_int_key
             )
     ) AS alias2
     ON alias2.col_varchar_key = alias1.col_varchar_key;

DROP VIEW v2;
DROP TABLE t1, t2, t3;

-- - Test cases for INSERT, UPDATE and DELETE against composite views

CREATE TABLE t0(x INTEGER);
INSERT INTO t0 VALUES(0);

CREATE TABLE t1(a1 INTEGER PRIMARY KEY, b1 INTEGER);
CREATE TABLE t2(a2 INTEGER PRIMARY KEY, b2 INTEGER);

CREATE VIEW v0 AS SELECT DISTINCT x FROM t0;

CREATE VIEW vmat1 AS SELECT DISTINCT * FROM t1;
CREATE VIEW vmat2 AS SELECT DISTINCT * FROM t2;

CREATE VIEW vtt AS
SELECT * FROM t1 JOIN t2 ON t1.a1=t2.a2;

CREATE VIEW vtr AS
SELECT * FROM t1 JOIN vmat2 AS dt2 ON t1.a1=dt2.a2;

CREATE VIEW vtrd AS
SELECT * FROM t1 JOIN (SELECT DISTINCT * FROM t2) AS dt2 ON t1.a1=dt2.a2;

CREATE VIEW vrt AS
SELECT * FROM vmat1 AS dt1 JOIN t2 ON dt1.a1=t2.a2;

CREATE VIEW vrtd AS
SELECT * FROM (SELECT DISTINCT * FROM t1) AS dt1 JOIN t2 ON dt1.a1=t2.a2;

CREATE VIEW vrr AS
SELECT * FROM vmat1 AS dt1 JOIN vmat2 AS dt2 ON dt1.a1=dt2.a2;

CREATE VIEW vrrd AS
SELECT * FROM (SELECT DISTINCT * FROM t1) AS dt1 JOIN
              (SELECT DISTINCT * FROM t2) AS dt2 ON dt1.a1=dt2.a2;

-- v0  - Dummy view for use in UPDATE
-- vtt - View defined over two tables
-- vtr - View defined over a table and a read-only view
-- vrt - View defined over a read-only view and a table
-- vrr - View defined over two read-only views
-- vtrd, vrtd, vrrd: Like above but using derived tables instead of views

INSERT INTO vtt(a1,b1) VALUES (1,100);

INSERT INTO vtt(a2,b2) VALUES (1,100);
INSERT INTO vtr(a1,b1) VALUES (2,100);
INSERT INTO vtrd(a1,b1) VALUES (3,100);
INSERT INTO vtr(a2,b2) VALUES (2,100);
INSERT INTO vtrd(a2,b2) VALUES (3,100);
INSERT INTO vrt(a1,b1) VALUES (4,100);
INSERT INTO vrtd(a1,b1) VALUES (5,100);
INSERT INTO vrt(a2,b2) VALUES (4,100);
INSERT INTO vrtd(a2,b2) VALUES (5,100);
INSERT INTO vrr(a1,b1) VALUES (6,100);
INSERT INTO vrrd(a1,b1) VALUES (7,100);
INSERT INTO vrr(a2,b2) VALUES (6,100);
INSERT INTO vrrd(a2,b2) VALUES (7,100);

SELECT * FROM vtt;

DELETE FROM t1;
DELETE FROM t2;

INSERT INTO vtt(a1,b1) SELECT 1,100;

INSERT INTO vtt(a2,b2) SELECT 1,100;
INSERT INTO vtr(a1,b1) SELECT 2,100;
INSERT INTO vtrd(a1,b1) SELECT 3,100;
INSERT INTO vtr(a2,b2) SELECT 2,100;
INSERT INTO vtrd(a2,b2) SELECT 3,100;
INSERT INTO vrt(a1,b1) SELECT 4,100;
INSERT INTO vrtd(a1,b1) SELECT 5,100;
INSERT INTO vrt(a2,b2) SELECT 4,100;
INSERT INTO vrtd(a2,b2) SELECT 5,100;
INSERT INTO vrr(a1,b1) SELECT 6,100;
INSERT INTO vrrd(a1,b1) SELECT 7,100;
INSERT INTO vrr(a2,b2) SELECT 6,100;
INSERT INTO vrrd(a2,b2) SELECT 7,100;

SELECT * FROM vtt;

DELETE FROM t1;
DELETE FROM t2;

INSERT INTO t1 VALUES
 (1,100), (2,100), (3,100), (4,100), (5,100),
 (6,100), (7,100), (8,100), (9,100), (10,100),
 (11,100), (12,100), (13,100), (14,100);

INSERT INTO t2 VALUES
 (1,100), (2,100), (3,100), (4,100), (5,100),
 (6,100), (7,100), (8,100), (9,100), (10,100),
 (11,100), (12,100), (13,100), (14,100);
DELETE FROM vtt WHERE a1=1;
DELETE FROM vtr WHERE a1=2;
DELETE FROM vtrd WHERE a1=3;
DELETE FROM vrt WHERE a1=4;
DELETE FROM vrtd WHERE a1=5;
DELETE FROM vrr WHERE a1=6;
DELETE FROM vrrd WHERE a1=7;
DELETE vtt FROM vtt WHERE a1=8;
DELETE vtr FROM vtr WHERE a1=9;
DELETE vtrd FROM vtrd WHERE a1=10;
DELETE vrt FROM vrt WHERE a1=11;
DELETE vrtd FROM vrtd WHERE a1=12;
DELETE vrr FROM vrr WHERE a1=13;
DELETE vrrd FROM vrrd WHERE a1=14;

SELECT * FROM vtt;

DELETE FROM t1;
DELETE FROM t2;

INSERT INTO t1 VALUES (1,100);

INSERT INTO t2 VALUES (1,100);

UPDATE vtt SET b1=b1+1 WHERE a1=1;

UPDATE vtt SET b2=b2+1 WHERE a2=1;

UPDATE vtr SET b1=b1+1 WHERE a1=1;

UPDATE vtrd SET b1=b1+1 WHERE a1=1;
UPDATE vtr SET b2=b2+1 WHERE a2=1;
UPDATE vtrd SET b2=b2+1 WHERE a2=1;
UPDATE vrt SET b1=b1+1 WHERE a1=1;
UPDATE vrtd SET b1=b1+1 WHERE a1=1;

UPDATE vrt SET b2=b2+1 WHERE a2=1;

UPDATE vrtd SET b2=b2+1 WHERE a2=1;
UPDATE vrr SET b1=b1+1 WHERE a1=1;
UPDATE vrrd SET b1=b1+1 WHERE a1=1;
UPDATE vrr SET b2=b2+1 WHERE a2=1;
UPDATE vrrd SET b2=b2+1 WHERE a2=1;

UPDATE vtt, v0 AS dt SET b1=b1+1 WHERE a1=1;

UPDATE vtt, v0 SET b2=b2+1 WHERE a2=1;

UPDATE vtr, v0 SET b1=b1+1 WHERE a1=1;

UPDATE vtrd, v0 SET b1=b1+1 WHERE a1=1;
UPDATE vtr, v0 SET b2=b2+1 WHERE a2=1;
UPDATE vtrd, v0 SET b2=b2+1 WHERE a2=1;
UPDATE vrt, v0 SET b1=b1+1 WHERE a1=1;
UPDATE vrtd, v0 SET b1=b1+1 WHERE a1=1;

UPDATE vrt, v0 SET b2=b2+1 WHERE a2=1;

UPDATE vrtd, v0 SET b2=b2+1 WHERE a2=1;
UPDATE vrr, v0 SET b1=b1+1 WHERE a1=1;
UPDATE vrrd, v0 SET b1=b1+1 WHERE a1=1;
UPDATE vrr, v0 SET b2=b2+1 WHERE a2=1;
UPDATE vrrd, v0 SET b2=b2+1 WHERE a2=1;

SELECT * FROM vtt;

DROP VIEW v0, vtt, vtr, vrt, vrr, vmat1, vmat2;
DROP VIEW vtrd, vrtd, vrrd;
DROP TABLE t0, t1, t2;

create table t1 (a varchar(100));

create view v1n as select * from t1 where a like '%v1n%';
create view v2c as select * from t1 where a like '%v2c%'
 with check option;
create view v3l as select * from t1 where a like '%v3l%'
 with local check option;
insert into t1 values('');
insert into v1n values('');
insert into v2c values('');
insert into v2c values('v2c');
insert into v3l values('');
insert into v3l values('v3l');
update v1n set a='_';
update v2c set a='';
update v3l set a='';
create view v4n as select * from v2c where a like '%v4n%';
create view v5n as select * from v3l where a like '%v5n%';
insert into v4n values('v2c');
insert into v4n values('');
insert into v4n values('v4n v2c');
update v4n set a='v2c';
insert into v4n values('v4n v2c');
update v4n set a='v4n';
delete from v4n;
insert into v5n values('v3l');
insert into v5n values('');
create view v4l as select * from v2c where a like '%v4l%'
 with local check option;
create view v5l as select * from v3l where a like '%v5l%'
 with local check option;
insert into v4l values('v4l v2c');
insert into v4l values('v2c');
update v4l set a='v2c';
insert into v4l values('v4l');
update v4l set a='v4l';
insert into v5l values('v5l v3l');
insert into v5l values('v3l');
update v5l set a='v3l';
insert into v5l values('v5l');
update v5l set a='v5l';

create view v6c as select * from v5n where a like '%v6c%'
 with cascaded check option;
insert into v6c values('v6c v5n v3l');
insert into v6c values('v5n v3l');
update v6c set a='v5n v3l';
insert into v6c values('v6c v3l');
update v6c set a='v6c v3l';
insert into v6c values('v6c v5n');
update v6c set a='v6c v5n';
create view v7n as select * from v6c where a like '%v7n%';
insert into v7n values('v6c v5n v3l');
insert into v7n values('v5n v3l');
insert into v7n values('v6c v3l');
insert into v7n values('v6c v5n');
insert into v7n values('v7n v6c v5n v3l');
update v7n set a='v7n v5n v3l';
update v7n set a='v7n v6c v3l';
update v7n set a='v7n v6c v5nà';
create view v8l as select * from v7n where a like '%v8l%'
 with local check option;
insert into v8l values('v8l v6c v5n v3l');
insert into v8l values('v6c v5n v3l');
insert into v8l values('v8l v5n v3l');
insert into v8l values('v8l v6c v3l');
insert into v8l values('v8l v6c v5n');
insert into v8l values('v8l v7n v6c v5n v3l');
update v8l set a='v7n v6c v5n v3l';
update v8l set a='v8l v7n v5n v3l';
update v8l set a='v8l v7n v6c v3l';
update v8l set a='v8l v7n v6c v5n';

drop view v1n,v2c,v3l,v4n,v5n,v4l,v5l,v6c,v7n,v8l;

drop table t1;

CREATE TABLE t1(a INTEGER) engine=innodb;

CREATE VIEW v3 AS SELECT 1 FROM t1;

CREATE VIEW v2 AS SELECT 1 FROM v3 LEFT JOIN t1 ON 1;

DROP VIEW  v2,v3;
DROP TABLE t1;

CREATE TABLE t1 (r INTEGER) engine=innodb;
CREATE VIEW v1 AS
SELECT 1 AS z from t1;
INSERT INTO v1(z) VALUES(1);

DROP VIEW  v1;
DROP TABLE t1;

CREATE TABLE t (i INTEGER);

CREATE VIEW v AS SELECT * FROM t;
DROP VIEW v;
DROP TABLE t;
CREATE VIEW v1 (fld1, fld2) AS
  SELECT 1 AS a, 2 AS b
    UNION ALL
  SELECT 1 AS a, 1 AS a;
CREATE VIEW v2 (fld1, fld2) AS
  SELECT 1 AS a, 2 AS a
    UNION ALL
  SELECT 1 AS a, 1 AS a;
CREATE VIEW v3 AS
  SELECT 1 AS a, 2 AS b
    UNION ALL
  SELECT 1 AS a, 1 AS a;
CREATE VIEW v4 (fld1, fld1) AS
  SELECT 1 AS a, 2 AS b
    UNION ALL
  SELECT 1 AS a, 1 AS a;
CREATE VIEW v4 AS
  SELECT 1 AS a, 2 AS a
    UNION ALL
  SELECT 1 AS a, 1 AS a;
DROP VIEW v1, v2, v3;
DROP VIEW bug22108567_v1;

-- Check that all connections opened by test cases in this file are really
-- gone so execution of other tests will not be affected by their presence.
--source include/wait_until_count_sessions.inc

--echo --
--echo -- BUG#21877062: MIN/MAX IN VIEW ON TIMESTAMDIFF IN VIEW CONFUSES
--echo --               OPTIMIZER TO THROW SYNTAX ERROR
--echo --

CREATE TABLE t(ts1 DATETIME(6), ts2 DATETIME(6));
INSERT INTO t VALUES('2016-01-11 09:15:25','2016-01-11 21:15:25');

CREATE VIEW v1 AS
SELECT TIMESTAMPDIFF(MICROSECOND, ts1, ts2) duration FROM t;
SELECT * FROM v1;

CREATE VIEW v2 AS
SELECT MIN(duration) AS dmin, MAX(duration) AS dmax FROM v1;

DROP VIEW v1, v2;
DROP TABLE t;
CREATE TABLE t1_base_N3 (pk INT, col_int INT);
CREATE VIEW t1_view_N3 AS SELECT * FROM t1_base_N3 WHERE `pk` BETWEEN 1 AND
2;
CREATE VIEW t1_view_N4 AS SELECT * FROM ( SELECT * FROM t1_view_N3 ) AS A;
UPDATE t1_view_N3 AS A JOIN t1_view_N4 B SET A. col_int = 1 , B. col_int = 2;
DROP VIEW t1_view_N3, t1_view_N4;
DROP TABLE t1_base_N3;

CREATE TABLE t1(a INT);
CREATE VIEW v1 AS SELECT * FROM t1;

-- This statement should give a warning about invalid view as v2
-- should be tagged as invalid by the RENAME TABLE statement.
-- Note that the view changes name from v1 to v2 by the same statement
-- so it is important that the uncommitted v2 is updated rather than v1.
SELECT * FROM information_schema.views WHERE table_schema='test';

DROP VIEW v2;
DROP TABLE t2;

-- Check that a statement that drops a view twice does not cause asserts.
CREATE TABLE t1(a INT);
CREATE TABLE t2(b INT);
CREATE TABLE t3(a INT);
CREATE TABLE t4(b INT);
CREATE VIEW v1 AS SELECT * FROM t1, t2;
DROP TABLE t1, t2;

-- This statement causes v1 to be updated twice, one for each rename.
-- Since alter view is currently implemented as drop+create, that means
-- that v1 will be registered in the local cache as dropped twice
-- (same name but different ID).
RENAME TABLE t3 TO t1, t4 TO t2;

DROP VIEW v1;
DROP TABLE t1, t2;

CREATE DATABASE db;
CREATE TABLE db.t1(fld1 INT);
CREATE TABLE db.t2(fld2 INT);
CREATE TABLE t1(fld1 INT);
CREATE TABLE t2(fld2 INT);
CREATE VIEW v1 AS SELECT * FROM t1 UNION SELECT * FROM t2;

CREATE VIEW v2 AS SELECT * FROM t1 UNION SELECT * FROM db.t2;

CREATE VIEW v3 AS SELECT fld1 FROM t1 UNION SELECT * FROM db.t2;

CREATE VIEW v4 AS SELECT t1.fld1 FROM t1 UNION SELECT * FROM db.t2;

CREATE VIEW v5 AS SELECT * FROM db.t1 UNION SELECT * FROM db.t2;
CREATE VIEW v6 AS SELECT * FROM t2 WHERE fld2 IN (SELECT fld1 FROM t1);

CREATE VIEW v7 AS SELECT * FROM db.t2 WHERE fld2 IN (SELECT fld1 FROM t1);

CREATE VIEW v8 AS SELECT * FROM t1 where fld1 NOT IN (SELECT fld2 FROM db.t2);

CREATE VIEW v9 AS SELECT fld1 FROM t1 where fld1 NOT IN (SELECT fld2 FROM db.t2);

CREATE VIEW v10 AS SELECT t1.fld1 FROM t1 where fld1 NOT IN (SELECT fld2 FROM db.t2);

CREATE VIEW v11 AS SELECT * FROM db.t1 WHERE fld1 NOT IN
                  (SELECT fld2 FROM db.t2);
CREATE VIEW v12 AS SELECT * FROM (SELECT fld1 FROM t1) dummy;

CREATE VIEW v13 AS SELECT * FROM (SELECT fld1 FROM db.t1) dummy;

CREATE VIEW v14 AS SELECT * FROM db.t2, (SELECT fld1 FROM t1) dummy;

CREATE VIEW v15 AS SELECT * FROM db.t2, (SELECT fld1 FROM db.t1) dummy;

CREATE VIEW v16 AS SELECT db.t2.fld2 FROM db.t2, (SELECT t1.fld1 FROM db.t1) dummy;
CREATE VIEW v17 AS WITH cte AS (SELECT * FROM t1) SELECT * FROM cte;

CREATE VIEW v18 AS WITH cte AS (SELECT fld1 FROM t1) SELECT * FROM cte;

CREATE VIEW v19 AS WITH cte AS (SELECT db.t2.fld2 FROM db.t2) SELECT * FROM cte;
CREATE VIEW db.v1 AS SELECT * FROM db.t1 UNION SELECT * FROM t2;

CREATE VIEW db.v2 AS SELECT * FROM t1 where fld1 NOT IN (SELECT fld2 FROM db.t2);

CREATE VIEW db.v3 AS SELECT * FROM (SELECT fld1 FROM t1) dummy;
DROP VIEW v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15,
v16, v17, v18, v19;
DROP TABLE t1, t2;
DROP DATABASE db;

CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1), (2);

CREATE VIEW v1 AS SELECT a FROM t1;
CREATE VIEW v2 AS SELECT 1;
CREATE VIEW v3 AS SELECT a FROM (SELECT a FROM v1) AS dt;
CREATE VIEW v4 AS SELECT a FROM (SELECT a FROM t1) AS dt;
CREATE VIEW v5 AS SELECT a FROM (SELECT a FROM v3) AS dt2;

-- Ensure both single table and multi table updates give the same error message.
--error ER_NON_UPDATABLE_TABLE
UPDATE v3 SET v3.a=3;
UPDATE v3, v2 SET v3.a=3;
UPDATE v3, v1 SET v1.a=3;
SELECT * FROM t1;
UPDATE v3, t1 SET t1.a=4;
SELECT * FROM t1;
UPDATE v4 SET v4.a=6;
SELECT * FROM t1;
UPDATE v4, v2 SET v4.a=6;
UPDATE v4, v1 SET v1.a=6;
SELECT * FROM t1;
UPDATE v4, t1 SET t1.a=7;
SELECT * FROM t1;
UPDATE v5 SET v5.a=9;
UPDATE v5, v2 SET v5.a=9;
UPDATE v5, v1 SET v1.a=9;
SELECT * FROM t1;
UPDATE v5, t1 SET t1.a=10;
SELECT * FROM t1;

DROP TABLE t1;
DROP VIEW v1, v2, v3, v4, v5;

CREATE TABLE t1(pk INTEGER, cik INTEGER, UNIQUE KEY(cik))
PARTITION BY KEY(cik) PARTITIONS 10;

CREATE TABLE t2(pk INTEGER, cvk VARCHAR(20), cik INTEGER, UNIQUE KEY(cik))
PARTITION BY KEY(cik) PARTITIONS 10;

CREATE VIEW v1 AS
SELECT MAX(t2.pk) AS field1
FROM t1, t2
WHERE (SELECT 7 FROM DUAL) IS NOT NULL AND
      t1.pk BETWEEN 123 AND (123 + 128) AND
      t2.cvk <= 'p'
ORDER BY t1.pk DESC;

DROP VIEW v1;
DROP TABLE t1, t2;

CREATE TABLE t1(fld1 INT, fld2 INT);
INSERT INTO t1 VALUES(1, 1);
CREATE OR REPLACE VIEW v1
(`x12345678901234567890123456789012345678901234567890123456789012322`) AS
SELECT fld1 FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (
  col_date_key DATE,
  KEY col_date_key (col_date_key)
);

INSERT INTO t1 VALUES ('2007-02-08');
INSERT INTO t1 VALUES ('2007-02-08');
INSERT INTO t1 VALUES ('2008-11-04');
INSERT INTO t1 VALUES ('2008-11-04');
INSERT INTO t1 VALUES ('2009-01-14');
INSERT INTO t1 VALUES ('2009-01-14');

SELECT MAX(col_date_key) AS x
 FROM t1
 HAVING x >= CAST('2009-01-01' AS DATE)
;

CREATE VIEW v1 AS
 SELECT MAX(col_date_key) AS x
  FROM t1
  HAVING x >= CAST('2009-01-01' AS DATE)
;

SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;

CREATE TABLE t1 (pk INT);

CREATE VIEW v1 AS SELECT COUNT(*) FROM t1
ORDER BY (SELECT 1 FROM t1 WHERE 1 IN (SELECT * FROM (SELECT 1 as field) AS dt));

DROP TABLE t1;
DROP VIEW v1;
CREATE VIEW v AS SELECT null AS 'c' UNION SELECT 'a' AS 'c';
DROP VIEW v;
                   JSON_TABLE('[]', '$[*]' COLUMNS (c1 INT PATH '$.x')) AS jt";
DROP VIEW v1;
DROP VIEW v1;
                    (
                      SELECT 1
                      UNION ALL
                      SELECT n + 1 FROM cte WHERE n < 5
                    )
                    SELECT * FROM cte";
DROP VIEW v1;
DROP VIEW v1;
DROP DATABASE I_S;

-- No expression should be evaluated during resolving when creating a view,
-- so these commands should not cause any warnings.

CREATE VIEW v AS SELECT INSERT('a', 1, 1, YEAR(UNHEX('w'))) AS c;
SELECT * FROM v;
DROP VIEW v;

CREATE VIEW v2 AS SELECT 1 AS c;
CREATE VIEW v1 AS SELECT 4711 AS a, COUNT(DISTINCT c) FROM v2 GROUP BY a WITH ROLLUP;

-- Recreate v2, forcing a dump and re-parse of v1.
DROP VIEW v2;
CREATE VIEW v2 AS SELECT 1 AS c;

-- This statement used to give a syntax error.
SHOW CREATE VIEW v1;

DROP VIEW v1, v2;

CREATE TABLE t1 (
  pk INT,
  col_int_key INT,
  col_int_nokey INT,
  col_varchar_key VARCHAR(10),
  col_varchar_nokey VARCHAR(10),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key)
);
INSERT INTO t1 VALUES (), ();

CREATE VIEW v1 AS
SELECT alias1.col_int_nokey AS field1,
  (SELECT alias2.col_int_key
   FROM t1 AS alias2
   WHERE alias1.col_varchar_key <= alias1.col_varchar_nokey
  ) AS field2
FROM t1 AS alias1;

DROP VIEW v1;

DROP TABLE t1;

CREATE TABLE t0 (c0 INTEGER, c1 INTEGER);

CREATE VIEW v0 AS
SELECT c0
FROM t0
WHERE c1 = (SELECT 1
            UNION
            SELECT c0 FROM t0
            ORDER BY c1
           );
SELECT * FROM v0;

DROP VIEW v0;
DROP TABLE t0;

CREATE TABLE `t1` (`c1` SMALLINT DEFAULT NULL);
CREATE VIEW v1 AS SELECT c1,'á' AS c2 FROM t1;
INSERT INTO t1 (c1) VALUES ('0'), ('1');

SET NAMES 'latin1';
ALTER TABLE t1 RENAME t1_aux;
ALTER TABLE t1_aux RENAME t1;

SET NAMES DEFAULT;
SELECT * FROM v1;

DROP VIEW v1;
DROP TABLE t1;