drop table if exists data_01072;
drop table if exists dist_01072;
set optimize_skip_unused_shards=1;
set force_optimize_skip_unused_shards=1;
create table data_01072 (key Int, value Int, str String) Engine=Null();
set allow_suspicious_low_cardinality_types=1;
drop table data_01072;
create table data_01072 (key Int) Engine=MergeTree() ORDER BY key;
drop table data_01072;
