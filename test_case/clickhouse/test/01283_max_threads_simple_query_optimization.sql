set allow_asynchronous_read_from_io_pool_for_merge_tree = 0;
set local_filesystem_read_method = 'pread';
set load_marks_asynchronously = 0;
CREATE TABLE data_01283 engine=MergeTree()
ORDER BY key
PARTITION BY key
AS SELECT number key FROM numbers(10);
SET log_queries=1;
SET log_queries=0;
SYSTEM FLUSH LOGS;
DROP TABLE data_01283;
