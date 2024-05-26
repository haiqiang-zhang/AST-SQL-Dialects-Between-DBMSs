SET optimize_move_to_prewhere = 1;
SET convert_query_to_cnf = 0;
SET move_all_conditions_to_prewhere = 0;
DROP TABLE IF EXISTS t_move_to_prewhere;
CREATE TABLE t_move_to_prewhere (id UInt32, a UInt8, b UInt8, c UInt8, fat_string String)
ENGINE = MergeTree ORDER BY id PARTITION BY id
SETTINGS min_rows_for_wide_part = 100, min_bytes_for_wide_part = 0;
INSERT INTO t_move_to_prewhere SELECT 1, number % 2 = 0, number % 3 = 0, number % 5 = 0, repeat('a', 1000) FROM numbers(1000);
INSERT INTO t_move_to_prewhere SELECT 2, number % 2 = 0, number % 3 = 0, number % 5 = 0, repeat('a', 1000) FROM numbers(10);
