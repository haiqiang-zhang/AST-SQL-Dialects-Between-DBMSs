set allow_suspicious_primary_key = 0;
DROP TABLE IF EXISTS data;
set allow_suspicious_primary_key = 1;
create table data (key Int, value SimpleAggregateFunction(sum, UInt64)) engine=AggregatingMergeTree() primary key value order by (value, key);
DROP TABLE data;
