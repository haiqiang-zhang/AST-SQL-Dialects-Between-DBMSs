drop table if exists da_memory_efficient_shard;
create table da_memory_efficient_shard(A Int64, B Int64) Engine=MergeTree order by A partition by B % 2;
insert into da_memory_efficient_shard select number, number from numbers(100000);
set distributed_aggregation_memory_efficient = 1, group_by_two_level_threshold = 1, group_by_two_level_threshold_bytes=1;
drop table if exists da_memory_efficient_shard;
