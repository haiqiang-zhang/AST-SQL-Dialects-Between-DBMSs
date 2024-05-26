drop table if exists num_10m;
create table num_10m (number UInt64) engine = MergeTree order by tuple();
insert into num_10m select * from numbers(10000000);
