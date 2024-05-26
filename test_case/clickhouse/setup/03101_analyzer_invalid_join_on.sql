drop table if exists t1;
drop table if exists t2;
set allow_experimental_analyzer=1;
create table t1 (c3 String, primary key(c3)) engine = MergeTree;
create table t2 (c11 String, primary key(c11)) engine = MergeTree;
insert into t1 values ('succeed');
insert into t2 values ('succeed');
