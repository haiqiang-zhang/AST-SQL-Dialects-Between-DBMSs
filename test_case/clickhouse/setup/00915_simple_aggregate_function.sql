set optimize_throw_if_noop = 1;
drop table if exists simple;
create table simple (id UInt64,val SimpleAggregateFunction(sum,Double)) engine=AggregatingMergeTree order by id;
insert into simple select number,number from system.numbers limit 10;
