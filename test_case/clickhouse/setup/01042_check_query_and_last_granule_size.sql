SET check_query_single_value_result = 0;
DROP TABLE IF EXISTS check_query_test;
CREATE TABLE check_query_test (SomeKey UInt64, SomeValue String) ENGINE = MergeTree() ORDER BY SomeKey SETTINGS min_bytes_for_wide_part = 0, min_rows_for_wide_part = 0;
INSERT INTO check_query_test SELECT number, toString(number) FROM system.numbers LIMIT 81920;
