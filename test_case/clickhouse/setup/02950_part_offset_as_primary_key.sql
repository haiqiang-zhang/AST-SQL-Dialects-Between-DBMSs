SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
drop table if exists a;
create table a (i int) engine MergeTree order by i settings index_granularity = 2;
insert into a select -number from numbers(5);
