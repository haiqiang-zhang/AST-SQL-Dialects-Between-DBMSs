create table t1 (a bigint);
lock tables t1 write;
insert into t1 values(0);
unlock tables;
drop table t1;
create table t1 (a bigint);
insert into t1 values(0);
lock tables t1 write;
delete from t1;
unlock tables;
drop table t1;
create table t1 (a bigint);
insert into t1 values(0);
drop table t1;
create table t1 (a mediumtext, fulltext key key1(a)) charset utf8mb3 COLLATE utf8mb3_general_ci;
insert into t1 values ('hello');
drop table t1;
create temporary table t1(a int, index(a));
insert into t1 values('1'),('2'),('3'),('4'),('5');
drop table t1;
create table t1(a int);
drop table t1;
CREATE PROCEDURE p() ANALYZE TABLE v UPDATE HISTOGRAM ON w;
DROP PROCEDURE p;