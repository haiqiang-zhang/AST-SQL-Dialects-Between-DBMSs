set enable_filesystem_cache=0;
set enable_filesystem_cache_on_write_operations=0;
drop table if exists t;
create table t (x UInt64, s String) engine = MergeTree order by x SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
