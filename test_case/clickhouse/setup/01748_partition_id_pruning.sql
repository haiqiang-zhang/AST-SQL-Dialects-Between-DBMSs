SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
drop table if exists x;
create table x (i int, j int) engine MergeTree partition by i order by j settings index_granularity = 1;
insert into x values (1, 1), (1, 2), (1, 3), (2, 4), (2, 5), (2, 6);
set max_rows_to_read = 3;
