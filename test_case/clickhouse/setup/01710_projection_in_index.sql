SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
drop table if exists t;
create table t (i int, j int, k int, projection p (select * order by j)) engine MergeTree order by i settings index_granularity = 1;
insert into t select number, number, number from numbers(10);
set optimize_use_projections = 1, max_rows_to_read = 3;
