
drop table if exists prefetched_table;
CREATE TABLE prefetched_table(key UInt64, s String) Engine = MergeTree() order by key;
SET local_filesystem_read_prefetch=1;
SET allow_prefetched_read_pool_for_local_filesystem=1;
SYSTEM ENABLE FAILPOINT prefetched_reader_pool_failpoint;
SYSTEM DISABLE FAILPOINT prefetched_reader_pool_failpoint;
drop table if exists prefetched_table;
