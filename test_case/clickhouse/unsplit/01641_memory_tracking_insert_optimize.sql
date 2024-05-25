drop table if exists data_01641;
set enable_filesystem_cache=0;
set local_filesystem_read_method = 'pread';
create table data_01641 (key Int, value String) engine=MergeTree order by (key, repeat(value, 40)) settings old_parts_lifetime=0, min_bytes_for_wide_part=0;
SET max_block_size = 1000, min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0;
insert into data_01641 select number, toString(number) from numbers(120000);
set max_memory_usage='10Mi', max_untracked_memory=0;
optimize table data_01641 final;
drop table data_01641;
