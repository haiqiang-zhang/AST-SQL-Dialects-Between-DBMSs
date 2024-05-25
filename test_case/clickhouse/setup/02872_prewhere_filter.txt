drop table if exists data;
create table data (key Int, val1 SimpleAggregateFunction(max, Nullable(Int)), val2 SimpleAggregateFunction(min, Int)) engine=AggregatingMergeTree() order by key;
