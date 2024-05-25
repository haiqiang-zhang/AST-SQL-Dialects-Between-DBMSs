create table t1 (a datetime not null, b datetime not null);
insert into t1 values (now(), now());
insert into t1 values (now(), now());
select * from t1 where a is null or b is null;
drop table t1;
