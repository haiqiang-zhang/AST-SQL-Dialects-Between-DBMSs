SET mutations_sync = 2;
DROP TABLE IF EXISTS t_sparse_alter;
CREATE TABLE t_sparse_alter (id UInt64, u UInt64, s String)
ENGINE = MergeTree ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.5;
INSERT INTO t_sparse_alter SELECT
    number,
    if (number % 11 = 0, number, 0),
    if (number % 13 = 0, toString(number), '')
FROM numbers(2000);
