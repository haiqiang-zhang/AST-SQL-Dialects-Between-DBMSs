drop table if exists test_table;
CREATE TABLE test_table (string_value String) ENGINE = MergeTree ORDER BY string_value SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
