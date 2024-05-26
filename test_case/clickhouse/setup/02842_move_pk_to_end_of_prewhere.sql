SET optimize_move_to_prewhere = 1;
SET enable_multiple_prewhere_read_steps = 1;
DROP TABLE IF EXISTS t_02848_mt1;
DROP TABLE IF EXISTS t_02848_mt2;
CREATE TABLE t_02848_mt1 (k UInt32, v String) ENGINE = MergeTree ORDER BY k SETTINGS min_bytes_for_wide_part=0;
INSERT INTO t_02848_mt1 SELECT number, toString(number) FROM numbers(100);
