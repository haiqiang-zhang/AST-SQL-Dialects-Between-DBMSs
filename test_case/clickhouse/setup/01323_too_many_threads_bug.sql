drop table if exists table_01323_many_parts;
set local_filesystem_read_method = 'pread';
set load_marks_asynchronously = 0;
set allow_asynchronous_read_from_io_pool_for_merge_tree = 0;
create table table_01323_many_parts (x UInt64) engine = MergeTree order by x partition by x % 100;
set max_partitions_per_insert_block = 100;
set max_threads = 16;
set log_queries = 1;
