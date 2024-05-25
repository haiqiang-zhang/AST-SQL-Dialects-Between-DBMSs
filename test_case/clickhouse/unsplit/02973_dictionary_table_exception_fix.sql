CREATE TABLE test_table (i Int64) engine=MergeTree order by i;
CREATE DICTIONARY test_dict (y String, value UInt64 DEFAULT 0) PRIMARY KEY y SOURCE(CLICKHOUSE(TABLE 'test_table')) LAYOUT(DIRECT());
