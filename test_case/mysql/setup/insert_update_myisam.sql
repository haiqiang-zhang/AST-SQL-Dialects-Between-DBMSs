create table t1 (a int not null unique) engine=myisam;
insert into t1 values (1),(2);
insert ignore into t1 select 1 on duplicate key update a=2;
