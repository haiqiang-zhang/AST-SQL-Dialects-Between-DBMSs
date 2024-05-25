drop table if exists t1, t2, tm;
create table t1 (i int) engine = myisam;
create table t2 (i int) engine = myisam;
create table tm (i int) engine=merge union=(t1, t2);
insert into t1 values (1), (2);
insert into t2 values (3), (4);
