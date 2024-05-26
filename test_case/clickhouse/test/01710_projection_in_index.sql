select * from t where i < 5 and j in (1, 2);
drop table t;
drop table if exists test;
create table test (name String, time Int64) engine MergeTree order by time;
insert into test values ('hello world', 1662336000241);
select count() from (select fromUnixTimestamp64Milli(time, 'UTC') time_fmt, name from test where time_fmt > '2022-09-05 00:00:00');
drop table test;
