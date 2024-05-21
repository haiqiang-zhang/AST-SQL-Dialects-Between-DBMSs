drop table if exists t;
create table t (x UInt32) engine = MergeTree order by tuple() settings index_granularity = 8;
insert into t select number from numbers(100);
alter table t add projection p (select uniqHLL12(x));
insert into t select number + 100 from numbers(100);
drop table if exists t;
