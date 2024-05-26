drop table if exists t1,t2,t3,t4;
drop table if exists t0,t5,t6,t7,t8,t9;
drop database if exists mysqltest;
drop view if exists v0, v1, v2, v3, v4;
create table T1 (id int primary key, Word varchar(40) not null, Index(Word));
create table t4 (id int primary key, Word varchar(40) not null);
INSERT INTO T1 VALUES (1, 'a'), (2, 'b'), (3, 'c');
INSERT INTO T4 VALUES(1,'match');
