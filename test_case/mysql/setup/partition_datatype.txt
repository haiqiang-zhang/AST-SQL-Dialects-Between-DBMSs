drop table if exists t1;
create table t1 (a bit not null) partition by key (a);
insert into t1 values (b'1');
