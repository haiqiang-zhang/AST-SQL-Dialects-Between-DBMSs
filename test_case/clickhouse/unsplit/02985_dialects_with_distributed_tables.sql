DROP TABLE IF EXISTS shared_test_table;
DROP TABLE IF EXISTS distributed_test_table;
CREATE TABLE shared_test_table (id UInt64)
ENGINE = MergeTree
ORDER BY (id);
INSERT INTO shared_test_table VALUES (123), (651), (446), (315), (234), (764);
SET dialect = 'kusto';
SET dialect = 'prql';
SET dialect = 'clickhouse';
DROP TABLE shared_test_table;
