drop table if exists t1;
create table t1 (n int not null primary key) engine=myisam;
insert into t1 values (4);
insert into t1 values (5);
