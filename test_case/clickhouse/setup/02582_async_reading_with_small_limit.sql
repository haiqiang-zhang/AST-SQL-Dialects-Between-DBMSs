SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
drop table if exists t;
create table t(a UInt64) engine=MergeTree order by tuple();
