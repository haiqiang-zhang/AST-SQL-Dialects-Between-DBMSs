DROP TABLE IF EXISTS t_02559;
CREATE TABLE t_02559 (
    key UInt64,
    value Array(String))
ENGINE = MergeTree
ORDER BY key
SETTINGS index_granularity=400, min_bytes_for_wide_part=0;
INSERT INTO t_02559 SELECT number,
if (number < 100 OR number > 1000,
    [toString(number)],
    emptyArrayString())
    FROM numbers(2000);
SET enable_multiple_prewhere_read_steps=1, move_all_conditions_to_prewhere=1;
