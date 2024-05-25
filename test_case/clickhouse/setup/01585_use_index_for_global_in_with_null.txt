drop table if exists xp;
drop table if exists xp_d;
create table xp(i Nullable(UInt64), j UInt64) engine MergeTree order by i settings index_granularity = 1, allow_nullable_key = 1;
insert into xp select number, number + 2 from numbers(10);
insert into xp select null, 100;
