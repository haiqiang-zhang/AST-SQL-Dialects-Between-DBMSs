drop table if exists t5, t6, t7, t8;
drop database if exists mysqltest;
drop database if exists client_test_db;
drop database if exists testtets;
drop table if exists t1Aa,t2Aa,v1Aa,v2Aa;
drop view if exists t1Aa,t2Aa,v1Aa,v2Aa;
select '------ basic tests ------' as test_sequence;
prepare stmt1 from ' select 1 as my_col ';
prepare stmt1 from ' select ? as my_col ';
drop table if exists not_exist;
create table t5
(
  a int primary key,
  b char(30),
  c int
);
insert into t5( a, b, c) values( 1, 'original table', 1);
prepare stmt2 from ' select * from t5 ';
drop table t5;
create table t5
(
  a int primary key,
  b char(30),
  c int
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5;
create table t5
(
  a int primary key,
  c int,
  b char(30)
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5;
create table t5
(
  a int primary key,
  b char(30),
  c int,
  d timestamp default '2008-02-23 09:23:45'
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5;
create table t5
(
  a int primary key,
  d timestamp default '2008-02-23 09:23:45',
  b char(30),
  c int
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5;
create table t5
(
  a timestamp default '2004-02-29 18:01:59',
  b char(30),
  c int
);
insert into t5( b, c) values( 'recreated table', 9);
drop table t5;
create table t5
(
  f1 int primary key,
  f2 char(30),
  f3 int
);
insert into t5( f1, f2, f3) values( 9, 'recreated table', 9);
drop table t5;
create table t5
(
  a int primary key,
  b char(10)
);
prepare stmt2 from ' select a,b from t5 where a <= 2 ';
drop table t5;
deallocate prepare stmt2;
select '------ show and misc tests ------' as test_sequence;
drop table if exists t2;
create table t2 
(
  a int primary key, b char(10)
);
prepare stmt4 from ' show databases like ''mysql'' ';
prepare stmt4 from ' show tables from test like ''t2%'' ';
prepare stmt4 from ' show columns from t2 where field in (select ?) ';
create index t2_idx on t2(b);
prepare stmt4 from ' show table status from test like ''t2%'' ';
prepare stmt4 from ' show table status from test like ''t9%'' ';
prepare stmt4 from ' show status like ''Threads_running'' ';
prepare stmt4 from ' show variables like ''sql_mode'' ';
prepare stmt4 from ' show engine myisam logs ';
prepare stmt4 from ' show grants for user ';
prepare stmt4 from ' show create table t2 ';
prepare stmt4 from ' show storage engines ';
drop table if exists t5;
prepare stmt1 from ' drop table if exists t5 ';
prepare stmt1 from ' drop table t5 ';
prepare stmt1 from ' SELECT @@version ';
select @var as 'content of @var is:';
select @var as 'content of @var is:';
drop table if exists t5;
create table t5 (a int);
prepare stmt_do from ' do @var:=  (1 in (select a from t5)) ';
prepare stmt_set from ' set @var= (1 in (select a from t5)) ';
select @var as 'content of @var is:';
select @var as 'content of @var is:';
drop table t5;
deallocate prepare stmt_do;
deallocate prepare stmt_set;
prepare stmt3 from ' create database mysqltest ';
create database mysqltest;
prepare stmt3 from ' drop database mysqltest ';
drop database mysqltest;
prepare stmt3 from ' describe t2 ';
drop table t2;
prepare stmt1 from ' optimize table t1 ';
prepare stmt1 from ' analyze table t1 ';
prepare stmt1 from ' checksum table t1 ';
prepare stmt1 from ' repair table t1 ';
prepare stmt3 from ' commit ';
prepare stmt3 from ' rollback ';
prepare stmt4 from ' SET sql_mode=ansi ';
select 'a' || 'b';
prepare stmt4 from ' SET sql_mode="" ';
select '2' || '3';
prepare stmt5 from ' select ''2'' || ''3'' ';
prepare stmt1 from ' flush local privileges ';
prepare stmt1 from ' KILL 0 ';
drop table if exists t2;
create table t2 (id smallint, name varchar(20));
prepare stmt1 from ' insert into t2 values(?, ?) ';
insert into t2 values ( @id , @arg00 );
insert into t2 values ( @id , @arg01 );
insert into t2 values ( @id , @arg02 );
insert into t2 values ( @id , @arg03 );
insert into t2 values ( @id , @arg04 );
prepare stmt1 from ' select * from t2 where id= ? and name= ? ';
drop table t2;
select '------ create/drop/alter/rename tests ------' as test_sequence;
drop table if exists t2, t3;
prepare stmt_drop from ' drop table if exists t2 ';
prepare stmt_create from ' create table t2 (
                             a int primary key, b char(10)) ';
prepare stmt3 from ' create table t3 (m int) select ? as m ';
prepare stmt3 from ' create index t2_idx on t2(b) ';
prepare stmt3 from ' drop index t2_idx on t2 ';
prepare stmt3 from ' alter table t2 drop primary key ';
drop table if exists new_t2;
prepare stmt3 from ' rename table t2 to new_t2 ';
prepare stmt1 from ' rename table t5 to t6, t7 to t8 ';
create table t5 (a int);
create table t7 (a int);
select '------ big statement tests ------' as test_sequence;
drop table if exists t5;
select @string as "";
select @string as "";
create table t1 (c1 int);
insert into t1 values (1);
prepare stmt1 from "select 1 from t1 where 1=(select 1 from t1 having c1)";
drop prepare stmt1;
drop table t1;
