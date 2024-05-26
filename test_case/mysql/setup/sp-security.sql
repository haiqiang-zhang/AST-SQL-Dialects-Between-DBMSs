drop table if exists t1;
drop database if exists db1_secret;
create database db1_secret;
create table t1 ( u varchar(64), i int );
insert into t1 values('test', 0);
create procedure stamp(i int)
  insert into db1_secret.t1 values (user(), i);
