drop database if exists mysqltest1;
drop database if exists `#mysql50#mysqltest-2`;
drop procedure if exists p1;
drop function if exists f1;
drop view if exists v1;
drop procedure if exists p2;
drop function if exists f2_base;
drop event if exists e1;
drop event if exists e2;
create table t1_base(i int) engine=myisam;
create table t2_base(j int) engine=myisam;
create table t3_trans(i int) engine=innodb;
create temporary table t1_temp(i int) engine=myisam;
create temporary table t2_temp(j int) engine=myisam;
create temporary table t3_temp_trans(i int) engine=innodb;
create database mysqltest1;
create database `#mysql50#mysqltest-2`;
create procedure p1() begin end;
create view v1 as select 1 as i;
create procedure p2(i int) begin end;
create event e1 on schedule every 1 minute do begin end;
unlock tables;
unlock tables;
insert into t3_trans values (1);
unlock tables;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "commit";
unlock tables;
delete from t3_trans;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "flush tables with read lock";
unlock tables;
delete from t3_trans;
prepare stmt1 from 'select * from t1_base';
deallocate prepare stmt1;
prepare stmt1 from 'insert into t1_base values (1)';
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1_base values (1)";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
unlock tables;
delete from t1_base;
deallocate prepare stmt1;
prepare stmt1 from 'insert into t1_base values (1)';
deallocate prepare stmt1;
create index i on t1_base (i);
drop index i on t1_base;
create index i on t1_temp (i);
drop index i on t1_temp;
unlock tables;
unlock tables;
unlock tables;
unlock tables;
unlock tables;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush" and
        info = "flush tables with read lock";
unlock tables;
unlock tables;
unlock tables;
unlock tables;
unlock tables;
unlock tables;
unlock tables;
lock tables t1_base read;
unlock tables;
lock tables t1_base read;
unlock tables;
unlock tables;
lock tables t1_base write;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "lock tables t1_base write";
unlock tables;
unlock tables;
lock tables t1_temp write;
unlock tables;
lock tables t1_temp write;
unlock tables;
unlock tables;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "optimize table t1_base";
unlock tables;
unlock tables;
unlock tables;
insert into t3_trans values (1);
unlock tables;
insert into t3_trans values (2);
unlock tables;
insert into t3_trans values (1);
unlock tables;
insert into t3_trans values (2);
unlock tables;
unlock tables;
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "repair table t1_base";
unlock tables;
insert into t3_temp_trans values (1);
unlock tables;
delete from t3_temp_trans;
unlock tables;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "set autocommit= 1";
unlock tables;
delete from t3_trans;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "flush tables with read lock";
unlock tables;
delete from t3_trans;
unlock tables;
unlock tables;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa prepare 'test1'";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa rollback 'test1'";
unlock tables;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa prepare 'test1'";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa commit 'test1'";
unlock tables;
delete from t3_trans;
insert into t3_trans values (1);
insert into t3_trans values (2);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa rollback 'test1'";
unlock tables;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "xa commit 'test2'";
unlock tables;
delete from t3_trans;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "flush tables with read lock";
unlock tables;
delete from t3_trans;
unlock tables;
unlock tables;
insert into t3_trans values (1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "check table t1_base";
unlock tables;
delete from t3_trans;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and
        info = "alter table t1_temp add column c1 int";
unlock tables;
insert into t1_base values (1);
insert into t3_trans values (1);
select * from t1_base;
select * from t2_base;
select * from t3_trans;
unlock tables;
delete from t1_base;
delete from t3_trans;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "flush tables with read lock";
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t2_base values (1)";
unlock tables;
delete from t1_base;
delete from t2_base;
select * from t1_base;
select * from t3_trans;
select * from t1_base;
select * from t3_trans;
unlock tables;
unlock tables;
create table tm_base (i int) engine=merge union=(t1_base) insert_method=last;
drop table tm_base;
create temporary table tm_temp_base (i int) engine=merge union=(t1_base) insert_method=last;
drop table tm_temp_base;
create temporary table tm_temp_temp (i int) engine=merge union=(t1_temp) insert_method=last;
drop table tm_temp_temp;
create table tm_base_temp (i int) engine=merge union=(t1_temp) insert_method=last;
drop table tm_base_temp;
drop event e1;
drop procedure p2;
drop view v1;
drop procedure p1;
drop database `#mysql50#mysqltest-2`;
drop database mysqltest1;
drop temporary tables t1_temp, t2_temp;
drop tables t1_base, t2_base, t3_trans;
