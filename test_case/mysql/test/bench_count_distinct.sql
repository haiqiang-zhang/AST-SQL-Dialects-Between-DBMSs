drop table if exists t1;
create table t1(n int not null, key(n)) delay_key_write = 1;
select count(distinct n) from t1;
drop table t1;
