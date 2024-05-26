SET check_query_single_value_result = 0;
DROP TABLE IF EXISTS mt_table;
CREATE TABLE mt_table (d Date, key UInt64, data String) ENGINE = MergeTree() PARTITION BY toYYYYMM(d) ORDER BY key;
