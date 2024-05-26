DROP TABLE IF EXISTS test_02559;
CREATE TABLE test_02559 (id1 UInt64, id2 UInt64) ENGINE=MergeTree ORDER BY id1 SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO test_02559 SELECT number, number FROM numbers(10);
DROP ROW POLICY IF EXISTS 02559_filter_1 ON test_02559;
DROP ROW POLICY IF EXISTS 02559_filter_2 ON test_02559;
SET enable_multiple_prewhere_read_steps=true, move_all_conditions_to_prewhere=true;
