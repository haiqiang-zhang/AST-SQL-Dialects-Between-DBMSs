drop table if exists t1,t2;
create table t1 (grp int, a bigint unsigned, c char(10) not null);
insert into t1 values (1,1,"a");
insert into t1 values (2,2,"b");
insert into t1 values (2,3,"c");
insert into t1 values (3,4,"E");
insert into t1 values (3,5,"C");
insert into t1 values (3,6,"D");
