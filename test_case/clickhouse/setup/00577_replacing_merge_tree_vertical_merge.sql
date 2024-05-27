set optimize_on_insert = 0;
drop table if exists tab_00577;
create table tab_00577 (date Date, version UInt64, val UInt64) engine = ReplacingMergeTree(version) partition by date order by date settings enable_vertical_merge_algorithm = 1,
    vertical_merge_algorithm_min_rows_to_activate = 0, vertical_merge_algorithm_min_columns_to_activate = 0, min_rows_for_wide_part = 0,
    min_bytes_for_wide_part = 0, allow_experimental_replacing_merge_with_cleanup=1;
insert into tab_00577 values ('2018-01-01', 2, 2), ('2018-01-01', 1, 1);
insert into tab_00577 values ('2018-01-01', 0, 0);