-- TODO: correct testing with real unique shards

set optimize_distributed_group_by_sharding_key=1;
set max_bytes_before_external_group_by = 0;
drop table if exists dist_01247;
drop table if exists data_01247;
create table data_01247 as system.numbers engine=Memory();
insert into data_01247 select * from system.numbers limit 2;
-- (and this is how we ensure that this optimization will work)

set max_distributed_connections=1;
set prefer_localhost_replica=0;
set enable_positional_arguments=0;
select '-';
select 'optimize_skip_unused_shards';
set optimize_skip_unused_shards=1;
select 'GROUP BY number';
select 'GROUP BY number distributed_group_by_no_merge';
select 'GROUP BY number, 1';
select 'GROUP BY 1';
select 'GROUP BY number ORDER BY number DESC';
select 'GROUP BY toString(number)';
select 'GROUP BY number%2';
select 'countDistinct';
select 'countDistinct GROUP BY number';
select 'DISTINCT';
select 'HAVING';
select 'HAVING LIMIT';
select 'LIMIT';
select 'LIMIT OFFSET';
select 'OFFSET distributed_push_down_limit=0';
select 'OFFSET distributed_push_down_limit=1';
select 'WHERE LIMIT OFFSET';
select 'LIMIT BY 1';
select 'GROUP BY (Distributed-over-Distributed)';
select 'GROUP BY (Distributed-over-Distributed) distributed_group_by_no_merge';
select 'GROUP BY (extemes)';
select 'LIMIT (extemes)';
select 'GROUP BY WITH TOTALS';
select 'GROUP BY WITH ROLLUP';
select 'GROUP BY WITH CUBE';
select 'GROUP BY WITH TOTALS ORDER BY';
select 'GROUP BY WITH TOTALS ORDER BY LIMIT';
select 'GROUP BY WITH TOTALS LIMIT';
select 'GROUP BY (compound)';
drop table if exists dist_01247;
drop table if exists data_01247;
create table data_01247 engine=Memory() as select number key, 0 value from numbers(2);
select 'GROUP BY sharding_key, ...';
select 'GROUP BY ..., sharding_key';
select 'sharding_key (compound)';
-- window functions
select 'window functions';
drop table data_01247;
