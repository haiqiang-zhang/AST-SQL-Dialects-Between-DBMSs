select i, from_unixtime(i), c from t1;
drop table t1;
create table t1 (ts timestamp);
insert into t1 values (19730101235900), (20040101235900);
select * from t1;
drop table t1;
SELECT FROM_UNIXTIME(1230768022), FROM_UNIXTIME(1230768023), FROM_UNIXTIME(1230768024);
