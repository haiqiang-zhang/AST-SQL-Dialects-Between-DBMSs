set send_logs_level = 'error';
create table mt_compact (a Int, s String) engine = MergeTree order by a partition by a
settings index_granularity_bytes = 0, min_rows_for_wide_part = 1000;
alter table mt_compact modify setting parts_to_delay_insert = 300;
alter table mt_compact modify setting min_rows_for_wide_part = 0;
show create table mt_compact;
drop table mt_compact;
