SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value_1 String,
    value_2 String,
    value_3 String,
    INDEX value_1_idx (value_1) TYPE bloom_filter GRANULARITY 1,
    INDEX value_2_idx (value_2) TYPE ngrambf_v1(3, 512, 2, 0) GRANULARITY 1,
    INDEX value_3_idx (value_3) TYPE tokenbf_v1(512, 3, 0) GRANULARITY 1
) ENGINE=MergeTree ORDER BY id;
INSERT INTO test_table SELECT number, toString(number), toString(number), toString(number) FROM numbers(10);
