select @@session.transaction_isolation;
drop table if exists t0, t1, t2, t3, t4, t5;
drop view if exists v1, v2;
drop procedure if exists p1;
drop procedure if exists p2;
drop function if exists f1;
drop function if exists f2;
drop function if exists f3;
drop function if exists f4;
drop function if exists f5;
drop function if exists f6;
drop function if exists f7;
drop function if exists f8;
drop function if exists f9;
drop function if exists f10;
drop function if exists f11;
drop function if exists f12;
drop function if exists f13;
drop function if exists f14;
drop function if exists f15;
create table t1 (i int primary key) engine=innodb;
insert into t1 values (1), (2), (3), (4), (5);
create table t2 (j int primary key) engine=innodb;
insert into t2 values (1), (2), (3), (4), (5);
create table t3 (k int primary key) engine=innodb;
insert into t3 values (1), (2), (3);
create table t4 (l int primary key) engine=innodb;
insert into t4 values (1);
create table t5 (l int primary key) engine=innodb;
insert into t5 values (1);
create view v1 as select i from t1;
create view v2 as select j from t2 where j in (select i from t1);
create procedure p1(k int) insert into t2 values (k);
drop view v1, v2;
drop procedure p1;
drop table t1, t2, t3, t4, t5;
drop table if exists t1, t2;
create table t1 (i int auto_increment not null primary key) engine=innodb;
create table t2 (i int) engine=innodb;
insert into t1 values (1), (2), (3), (4), (5);
insert into t2 select count(*) from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
insert into t1 values (6);
drop tables t1, t2;
create table t1 (i int auto_increment not null primary key) engine=innodb
  partition by hash (i) partitions 4;
create table t2 (i int) engine=innodb;
insert into t1 values (1), (2), (3), (4), (5);
select * from t1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 rebuild partition p0";
insert into t2 select count(*) from t1;
drop tables t1, t2;
