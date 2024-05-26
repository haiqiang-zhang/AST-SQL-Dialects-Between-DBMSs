SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
drop table if exists data_02233;
create table data_02233 (parent_key Int, child_key Int, value Int) engine=MergeTree() order by parent_key;
