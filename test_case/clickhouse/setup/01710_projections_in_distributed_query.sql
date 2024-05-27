set enable_memory_bound_merging_of_aggregation_results=0;
drop table if exists projection_test;
create table projection_test (dt DateTime, cost Int64, projection p (select toStartOfMinute(dt) dt_m, sum(cost) group by dt_m)) engine MergeTree partition by toDate(dt) order by dt;
insert into projection_test with rowNumberInAllBlocks() as id select toDateTime('2020-10-24 00:00:00') + (id / 20), * from generateRandom('cost Int64', 10, 10, 1) limit 1000 settings max_threads = 1;
set optimize_use_projections = 1, force_optimize_projection = 1;