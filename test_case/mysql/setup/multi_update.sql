drop table if exists t1,t2,t3;
drop database if exists mysqltest;
drop view if exists v1;
create table t1(id1 int not null auto_increment primary key, t char(12));
create table t2(id2 int not null, t char(12));
create table t3(id3 int not null, t char(12), index(id3));
