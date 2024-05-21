drop table if exists x;
create table x (i int, j int, k int) engine MergeTree order by tuple() settings index_granularity=8192, index_granularity_bytes = '10Mi',  min_bytes_for_wide_part=0, min_rows_for_wide_part=0, ratio_of_defaults_for_sparse_serialization=1;
insert into x select number, number * 2, number * 3 from numbers(100000);
select * from x prewhere _part_offset = 0 settings max_bytes_to_read = 98312;
drop table x;