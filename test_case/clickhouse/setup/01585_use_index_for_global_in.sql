SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
drop table if exists xp;
drop table if exists xp_d;
create table xp(i UInt64, j UInt64) engine MergeTree order by i settings index_granularity = 1;
insert into xp select number, number + 2 from numbers(10);
set max_rows_to_read = 4;
